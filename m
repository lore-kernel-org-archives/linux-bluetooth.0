Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] need to patch 2.4.24 kernel?
From: Marcel Holtmann <marcel@holtmann.org>
To: ALBERT RIBAS GUASCH <albert.ribas@estudiants.urv.es>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <91ff49438f.9438f91ff4@estudiants.urv.es>
References: <91ff49438f.9438f91ff4@estudiants.urv.es>
Content-Type: text/plain
Message-Id: <1080812501.3059.8.camel@pegasus>
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
Date: Thu, 01 Apr 2004 11:41:41 +0200

Hi Albert,

> I find that some utils like l2test,scotest, hciemud
> and hcidump cannot be found in the system, so I
> would like to know if I need to patch this kernel
> with one of your patches or do I need to install
> bluez-utlis and bluez-libs (I thought they were
> included in the kernel) in order to have these utils??.

utilities are never included in the kernel. The *test programs are part
of bluez-utils and they are never installed by default. The hcidump and
hciemu are seperate source packages.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
