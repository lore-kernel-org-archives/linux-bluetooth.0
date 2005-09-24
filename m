Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Andreas Beck <becka-bzdvl@bedatec.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Voice setting for U-law and A-law.
Message-ID: <20050924113216.GB5529@uni-duesseldorf.de>
References: <10232381.1127560888625.JavaMail.Administrator@appsrv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <10232381.1127560888625.JavaMail.Administrator@appsrv>
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
Date: Sat, 24 Sep 2005 13:32:16 +0200

Ivy <ivy@cashette.com> wrote:
> > >  xxxxxxxxxx1xxxxx Input Sample Size: 16 bit   (Can i use 8 bit ?) 
> > IMHO you should, if you want alaw/ulaw.
> You meant to use 16 Bit or 8 bit ?..

8 bit.

> > > xxxxxxxxxxx010xx # of bits padding at MSB: 2 (if i use 16 Bit, 
> > > 2bit's of MSB is needed for padding, coz only 14bits are enough 
> > > for u-law) 
> > AFAIK 8 bits are enough - could you explain?
> U-LAW takes 14bits of linear PCM data as input and generates 8 bit 
> compressed data. Am i correct ?

Yes. That is correct.

> Thatswhy i assume that it needs 16 bits for INPUT Sample size and 
> 2 bit offset in MSB position. 

No - I suppose this is a misunderstanding about "input".

The SCM link via bluetooth uses its own encoding anyway (see the 
comment about on air coding at the end of the list).

INPUT means what you feed in/get out at the driver side.

That is, if you choose alaw, you already feed alaw data.

Otherwise you could just use linear anyway. There would be no use in
converting to alaw first and then again to the air coding format.

Basically you will want to use alaw/ulaw, if you want to feed the
received data directly into a device that wants this data format anyway,
saving unnecessary conversions.


CU, ANdy


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
