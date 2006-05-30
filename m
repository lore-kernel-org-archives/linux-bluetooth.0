Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <447C69D4.9020504@palmsource.com>
Date: Tue, 30 May 2006 17:50:44 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <447C6278.1040707@palmsource.com> <447C6598.6050107@xmission.com>
In-Reply-To: <447C6598.6050107@xmission.com>
Subject: Re: [Bluez-devel] A2DP Profile Certification
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

Hi brad,

We must be very careful here : The ICS says the Source must accept =

connection establishment, this is different from the sink role because =

the source will accept the connection and then send its audio stream!

As you said, I'm not sure it makes sense, and I can't figure how to test =

it. But I believe a typical scenario would be the following :

- you listen a2dp music from your pc (source) on the headphone (sink).
- someone call your mobile.
- you answer the call so the headphone tell the source to stop a2dp.
- while you talk, the source send audio data to /dev/null.
- when you hangup, the headphone will tell your computer to send the =

music again.

Fr=E9d=E9ric



Brad Midgley a =E9crit :

>Fr=E9d=E9ric
>
>  =

>
>>- Accept Connection Establishment,
>>- Accept Start Streaming,
>>- Accept Connection Release.
>>    =

>>
>
>see a2recv for these. it implements the a2dp sink. there is not any sort
>of special connection with alsa for this, but i'm not sure it makes
>sense since this runs more like a daemon and just sends any audio that
>comes in to the speakers.
>
>  =

>
>>- An entry must also appear in SDP records.
>>    =

>>
>
>sdptool add A2SNK
>
>brad
>
>
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>  =

>



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
