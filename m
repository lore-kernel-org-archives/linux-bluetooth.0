Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4587D051.8080703@jambit.com>
Date: Tue, 19 Dec 2006 12:43:13 +0100
From: =?ISO-8859-1?Q?Frank_Heimb=E4cher?= <frank.heimbaecher@jambit.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44F6B7AE.1030209@jambit.com> <4582A310.60905@jambit.com>
	<4583A020.2040808@xmission.com>
In-Reply-To: <4583A020.2040808@xmission.com>
Subject: [Bluez-devel] How to use sbc.c ?
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

Thanks a lot, Brad.

What succeeded: With an older version of sbc.c I managed to encode a wav
file, send it over the air and receive it, decode it and write it in a
file. Well, it looks different than the original. In the original there
is some information in the first bytes like: "WAVEfmt", a long area with
zero bytes, then the characters "data" and then the data seems to begin.
I do not find this in my received file. Is there something else I have
to care about? Should I run sbcinfo and change sbc_init() according to
the results?

The newest download of sbc.c from http://sbc.cvs.sourceforge.net/sbc/
under menu "CVS Browse" contains a simple bug, which lets the file
compile, but crash on runtime: In function _sbc_analyze_eight() the
array 't[8]' is referenced from t[1] to t[8], instead of t[0] to t[7].

Thanks a lot
Frank

Brad Midgley schrieb:
> Frank
> 
> fyi, I moved the reply to bluez-devel.
> 
>> sbc_encode: It seems like you put pcm data on 'data' and get sbc data in
>>  'sbc.data'. 'count' is not used in the function. How often must I call
>> it? How do I know how much of 'data' is converted already?
> 
> the return value from sbc_encode is the number of bytes consumed. It's
> true that count is not used properly. In fact we assume there is enough
> data there to fill one sbc frame.
> 
>> sbc_decode: Put sbc data on 'data' and you get pcm data in 'sbc.m.data'.
>> Is that right? Must I always change the byte order like it is done in
>> a2recv.c?
> 
> The swapping was to accommodate bugs in the audio driver's endian
> processing on gumstix. You can ignore it.
> 
>> Are there special things to do if I have a .wav file or do I just have
>> to call the functions? I am just talking of the payload and not the
>> headers.
> 
> be sure you init the encoder with the correct channels (1 or 2) and
> sample rate. after that just be sure to pass enough data to sbc_encode
> in each pass so it doesn't underrun.
> 
>> It would help me a lot if somebody could put me on the right track.
> 
> Be sure you are using the separate sbc sourceforge project since that's
> the version of the codec we are maintaining. Finally, we'd appreciate
> any patches you come up with to improve the code documentation or even
> more if you address any of the limitations. Documentation of course is a
> problem, but there's also a todo list at the top of sbc.c.
> 
> Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
