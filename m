Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Ruben Jenster <RJenster@web.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] link_key pairing problem
References: <200505211500.37962.ruben@hotheads.de> <200505251724.23452.RJenster@web.de> <1117036303.30044.236.camel@pegasus>
In-Reply-To: <1117036303.30044.236.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200505252234.34210.RJenster@web.de>
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
Date: Wed, 25 May 2005 22:34:34 +0200

Hi Marcel,

>
> both are CSR based and they should work without any problems. If you
> find a note about "full reset" of your headset in its manual, then you
> maybe should try that.
>

No, the headset does not have a full reset funktion.
But really think it's not the headset as it does work perfecly with the 
builtin bluetooth module of the thinkpad which is also CSR based.

hci0:   Type: USB
        BD Address: 00:20:E0:7D:21:C7 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:143 acl:0 sco:0 events:19 errors:0
        TX bytes:317 acl:0 sco:0 commands:17 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'Thinkpad (0)'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x222 LMP Ver: 1.1 (0x1) LMP Subver: 0x222
        Manufacturer: Cambridge Silicon Radio (10)

Maybe I fool myself but I think the dongle is the basic problem. The best 
would be if someone who  has the same or at least a dongle with the same chip 
revision could deny or confirm this behaviour
Although it's not a solution at the moment I feel comfortable with /dev/zero 
symlinked to link_key.

Regards

Ruben


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
