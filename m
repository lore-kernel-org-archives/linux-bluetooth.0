Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] ms explorer for bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: neoclust <n1c0l4s.l3@wanadoo.fr>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200410141348.12452.n1c0l4s.l3@wanadoo.fr>
References: <200410122022.30501.n1c0l4s.l3@wanadoo.fr>
	 <200410140046.41141.n1c0l4s.l3@wanadoo.fr>
	 <1097753304.4640.47.camel@notepaq>
	 <200410141348.12452.n1c0l4s.l3@wanadoo.fr>
Content-Type: text/plain
Message-Id: <1098014604.4911.56.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 17 Oct 2004 14:03:25 +0200

Hi Nicholas,

> > use "hcitool info 00:50:F2:80:A1:2B" as root. Maybe you need to pair and
> > the device is still waiting for the PIN. So enter a PIN on the number
> > key of your keyboard and press enter. If a PIN box pops up on your PC
> > enter the same PIN. And always run "hcidump -x" as root to see happens
> > on the link.
> 
> 
> # hcitool info 00:50:F2:80:A1:2B
> Requesting information ...
>         BD Address:  00:50:F2:80:A1:2B
>         Device Name: Microsoft Keyboard
>         LMP Version: 1.1 (0x1) LMP Subversion: 0x1df
>         Manufacturer: Cambridge Silicon Radio (10)
>         Features: 0xfc 0xfb 0x0f 0x00 0x00 0x00 0x00 0x00
>                 <encryption> <slot offset> <timing accuracy> <role switch>
>                 <hold mode> <sniff mode> <park state> <RSSI> <SCO link>
>                 <HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>
>                 <paging scheme> <power control> <transparent SCO>
> 
> i have no popup asking for PIN

this is the first generation of the Microsoft keyboard. It works
perfect, but maybe you set auth and encrypt in hcid.conf and forced
yourself to be in security mode 3. Don't do that and start checking the
mailing list archive.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
