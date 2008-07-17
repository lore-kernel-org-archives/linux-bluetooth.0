Return-Path: <cyrus@holtmann.org>
Message-ID: <487F148F.7030109@access-company.com>
Date: Thu, 17 Jul 2008 11:44:47 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?= <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <48075B6A.2060308@access-company.com>	<1209058941.12684.37.camel@violet.holtmann.net>	<48355289.7070906@access-company.com>	<5D487EED-A2B2-4AEA-AA7B-9EC8681157C0@holtmann.org>	<48357D9C.9080009@access-company.com>
	<486A6392.6080008@access-company.com>
In-Reply-To: <486A6392.6080008@access-company.com>
Subject: Re: [Bluez-devel] [patch] BNEP/PAN Qualification issues
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Any updates?

Fr=E9d=E9ric DALLEAU




Fr=E9d=E9ric Dalleau wrote:
> Marcel, Luiz
>
>>>> A part of the patch si to move handling of incoming setup_conn_req  =

>>>> in kernel. In order to keep pan working with older kernel, some  =

>>>> differenciation must be done. How to achieve this ?
>>>>           =

>>> I don't know yet. Can we first fix the issues that don't need  =

>>> modifications within the kernel. I prefer not modifying the kernel =

>>> at  all at the moment.     =

>>
>> I understand.
>> My problem is that some tests require grouping several messages into =

>> one. In particular, the setup_conn_req can be sent together with a =

>> control extension TP/BNEP/CTRL/BV-19-C.
>> The current extension processing is to skip everything and I'm not =

>> sure the control message can be handled at application level.
>>   =

>
> I wake up this thread,
>
> I'm working at making this easier to integrate but it will makes a =

> bunch of patches.
> Let's start with the small and self contained.
>
> Resend patch for bluez-utils, and network service timeout  (after =

> SETUP_CONN_REQ is sent and no answer for  30 sec, disconnect)
>
> Other patch adds a parameter to bnep module for disabling header =

> compression.
>
> Let me know what you think.
> Regards,
>
> Fr=E9d=E9ric DALLEAU
>
>
> ------------------------------------------------------------------------
>
> -------------------------------------------------------------------------
> Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
> Studies have shown that voting for your favorite open source project,
> along with a healthy diet, reduces your potential for chronic lameness
> and boredom. Vote Now at http://www.sourceforge.net/community/cca08
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
