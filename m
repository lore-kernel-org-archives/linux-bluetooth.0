Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Dec 2007 03:42:52 -0800 (PST)
From: oohay otihs <oohaynotihs@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <244364.8286.qm@web38502.mail.mud.yahoo.com>
Subject: [Bluez-users] Resetting the Major Device Class Not Working
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0354921542=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0354921542==
Content-Type: multipart/alternative; boundary="0-2082141434-1198064572=:8286"
Content-Transfer-Encoding: 8bit

--0-2082141434-1198064572=:8286
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello everybody.

Can one reset the Major Device Class to something other than 0x01 (Personal Computer)?  I would like to masquerade as a Mobile Phone because I have a device that only connects to mobiles, and I would like for it to connect to a desktop PC.

I've tried editing the class option in the device section in /etc/bluetooth/hcid.conf, and upon restarting the bluetooth services, hciconfig -a still lists my device's class as if it's a PC.

Here's an excerpt from /etc/bluetooth/hcid.conf:
...
device {
    # Local device name
    #   %d - device id
    #   %h - host name
    #name "%h-%d";
    name "Logger_3";

    # Local device class
    class 0x5a020c;
...
}

Here's the output from hciconfig -a:

hci0:   Type: USB
        BD Address: 00:80:5A:46:A1:E5 ACL MTU: 384:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN 
        RX bytes:944 acl:0 sco:0 events:41 errors:0
        TX bytes:612 acl:0 sco:0 commands:27 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'Logger_3'
        Class: 0x3e0104
        Service Classes: Networking, Rendering, Capturing, Object Transfer, Audio
        Device Class: Computer, Desktop workstation
        HCI Ver: 2.0 (0x3) HCI Rev: 0x7a6 LMP Ver: 2.0 (0x3) LMP Subver: 0x7a6
        Manufacturer: Cambridge Silicon Radio (10)

Is it likely that I've got something misconfigured, or does Bluez allow for the resetting of the Major Device class?

As a side question - might anybody have a link to the Bluetooth Assigned Numbers document?  I can't find it on the Bluetooth SIG site (just broken links), nor does Google seem to turn up anything fruitful.
 
 Anybody's help would be greatly appreciated.  Thanks.



 
       
---------------------------------
Be a better friend, newshound, and know-it-all with Yahoo! Mobile.  Try it now.
--0-2082141434-1198064572=:8286
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello everybody.<br><br>Can one reset the Major Device Class to something other than 0x01 (Personal Computer)?&nbsp; I would like to masquerade as a Mobile Phone because I have a device that only connects to mobiles, and I would like for it to connect to a desktop PC.<br><br>I've tried editing the class option in the device section in /etc/bluetooth/hcid.conf, and upon restarting the bluetooth services, hciconfig -a still lists my device's class as if it's a PC.<br><br>Here's an excerpt from /etc/bluetooth/hcid.conf:<br>...<br>device {<br>&nbsp;&nbsp;&nbsp; # Local device name<br>&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; %d - device id<br>&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; %h - host name<br>&nbsp;&nbsp;&nbsp; #name "%h-%d";<br>&nbsp;&nbsp;&nbsp; name "Logger_3";<br><br>&nbsp;&nbsp;&nbsp; # Local device class<br>&nbsp;&nbsp;&nbsp; class 0x5a020c;<br>...<br>}<br><br>Here's the output from hciconfig -a:<br><br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD
 Address: 00:80:5A:46:A1:E5 ACL MTU: 384:8 SCO MTU: 64:8<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:944 acl:0 sco:0 events:41 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:612 acl:0 sco:0 commands:27 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'Logger_3'<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x3e0104<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Networking, Rendering, Capturing, Object Transfer, Audio<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Computer, Desktop
 workstation<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 2.0 (0x3) HCI Rev: 0x7a6 LMP Ver: 2.0 (0x3) LMP Subver: 0x7a6<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)<br><br>Is it likely that I've got something misconfigured, or does Bluez allow for the resetting of the Major Device class?<br><br>As a side question - might anybody have a link to the Bluetooth Assigned Numbers document?&nbsp; I can't find it on the Bluetooth SIG site (just broken links), nor does Google seem to turn up anything fruitful.<br> <br> Anybody's help would be greatly appreciated.&nbsp; Thanks.<br><br><br><br> <p>&#32;
      <hr size=1>Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile. <a href="http://us.rd.yahoo.com/evt=51733/*http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ "> Try it now.</a>
--0-2082141434-1198064572=:8286--


--===============0354921542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============0354921542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0354921542==--
