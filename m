Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] More SDP UUIDs...
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Stephen Crane <steve.crane@rococosoft.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20030916195333.GA25068@bougret.hpl.hp.com>
References: <20030915221624.GA17085@bougret.hpl.hp.com>
	<1063712005.22723.27.camel@pegasus>
	<20030916195333.GA25068@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1063755753.29942.9.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 17 Sep 2003 01:42:27 +0200

Hi Jean,

> 	While you are at it, would you mid to do the following :
> 	o rename sdp_uuid_cmp() to sdp_uuid128_cmp(). The current name
> totally confused me.

who are the current users of sdp_uuid_cmp() ?

> 	Or make it two libraries.

The goal is to have only one Bluetooth library. But we care about the
embedded people, so comments are welcome.

> 	I hope you will keep the --tree browsing option in sdptool,
> because the default browsing is useless for advanced stuff. The
> display might be ugly, but at least it display everything and the
> basic infrastructure is sound.

Of course, because that is the only output that matters to me and I
don't find the tree output so ugly. This is an example output of my
Bluespoon headset from my code:

Sequence
        Attribute 0x0000 - Service record handle
                UINT32 0x00010000
        Attribute 0x0001 - Service class ID list
                Sequence
                        UUID16 0x1108 - Headset
                        UUID16 0x1203 - Generic Audio
        Attribute 0x0004 - Protocol descriptor list
                Sequence
                        Sequence
                                UUID16 0x0100 - L2CAP
                        Sequence
                                UUID16 0x0003 - RFCOMM
                                UINT8 0x01
        Attribute 0x0009 - Bluetooth profile descriptor list
                Sequence
                        Sequence
                                UUID16 0x1108 - Headset
                                UINT16 0x0100
        Attribute 0x0100
                String Headset
        Attribute 0x0302
                Bool True

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
