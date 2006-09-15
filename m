Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Fri, 15 Sep 2006 17:15:25 +0200
Message-ID: <59260DC6DFC1CF40B06388D43B284EBB22FF8E@destc0strmsx02.eu.sony.com>
From: "Hohl, Fritz" <hohl@sony.de>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SBC: Some remarks and a question
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello,
 
> > The USE_FIXED version is even more quiet (a (signal-disturbing) "<<=

> > 2" operation seems to bring the signal to about the original level,
so 
> > it is really quiet).
> there are some ops like this that are to avoid fixed point overflows.
> when the encoder overflows, it generates an annoying "pop" 
> noise in the stream.

Certainly. I just want to point out that the encoded-decoded sound
differs in loudness from the original by a multiplication factor of 4
(on the PCM signal). That is quite an amount...

> > How much MIPS does the implementation needs?
> > I read that once some Philips guy told something about 5 MIPS, but
it 
> > was not clear what types of MIPS he meant nor to which version this
applied.
> > Compared to MP3 encoding and decoding, what are your experiences?
> I haven't measured it and I've only tried it on a pxa255 at 
> 400mhz but I think someone had success with an arm 7...

I tried it with a 80Mhz MicroBlaze, and it seem to work in real-time (at
least 
either encoding or decoding), but still, the implementatio seems to me
to use much more 
compute power than 1/10 of the MP3 encoding or 1/5 of the MP3 decoding
needs.

> > ----addendum 1-----------------------------------------
> > Proposal to add at least some lines
> > to the important functions:
> which problems are these proposals addressing?

The problem of not having any documentation for the ones that 
want to use the codec on the sbc_encode and sbc_decode level?

One of my several problems to understand the software was e.g. 
to know that the PCM data for encoding and the decoded PCM
data is Little Endian.

Regards,
  Fritz

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
