Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Cross-compile pand to Arm system problem
From: Marcel Holtmann <marcel@holtmann.org>
To: =?UTF-8?Q?=E9=BB=83=E5=AD=90?= =?UTF-8?Q?=E5=84=80?= <sammy@autumn.ccl.itri.org.tw>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <021d01c46ed2$1b00eed0$7053608c@ccl.itri.org.tw>
References: <021d01c46ed2$1b00eed0$7053608c@ccl.itri.org.tw>
Content-Type: text/plain
Message-Id: <1090395444.21683.39.camel@pegasus>
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
Date: Wed, 21 Jul 2004 09:37:24 +0200

Hi Sammy,

> I download bluez-utils-2.7.tar.gz and bluez-lib-2.7.tar.gz
> and cross-compile the pand daemon to arm-uclibc-gcc environment smoothly.
> The process includes cross-compile bluez-lib firstly.
> and copy the pand daemon to my all embedded system.(bnep module is ok too)
> i hope they can be connected by pand.

use the and bluez-libs-2.8 and bluez-utils-2.8, because I included some
fixes for pand in that release.

> But it always show the message like "bcsp_timed_event: Timeout, retransmitting 1 pkts"
> of course the line is not connected.(But i try hcitool cc solution it can work.)

You can ignore this error, because it only tells you that it lost one
packet and it is now going to resend it. I will change that error into a
debug message.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
