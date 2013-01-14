Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/1] test: Make map script a command line client
Date: Mon, 14 Jan 2013 11:49:58 +0100
Message-Id: <1358160598-14639-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

Rework the map-client test script into an interactive command line client.
Now multiple MCE functions can be called in one active session.
The script also allows to specify all filters or optional parameters including
auto completion.
---
 test/map-client | 320 ++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 218 insertions(+), 102 deletions(-)

diff --git a/test/map-client b/test/map-client
index 9fb7a5e..c5c899a 100755
--- a/test/map-client
+++ b/test/map-client
@@ -4,10 +4,13 @@ from __future__ import absolute_import, print_function, unicode_literals
 
 import gobject
 
+import cmd
+import shlex
 import sys
 import os
 import dbus
 import dbus.mainloop.glib
+import threading
 from optparse import OptionParser
 
 from pprint import pformat
@@ -31,49 +34,39 @@ def unwrap(x):
         return tuple(map(unwrap, x))
 
     if isinstance(x, dict):
-        return dict([(unwrap(k), unwrap(v)) for k, v in x.iteritems()])
+        return dict([(unwrap(k), unwrap(v)) for k, v in x.items()])
 
-    for t in [unicode, str, long, int, float, bool]:
+    if sys.version_info >= (3, 0):
+        coversion_types = [str, int, float, bool]
+    else:
+        coversion_types = [unicode, str, long, int, float, bool]
+
+    for t in coversion_types:
         if isinstance(x, t):
             return t(x)
 
     return x
 
 def parse_options():
+	parser.add_option("-s", "--source", dest="source",
+			help="Source / local address to use", metavar="SOURCE")
 	parser.add_option("-d", "--device", dest="device",
 			help="Device to connect", metavar="DEVICE")
-	parser.add_option("-c", "--chdir", dest="new_dir",
-			help="Change current directory to DIR", metavar="DIR")
-	parser.add_option("-l", "--lsdir", action="store_true", dest="ls_dir",
-			help="List folders in current directory")
-	parser.add_option("-v", "--verbose", action="store_true", dest="verbose")
-	parser.add_option("-L", "--lsmsg", action="store", dest="ls_msg",
-			help="List messages in supplied CWD subdir")
-	parser.add_option("-g", "--get", action="store", dest="get_msg",
-			help="Get message contents")
-	parser.add_option("--get-properties", action="store", dest="get_msg_properties",
-			help="Get message properties")
-	parser.add_option("--mark-read", action="store", dest="mark_msg_read",
-			help="Marks the messages as read")
-	parser.add_option("--mark-unread", action="store", dest="mark_msg_unread",
-			help="Marks the messages as unread")
-	parser.add_option("--mark-deleted", action="store", dest="mark_msg_deleted",
-			help="Deletes the message from the folder")
-	parser.add_option("--mark-undeleted", action="store", dest="mark_msg_undeleted",
-			help="Undeletes the message")
-	parser.add_option("-u", "--update-inbox", action="store_true", dest="update_inbox",
-			help="Checks for new mails")
+	parser.add_option("-p", "--port", dest="port", default=0,
+			help="RFCOMM port to connect", metavar="PORT")
+	parser.add_option("-v", "--verbose", action="store_true",
+			dest="verbose")
 
 	return parser.parse_args()
 
-def set_folder(session, new_dir):
-	session.SetFolder(new_dir)
-
-class MapClient:
+class MapClient(cmd.Cmd):
 	def __init__(self, session_path, verbose=False):
+		cmd.Cmd.__init__(self)
+		cmd.Cmd.prompt = "MCE> "
 		self.progress = 0
 		self.transfer_path = None
 		self.props = dict()
+		self.dir = dict()
 		self.verbose = verbose
 		self.path = session_path
 		bus = dbus.SessionBus()
@@ -85,8 +78,15 @@ class MapClient:
 			signal_name="PropertiesChanged",
 			path_keyword="path")
 
-	def create_transfer_reply(self, reply):
-		(path, properties) = reply
+	def create_transfer_reply_get(self, path, properties):
+		self.dir[path] = "in";
+		self.create_transfer_reply(path, properties)
+
+	def create_transfer_reply_put(self, path, properties):
+		self.dir[path] = "out";
+		self.create_transfer_reply(path, properties)
+
+	def create_transfer_reply(self, path, properties):
 		self.transfer_path = path
 		self.props[path] = properties
 		if self.verbose:
@@ -98,22 +98,25 @@ class MapClient:
 			print("Operation succeeded")
 
 	def error(self, err):
-		print err
-		mainloop.quit()
+		print(err)
 
 	def transfer_complete(self, path):
 		if self.verbose:
 			print("Transfer finished")
 		properties = self.props.get(path)
+		print(path)
+		print(self.dir)
 		if properties == None:
 			return
-		f = open(properties["Filename"], "r")
-		os.remove(properties["Filename"])
-		print(f.readlines())
+		if self.dir.get(path) == "in":
+			f = open(properties["Filename"], "r")
+			os.remove(properties["Filename"])
+			print(f.readlines())
 
-	def transfer_error(self, path):
-		print("Transfer %s error" % path)
-		mainloop.quit()
+	def transfer_error(self, code, message, path):
+		if path != self.transfer_path:
+			return
+		print("Transfer finished with error %s: %s" % (code, message))
 
 	def properties_changed(self, interface, properties, invalidated, path):
 		req = self.props.get(path)
@@ -128,46 +131,171 @@ class MapClient:
 			self.transfer_error(path)
 			return
 
-	def set_folder(self, new_dir):
-		self.map.SetFolder(new_dir)
-
-	def list_folders(self):
-		for i in self.map.ListFolders(dict()):
-			print("%s/" % (i["Name"]))
-
-	def list_messages(self, folder):
-		ret = self.map.ListMessages(folder, dict())
-		print(pformat(unwrap(ret)))
-
-	def get_message(self, handle):
-		self.map.ListMessages("", dict())
+	def emptyline(self):
+		pass
+
+	def do_EOF(self, args):
+		""" Quit """
+		return True
+
+	def do_exit(self, args):
+		""" Quit """
+		return True
+
+	# SetFolder
+	def do_SetFolder(self, new_dir):
+		""" Set working directory for current session """
+		try:
+			self.map.SetFolder(new_dir)
+		except dbus.exceptions.DBusException as e:
+			print("Failed:", e)
+
+	def do_cd(self, new_dir):
+		self.do_SetFolder(new_dir)
+
+	# ListFolders
+	list_folder_parms = {
+				'MaxCount': lambda x: dbus.UInt16(x),
+				'Offset': lambda x: dbus.UInt16(x)
+				}
+
+	def do_ListFolders(self, args):
+		""" List directories in current working directory """
+		parms={}
+		if args:
+			try:
+				for i in args.split(' '):
+					k,v = i.split('=')
+					parms[k] = self.list_folder_parms[k](v)
+			except:
+				print("Syntax error")
+				return
+
+		try:
+			for i in self.map.ListFolders(parms):
+				print("%s/" % (i["Name"]))
+		except dbus.exceptions.DBusException as e:
+			print("Failed:", e)
+
+	def complete_ListFolders(self, text, args, begidx, endidx):
+		if not text:
+			completions = list(self.list_folder_parms.keys())
+		else:
+			completions = [ f + "=" for f in
+						self.list_folder_parms.keys()
+							if f.startswith(text) ]
+		return completions
+
+	# ListFilterFields
+	def do_ListFilterFields(self, args):
+		""" List all available fields that can be used as filters """
+		for i in self.map.ListFilterFields():
+			print(i)
+
+	# ListMessages
+	list_msg_parms = { 'Folder': lambda x: x,
+				'MaxCount': lambda x: dbus.UInt16(x),
+				'Offset': lambda x: dbus.UInt16(x),
+				'SubjectLength': lambda x: dbus.Byte(int(x)),
+				'Fields': lambda x: x.split(','),
+				'Types': lambda x: x.split(','),
+				'PeriodBegin': lambda x: dbus.String(x),
+				'PeriodEnd': lambda x: dbus.String(x),
+				'Read': lambda x:
+					dbus.Boolean(x.lower() in
+							("yes", "true", "1")),
+				'Recipient': lambda x: dbus.String(x),
+				'Sender': lambda x: dbus.String(x),
+				'Priority': lambda x:
+					dbus.Boolean(x.lower() in
+							("yes", "true", "1"))
+				}
+
+	def do_ListMessages(self, args):
+		""" List messages in current working directory """
+		parms={}
+		if args:
+			try:
+				for i in shlex.split(args):
+					k,v = i.split('=')
+					parms[k] = self.list_msg_parms[k](v)
+			except Exception as e:
+				print("Syntax error", e)
+				return
+
+		try:
+			ret = self.map.ListMessages(parms.pop('Folder', ''),
+									parms)
+			print(pformat(unwrap(ret)))
+		except dbus.exceptions.DBusException as e:
+			print("Failed:", e)
+
+	def complete_ListMessages(self, text, args, begidx, endidx):
+		if not text:
+			completions = list(self.list_msg_parms.keys())
+		else:
+			completions = [ f + "=" for f in
+						self.list_msg_parms.keys()
+							if f.startswith(text) ]
+		return completions
+
+	def do_ls(self, args):
+		print("Folders:")
+		self.do_ListFolders(args)
+		print("Messages:")
+		self.do_ListMessages(args)
+
+	# GetMessage
+	def do_GetMessage(self, handle):
+		""" Download message """
 		path = self.path + "/message" + handle
 		obj = bus.get_object(BUS_NAME, path)
 		msg = dbus.Interface(obj, MESSAGE_INTERFACE)
-		msg.Get("", True, reply_handler=self.create_transfer_reply,
+		msg.Get("", True, reply_handler=self.create_transfer_reply_get,
 						error_handler=self.error)
 
-	def get_message_properties(self, handle):
-		self.map.ListMessages("", dict())
-		path = self.path + "/message" + handle
-		obj = bus.get_object(BUS_NAME, path)
-		msg = dbus.Interface(obj, "org.freedesktop.DBus.Properties")
-		ret = msg.GetAll(MESSAGE_INTERFACE)
-		print(pformat(unwrap(ret)))
-
-	def set_message_property(self, handle, prop, flag):
-		self.map.ListMessages("", dict())
-		path = self.path + "/message" + handle
-		obj = bus.get_object(BUS_NAME, path)
-		msg = dbus.Interface(obj, MESSAGE_INTERFACE)
-		msg.SetProperty (prop, flag);
-
-	def update_inbox(self):
-		self.map.UpdateInbox()
-
+	# GetMessageProperties
+	def do_GetMessageProperties(self, handle):
+		""" Returns all properties for the message """
+		try:
+			path = self.path + "/message" + handle
+			obj = bus.get_object(BUS_NAME, path)
+			msg = dbus.Interface(obj,
+					"org.freedesktop.DBus.Properties")
+			ret = msg.GetAll(MESSAGE_INTERFACE)
+			print(pformat(unwrap(ret)))
+		except Exception as e:
+			print("Error", e)
+			return
 
-if  __name__ == '__main__':
+	# SetMessageProperties
+	def do_SetMessageProperty(self, args):
+		"""Sets value to the mentioned property (Read, Delete) """
+		try:
+			handle, parm_line = args.split(' ')
+			parm, value = parm_line.split('=')
+		except Exception as e:
+			print("Syntax error", e)
+			return
 
+		try:
+			path = self.path + "/message" + handle
+			obj = bus.get_object(BUS_NAME, path)
+			msg = dbus.Interface(obj, MESSAGE_INTERFACE)
+			msg.SetProperty(parm, value in ("yes", "true", "1"));
+		except dbus.exceptions.DBusException as e:
+			print("Failed:", e)
+
+	# UpdateInbox
+	def do_UpdateInbox(self, line):
+		""" Request remote to update its inbox """
+		try:
+			self.map.UpdateInbox()
+		except dbus.exceptions.DBusException as e:
+			print("Failed:", e)
+
+if __name__ == '__main__':
+	dbus.mainloop.glib.threads_init()
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
 	parser = OptionParser()
@@ -179,44 +307,32 @@ if  __name__ == '__main__':
 		exit(0)
 
 	bus = dbus.SessionBus()
+	gobject.threads_init()
 	mainloop = gobject.MainLoop()
 
-	client = dbus.Interface(bus.get_object(BUS_NAME, PATH),
-							CLIENT_INTERFACE)
-
-	print("Creating Session")
-	path = client.CreateSession(options.device, { "Target": "map" })
+	mainloop_thread = threading.Thread(target=mainloop.run)
+	mainloop_thread.start()
 
-	map_client = MapClient(path, options.verbose)
-
-	if options.new_dir:
-		map_client.set_folder(options.new_dir)
-
-	if options.ls_dir:
-		map_client.list_folders()
-
-	if options.ls_msg is not None:
-		map_client.list_messages(options.ls_msg)
-
-	if options.get_msg is not None:
-		map_client.get_message(options.get_msg)
-
-	if options.get_msg_properties is not None:
-		map_client.get_message_properties(options.get_msg_properties)
+	try:
+		client = dbus.Interface(bus.get_object(BUS_NAME, PATH),
+							CLIENT_INTERFACE)
 
-	if options.mark_msg_read is not None:
-		map_client.set_message_property(options.mark_msg_read, "Read", True)
+		print("Creating Session")
 
-	if options.mark_msg_unread is not None:
-		map_client.set_message_property(options.mark_msg_unread, "Read", False)
+		opts = { "Target": "map",
+				"Channel": dbus.Byte(int(options.port)) }
+		if options.source:
+			opts["Source"] = options.source
 
-	if options.mark_msg_deleted is not None:
-		map_client.set_message_property(options.mark_msg_deleted, "Deleted", True)
+		path = client.CreateSession(options.device, opts)
 
-	if options.mark_msg_undeleted is not None:
-		map_client.set_message_property(options.mark_msg_undeleted, "Deleted", False)
+		map_client = MapClient(path, options.verbose)
+		map_client.cmdloop()
 
-	if options.update_inbox:
-		map_client.update_inbox()
+	except (KeyboardInterrupt, SystemExit):
+		pass
+	except Exception as e:
+		print("Error", e)
 
-	mainloop.run()
+	mainloop.quit()
+	mainloop_thread.join()
-- 
1.8.1

