Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Fri, 15 Sep 2006 14:00:31 +0200
Message-ID: <59260DC6DFC1CF40B06388D43B284EBB22FF8A@destc0strmsx02.eu.sony.com>
From: "Hohl, Fritz" <hohl@sony.de>
To: <Bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] SBC: Some remarks and a question
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

I (try to) use the SBC package inside btsco 0.42 and want to 
give some feedback on things I noticed:

SBC in general
--------------

Compared to the Philips reference en/decoder, the 
decoded sound using the floating-point version 
is much more quiet. 

The USE_FIXED version is even more quiet (a (signal-disturbing) 
"<<= 2" operation seems to bring the signal to about the original 
level, so it is really quiet).

How much MIPS does the implementation needs?
I read that once some Philips guy told something
about 5 MIPS, but it was not clear what types of 
MIPS he meant nor to which version this applied.
Compared to MP3 encoding and decoding, what are your
experiences?


sbcenc.c
--------

bug?: Files of a size <= the buffer size (i.e. 2048) 
      are not processed.

bug?: not all option shortcuts (-* forms instead of --*) can
      be used (also holds true in sbcdec.c).

feature: I wrote (imperfect) sbcenc and sbcdec versions that consume and
         produce canonical .wav files, respectively.
         Is somebody interested?
         

----addendum 1-----------------------------------------

Proposal to add at least some lines 
to the important functions:

int sbc_encode(sbc_t *sbc, void *data, int count)
----------------------------------------------
Encodes PCM samples into one frame of SBC-encoded data. The PCM samples
starts at data and are of length count. The encoded data 
is of length sbc->len is then stored in sbc->data.

Returns the length of the encoded PCM data

Please note that for encoding an entire stream, you might 
have to use sbc_encode multiple times as it encodes only 
into 1 frame per call. 


int sbc_decode(sbc_t *sbc, void *data, int count)
----------------------------------------------
Decodes one frame of SBC-encoded data. The SBC-encoded data
starts at data and is of length count. The decoded data 
of length sbc->len is then stored in sbc->data.

Returns the length of the frame that was decoded.

Please note that for decoding an entire stream, you might 
have to use sbc_decode multiple times as it decodes only 
1 frame per call. 


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
