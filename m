Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] kernel bug?
From: Marcel Holtmann <marcel@holtmann.org>
To: dsailer <dsailer@paonline.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <007901c4b9fd$76634c20$90a7dcd8@sailers>
References: <417A73C5.10907@paonline.com> <1098550817.4866.7.camel@pegasus>
	 <007901c4b9fd$76634c20$90a7dcd8@sailers>
Content-Type: text/plain
Message-Id: <1098676990.6465.79.camel@pegasus>
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
Date: Mon, 25 Oct 2004 06:03:10 +0200

Hi Dave,

> I haven't tried vanilla yet - I've built this kernel about 100 times, I
> guess once more won't hurt. Will have to wait till I get this box back into
> work where I have broad-band.

you must really try a vanilla one, because the vendor kernels are not
really predictable. However you might wanna try to disable SMP and
preempt and try again. If it not works then report this to the LKML,
because this bug is in the VM and a way out of my knowledge.

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
