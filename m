Return-Path: <cyrus@holtmann.org>
Message-ID: <488CA7E3.4000303@powercraft.nl>
Date: Sun, 27 Jul 2008 18:52:51 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------090108000702050007000901"
Subject: [Bluez-users] .simple-agent dbus pin handle
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090108000702050007000901
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This message contains the following attachment(s):
.simple-agent.py

Hello everybody,

I can't get my pin-agent working anymore. I currently have not the 
knowledge to fix this issue and help is appreciated. I don't use a gui 
on the system, so gnome tools is not an options. Any help is really 
appreciated.

running on debian sid:
Architecture: i386
Version: 3.36-1

Thanks in advance,

Jelle


sudo python .simple-agent.py
ERROR:dbus.connection:Unable to set arguments ('/test/agent',) according 
to signature u'os': <type 'exceptions.TypeError'>: More items found in 
D-Bus signature than in Python arguments
Traceback (most recent call last):
   File ".simple-agent.py", line 54, in <module>
     adapter.RegisterAgent(path)
   File "/var/lib/python-support/python2.5/dbus/proxies.py", line 68, in 
__call__
     return self._proxy_method(*args, **keywords)
   File "/var/lib/python-support/python2.5/dbus/proxies.py", line 140, 
in __call__
     **keywords)
   File "/var/lib/python-support/python2.5/dbus/connection.py", line 
597, in call_blocking
     message.append(signature=signature, *args)
TypeError: More items found in D-Bus signature than in Python arguments

--------------090108000702050007000901
Content-Type: text/x-python;
 name=".simple-agent.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".simple-agent.py"

#!/usr/bin/python

import gobject

import dbus
import dbus.service
import dbus.mainloop.glib

class Agent(dbus.service.Object):
    @dbus.service.method("org.bluez.Agent",
                    in_signature="", out_signature="")
    def Release(self):
        print "Release"
        mainloop.quit()

    @dbus.service.method("org.bluez.Agent",
                    in_signature="os", out_signature="")
    def Authorize(self, device, uuid):
        print "Authorize (" + device + ", " + uuid + ")"
        return

    @dbus.service.method("org.bluez.Agent",
                    in_signature="o", out_signature="s")
    def RequestPasskey(self, device):
        print "RequestPasskey (" + device + ")"
        return "0000"

    @dbus.service.method("org.bluez.Agent",
                    in_signature="s", out_signature="")
    def ConfirmModeChange(self, mode):
        print "ConfirmModeChange (" + mode + ")"
        return

    @dbus.service.method("org.bluez.Agent",
                    in_signature="", out_signature="")
    def Cancel(self):
        print "Cancel"
        return

if __name__ == '__main__':
    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)

    bus = dbus.SystemBus()
    manager = dbus.Interface(bus.get_object("org.bluez", "/"),
                            "org.bluez.Manager")

    path = manager.DefaultAdapter()
    adapter = dbus.Interface(bus.get_object("org.bluez", path),
                            "org.bluez.Adapter")

    path = "/test/agent"
    object = Agent(bus, path)

    adapter.RegisterAgent(path)
    print "Agent registered"

    mainloop = gobject.MainLoop()
    mainloop.run()

    #adapter.UnregisterAgent(path)
    #print "Agent unregistered"

--------------090108000702050007000901
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--------------090108000702050007000901
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--------------090108000702050007000901--
