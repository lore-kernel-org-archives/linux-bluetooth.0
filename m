Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-users] sniff mode 
Message-ID: <EFCD68F7BFDB06468769D4D9EAAA93870972B18F@scsmsx401.amr.corp.intel.com>
From: "Pering, Trevor" <trevor.pering@intel.com>
To: <bluez-users@lists.sourceforge.net>
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
Date: Wed, 16 Nov 2005 08:40:30 -0800

Thanks everybody for their help.... I got sniff mode working...

1) the BT device I was using didn't seem to really support it (it said
it did, but would reject all options to the command) -- so, I found a
more-recent device
2) I was sending commands in the wrong order through hcitool cmd
(big-endian instead of little endian)=20

Cheers,
	Trevor


-----Original Message-----
From: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net] On Behalf Of Peter
Stephenson
Sent: Monday, November 14, 2005 2:28 AM
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] sniff mode=20

"Pering, Trevor" wrote:
> Thanks, Marcel. See the output below.  It says "Unsupported Feature of
> Parameter value" -- so, I suppose this means either that the feature
> isn't supported by my particular BT device, or that I'm getting
> something wrong :-).  This is a fairly new SilliconWave dongle, so I
> would assume it would work...   (I've also tried with other devices
with
> similar results).

If you're doing this via raw HCI, make sure you or the host stack has
sent HCI_write_link_policy_settings (or
HCI_write_default_link_policy_settings) at both ends to allow sniff
mode.  I believe bluez does this if you have the hcid.conf set up
correctly.

pws


This message has been scanned for viruses by BlackSpider MailControl -
www.blackspider.com


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server.
Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
