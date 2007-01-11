Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45A5F6DD.7020904@palmsource.com>
Date: Thu, 11 Jan 2007 09:35:41 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44F6B7AE.1030209@jambit.com>	<4582A310.60905@jambit.com>	<4583A020.2040808@xmission.com>	<4587D051.8080703@jambit.com>	<458864F1.4070104@xmission.com>	<4589371F.2000507@palmsource.com>
	<45A54D5B.8030001@xmission.com>
In-Reply-To: <45A54D5B.8030001@xmission.com>
Subject: Re: [Bluez-devel] How to use sbc.c ?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Brad,

Thank you for answering, I was hesitating between precalculation or =

custom tables.

I've not been really deep into the codec now. It's not easy to follow as =

the spec itself could be more clear.

In my investigations, I got over a 64 bits version of the codec. I =

tested it on pc and arm. It gave better results than the 32 bits : the =

gain is better, the overflow do not occurs, there is still a bit of =

background noise, but not more than the 32 bits and it may be the sample =

file. It will probably consume a little bit more cpu, but I found this =

was not really noticeable (at least on my hardware). But the library =

could be changed according to needs.

While this is not the best solution to the problem, I still think users =

are complaining mainly about gain. So it could be possible to provide it =

as default. What about you?

Regards,
Fr=E9d=E9ric.

Brad Midgley a =E9crit :
> Fr=E9d=E9ric
>
> Somehow this message went to my junk folder!
>
> The tables we have are different because we have changed the algorithm
> over time and adapted the tables to avoid some computation. We also
> split the tables as a result of how they are used.
>
> On top of that, we converted the values to integers which doesn't help
> make it easy to follow.
>
> I hope it's not impossible to follow :(
>
> Brad
>
>   =

>>>> The newest download of sbc.c from http://sbc.cvs.sourceforge.net/sbc/
>>>> under menu "CVS Browse" contains a simple bug, which lets the file
>>>> compile, but crash on runtime: In function _sbc_analyze_eight() the
>>>> array 't[8]' is referenced from t[1] to t[8], instead of t[0] to t[7].
>>>>     =

>>>>         =

>>> fixed. thanks.
>>>   =

>>>       =

>> some values were missed so the sound is now larsenized ;)
>> patch attached.
>>
>> BTW, I was looking for the tables specially Proto_4_40 and Proto_8_80
>> from a2dp specifications.
>> I suspect they are stored in sbc_proto_8_80m0 and sbc_proto_8_80m1.
>> The values are not the same that in the spec. Do you know why?
>>
>>
>> ------------------------------------------------------------------------
>>
>> ? Doxyfile
>> ? Makefile
>> ? Makefile.in
>> ? aclocal.m4
>> ? autom4te.cache
>> ? config.guess
>> ? config.h
>> ? config.h.in
>> ? config.log
>> ? config.status
>> ? config.sub
>> ? configure
>> ? debug
>> ? depcomp
>> ? install-sh
>> ? libtool
>> ? ltmain.sh
>> ? missing
>> ? sbc.kdevelop
>> ? sbc.kdevelop.pcs
>> ? sbc.kdevses
>> ? sbc.pc
>> ? stamp-h1
>> ? include/Makefile
>> ? include/Makefile.in
>> ? lib/.deps
>> ? lib/.libs
>> ? lib/Makefile
>> ? lib/Makefile.in
>> ? lib/libsbc.la
>> ? lib/sbc.lo
>> ? src/.deps
>> ? src/.libs
>> ? src/Makefile
>> ? src/Makefile.in
>> ? src/sbcinfo
>> Index: lib/sbc.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> RCS file: /cvsroot/sbc/sbc/lib/sbc.c,v
>> retrieving revision 1.8
>> diff -u -r1.8 sbc.c
>> --- lib/sbc.c	19 Dec 2006 22:13:41 -0000	1.8
>> +++ lib/sbc.c	20 Dec 2006 12:58:09 -0000
>> @@ -892,84 +892,84 @@
>>  	MULA(res, -_sbc_proto_8[21], in[75]);
>>  	t[7] =3D SCALE8_STAGE1(res);
>>  =

>> -	MUL(res, _anamatrix8[0], t[1]);
>> -	MULA(res, _anamatrix8[7], t[2]);
>> -	MULA(res, _anamatrix8[2], t[3]);
>> -	MULA(res, _anamatrix8[3], t[4]);
>> -	MULA(res, _anamatrix8[6], t[5]);
>> -	MULA(res, _anamatrix8[4], t[6]);
>> -	MULA(res, _anamatrix8[1], t[7]);
>> -	MULA(res, _anamatrix8[5], t[8]);
>> +	MUL(res, _anamatrix8[0], t[0]);
>> +	MULA(res, _anamatrix8[7], t[1]);
>> +	MULA(res, _anamatrix8[2], t[2]);
>> +	MULA(res, _anamatrix8[3], t[3]);
>> +	MULA(res, _anamatrix8[6], t[4]);
>> +	MULA(res, _anamatrix8[4], t[5]);
>> +	MULA(res, _anamatrix8[1], t[6]);
>> +	MULA(res, _anamatrix8[5], t[7]);
>>  	out[0] =3D SCALE8_STAGE2(res);
>>  =

>> -	MUL(res, _anamatrix8[1], t[1]);
>> -	MULA(res, _anamatrix8[7], t[2]);
>> -	MULA(res, _anamatrix8[3], t[3]);
>> -	MULA(res, -_anamatrix8[5], t[4]);
>> -	MULA(res, -_anamatrix8[6], t[5]);
>> -	MULA(res, -_anamatrix8[2], t[6]);
>> -	MULA(res, -_anamatrix8[0], t[7]);
>> -	MULA(res, -_anamatrix8[4], t[8]);
>> +	MUL(res, _anamatrix8[1], t[0]);
>> +	MULA(res, _anamatrix8[7], t[1]);
>> +	MULA(res, _anamatrix8[3], t[2]);
>> +	MULA(res, -_anamatrix8[5], t[3]);
>> +	MULA(res, -_anamatrix8[6], t[4]);
>> +	MULA(res, -_anamatrix8[2], t[5]);
>> +	MULA(res, -_anamatrix8[0], t[6]);
>> +	MULA(res, -_anamatrix8[4], t[7]);
>>  	out[1] =3D SCALE8_STAGE2(res);
>>  =

>> -	MUL(res, -_anamatrix8[1], t[1]);
>> -	MULA(res, _anamatrix8[7], t[2]);
>> -	MULA(res, _anamatrix8[4], t[3]);
>> -	MULA(res, -_anamatrix8[2], t[4]);
>> -	MULA(res, -_anamatrix8[6], t[5]);
>> -	MULA(res, _anamatrix8[5], t[6]);
>> -	MULA(res, _anamatrix8[0], t[7]);
>> -	MULA(res, _anamatrix8[3], t[8]);
>> +	MUL(res, -_anamatrix8[1], t[0]);
>> +	MULA(res, _anamatrix8[7], t[1]);
>> +	MULA(res, _anamatrix8[4], t[2]);
>> +	MULA(res, -_anamatrix8[2], t[3]);
>> +	MULA(res, -_anamatrix8[6], t[4]);
>> +	MULA(res, _anamatrix8[5], t[5]);
>> +	MULA(res, _anamatrix8[0], t[6]);
>> +	MULA(res, _anamatrix8[3], t[7]);
>>  	out[2] =3D SCALE8_STAGE2(res);
>>  =

>> -	MUL(res, -_anamatrix8[0], t[1]);
>> -	MULA(res, _anamatrix8[7], t[2]);
>> -	MULA(res, _anamatrix8[5], t[3]);
>> -	MULA(res, -_anamatrix8[4], t[4]);
>> -	MULA(res, _anamatrix8[6], t[5]);
>> -	MULA(res, _anamatrix8[3], t[6]);
>> -	MULA(res, -_anamatrix8[1], t[7]);
>> -	MULA(res, -_anamatrix8[2], t[8]);
>> +	MUL(res, -_anamatrix8[0], t[0]);
>> +	MULA(res, _anamatrix8[7], t[1]);
>> +	MULA(res, _anamatrix8[5], t[2]);
>> +	MULA(res, -_anamatrix8[4], t[3]);
>> +	MULA(res, _anamatrix8[6], t[4]);
>> +	MULA(res, _anamatrix8[3], t[5]);
>> +	MULA(res, -_anamatrix8[1], t[6]);
>> +	MULA(res, -_anamatrix8[2], t[7]);
>>  	out[3] =3D SCALE8_STAGE2(res);
>>  =

>> -	MUL(res, -_anamatrix8[0], t[1]);
>> -	MULA(res, _anamatrix8[7], t[2]);
>> -	MULA(res, -_anamatrix8[5], t[3]);
>> -	MULA(res, _anamatrix8[4], t[4]);
>> -	MULA(res, _anamatrix8[6], t[5]);
>> -	MULA(res, -_anamatrix8[3], t[6]);
>> -	MULA(res, -_anamatrix8[1], t[7]);
>> -	MULA(res, _anamatrix8[2], t[8]);
>> +	MUL(res, -_anamatrix8[0], t[0]);
>> +	MULA(res, _anamatrix8[7], t[1]);
>> +	MULA(res, -_anamatrix8[5], t[2]);
>> +	MULA(res, _anamatrix8[4], t[3]);
>> +	MULA(res, _anamatrix8[6], t[4]);
>> +	MULA(res, -_anamatrix8[3], t[5]);
>> +	MULA(res, -_anamatrix8[1], t[6]);
>> +	MULA(res, _anamatrix8[2], t[7]);
>>  	out[4] =3D SCALE8_STAGE2(res);
>>  =

>> -	MUL(res, -_anamatrix8[1], t[1]);
>> -	MULA(res, _anamatrix8[7], t[2]);
>> -	MULA(res, -_anamatrix8[4], t[3]);
>> -	MULA(res, _anamatrix8[2], t[4]);
>> -	MULA(res, -_anamatrix8[6], t[5]);
>> -	MULA(res, -_anamatrix8[5], t[6]);
>> -	MULA(res, _anamatrix8[0], t[7]);
>> -	MULA(res, -_anamatrix8[3], t[8]);
>> +	MUL(res, -_anamatrix8[1], t[0]);
>> +	MULA(res, _anamatrix8[7], t[1]);
>> +	MULA(res, -_anamatrix8[4], t[2]);
>> +	MULA(res, _anamatrix8[2], t[3]);
>> +	MULA(res, -_anamatrix8[6], t[4]);
>> +	MULA(res, -_anamatrix8[5], t[5]);
>> +	MULA(res, _anamatrix8[0], t[6]);
>> +	MULA(res, -_anamatrix8[3], t[7]);
>>  	out[5] =3D SCALE8_STAGE2(res);
>>  =

>> -	MUL(res, _anamatrix8[1], t[1]);
>> -	MULA(res, _anamatrix8[7], t[2]);
>> -	MULA(res, -_anamatrix8[3], t[3]);
>> -	MULA(res, _anamatrix8[5], t[4]);
>> -	MULA(res, -_anamatrix8[6], t[5]);
>> -	MULA(res, _anamatrix8[2], t[6]);
>> -	MULA(res, -_anamatrix8[0], t[7]);
>> -	MULA(res, _anamatrix8[4], t[8]);
>> +	MUL(res, _anamatrix8[1], t[0]);
>> +	MULA(res, _anamatrix8[7], t[1]);
>> +	MULA(res, -_anamatrix8[3], t[2]);
>> +	MULA(res, _anamatrix8[5], t[3]);
>> +	MULA(res, -_anamatrix8[6], t[4]);
>> +	MULA(res, _anamatrix8[2], t[5]);
>> +	MULA(res, -_anamatrix8[0], t[6]);
>> +	MULA(res, _anamatrix8[4], t[7]);
>>  	out[6] =3D SCALE8_STAGE2(res);
>>  =

>> -	MUL(res, _anamatrix8[0], t[1]);
>> -	MULA(res, _anamatrix8[7], t[2]);
>> -	MULA(res, -_anamatrix8[2], t[3]);
>> -	MULA(res, -_anamatrix8[3], t[4]);
>> -	MULA(res, _anamatrix8[6], t[5]);
>> -	MULA(res, -_anamatrix8[4], t[6]);
>> -	MULA(res, _anamatrix8[1], t[7]);
>> -	MULA(res, -_anamatrix8[5], t[8]);
>> +	MUL(res, _anamatrix8[0], t[0]);
>> +	MULA(res, _anamatrix8[7], t[1]);
>> +	MULA(res, -_anamatrix8[2], t[2]);
>> +	MULA(res, -_anamatrix8[3], t[3]);
>> +	MULA(res, _anamatrix8[6], t[4]);
>> +	MULA(res, -_anamatrix8[4], t[5]);
>> +	MULA(res, _anamatrix8[1], t[6]);
>> +	MULA(res, -_anamatrix8[5], t[7]);
>>  	out[7] =3D SCALE8_STAGE2(res);
>>  }
>>  =

>>
>>
>> ------------------------------------------------------------------------
>>
>> -------------------------------------------------------------------------
>> Take Surveys. Earn Cash. Influence the Future of IT
>> Join SourceForge.net's Techsay panel and you'll get the chance to share =
your
>> opinions on IT & business topics through brief surveys - and earn cash
>> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=
=3DDEVDEV
>>
>>
>> ------------------------------------------------------------------------
>>
>> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>     =

>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>   =



-- =

Frederic

Without the wind, the grass does not move.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
