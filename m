Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluez Patches for kernel v2.4
From: Marcel Holtmann <marcel@holtmann.org>
To: Bhatt Abhi-ABHATT <ABHISHEK.BHATT@motorola.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5987A7CB1694D811A04D0002B32C289601BF3C17@il93exb05.corp.mot.com>
References: 
	 <5987A7CB1694D811A04D0002B32C289601BF3C17@il93exb05.corp.mot.com>
Content-Type: text/plain
Message-Id: <1099322702.16247.116.camel@pegasus>
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
Date: Mon, 01 Nov 2004 16:25:02 +0100

Hi Abhi,

one small note, please don't send HTML emails to the mailing list. The
good old ASCII ones are perfect.

> I work on kernel v2.4 and I would be interested in having some of the
> new bluez patches for kernel v2.6 applied to v2.4.
> 
> I believe there are no new feature patches for kernel v2.4 and new
> features are only being developed for kernel v2.6. Is
> 
> there someone out there who also works on v2.4 and if so I would like
> to know if there is a better way to put in the new
> 
> kernel patches (for e.g. patch-2.6.9-mh3) to v2.4 other than manually
> putting them in.

there are some pending security and bugfix patches for the 2.4 kernel
that I may put out next week. However there is no plan to backport any
of these new features to 2.4 and actually this will consume a lot of
time (even for me) and more time for testing them. And time is money as
you know ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
