Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3013cac80602231049j49a278fj549ac697a696cc42@mail.gmail.com>
From: "Eduardo Rocha" <folhabranca@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_22291_6559882.1140720597776"
Subject: [Bluez-devel] [DBUS PATCH] dbus-test
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 23 Feb 2006 15:49:57 -0300

------=_Part_22291_6559882.1140720597776
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel & Johan,

here is the patch for the new dbus-test compliant with the new
interface. It's not fully tested. By the way Marcel, did you removed
the Discovery method from the API document?

BR,
Eduardo.

--
Eduardo Rocha
Instituto Nokia de Tecnologia - INdT

------=_Part_22291_6559882.1140720597776
Content-Type: text/x-patch; name=dbus-test.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ek1feqzi
Content-Disposition: attachment; filename="dbus-test.patch"

--- utils.23022006/hcid/dbus-test	2006-02-07 07:31:26.000000000 -0300
+++ utils.new/hcid/dbus-test	2006-02-23 15:38:37.000000000 -0300
@@ -8,15 +8,21 @@
 import getopt
 from signal import *
 
-mgr_cmds = [ "DeviceList", "DefaultDevice" ]
-dev_cmds = [ "Up", "Down", "SetProperty", "GetProperty", "SetMode", "GetMode", "Inquiry",
-             "CancelInquiry", "PeriodicInquiry","CancelPeriodic", "RemoteName",
-             "Connections", "Authenticate", "RoleSwitch" ]
-dev_setprop_bool = [ "auth", "encrypt" ]
-dev_setprop_byte = [ "incmode" ]
-dev_prop_filter = ["/org/bluez/Device/hci0", "/org/bluez/Device/hci1",
-                   "/org/bluez/Device/hci2", "/org/bluez/Device/hci3",
-                   "/org/bluez/Device/hci4", "/org/bluez/Device/hci5"]
+mgr_cmds = [ "ListDevices", "DefaultDevice" ]
+dev_cmds = [ "GetAddress", "GetManufacturer", "GetVersion", "GetRevision",
+             "GetCompany", "GetFeatures", "GetMode", "SetMode", "GetDiscoverableTimeout",
+             "SetDiscoverableTimeout", "IsConnectable", "IsDiscoverable" , "GetName",
+             "SetName", "GetMajorClass", "GetMinorClass", "SetMinorClass", "GetAlias", 
+             "SetAlias", "GetRemoteName", "GetRemoteAlias", "SetRemoteAlias", "GetRemoteVersion", 
+             "LastSeen", "Discover", "DiscoverService", "CreateBonding", "RemoveBonding", 
+             "HasBonding", "ListBondings", "PinCodeLength", "EncryptionKeySize", "GetServiceClasses" ]
+mgr_signals = [ "DeviceAdded", "DeviceRemoved" ]
+dev_signals = [ "ModeChanged", "NameChanged" , "AliasChanged", "RemoteName", "RemoteAlias" ]
+dev_signals_filter = [ "/org/bluez/Device/hci0", "/org/bluez/Device/hci1",
+                       "/org/bluez/Device/hci2", "/org/bluez/Device/hci3",
+                       "/org/bluez/Device/hci4", "/org/bluez/Device/hci5",
+                       "/org/bluez/Device/hci6", "/org/bluez/Device/hci7",
+                       "/org/bluez/Device/hci8", "/org/bluez/Device/hci9" ]
 
 class Tester:
     exit_events = []
@@ -36,8 +42,6 @@
             print 'Failed to do D-BUS setup: %s' % e
             sys.exit(1)
 
-        self.dev_setup()
-
     def parse_args(self, argv):
         try:
             opts, args = getopt.getopt(argv, "hli:")
@@ -50,7 +54,6 @@
                 self.usage()
                 sys.exit()
             elif o == "-l":
-                self.need_dev = True
                 self.listen = True
             elif o == "-i":
                 if a[0] == '/':
@@ -66,52 +69,48 @@
             self.cmd = args[0]
             self.cmd_args = args[1:]
 
-            if not self.cmd in mgr_cmds:
-                self.need_dev = True
-
-    def dev_setup(self):
-        if self.need_dev and not self.dev_path:
+    def dbus_dev_setup(self):
+        if not self.dev_path:
             try:
+                self.dbus_mrg_setup()
                 self.dev_path = self.manager.DefaultDevice()
             except dbus.DBusException, e:
                 print 'Failed to get default device: %s' % e
                 sys.exit(1)
+        try:
+            obj = self.bus.get_object('org.bluez', self.dev_path)
+            self.device = dbus.Interface(obj, 'org.bluez.Device')
+        except dbus.DBusException, e:
+            print 'Failed to setup device path: %s' % e
+            sys.exit(1)
 
-        if self.dev_path:
-            try:
-                obj = self.bus.get_object('org.bluez', self.dev_path)
-                self.dev = dbus.Interface(obj, 'org.bluez.Device')
+    def dbus_dev_sig_setup(self):
+        try:
+           for signal in dev_signals:
+                for path in dev_signals_filter:
+                    self.bus.add_signal_receiver(self.dev_signal_handler,
+                                             signal, 'org.bluez.Device',
+                                             'org.bluez', path)
+        except dbus.DBusException, e:
+            print 'Failed to setup signal handler for device path: %s' % e
+            sys.exit(1)
 
-                self.dev.connect_to_signal('Up', self.dev_up)
-                self.dev.connect_to_signal('Down', self.dev_down)
-                for path in dev_prop_filter:
-                    self.bus.add_signal_receiver(self.dev_property_changed,
-                                             'PropertyChanged','org.bluez.Device',
-                                             'org.bluez',path)
-                for path in dev_prop_filter:
-                    self.bus.add_signal_receiver(self.dev_mode_changed,
-                                             'ModeChanged','org.bluez.Device',
-                                             'org.bluez',path)
-                obj = self.bus.get_object('org.bluez', '%s/Controller' % self.dev_path)
-                self.ctl = dbus.Interface(obj, 'org.bluez.Device.Controller')
-
-                self.ctl.connect_to_signal('InquiryStart', self.inquiry_start)
-                self.ctl.connect_to_signal('InquiryResult', self.inquiry_result)
-                self.ctl.connect_to_signal('InquiryComplete', self.inquiry_complete)
-                self.ctl.connect_to_signal('RemoteName', self.remote_name)
-                self.ctl.connect_to_signal('RemoteNameFailed', self.remote_name_failed)
-                self.ctl.connect_to_signal('AuthenticationComplete', self.authentication_complete)
+    def dbus_mgr_sig_setup(self):
+        try:
+            for signal in mgr_signals:
+                self.bus.add_signal_receiver(self.mgr_signal_handler,
+                                         signal,'org.bluez.Manager',
+                                         'org.bluez', '/org/bluez/Manager')
+        except dbus.DBusException, e:
+            print 'Failed to setup signal handler for manager path: %s' % e
+            sys.exit(1)
 
-            except dbus.DBusException, e:
-                print 'Failed to setup device path: %s' % e
-                sys.exit(1)
+    def dbus_mrg_setup(self):
+        self.manager_obj = self.bus.get_object('org.bluez', '/org/bluez/Manager')
+        self.manager = dbus.Interface(self.manager_obj, 'org.bluez.Manager')
 
     def dbus_setup(self):
         self.bus = dbus.SystemBus()
-        manager_obj = self.bus.get_object('org.bluez', '/org/bluez/Manager')
-        self.manager = dbus.Interface(manager_obj, 'org.bluez.Manager')
-        self.manager.connect_to_signal('DeviceAdded', self.device_added)
-        self.manager.connect_to_signal('DeviceRemoved', self.device_removed)
 
     def usage(self):
         print 'Usage: %s [-i <dev>] [-l] [-h] <cmd> [arg1..]' % self.name
@@ -125,57 +124,31 @@
         for cmd in dev_cmds:
             print '\t%s' % cmd
 
-    def device_added(self, path):
-        print 'DeviceAdded: %s' % path
-
-    def device_removed(self, path):
-        print 'DeviceRemoved: %s' % path
-
-    def remote_name(self, bda, name):
-        print 'RemoteName: %s, %s' % (bda, name)
-        if 'RemoteName' in self.exit_events:
-            self.main_loop.quit()
-
-    def remote_name_failed(self, bda, status):
-        print 'RemoteNameFailed: %s, 0x%02X' % (bda, status)
-        if 'RemoteNameFailed' in self.exit_events:
-            self.main_loop.quit()
-
-    def inquiry_start(self):
-        print 'InquiryStart'
-
-    def inquiry_complete(self):
-        print 'InquiryComplete'
-        if 'InquiryComplete' in self.exit_events:
-            self.main_loop.quit()
-
-    def inquiry_result(self, bda, cls, rssi):
-        print 'InquiryResult: %s, %06X, %02X' % (bda, cls, rssi)
-
-    def authentication_complete(self, bda, status):
-        print 'AuthenticationComplete: %s, 0x%02X' % (bda, status)
-        if 'AuthenticationComplete' in self.exit_events:
-            self.main_loop.quit()
-
-    def dev_up(self):
-        print 'Up'
-
-    def dev_down(self):
-        print 'Down'
-
     @dbus.decorators.explicitly_pass_message
-    def dev_property_changed(*args, **keywords):
-        property = args[1]
-        param = args[2]
+    def dev_signal_handler(*args, **keywords):
         dbus_message = keywords["dbus_message"]
-        if property == 'name':
-            print 'Device %s name changed: %s' % (dbus_message.get_path(), param)
+        member = dbus_message.get_member()
+        sys.stdout.write(member) 
+        sys.stdout.write(' - ') 
+        sys.stdout.write(dbus_message.get_path())
+        sys.stdout.write(': ')
+        for arg in args[1:]:
+            sys.stdout.write(arg)
+            sys.stdout.write('   ')
+        sys.stdout.write('\n')
+        sys.stdout.flush()
 
     @dbus.decorators.explicitly_pass_message
-    def dev_mode_changed(*args, **keywords):
-        mode = args[1]
+    def mgr_signal_handler(*args, **keywords):
         dbus_message = keywords["dbus_message"]
-        print 'Device %s scan mode changed: %x' % (dbus_message.get_path(), mode)
+        member = dbus_message.get_member()
+        sys.stdout.write(member) 
+        sys.stdout.write(': ')
+        for arg in args[1:]:
+            sys.stdout.write(arg)
+            sys.stdout.write('   ')
+        sys.stdout.write('\n')
+        sys.stdout.flush()
 
     def signal_cb(self, sig, frame):
         print 'Caught signal, exiting'
@@ -183,163 +156,165 @@
             self.at_interrupt()
         self.main_loop.quit()
 
-    def run(self):
-        # Manager methods
-        if self.listen:
-            print 'Listening for events...'
-        elif self.cmd == 'DeviceList':
-            for dev in self.manager.DeviceList():
-                print dev
-        elif self.cmd == 'DefaultDevice':
-            print self.manager.DefaultDevice()
-
-        # Device methods
-        elif self.cmd == 'Up':
-            try:
-                self.dev.Up()
-            except dbus.DBusException, e:
-                print 'Sending %s failed: %s' % (self.cmd, e)
-                sys.exit(1)
-        elif self.cmd == 'Down':
-            try:
-                self.dev.Down()
-            except dbus.DBusException, e:
-                print 'Sending %s failed: %s' % (self.cmd, e)
-                sys.exit(1)
-        elif self.cmd == 'SetProperty':
-            if len(self.cmd_args) < 2:
-                print 'Usage: %s -i <dev> SetProperty strPropName arg' % self.name
-                sys.exit(1)
+    def call_mgr_dbus_func(self):
+        if self.cmd == 'ListDevices':
             try:
-                if self.cmd_args[0].lower() in dev_setprop_bool:
-                    self.dev.SetProperty(self.cmd_args[0], dbus.Boolean(self.cmd_args[1]))
-                elif self.cmd_args[0].lower() in dev_setprop_byte:
-                    self.dev.SetProperty(self.cmd_args[0], dbus.Byte(self.cmd_args[1]))
-                else:
-                    self.dev.SetProperty(self.cmd_args[0], self.cmd_args[1])
+                devices = self.manager.ListDevices()
             except dbus.DBusException, e:
                 print 'Sending %s failed: %s' % (self.cmd, e)
                 sys.exit(1)
-        elif self.cmd == 'GetProperty':
-            if len(self.cmd_args) < 1:
-                print 'Usage: %s -i <dev> GetProperty strPropName' % self.name
-                sys.exit(1)
-            try:
-                print self.dev.GetProperty(self.cmd_args[0])
-            except dbus.DBusException, e:
-                print 'Sending %s failed: %s' % (self.cmd, e)
-                sys.exit(1)
-        elif self.cmd == 'SetMode':
-            if len(self.cmd_args) != 1:
-                print 'Usage: %s -i <dev> SetMode scan_enable' % self.name
-                print 'scan_enable values: 0(no scan), 1(connectable), 2(connectable and discoverable)' % self.name
-                sys.exit(1)
-            try:
-                print self.dev.SetMode(dbus.Byte(self.cmd_args[0]))
-            except dbus.DBusException, e:
-                print 'Sending %s failed: %s' % (self.cmd, e)
-                sys.exit(1)
-        elif self.cmd == 'GetMode':
-            if len(self.cmd_args) != 0:
-                print 'Usage: %s -i <dev> GetMode' % self.name
-                sys.exit(1)
-            try:
-                print self.dev.GetMode()
-            except dbus.DBusException, e:
-                print 'Sending %s failed: %s' % (self.cmd, e)
-                sys.exit(1)
-        # Device.Controller methods
-        elif self.cmd == 'Inquiry':
-            try:
-                if len(self.cmd_args) != 2:
-                    self.ctl.Inquiry()
-                else:
-                    length, lap = self.cmd_args
-                    self.ctl.Inquiry(dbus.Byte(length), dbus.UInt32(long(lap, 0)))
-            except dbus.DBusException, e:
-                print 'Sending %s failed: %s' % (self.cmd, e)
-                sys.exit(1)
-            self.listen = True
-            self.exit_events.append('InquiryComplete')
-            self.at_interrupt = self.ctl.CancelInquiry
-
-        elif self.cmd == 'CancelInquiry':
-            try:
-                self.ctl.CancelInquiry()
-            except dbus.DBusException, e:
-                print 'Sending %s failed: %s' % (self.cmd, e)
-                sys.exit(1)
-
-        elif self.cmd == 'RemoteName':
-            if len(self.cmd_args) < 1:
-                print 'Bluetooth address needed'
-                sys.exit(1)
-            try:
-                self.ctl.RemoteName(self.cmd_args[0])
-            except dbus.DBusException, e:
-                print 'Sending %s failed: %s' % (self.cmd, e)
-                sys.exit(1)
-            self.listen = True
-            self.exit_events.append('RemoteNameFailed')
-            self.exit_events.append('RemoteName')
-
-        elif self.cmd == 'PeriodicInquiry':
+            for device in devices:
+                print device
+        elif self.cmd == 'DefaultDevice':
             try:
-                if len(self.cmd_args) < 3:
-                    length, min, max = (6, 20, 60)
-                    self.ctl.PeriodicInquiry(dbus.Byte(length), dbus.UInt16(min), dbus.UInt16(max))
-                elif len(self.cmd_args) == 3:
-                    length, min, max = self.cmd_args
-                    self.ctl.PeriodicInquiry(dbus.Byte(length), dbus.UInt16(min), dbus.UInt16(max))
-                else:
-                    length, min, max, lap = self.cmd_args
-                    self.ctl.PeriodicInquiry(dbus.Byte(length), dbus.UInt16(min), dbus.UInt16(max),
-                            dbus.UInt32(long(lap, 0)))
-                self.listen = True
+                print self.manager.DefaultDevice()
             except dbus.DBusException, e:
                 print 'Sending %s failed: %s' % (self.cmd, e)
                 sys.exit(1)
 
-        elif self.cmd == 'CancelPeriodic':
-            try:
-                self.ctl.CancelPeriodic()
-            except dbus.DBusException, e:
-                print 'Sending %s failed: %s' % (self.cmd, e)
-                sys.exit(1)
+    def call_dev_dbus_func(self):
+       try:
+           if self.cmd == 'GetAddress':
+               print self.device.GetAddress()
+           elif self.cmd == 'GetManufacturer':
+               print self.device.GetManufacturer()
+           elif self.cmd == 'GetVersion':
+               print self.device.GetVersion()
+           elif self.cmd == 'GetRevision':
+               print self.device.GetRevision()
+           elif self.cmd == 'GetCompany':
+               print self.device.GetCompany()
+           elif self.cmd == 'GetFeatures':
+               features = self.device.GetFeatures()
+               for feature in features: 
+                   print feature,
+           elif self.cmd == 'GetMode':
+               print self.device.GetMode()
+           elif self.cmd == 'SetMode':
+               if len(self.cmd_args) == 1:
+                   self.device.SetMode(self.cmd_args[0])
+               else:
+                   print 'Usage: %s -i <dev> SetMode scan_mode' % self.name
+           elif self.cmd == 'GetDiscoverableTimeout':
+               print '%u' % (self.device.GetDiscoverableTimeout())
+           elif self.cmd == 'SetDiscoverableTimeout':
+               if len(self.cmd_args) == 1:
+                   self.device.SetDiscoverableTimeout(dbus.UInt32(self.cmd_args[0]))
+               else:
+                   print 'Usage: %s -i <dev> SetDiscoverableTimeout timeout' % self.name
+           elif self.cmd == 'IsConnectable':
+               print self.device.IsConnectable()
+           elif self.cmd == 'IsDiscoverable':
+               print self.device.IsDiscoverable()
+           elif self.cmd == 'GetMajorClass':
+               print self.device.GetMajorClass()
+           elif self.cmd == 'GetMinorClass':
+               print self.device.GetMinorClass()
+           elif self.cmd == 'SetMinorClass':
+               if len(self.cmd_args) == 1:
+                   self.device.SetMinorClass(self.cmd_args[0])
+               else:
+                   print 'Usage: %s -i <dev> SetMinorClass minor' % self.name
+           elif self.cmd == 'GetServiceClasses':
+               classes = self.device.GetServiceClasses()
+               for clas in classes: 
+                   print clas,
+           elif self.cmd == 'GetName':
+               print self.device.GetName()
+           elif self.cmd == 'SetName':
+               if len(self.cmd_args) == 1:
+                   self.device.SetName(self.cmd_args[0])
+               else:
+                   print 'Usage: %s -i <dev> SetName newname' % self.name
+           elif self.cmd == 'GetRemoteName':
+               if len(self.cmd_args) == 1:
+                   print self.device.GetRemoteName()
+               else:
+                   print 'Usage: %s -i <dev> GetRemoteName address' % self.name
+           elif self.cmd == 'GetRemoteVersion':
+               if len(self.cmd_args) == 1:
+                   print self.device.GetRemoteVersion(self.cmd_args[0])
+               else:
+                   print 'Usage: %s -i <dev> GetRemoteVersion address' % self.name
+           elif self.cmd == 'GetRemoteAlias':
+               if len(self.cmd_args) == 1:
+                   print self.device.GetRemoteAlias(self.cmd_args[0])
+               else:
+                   print 'Usage: %s -i <dev> GetRemoteAlias address' % self.name
+           elif self.cmd == 'SetRemoteAlias':
+               if len(self.cmd_args) == 2:
+                   self.device.SetRemoteAlias(self.cmd_args[0], self.cmd_args[1])
+               else:
+                   print 'Usage: %s -i <dev> SetRemoteAlias address alias' % self.name
+           elif self.cmd == 'LastSeen':
+               if len(self.cmd_args) == 1:
+                   print self.device.LastSeen(self.cmd_args[0])
+               else:
+                   print 'Usage: %s -i <dev> LastSeen address' % self.name
+           elif self.cmd == 'LastUsed':
+               if len(self.cmd_args) == 1:
+                   print self.device.LastUsed(self.cmd_args[0])
+               else:
+                   print 'Usage: %s -i <dev> LastUsed address' % self.name
+           elif self.cmd == 'CreateBonding':
+               if len(self.cmd_args) == 1:
+                   print self.device.CreateBonding(self.cmd_args[0])
+               else:
+                   print 'Usage: %s -i <dev> CreateBonding address' % self.name
+           elif self.cmd == 'RemoveBonding':
+               if len(self.cmd_args) == 1:
+                   print self.device.RemoveBonding(self.cmd_args[0])
+               else:
+                   print 'Usage: %s -i <dev> RemoveBonding address' % self.name
+           elif self.cmd == 'HasBonding':
+               if len(self.cmd_args) == 1:
+                   print self.device.HasBonding(self.cmd_args[0])
+               else:
+                   print 'Usage: %s -i <dev> HasBonding address' % self.name
+           elif self.cmd == 'ListBondings':
+               bondings = self.device.ListBondings()
+               for bond in bondings: 
+                   print bond,
+           elif self.cmd == 'PinCodeLength':
+               if len(self.cmd_args) == 1:
+                   print self.device.PinCodeLength(self.cmd_args[0])
+               else:
+                   print 'Usage: %s -i <dev> PinCodeLength address' % self.name
+           elif self.cmd == 'EncryptionKeySize':
+               if len(self.cmd_args) == 1:
+                   print self.device.EncryptionKeySize(self.cmd_args[0])
+               else:
+                   print 'Usage: %s -i <dev> EncryptionKeySize address' % self.name
+           else:
+                # FIXME: remove at future version
+                print 'Script Error: Method %s not found. Maybe a mispelled word.' % (self.cmd_args)
+       except dbus.DBusException, e:
+           print '%s failed: %s' % (self.cmd, e)
+           sys.exit(1)
 
-        elif self.cmd == 'Authenticate':
-            if len(self.cmd_args) < 1:
-                print 'Bluetooth address needed'
-                sys.exit(1)
+    def run(self):
+        # Manager methods
+        if self.listen:
+            self.dbus_mgr_sig_setup()
+            self.dbus_dev_sig_setup()
+            print 'Listening for events...'
+        elif self.cmd in mgr_cmds:
             try:
-                self.ctl.Authenticate(self.cmd_args[0])
+                self.dbus_mrg_setup()
             except dbus.DBusException, e:
-                print 'Sending %s failed: %s' % (self.cmd, e)
-                sys.exit(1)
-            self.listen = True
-            self.exit_events.append('AuthenticationComplete')
-
-        elif self.cmd == 'RoleSwitch':
-            if len(self.cmd_args) < 2:
-                print 'Bluetooth address and role needed'
-                exit.exit(1)
-            bda, role = self.cmd_args
-            if not (role == '0' or role == '1'):
-                print 'Role should be 0 (master) or 1 (slave)'
+                print 'Failed to setup manager interface: %s' % e
                 sys.exit(1)
+            self.call_mgr_dbus_func()
+        elif self.cmd in dev_cmds:
             try:
-                self.ctl.RoleSwitch(bda, dbus.Byte(role))
+                self.dbus_dev_setup()
             except dbus.DBusException, e:
-                print 'Sending %s failed: %s' % (self.cmd, e)
+                print 'Failed to setup device interface: %s' % e
                 sys.exit(1)
-
-        elif self.cmd == 'Connections':
-            connections = self.ctl.Connections()
-            for conn in connections:
-                print conn
-
+            self.call_dev_dbus_func()
         else:
             print 'Unknown command: %s' % self.cmd
+            self.usage()
             sys.exit(1)
 
         if self.listen:
@@ -354,4 +329,3 @@
 
     tester = Tester(sys.argv)
     tester.run()
-

------=_Part_22291_6559882.1140720597776--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
