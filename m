Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-devel] sbc and fixed-point progress
Message-ID: <C70061B183DE09419568AB2060C52A95B73437@arion.intra.local>
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
Date: Fri, 26 Aug 2005 10:02:16 +0200

Brad,

The _anamatrix8[] and _sbc_proto_8[] are  extracted from anamatrix8[][]
and sbc_proto_8_80[].=20
Basically what I did is, made loop unrolling, then the rearanged
resulting code minimizing the number of multiplies, at this point I had
the code with the same structure as now, but using old matrices. After
this I've made single run of the filter printing out the matrices values
as the used, then put it in a array, eliminated elements with the same
value and modified the code to use the new array. So basically I did it
manually till some extent :)

Regards,
    Victor

P.S. There is a bug in general code of SUB64 (not much  influencing the
final result). I'll check in fix this weeken and also I did some
cleaning up of my code and added arm assembly for ADD64, SUB64. I still
plan to modify joint stereo code in sbc_pack_frame()  (as there are some
floating point ops still remain there) sbc_init() (and a2play) to accept
encoder parameters like nr. of subbands, bit pool and so on.

P.P.S. I'm also thinking to merge floating point and fixed point filter
code, so USE_FIXED will decide which macro to use floating or fixed
(general|arm). Btw, I also think it is quite easy to implement 32 bit
version this way.

-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Brad
Midgley
Sent: Friday, August 26, 2005 7:11 AM
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sbc and fixed-point progress

Victor,

How did you compute the floating point _anamatrix8[] and _sbc_proto_8[]
in sbc_tables.h? (I am trying to improve the 4-subband code based on
your 8-subband float and fixed code.)

BTW, I pulled out the testcode for fixed-point decoding now that people
will compile with fixed point enabled and expect everything to work.

thanks
Brad

Victor Shcherbatyuk wrote:
> Brad,
>=20
> I ran one more test and instead of -n flag for a2play I changed magic
87 to magic 50, CPU usage dropped >2 times to ~8% on ARM9@400Mhz and
sound is still smooth. That's how it was tested in first place which is
close to 30 MIPS I guess...
>=20
> Regards,
>     Victor.
>=20
>=20
> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net on behalf of Victor=20
> Shcherbatyuk
> Sent: Tue 8/23/2005 5:00 PM
> To: bluez-devel@lists.sourceforge.net
> Subject: RE: [Bluez-devel] sbc and fixed-point progress
> =20
> Hello Brad,
>=20
> I did some test runs on ARM9@400MHz, general fixed point encoder eats
up ~40% of CPU time, while arm specific version  - ~20%. And in both
cases it runs quite smooth. So the drops you had should have been caused
by something else (unless you run some othe applications cuncurently).
>=20
>=20
> Victor.
>=20
>=20
> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net on behalf of Brad=20
> Midgley
> Sent: Mon 8/22/2005 9:22 AM
> To: bluez-devel@lists.sourceforge.net
> Subject: Re: [Bluez-devel] sbc and fixed-point progress
> =20
> Victor
>=20
>=20
>>>I do not have HW to test arm specific version real time, hope no=20
>>>suprises there, but I could have missed something when integrating it

>>>into sbc code (it decodes well, but how fast, I will try only monday=20
>>>evening).
>>
>>
>>Ok, I'll load it on gumstix now and give it a try.
>=20
>=20
> This is almost perfect. On a 400mhz gumstix (pxa255), I'm able to send

> a 5-minute audio stream with only about three breaks in the audio=20
> (about 5 seconds each).
>=20
> I think it will work flawlessly in 4 subbands or if we can shorten a=20
> few of the ops from 64 to 32 bit.
>=20
> I committed what's there and used __arm__ for the conditional asm
code.
>=20
>=20
>>>Using a2play needs to tweak 87 magic number, otherwise it drops
samples?
>>
>>
>>yes, this is disappointing. We may need to find another way to get=20
>>reliable timing than setitimer.
>>
>>I did change the first usleep(10) to usleep(1000) and that *may* help=20
>>with this problem by ensuring that we always interrupt the usleep=20
>>syscall consistently. I don't have my hp headphones (the set that's=20
>>very sensitive to timing) handy to test.
>=20
>=20
> fwiw, I had to use the -n flag to a2play so it wouldn't use itimer at=20
> all. This flag tells a2play to just send the audio as fast as it can=20
> encode it.
>=20
> Brad
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
>=20
>=20


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
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
