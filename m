Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Jack Jia <jjia@cs.ubc.ca>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050211111140.64497886BC@sc8-sf-spam1.sourceforge.net>
Message-ID: <Pine.GSO.4.60.0502110314380.12691@columbia.cs.ubc.ca>
References: <20050211111140.64497886BC@sc8-sf-spam1.sourceforge.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Bluez-users] hcitool scan question
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
Date: Fri, 11 Feb 2005 03:35:34 -0800 (PST)

Hi there,

I am running hciemu. hciconfig shows VHCI devices up and running and I can 
l2ping the devices, but when I do hcitool scan I get the following:

# hcitool scan
Scanning ...
Inquiry failed: Connection timed out

hcidump shows the following:

# hcidump -i hci0 -V
HCI sniffer - Bluetooth packet analyzer ver 1.17
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
> HCI Event: Command Complete (0x0e) plen 4
     Inquiry (0x01|0x0001) ncmd 1

Could you give me some ideas about what I should do to make the scan 
working? Can I achieve that with VHCI devices? hcidump shows hci0 is doing 
the job, but the scan doesn't show it.

Regards,
Jack

By the way, my hciconfigure shows the following:

# hciconfig -a
hci0:   Type: VHCI
         BD Address: 7F:00:00:01:00:0A ACL MTU: 192:8 SCO MTU: 64:0
         UP RUNNING PSCAN ISCAN
         RX bytes:0 acl:11 sco:0 events:36 errors:0
         TX bytes:870 acl:13 sco:0 commands:26 errors:0
         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'BlueZ (0)'
         Class: 0x3e0100
         Service Classes: Networking, Rendering, Capturing
         Device Class: Computer, Uncategorized
         HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) LMP Subver: 0x0
         Manufacturer: Qualcomm (29)

hci1:   Type: VHCI
         BD Address: 7F:00:00:01:00:0B ACL MTU: 192:8 SCO MTU: 64:0
         UP RUNNING PSCAN ISCAN
         RX bytes:0 acl:11 sco:0 events:25 errors:0
         TX bytes:735 acl:11 sco:0 commands:19 errors:0
         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'BlueZ (1)'
         Class: 0x3e0100
         Service Classes: Networking, Rendering, Capturing
         Device Class: Computer, Uncategorized
         HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) LMP Subver: 0x0
         Manufacturer: Qualcomm (29)



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
