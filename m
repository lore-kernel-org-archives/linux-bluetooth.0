Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-devel] sbc and fixed-point progress
Message-ID: <C70061B183DE09419568AB2060C52A959BEBF9@arion.intra.local>
From: "Victor Shcherbatyuk" <Victor.Shcherbatyuk@tomtom.com>
To: <bluez-devel@lists.sourceforge.net>
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
Date: Mon, 1 Aug 2005 10:20:31 +0200

Brad,

I've looked at the code once more. Probably you asware of this,  but
using rmagnitude(...)  gives almost no information about required
precision :( . Like for the table value 0.923879532511287 we need 51-bit
to represent it without precision loss, cause during conversion it is
multiplied by 2 ^ nr_prec_bits and then the fractional part is being
thrown away, if we do not want to lose precision the fractional part
should be 0, so 2 ^ nr_prec_bits sholud be equal 10 ^ 15, so
nr_prec_bits =3D 15 log2 10 =3D 49+ ... Plus 1 bit for an integer part + =
1
bit for a sign... -> 51bit

So even assigning 32 bits for a fractional part for a table drops 17
bits... :( .=20

I guess the noise I have after encoding I guess is coming from here.

Regards,
     Victor.

P.S. I'll send in fixed point code for the encoder a bit later, didn't
have much time to clean it up ....

-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Brad
Midgley
Sent: Thursday, July 28, 2005 23:09 PM
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sbc and fixed-point progress

Victor,

So maybe for state->W and state->X I could use a different fixed point
with 16 bits representing the integer. I tried doing everything that way
(only 15 bits remain for the fractional part) but the error compounded
very quickly.

Brad

Victor Shcherbatyuk wrote:
>> possibly do some optimizations.... I think large precision parts=20
>> under some conditions can be ignored, cause they will be cut anyway=20
>> when converting
>=20
>=20
> by ignored I meant "partially ignored" of course, meaning some=20
> precision can be lost cause you will lose it anyway converting to 16=20
> bit samples
>=20
> Regards,
> Victor
>=20
> ----- Original Message ----- From: "Victor Shcherbatyuk"=20
> <victor@win.tue.nl>
> To: <bluez-devel@lists.sourceforge.net>
> Sent: Thursday, July 28, 2005 20:41
> Subject: Re: [Bluez-devel] sbc and fixed-point progress
>=20
>=20
>> Brad,
>>
>> I'll send it in on weekend, still want to play a bit with precisions=20
>> and possibly do some optimizations.... I think large precision parts=20
>> under some conditions can be ignored, cause they will be cut anyway=20
>> when converting back to 16 bit integer at the end (or they have very=20
>> small impact on the final result). But, of course, it should be done=20
>> only after some consideration....
>>
>> I think 32 bit is the way to go, esp. for arm, and afterwards, lame
>> mp3 is working fine with 32-bit....
>>
>> Regards,
>>     Victor.
>>
>> ----- Original Message ----- From: "Brad Midgley"=20
>> <bmidgley@xmission.com>
>> To: <bluez-devel@lists.sourceforge.net>
>> Sent: Thursday, July 28, 2005 16:59
>> Subject: Re: [Bluez-devel] sbc and fixed-point progress
>>
>>
>>> Victor,
>>>
>>> Great! Can you send me the output of "cvs diff -u" or the resulting=20
>>> sbc.c?
>>>
>>> Even if it's noisy, we will just make it optional using the=20
>>> compile-time option and improve it over time. Right now we have no=20
>>> way at all to encode on arm, so even a noisy encoder would be going=20
>>> in the right direction.
>>>
>>> I started working on the decoder but got stuck when I found that the
>>> state->W and state->X variables sometimes needed large precision and
>>> sometimes had large integer parts (ie in a naive fixed-point=20
>>> implementation, they would need more than 32 bits). I was=20
>>> contemplating keeping a large precision in the fixed point type but=20
>>> using a separate integer for those variables' integer part.
>>>
>>> Brad
>>>
>>> Victor Shcherbatyuk wrote:
>>>
>>>> Hello Brad,
>>>>
>>>> FYI,
>>>>
>>>> Yesterday I converted encoder to fixed point (I did it a dirty way,

>>>> so probably it doesn't have much of the value). I've converted each

>>>> of the tables with different precision in such a way that the=20
>>>> operations involving the tables (mults and adds) will not overflow=20
>>>> 32 bit, and where necessary I pre-shift intermediate results to
prevent overlowing.
>>>> Currently the output  is a slightly noisy, but the purpose was to=20
>>>> estimate required performance. The result is, in the current=20
>>>> implementation, using fixed point it is just about to be enough to=20
>>>> run on 400Mhz arm combined with mp3 decoder (mp3 piped though mad=20
>>>> mp3 decoder to sbc encoder to a2play). This means either something=20
>>>> is wrong
>>>> :) or SBC codec should be heavily optimized (3 - 5 times ?) to make

>>>> it reasonable (memcopies is the first thing to optimize
probably)...
>>>>
>>>> Regards,
>>>>      Victor.
>>>>
>>>>
>>>> -----Original Message-----
>>>> From: bluez-devel-admin@lists.sourceforge.net
>>>> [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Brad=20
>>>> Midgley
>>>> Sent: Monday, July 04, 2005 6:03 AM
>>>> To: BlueZ Mailing List
>>>> Subject: [Bluez-devel] sbc and fixed-point progress
>>>>
>>>> Guys,
>>>>
>>>> just FYI...
>>>>
>>>> I found a decent fixed point multiply that preshifts the values=20
>>>> before multiplying them. It keeps things in 32 bits. Most of the=20
>>>> roundoff error is taken care of in two additional terms. I think=20
>>>> the result is reasonable.
>>>> (http://www.accu.org/acornsig/public/caugers/volume2/issue6/fixedpo
>>>> int.h
>>>>
>>>> tml)
>>>>
>>>> If you compile with fixed-point on, libsbc will run both the fixed=20
>>>> and floating point calculations and flag errors when they differ
too much.
>>>> It seems to be working well and has helped me catch a couple of=20
>>>> fixed-point calculation problems.
>>>>
>>>> I have the decoder almost finished but I probably need to split=20
>>>> some terms into integer and fixed-point components. Loading up
>>>> frame->sb_sample for example can have a big integer part but we=20
>>>> frame->want to
>>>> use most of the 32 bit fixed-point type for the fractional part.
>>>>
>>>> Brad
>>>>
>>>>
>>>>
>>>> -------------------------------------------------------
>>>> SF.Net email is sponsored by: Discover Easy Linux Migration=20
>>>> Strategies from IBM. Find simple to follow Roadmaps,=20
>>>> straightforward articles, informative Webcasts and more! Get=20
>>>> everything you need to get up to speed, fast.=20
>>>> http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclick
>>>> _______________________________________________
>>>> Bluez-devel mailing list
>>>> Bluez-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>>>
>>>>
>>>> This e-mail message contains information which is confidential and=20
>>>> may be privileged. It is intended for use by the addressee only. If

>>>> you are not the intended addressee, we request that you notify the=20
>>>> sender immediately and delete or destroy this e-mail message and=20
>>>> any attachment(s), without copying, saving, forwarding, disclosing=20
>>>> or using its contents in any other way. TomTom N.V., TomTom=20
>>>> International BV or any other company belonging to the TomTom group

>>>> of companies will not be liable for damage relating to the=20
>>>> communication by e-mail of data, documents or any other
information.
>>>>
>>>>
>>>> -------------------------------------------------------
>>>> SF.Net email is Sponsored by the Better Software Conference & EXPO=20
>>>> September 19-22, 2005 * San Francisco, CA * Development Lifecycle=20
>>>> Practices Agile & Plan-Driven Development * Managing Projects &=20
>>>> Teams * Testing & QA Security * Process Improvement & Measurement *

>>>> http://www.sqe.com/bsce5sf=20
>>>> _______________________________________________
>>>> Bluez-devel mailing list
>>>> Bluez-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>>
>>>
>>>
>>> -------------------------------------------------------
>>> SF.Net email is Sponsored by the Better Software Conference & EXPO=20
>>> September 19-22, 2005 * San Francisco, CA * Development Lifecycle=20
>>> Practices Agile & Plan-Driven Development * Managing Projects &=20
>>> Teams * Testing & QA Security * Process Improvement & Measurement *=20
>>> http://www.sqe.com/bsce5sf=20
>>> _______________________________________________
>>> Bluez-devel mailing list
>>> Bluez-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>
>>
>>
>>
>> -------------------------------------------------------
>> SF.Net email is Sponsored by the Better Software Conference & EXPO=20
>> September 19-22, 2005 * San Francisco, CA * Development Lifecycle=20
>> Practices Agile & Plan-Driven Development * Managing Projects & Teams

>> * Testing & QA Security * Process Improvement & Measurement *=20
>> http://www.sqe.com/bsce5sf=20
>> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO=20
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle=20
> Practices Agile & Plan-Driven Development * Managing Projects & Teams=20
> * Testing & QA Security * Process Improvement & Measurement *=20
> http://www.sqe.com/bsce5sf=20
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle
Practices Agile & Plan-Driven Development * Managing Projects & Teams *
Testing & QA Security * Process Improvement & Measurement *
http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


This e-mail message contains information which is confidential and may be=
 privileged. It is intended for use by the addressee only. If you are not=
 the intended addressee, we request that you notify the sender immediatel=
y and delete or destroy this e-mail message and any attachment(s), withou=
t copying, saving, forwarding, disclosing or using its contents in any ot=
her way. TomTom N.V., TomTom International BV or any other company belong=
ing to the TomTom group of companies will not be liable for damage relati=
ng to the communication by e-mail of data, documents or any other informa=
tion.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
