Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Timeout message from kernel
From: Marcel Holtmann <marcel@holtmann.org>
To: Jeff Sutherland <jeffs@fairwayacademy.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402132310.53881.jeffs@fairwayacademy.org>
References: <200402121636.02074.jeffs@fairwayacademy.org>
	 <200402131858.51524.jeffs@fairwayacademy.org>
	 <1076717197.18588.109.camel@pegasus>
	 <200402132310.53881.jeffs@fairwayacademy.org>
Content-Type: text/plain
Message-Id: <1076748792.18588.152.camel@pegasus>
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
Date: Sat, 14 Feb 2004 09:53:13 +0100

Hi Jeff,

> > the endian stuff looks fine in the l2test.c source. What endian do the
> > Coldfire processor use?
> 
> Big Endian.

maybe we really have some endian problems here and also in hcitool. The
pkt_type for create_connection is for example uint16 and this explains
why "hcitool info ..." fails. I don't have access to a machine with big
endian, so most of the userspace tools are not fully tested.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
