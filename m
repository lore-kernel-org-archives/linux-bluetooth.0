Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] More SDP UUIDs...
From: Marcel Holtmann <marcel@holtmann.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Stephen Crane <steve.crane@rococosoft.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20030917000637.GA26969@bougret.hpl.hp.com>
References: <20030915221624.GA17085@bougret.hpl.hp.com>
	<1063712005.22723.27.camel@pegasus>
	<20030916195333.GA25068@bougret.hpl.hp.com>
	<1063755753.29942.9.camel@pegasus>
	<20030917000637.GA26969@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1063758501.29942.47.camel@pegasus>
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
Date: 17 Sep 2003 02:28:15 +0200

Hi Jean,

> > who are the current users of sdp_uuid_cmp() ?
> 
> 	As far as I can see, it's only used internally, like this :
> 
> record.c:       if (sdp_list_find(rec->pattern, uuid128, sdp_uuid_cmp) == NULL)
> record.c:               rec->pattern = sdp_list_insert_sorted(rec->pattern, uuid128, sdp_uuid_cmp);
> 
> 	I believe that it can only work with the server records,
> because it require all UUIDs to be 128, whereas the UUID you get as a
> client are UUID16. That's why I needed the other function :
> 
> 	  if(sdp_list_find(services, &service_nap, sdp_uuid16_cmp) != NULL)

please send me a patch, with the modified code above, your function name
change and the extra function.

> > Of course, because that is the only output that matters to me and I
> > don't find the tree output so ugly. This is an example output of my
> > Bluespoon headset from my code:
> > 
> > Sequence
> >         Attribute 0x0000 - Service record handle
> >                 UINT32 0x00010000
> >         Attribute 0x0001 - Service class ID list
> >                 Sequence
> >                         UUID16 0x1108 - Headset
> >                         UUID16 0x1203 - Generic Audio
> >         Attribute 0x0004 - Protocol descriptor list
> >                 Sequence
> >                         Sequence
> >                                 UUID16 0x0100 - L2CAP
> >                         Sequence
> >                                 UUID16 0x0003 - RFCOMM
> 
> 	This looks much better than what I have with sdp-1.2, it seems
> that you have done some nice cleanup. Wonderful ;-)
> 
> >                                 UINT8 0x01
> 
> 	Why is this one broken ? In version 1.2, it should display
> "Channel/Port".
> 
> >         Attribute 0x0009 - Bluetooth profile descriptor list
> >                 Sequence
> >                         Sequence
> >                                 UUID16 0x1108 - Headset
> >                                 UINT16 0x0100
> 
> 	I can't help on this one, but that would be easy to add.
> 
> >         Attribute 0x0302
> >                 Bool True

I forgot to mention that I started from scratch and the output you see
above is a textual presentation of the new internal data structure. The
core attributes id's and the UUID16's are decoded into strings, because
they are unique. All other meanings of some data elements depends on
others. I have to add some checks which makes sure that this is a valid
SDP record, before I can do this.

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
