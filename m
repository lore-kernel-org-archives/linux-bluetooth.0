Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] installing bluez in an access point
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050204195518.97971.qmail@web26410.mail.ukl.yahoo.com>
References: <20050204195518.97971.qmail@web26410.mail.ukl.yahoo.com>
Content-Type: text/plain
Message-Id: <1107547801.6921.103.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 04 Feb 2005 21:10:01 +0100

Hi,

> exuse me but I think that there is a lot of staff here
> ;)
> and please don't answear me in one line like you do
> somtimes " see the howto about ..." ;))))

if I think it is appropriate, I will do that as always. See the paper
from ESR for why.

> okay, if I understand , the protocols are modules and
> the profiles are implemented like apllications(library
> +utils)
> in My DSP i have kernel moduls but not all the moduls
> of 2.6 linux but just moduls that I need for my chip.
> so I have to impleent moduls of blueZ and its profiles
> apllication. I will impleent only profiles that I nedd
> such PAN, CTP,etc... after that I build my kernel in a
> target file that I send to my chip.

For PAN you need the BNEP kernel module and this means you also need the
L2CAP kernel module and the Bluetooth subsystem core.

For CTP you will also need SCO if you haven't connected your device
through an external PCM.

> I would like to know wich profile are present in blueZ
> because when I do
> #man -k bluetooth
> I see just pand and dund profile. how can I find the
> help of other profil If there are implemented in
> bluez.

I see a lot more when I do that, but there exists presentations from me
that have a quite extensive list of supported profiles. You will find
the links to them at the BlueZ website.

> and can you give me modules that I have to add in my
> kernel,because I havn't bluetooth subsystem
> implemented in my chip kernel.

No. You have the source and so do it by yourself.

> in mmy file '/etc/resolv.conf' I have the IP adresse
> of my DNS.
> nameserver 10.10.10.10
> but it dosn't work what's the matter.
> it work for my eth0 interface but not for bnep0????

Basically this is not a BlueZ question. Consult a Linux network howto.

> okay , here is the file /proc/bus/usb/devices.
> and the problem is ; when i plug this usb dongle in
> one PC i cn't see it when i do a scan or an inquery.
> and when I plug it in the second PC the problem is
> diferent it doesn't want to set up it :
> 
> # hciconfig hci0 up
> Can't init device hci0: Device or resource busy (16)

You use the BCM92035 (PID 0x2009) I was lately talking about. A patch
for this dongle can be found in the mailing list archive.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
