Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <564d96fb0606120452m4e4ced33x66ca63fd675ad3@mail.gmail.com>
Date: Mon, 12 Jun 2006 08:52:30 -0300
From: "=?UTF-8?Q?Rafael_Esp=C3=ADndola?=" <rafael.espindola@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1150099297.2589.15.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <564d96fb0606060325q834360bqe4e9d41cbb28a16f@mail.gmail.com>
	<1149714650.22472.62.camel@localhost>
	<564d96fb0606071459i7367f84fkb7ee645941f84279@mail.gmail.com>
	<1149718288.22472.71.camel@localhost>
	<564d96fb0606081007p3fb8ea42v5926c80eb1cc9657@mail.gmail.com>
	<1149884042.3985.6.camel@aeonflux.holtmann.net>
	<1150099297.2589.15.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] bug in sdp_gen_pd
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

> please use the latest bluez-utils-3.0 release and call this three
> commands:
>
>         sdptool add sp
>         sdptool browse local
>         sdptool browse --raw local
>
> You will see that the string values are wrong for the third commands.
> Can you please check what happens here.
I am unable to reproduce. I have just compiled bluez-libs-3.0 and
bluz-utils-3.0 (using the just compiled lib) and the output is equal
to the installed 2.25.

> Regards
>
> Marcel

Best Regards,

--
Rafael,
INdT


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
