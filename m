Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Andreas Beck <becka-bzdvl@bedatec.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Voice setting for U-law and A-law.
Message-ID: <20050924110338.GA5416@uni-duesseldorf.de>
References: <8441772.1127557236734.JavaMail.Administrator@appsrv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8441772.1127557236734.JavaMail.Administrator@appsrv>
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
Date: Sat, 24 Sep 2005 13:03:38 +0200

Ivy <ivy@cashette.com> wrote:

>    xxxxxx01xxxxxxxx Input Coding: u-law 
>    xxxxxxxx01xxxxxx Input Data Format: 2"s complement 
> ( what is the advantage of 2's complement that 1's com ?).

Actually I don't think this makes sense for ulaw/alaw, as AFAIK these
are always 8 bit, as they were designed for telephony channels (ISDN)
that operate at 64kbit, thus giving 8kSamples/s at 8 bit.

The alaw/ulaw encoding gives a somewhat logarithmic scale which gives
better dynamic range at the expense of small details the human ear
doesn't recognize well anyway.

For linear, the difference is in the coding of negative numbers.
1s complement will code negative numbers as their positive equivalent 
XOR 0xffff (i.e. a word with all-one bits). This is a rater uncommon
coding scheme. It has the odditiy of having a +0 (0x0000) and a 
-0 (0xffff). 2s complement will add 1 after the above step, which 
has the advantage of simple handling of arithmetic operations with
common ALUs designed for unsigned numbers. It just works - only thing
you have to adjust is handling of overflow flags.
Another advantage is a slightly increased range of values (-32768 to
32767 at 16 bit as compared to -32767 to 32767 at 1s complement)
at the expense of an asymmetric value range.

>  xxxxxxxxxx1xxxxx Input Sample Size: 16 bit   (Can i use 8 bit ?) 

IMHO you should, if you want alaw/ulaw.

>  (what does it  mean "ONly FOR Linear PCM in Documentation ?).  

I suppose these bits get ignored for formats other than linear PCM, as
ulaw/alaw are inherently 8 bits.

> xxxxxxxxxxx010xx # of bits padding at MSB: 2 (if i use 16 Bit, 
> 2bit's of MSB is needed for padding, coz only 14bits are enough 
> for u-law) 

AFAIK 8 bits are enough - could you explain?


CU, Andy

-- 
= Andreas Beck                    |  Email :  <becka-sig@bedatec.de>         =


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
