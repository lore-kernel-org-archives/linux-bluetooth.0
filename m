Return-Path: <thomae@ei.tum.de>
Message-ID: <3FDECECD.2050001@ei.tum.de>
Date: Tue, 16 Dec 2003 10:22:21 +0100
From: Matthias Thomae <thomae@ei.tum.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Stephen Crane <steve.crane@rococosoft.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] New Bluetooth kernel patches available
References: <1071505820.6499.80.camel@pegasus>	 <1071507511.26243.452.camel@baroque.rococosoft.com> <1071528118.6526.126.camel@pegasus>
In-Reply-To: <1071528118.6526.126.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Stephen, Marcel, all,

Marcel Holtmann wrote:
>>2.4.18 is needed for the Sharp Zaurus (ROM 3.10) and actually using a BT
>>keyboard would be way cool :-)

I think so, too, especially when there are foldable keyboards available 
:), see http://www.heise.de/newsticker/data/dal-11.12.03-000/

> do you know what Bluetooth stack is used by Sharp in their ROM?

AFAIK, they have no built-in bluetooth support, but there is a variant 
of the Sharp ROM from theKompany 
(http://www.thekompany.com/embedded/rom/) which has BlueZ support 
(stemming from http://tumnus.zaurii.net/, please anyone correct me if I 
am wrong).

Also, the current testing version of OpenZaurus (3.3.5) 
(http://www.openzaurus.org/oz_website/content/news)
uses a 2.4.18 kernel, and bluez seems to run with the packages from 
tumnus and an Anycom CF card on my SL-5500.

However, the OZ developers see the 2.4.18 based OZ as an interim 
solution until they have their own port of the 2.4.21 kernel, see 
http://openzaurus.org/newsletters/2003.12/

So it would be nice if the 2.4.21 could also be maintained!

But maybe Marcel would want to contact the OZ developers directly (e.g. 
via openzaurus-devel@lists.sourceforge.net) to talk about their plans. I 
am sure they are interested in BlueZ support for OZ, especially with the 
coming Zaurus SL-6000 that has a built-in bluetooth module.

Regards.
Matthias
