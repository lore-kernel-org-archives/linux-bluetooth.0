Return-Path: <cyrus@holtmann.org>
Message-ID: <2a9506370811242042s8ac516ep5ee181ffe4eb1f0f@mail.gmail.com>
Date: Tue, 25 Nov 2008 01:42:29 -0300
From: "Vinicius Gomes" <vinicius.gomes@openbossa.org>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BD8ED0C257AAA247BB6C9A92879522C10D827E1C@CNSCNEVS01.ap.sony.com>
MIME-Version: 1.0
References: <BD8ED0C257AAA247BB6C9A92879522C10D827E1C@CNSCNEVS01.ap.sony.com>
Subject: Re: [Bluez-devel] What's the API different between in
	adapter-api.txt and dbus-api.txt in bluez-utils-3.36.tar.gz
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

On Mon, Nov 24, 2008 at 10:57 PM, WanYan, Uranus
<Uranus.WanYan@sony.com.cn> wrote:
> Hello Every Developer;
>
>          I am a fresh man in bluez. I studied bluez through
> http://wiki.bluez.org/.
>
>          But now I am confused by the bluez documentation. BlueZ D-Bus
> Adapter API were described in adapter-api(bluez-utils-3.36\doc). Also
> they were described in dbus-api.txt(bluez-utils-3.36\hcid). Please
> reference attachment.
>
>          So could you tell me why there are two documents describing
> Adapter API?
>

hcid/dbus-api.txt describes the 'old' 3.X series API

the documents in the doc/ directory describe the new API, that is the only API
of the 4.X series, which I suggest for you to take a look. And because
3.36 is not developed
anymore, are you are missing a much simplified API and some very nice
features ;-)

This mailing list is going to be closed soon, so please take a look at
[1] for alternatives.

>  Thank you for your help!
>
> Uranus
>
>
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
> Build the coolest Linux based applications with Moblin SDK & win great prizes
> Grand prize is a trip for two to an Open Source event anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>

Cheers,
-- 
Vinicius Gomes
INdT - Instituto Nokia de Tecnologia

[1] http://www.bluez.org/contact/

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
