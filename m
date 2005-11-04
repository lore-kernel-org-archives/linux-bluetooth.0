Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Disconnecting after 54 seconds
From: Marcel Holtmann <marcel@holtmann.org>
To: matt@matthew.ath.cx
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.63.0511041547530.27685@illythia.matthew.ath.cx>
References: <Pine.LNX.4.63.0511041142190.27685@illythia.matthew.ath.cx>
	 <1131119129.11673.4.camel@localhost.localdomain>
	 <Pine.LNX.4.63.0511041547530.27685@illythia.matthew.ath.cx>
Content-Type: text/plain
Message-Id: <1131122744.11673.12.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Fri, 04 Nov 2005 17:45:44 +0100

Hi Matthew,

> >> Is there some sort of timeout happening here? I thought it might need
> >> activity to keep the link up, but l2ping should do that. Has anyone else
> >> seen anything similar?
> >
> > these are L2CAP echo packets and so this doesn't have to be reliable.
> >
> Having packets dropped I would expect, but I wouldn't expect the HCI
> connection to be dropped regularly like this. This happens consistently
> using hcitool as well, after 54 seconds a link created with hcitool cc
> is dropped.

the "hcitool cc ..." and "l2ping" are for testing purpose only. Use real
connection on RFCOMM level.

> I've read over the FAQ and howtos on bluez.org and none of them appear
> to address this. Are there any low-level protocol docs which would
> suggest some sort of keep-alive which might be necessary? or is this
> likely to be a problem with my phone?
> 

If the phone decides to drop your connection that is fine. From the
security standpoint I would even encourage this.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
