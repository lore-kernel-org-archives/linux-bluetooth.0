Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluez-devel]
From: Marcel Holtmann <marcel@holtmann.org>
To: blookk - <blookk@hotmail.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY1-F42k6kvXsn2Yf00002fe32@hotmail.com>
References: <BAY1-F42k6kvXsn2Yf00002fe32@hotmail.com>
Content-Type: text/plain
Message-Id: <1096917898.20349.57.camel@pegasus>
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
Date: Mon, 04 Oct 2004 21:24:59 +0200

Hi,

> When I load with "insmod" rfcomm, the kernel give me this error:
> "
> Oct  4 19:03:22 clavijo modprobe: modprobe: Can't locate module bt-proto-0
> Oct  4 19:03:22 clavijo kernel: rfcomm_add_listener: Create socket failed -2
> "
> Which is the solution?

do a "modprobe l2cap" first.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
