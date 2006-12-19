Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <08C55293-7564-45BD-B18C-571EBC240FEC@gothpunk.com>
References: <mailman.247983.1166465173.8777.bluez-users@lists.sourceforge.net>
	<08C55293-7564-45BD-B18C-571EBC240FEC@gothpunk.com>
Date: Tue, 19 Dec 2006 10:43:49 +0100
Message-Id: <1166521429.29972.10.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] why does one need bluez-firmware ?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Steve,

> >>> I read on some web pages that one need bluez-firmware to be able to
> >>> operate the BroadCom 203x series bluetooth dongle correctly on a 2.4
> >>> kernel. So I am wondering what is the purpose of bluez-firmware? And
> >>> how does it work?
> >>
> >> that is a misunderstanding. For the 2.6 kernel you use a kernel  
> >> module
> >> to load the firmware. For 2.4 an extra USB application was needed.  
> >> Both
> >> however need the firmware files.
> >
> > And what is the purpose of bluez-firmware? How does it work?
> 
> The USB dongles themselves are stupid and don't have operational  
> firmware in them.

most of them actually do have the firmware in flash or RAM. Only a few
need a firmware download before they can be used.

> It's a cost-saving measure. By using uploadable firmware, the  
> manufacturer (Dlink, Linksys, whoever)
> doesn't have to make a Windows version and a Mac version and a Linux  
> version.
> They just make one type of device and then ship the appropriate  
> firmware blob on the drivers CD.

This is a generalization from the WiFi world and it is simply not true.
Only a minor number of devices need a firmware download.

> So the real reason you need the BlueZ firmware is that the driver has  
> to upload the right firmware(in this case, for Linux) into the
> bluetooth module itself, otherwise it won't work.

Just to make it clear. You are talking about a firmware download. You
download firmware to the device. An upload would mean to extract the
firmware from the device.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
