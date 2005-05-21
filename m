Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <428E7D72.3030501@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] libsbc optimizing
References: <428BD03E.9000307@xmission.com> <20050521000412.1499f11e.henryk@ploetzli.ch>
In-Reply-To: <20050521000412.1499f11e.henryk@ploetzli.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Fri, 20 May 2005 18:14:42 -0600

Henryk

> This doesn't particularly aid readability so I'd suggest to keep the old
> code in a comment

ok

> I thought about it: Do you have long integers on that platform or will
> they be slow too? Basically there should be no number greater than 2^16
> anywhere (I'll have to check that, though) and we only need add,
> multiply and shift. 

32-bit ints are not costly, but >32 probably are too expensive.

> A naive fixed point implementation would be to use a 32 bit integers and
> shift the original value left 16 bits (multiplying by 2^16) leaving 16
> bits before and 16 bits after the decimal point. Add and Shift will work
> as usual, but for multiply additional 16 bits (e.g. an integer type with
> at least 48 bits) are needed.

uclibc provides an fp emulation library that is already doing a naive 
implementation. On a 400mhz pxa255, it works (sort of) for a2dp sink but 
only if encoding parameters are set low. It doesn't work for a2dp 
source--it only produces some choppy audio and then drops out completely.

maybe we just need to break floats into two ints. using rationals 
(numerator/denominator) is what i was thinking when I saw that first fp 
division by bits[][].

Brad


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
