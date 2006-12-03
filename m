Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <8f75d250611291439m6a26ca3en9261e81280a07985@mail.gmail.com>
References: <8f75d250611291439m6a26ca3en9261e81280a07985@mail.gmail.com>
Date: Sun, 03 Dec 2006 14:50:46 +0100
Message-Id: <1165153846.19590.33.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] HID create error 2 (no such file or directory)
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

Hi Viktor,

> I would like to use my sonyericsson k750 as a remote controller. The
> mobile knows HIDD, so I have allowed it. Now it seems that I can
> connect, but when I touch the buttons on the mobile nothing happens.
> In the syslog I get the following message: HID create error 2 (no such
> file or directory)
> 
> I used hcidump also. Given that its output is quite long, and I do not
> want to enerve you with it, you can read it at
> http://blog.educomm.hu/tmp/hcidump.txt

use "hcidump -X -V" as root. Otherwise it is useless.

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
