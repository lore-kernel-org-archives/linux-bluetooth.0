Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Sebastian Roth <sebastian.roth@esk.fhg.de>
Message-ID: <cttbgv$knk$1@sea.gmane.org>
References: <41FA06A5.3010904@tootai.net> <ctdn6n$sqs$1@sea.gmane.org> <41FE4744.5010804@tootai.net> <ctob73$ph0$1@sea.gmane.org> <4200D3B6.1050708@tootai.net> <ctqulk$ce4$1@sea.gmane.org> <420105F0.5030407@tootai.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
In-Reply-To: <420105F0.5030407@tootai.net>
Subject: [Bluez-users] Re: Connection issue with headset
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 03 Feb 2005 15:13:23 +0100

Hi Daniel,


>> are the other things build into the kernel or loaded? (bluetooth,
>> hci_usb, l2cap, rfcomm, sco)
> 
> all in modules
Have you really loaded all of them?

Your posted output of dmesg:
Bluetooth: L2CAP ver 2.6
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.3
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
# where is SCO?
snd-bt-sco revision 1.4 $
snd-bt-sco: snd-bt-scod thread starting

My output:
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: SCO (Voice Link) ver 0.4
Bluetooth: SCO socket layer initialized
snd-bt-sco revision 1.4 $
snd-bt-sco: snd-bt-scod thread starting


Btw. what kernel version do you use? Please update the kernel to
2.6.10-mh3 and the libs/utils to 2.15!!



# sdptool search --bdaddr <bdaddr> 0x1108
Class 0x1108
Searching for 0x1108 on <bdaddr> ...
Service Name: Headset
Service RecHandle: 0x10000
Service Class ID List:
   "Headset" (0x1108)
   "Generic Audio" (0x1203)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 1
Profile Descriptor List:
   "Headset" (0x1108)
     Version: 0x0100

What does this command show to you? Is the Channel the same when
connecting with btsco?



>> If you followed this and it does not work I have two ideas.
>> 1. Is it possible that your headset does not send any AT commands
>> over the connected RFCOMM channel? As far as I know btsco will never
>> try to establish an SCO connection without having recived the cmd
>> from your headset.
> 
>  From what I check nowhere I saw any AT command. That exactly what I'm 
> looking for!

Try hcidump -X (upper case). This is the part of my output:

...
 > ACL data: handle 0x0029 flags 0x01 dlen 3
    L2CAP(d): cid 0x0041 len 16 [psm 3]
     RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 12 fcs 0x40
     0000: 41 54 2b 43 4b 50 44 3d  32 30 30 0d              AT+CKPD=200.
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x0087 len 10 [psm 3]
     RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
     0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
...


Regards,
hecatomb



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
