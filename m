Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Sebastian Roth <sebastian.roth@esk.fhg.de>
Message-ID: <ctv8ou$aa1$2@sea.gmane.org>
References: <41FA06A5.3010904@tootai.net> <ctdn6n$sqs$1@sea.gmane.org> <41FE4744.5010804@tootai.net> <ctob73$ph0$1@sea.gmane.org> <4200D3B6.1050708@tootai.net> <ctqulk$ce4$1@sea.gmane.org> <420105F0.5030407@tootai.net> <cttbgv$knk$1@sea.gmane.org> <42029A2B.6020905@tootai.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
In-Reply-To: <42029A2B.6020905@tootai.net>
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
Date: Fri, 04 Feb 2005 08:38:50 +0100

Hi Daniel,


> 2.6.10 (debian) + patch swsusp2 & bluez-utils 2.10-5 (debian sid)
As I said before please give it a try and update your kernel with the
current patch from bluez.org and install the latest versions of
utils and lib (source is also available at bluez.org)

Haven't seen any output of the SCO module in your dmesg. Make sure
you have enabled CONFIG_BT_SCO and CONFIG_BT_HCIUSB_SCO in your kernel
config and loaded the module 'sco'!


> #sdptool search --bdaddr 00:0b:2e:06:01:2e 0x1108
[...]
>    Channel: 6
[...]
> nomade:/etc/waproamd/keys# btsco 00:0b:2e:06:01:2e
> Device is 1:0
> Voice setting: 0x0060
> RFCOMM channel 6 connected
> speaker volume: 10 mic volume: 10
Channel should be ok. Now where are the new message from? Does it
work now?

Regards,
Sebastian



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
