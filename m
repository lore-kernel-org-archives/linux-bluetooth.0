Return-Path: <cyrus@holtmann.org>
Message-ID: <48382BE9.2000309@powercraft.nl>
Date: Sat, 24 May 2008 16:53:29 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: Bluez-Users-List <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] dbus agent problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello everybody

I am still trying to get my bluetooth headset working again, the problem 
is that my dbus agent does not work anymore!

I would like to have a checklist what is needed to have an functional agent.

As you can see there is no key send to the device anymore and the agent 
is not working, so i would really appreciate a checklist what is needed 
to have a functional agent.

Thanks in advance,

Kind regards,

Jelle

-- -- -- --

May 24 13:07:11 debian-eeepc hcid[3138]: Bluetooth HCI daemon
May 24 13:07:11 debian-eeepc hcid[3138]: HCI dev 0 registered
May 24 13:07:11 debian-eeepc hcid[3138]: HCI dev 0 already up
May 24 13:07:11 debian-eeepc hcid[3138]: Device hci0 has been added
May 24 13:07:11 debian-eeepc hidd[3142]: Bluetooth HID daemon
May 24 13:07:11 debian-eeepc hcid[3138]: Starting security manager 0
May 24 13:07:11 debian-eeepc hcid[3138]: Device hci0 has been activated
May 24 13:07:11 debian-eeepc hcid[3138]: Starting SDP server
May 24 13:07:11 debian-eeepc hcid[3138]: Unix socket created: 13
May 24 13:07:11 debian-eeepc hcid[3138]: Registered manager 
path:/org/bluez/audio
May 24 13:07:11 debian-eeepc hcid[3138]: Registering service
May 24 13:07:54 debian-eeepc hcid[3138]: Audio API: received 
BT_GETCAPABILITIES_REQ
May 24 13:08:15 debian-eeepc hcid[3138]: connect(): Host is down (112)
May 24 13:08:15 debian-eeepc hcid[3138]: GetRemoteServiceHandles failed: 
Host is down
May 24 13:08:15 debian-eeepc hcid[3138]: Audio API: sending 
BT_GETCAPABILITIES_RSP
May 24 13:08:15 debian-eeepc hcid[3138]: Unregistered device 
path:/org/bluez/audio/device0
May 24 13:08:16 debian-eeepc hcid[3138]: Audio API: received 
BT_GETCAPABILITIES_REQ
May 24 13:08:36 debian-eeepc hcid[3138]: connect(): Host is down (112)
May 24 13:08:36 debian-eeepc hcid[3138]: GetRemoteServiceHandles failed: 
Host is down
May 24 13:08:36 debian-eeepc hcid[3138]: Unregistered device 
path:/org/bluez/audio/device1

-- -- -- --

sudo /etc/init.d/bluetooth stop
sudo /etc/init.d/alsa-utils stop
echo | sudo tee /var/log/syslog
sudo rm --recursive /var/lib/bluetooth/*

echo 'pcm.headset {
     type bluetooth
     #~ device 00:0D:18:A0:35:70
     #~ device 00:53:53:FB:7E:9C # Nokia BH-801
     #~ device 00:0C:55:D1:C9:78 # Motorola S805
     device 00:0D:FD:18:6E:3C # Motorolas S9
     #~ device 20:07:09:15:A9:5A # Samsung WEP210
     profile hifi
     #~ profile voice
     #profile auto
}
pcm.softvol {
     type softvol
     slave.pcm headset
     control.name Headset
     control.card 0
}
pcm.!default {
     #~ type hw
     #~ card 0
     type plug
     slave.pcm softvol
}' | tee $HOME/.asoundrc

echo 'options {
     autoinit yes;
     security auto;
     pairing multi;
     passkey "0000";
}
device {
     name "BlueZ (%d)";
     class 0x000100;
     iscan enable; pscan enable;
     lm accept,master;
     lp hold,sniff,park;
}' | sudo tee /etc/bluetooth/hcid.conf

sudo /etc/init.d/sysklogd restart
sudo /etc/init.d/klogd restart
sudo /etc/init.d/bluetooth restart
sudo /etc/init.d/alsa-utils restart
sudo python $HOME/.simple-agent.py
echo done

sudo tail --lines=100 --follow /var/log/syslog

speaker-test -c2

-- -- -- --
http://filebin.ca/kojejg/simple-agent

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

-- -- -- --

cat /etc/dbus-1/system.d/bluetooth.conf
<!-- This configuration file specifies the required security policies
      for Bluetooth core service to work. -->

<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 
1.0//EN"
  "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>

   <!-- ../system.conf have denied everything, so we just punch some 
holes -->

   <policy user="root">
     <allow own="org.bluez"/>
   </policy>

   <policy at_console="true">
     <allow send_destination="org.bluez.Manager"/>
     <allow receive_sender="org.bluez.Manager"/>

     <allow send_path="/org/bluez"/>

     <allow send_destination="org.bluez.Adapter"/>
     <allow receive_sender="org.bluez.Adapter"/>

     <allow send_destination="org.bluez.Service"/>
     <allow receive_sender="org.bluez.Service"/>

     <allow send_destination="org.bluez.Database"/>
     <allow receive_sender="org.bluez.Database"/>

     <allow send_destination="org.bluez.Security"/>
     <allow receive_sender="org.bluez.Security"/>
   </policy>

</busconfig>

-- -- -- -- --

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
