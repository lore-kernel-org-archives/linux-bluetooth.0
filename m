Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jon Hoffman <Jon.Hoffman@myfuelmaster.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 11 Feb 2016 09:12:59 -0500
Subject: RE: Bluetooth PAN Connection - NAP and GN
Message-ID: <3916CF28FA2C014B862815C318D03FF5A0A7493B18@Courier.syntech.org>
References: <3916CF28FA2C014B862815C318D03FF5A0A7493B03@Courier.syntech.org>
 <20160210133708.GA26024@vps217108.ovh.net>
In-Reply-To: <20160210133708.GA26024@vps217108.ovh.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 
> 
> Hi Jon,
> 
> Unfortunately, I have no answer to your problem, but I would like to back
> you up on this issue, since I ran into the exact same problem a few month
> ago, and didn't make any progress since.
> 
> I remember looking at the test-pan script packaged with blueZ, and
> modifying it to make it work with the GN role, but unsuccessfully.
> 
> Here is the mail I sent at the time :
> http://permalink.gmane.org/gmane.linux.bluez.kernel/64144
> 
> I hope someone can help us on this issue,
> 
> Thanks,
> 
> Maxime

Based on Maxime's reply to my original e-mail (http://article.gmane.org/gmane.linux.bluez.kernel/66582/)   I decided to try the test scripts rather than bt-network even though it appeared that Maxime could not get it to work (something else to try).  I took the test-nap and changed it to the following (trying to get a Group Network working rather than a NAP):

    #!/usr/bin/python3
    from optparse import OptionParser, make_option
    import sys 
    import time
    import dbus
    import bluezutils
    import dbus.mainloop.glib
    try:
          from gi.repository import GObject
    except ImportError:
    import gobject as GObject

    bus = dbus.SystemBus()

    option_list = [
		make_option("-i", "--device", action="store",
				type="string", dest="dev_id"),
		]
    parser = OptionParser(option_list=option_list)

    (options, args) = parser.parse_args()

    adapter_path = bluezutils.find_adapter(options.dev_id).object_path
    server = dbus.Interface(bus.get_object("org.bluez", adapter_path),
						"org.bluez.NetworkServer1")

    service = "gn"

    if (len(args) < 1):
	bridge = "pan0"
    else:
	bridge = args[0]

    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
    mainloop = GObject.MainLoop()

    server.Register(service, bridge)
    print("Server for %s registered for %s" % (service, bridge))
    print("Press CTRL-C to disconnect")
    mainloop.run()

I then took the test-network script and ran it on the master like this:
        ./test-network 5C:F3:70:XX:XX:XX gn

But still received the same security block error.  Here are the lines form the HCI dump again:

    > ACL data: handle 11 flags 0x02 dlen 12
        L2CAP(s): Connect req: psm 15 scid 0x0041
    < ACL data: handle 11 flags 0x00 dlen 16
        L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 1 status 2
            Connection pending - Authorization pending
     < ACL data: handle 11 flags 0x00 dlen 16
         L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 3 status 0
             Connection refused - security block

I did change the /etc/dbus-1/system.d/bluetooth.conf file thinking that might be the issue.  Here is the configuration file after I changed it:
     <!-- This configuration file specifies the required security policies
          for Bluetooth core daemon to work. -->

     <!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
          "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
     <busconfig>

      <!-- ../system.conf have denied everything, so we just punch some holes -->

       <policy user="root">
              <allow own="org.bluez"/>
              <allow send_destination="org.bluez"/>
              <allow send_interface="org.bluez.Agent1"/>
              <allow send_interface="org.bluez.MediaEndpoint1"/>
              <allow send_interface="org.bluez.MediaPlayer1"/>
              <allow send_interface="org.bluez.Network1"/>
              <allow send_interface="org.bluez.NetworkServer1"/>
             <allow send_interface="org.bluez.ThermometerWatcher1"/>
             <allow send_interface="org.bluez.AlertAgent1"/>
             <allow send_interface="org.bluez.Profile1"/>
             <allow send_interface="org.bluez.HeartRateWatcher1"/>
             <allow send_interface="org.bluez.CyclingSpeedWatcher1"/>
             <allow send_interface="org.bluez.GattCharacteristic1"/>
             <allow send_interface="org.bluez.GattDescriptor1"/>
             <allow send_interface="org.freedesktop.DBus.ObjectManager"/>
             <allow send_interface="org.freedesktop.DBus.Properties"/>
       </policy>

       <!-- allow users of bluetooth group to communicate -->
       <policy group="bluetooth">
               <allow send_destination="org.bluez"/>
        </policy>

       <policy at_console="true">
               <allow send_destination="org.bluez"/>
        </policy>

        <!-- allow users of lp group (printing subsystem) to 
               communicate with bluetoothd -->
         <policy group="lp">
                  <allow send_destination="org.bluez"/>
         </policy>

        <policy context="default">
                  <allow send_destination="org.bluez"/>
         </policy>

     </busconfig>

But even changing the bluetooth.conf file did not help.  Still getting the security block error.
This works perfectly if I try to connect with the NAP scenario but I keep getting the security block error when I connect with the GN scenario and I really need the GN scenario working since I do not want routing.   Is this a bug with bluez?  It does seem that others are having the same issue by Maxime's reply and I also ran across this in stack overflow:  http://stackoverflow.com/questions/32520581/bluez-pan-gn-server-connection-refused-when-nap-server-is-down  
Any help or advice would be appreciated.
Thanks,

Jon
