Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "blookk -" <blookk@hotmail.com>
To: bluez-devel@lists.sf.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Message-ID: <BAY1-F217RtMeKbK1tH00042281@hotmail.com>
Subject: [Bluez-devel] PAN profile of bluetooth
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 30 Aug 2004 11:19:36 +0000

Hello

I want to connect 2 pc using the PAN profile. I do this things:

- In server and client:

insmod rfcomm
insmod l2cap
insmod bnep

hcid -n &
sdpd -n &
sdptool add LAN

- In the server:
The file hcid.conf :    lm accept,master;
in the console     :    pand --listen --role GN

- In the client:
The file hcid.conf :    lm accept,master;
in the console     :    pand --connect 00:11:22:33:44:55

After i do this things, the virtual interfaz "Bnep0" doesn't create.

I execute ifconfig and only appears:

eth0      Link encap:Ethernet  HWaddr 00:0A:9B:4D:75:W3
          inet addr:192.161.56.171  Bcast:192.161.56.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:22602 errors:0 dropped:0 overruns:0 frame:0
          TX packets:17295 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:17913250 (17.0 Mb)  TX bytes:2621877 (2.5 Mb)
          Interrupt:5 Base address:0x1c00

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:116487 errors:0 dropped:0 overruns:0 frame:0
          TX packets:116487 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:7500466 (7.1 Mb)  TX bytes:7500466 (7.1 Mb)

In the messages of kernel appears:
in server:
Aug 30 09:54:39 clavijo hcid[4819]: Bluetooth HCI daemon
Aug 30 09:54:39 clavijo hcid[4819]: HCI dev 0 up
Aug 30 09:54:49 clavijo sdpd[4822]: Bluetooth SDP daemon
Aug 30 10:14:30 clavijo pand[4836]: Bluetooth PAN daemon
Aug 30 10:14:36 clavijo pand[4837]: New connection from 00:80:5A:20:6E:26 
bnep0
Aug 30 10:14:36 clavijo /etc/hotplug/net.agent: invoke ifup bnep0

in client:
                      Bluetooth HCI daemon
                      HCI dev 0 up
                      Bluetooth SDP daemon
                      Bluetooth PAN daemon
                      connecting to 00:11:22:33:44:55
                      bnep0 connected
                      /etc/hotplug/net.agent: invoke ifup bnep0

I don't know if i do something wrong.


thanks and regards

_________________________________________________________________
¿Estás pensando en cambiar de coche? Todas los modelos de serie y extras en 
MSN Motor. http://motor.msn.es/researchcentre/



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
