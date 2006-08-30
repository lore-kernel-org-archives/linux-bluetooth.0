Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <61544.84.168.23.219.1156917000.overlook@webmail.prodigy7.de>
In-Reply-To: <1156888343.4026.39.camel@aeonflux.holtmann.net>
References: <44F1A585.8050408@prodigy7.de>
	<1156888343.4026.39.camel@aeonflux.holtmann.net>
Date: Wed, 30 Aug 2006 07:50:00 +0200 (CEST)
From: "Manuel Bernhardt" <mailinglist@prodigy7.de>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Can't use capi/cmtp with bfusb
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

Hi Marcel,

> I think the problem is that your CPU is big endian and the CAPI
> subsystem is not working on big endian systems. I tried to fix it at one
> point, but never succeeded.

thank you for this information. That means, that i should annoy the
ISDN4Linux-Mailinglist (or which project/group is the right contact point
in your opinion?) with my concern? If you say, you need only an System for
testing and it's no big job, do this big endian changes, I also could give
you temporary access to my ppc-box for developing. I'm not an c/c++
expert, but if i can contribute to open source by giving access to
hardware, I do it.

I search now a long time for a way, get CAPI on one of my NAS and now i
thought, i found a way because the bluefritz usb stick doesn't need
hardware depended firmware (i tried first an "old" fritz!x but avm
rejected my request for an ppc firmware) but now the kernel code doesn't
match the requirements... "nice"

Manuel


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
