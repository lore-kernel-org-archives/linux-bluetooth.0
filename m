Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <450ABCAB.6020809@xmission.com>
Date: Fri, 15 Sep 2006 08:46:03 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <59260DC6DFC1CF40B06388D43B284EBB22FF8A@destc0strmsx02.eu.sony.com>
In-Reply-To: <59260DC6DFC1CF40B06388D43B284EBB22FF8A@destc0strmsx02.eu.sony.com>
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

Fritz

I'm glad someone is having a look. Yes, we have some work to do here.

fyi, we're trying to limit changes to the fixed-point only version in
the sbc sourceforge project. It does have volume problems but we'd like
to hammer them out so fixed point is what everybody uses.

> The USE_FIXED version is even more quiet (a (signal-disturbing) 
> "<<= 2" operation seems to bring the signal to about the original 
> level, so it is really quiet).

there are some ops like this that are to avoid fixed point overflows.
when the encoder overflows, it generates an annoying "pop" noise in the
stream.

> How much MIPS does the implementation needs?
> I read that once some Philips guy told something
> about 5 MIPS, but it was not clear what types of 
> MIPS he meant nor to which version this applied.
> Compared to MP3 encoding and decoding, what are your
> experiences?

I haven't measured it and I've only tried it on a pxa255 at 400mhz but I
think someone had success with an arm 7...

> sbcenc.c
> --------
> 
> bug?: Files of a size <= the buffer size (i.e. 2048) 
>       are not processed.

that would explain why some songs end prematurely

> 
> bug?: not all option shortcuts (-* forms instead of --*) can
>       be used (also holds true in sbcdec.c).

it would be nice to be consistent in the args

> 
> feature: I wrote (imperfect) sbcenc and sbcdec versions that consume and
>          produce canonical .wav files, respectively.
>          Is somebody interested?

sbcenc/dec are part of the "playground" which is there for testing and
development. If your additions make that easier then they'd be nice to have.

>          
> 
> ----addendum 1-----------------------------------------
> 
> Proposal to add at least some lines 
> to the important functions:
> 
> int sbc_encode(sbc_t *sbc, void *data, int count)
> ----------------------------------------------
> Encodes PCM samples into one frame of SBC-encoded data. The PCM samples
> starts at data and are of length count. The encoded data 
> is of length sbc->len is then stored in sbc->data.
> 
> Returns the length of the encoded PCM data
> 
> Please note that for encoding an entire stream, you might 
> have to use sbc_encode multiple times as it encodes only 
> into 1 frame per call. 
> 
> 
> int sbc_decode(sbc_t *sbc, void *data, int count)
> ----------------------------------------------
> Decodes one frame of SBC-encoded data. The SBC-encoded data
> starts at data and is of length count. The decoded data 
> of length sbc->len is then stored in sbc->data.
> 
> Returns the length of the frame that was decoded.
> 
> Please note that for decoding an entire stream, you might 
> have to use sbc_decode multiple times as it decodes only 
> 1 frame per call. 

which problems are these proposals addressing?

brad

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
