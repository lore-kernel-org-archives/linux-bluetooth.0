Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: multi rfcomm/sco connection
From: Marcel Holtmann <marcel@holtmann.org>
To: Radha Thiagarajan <rthiaga1@urbana.css.mot.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4112532E.1010708@urbana.css.mot.com>
References: <20040618175410.28510.qmail@webmail.aruba.it>
	 <1087582530.4309.121.camel@pegasus>
	 <20040618183339.20830.qmail@webmail.aruba.it>
	 <1087583875.25061.2.camel@pegasus>
	 <20040618184232.25439.qmail@webmail.aruba.it>
	 <1087584576.25061.6.camel@pegasus>
	 <20040716140215.564.qmail@webmail2.aruba.it>
	 <1089991775.5119.18.camel@pegasus>  <411166F7.2020500@urbana.css.mot.com>
	 <1091662532.16182.86.camel@pegasus>  <4112532E.1010708@urbana.css.mot.com>
Content-Type: text/plain
Message-Id: <1091726733.20839.10.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 05 Aug 2004 19:25:33 +0200

Hi Radha,

> Thanks for the reply. We will be using SCO over PCM.
> Are you planning on a fix for both the problems?

the point is if you use SCO over PCM then the SCO socket interface is
really useless. My idea is to add an ioctl to the L2CAP and RFCOMM
sockets for adding and releasing a SCO link. Actually I realized that I
never thought about incoming SCO connections for that case. Are there
any proposals for getting a nice SCO over PCM support?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
