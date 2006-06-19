Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <564d96fb0606190513r4c59cd28v9bd23a9a45e55e8b@mail.gmail.com>
Date: Mon, 19 Jun 2006 09:13:38 -0300
From: "=?UTF-8?Q?Rafael_Esp=C3=ADndola?=" <rafael.espindola@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1150715237.4277.17.camel@localhost>
MIME-Version: 1.0
References: <564d96fb0606060325q834360bqe4e9d41cbb28a16f@mail.gmail.com>
	<1149714650.22472.62.camel@localhost>
	<564d96fb0606071459i7367f84fkb7ee645941f84279@mail.gmail.com>
	<1149718288.22472.71.camel@localhost>
	<564d96fb0606081007p3fb8ea42v5926c80eb1cc9657@mail.gmail.com>
	<1149884042.3985.6.camel@aeonflux.holtmann.net>
	<1150099297.2589.15.camel@aeonflux.holtmann.net>
	<564d96fb0606120452m4e4ced33x66ca63fd675ad3@mail.gmail.com>
	<1150715237.4277.17.camel@localhost>
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

On 6/19/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Rafael,
Hi Marcel,

>
> please use bluez-libs-3.1 and bluez-utils-3.1 and make sure that the
> sdpd from this release is running and you use its sdptool. After that
> issues the following commands:
.....

> You will see that attributes 0x100 and 0x101 are not matching.
I am sorry, but due to my lack of experience with bluetooth I don't
know what is wrong with the output.

I have run the commands in vanilla 2.24-0ubuntu1 packages and with my
patch attached. The output was the same.

> Regards
>
> Marcel

Best Regards,
Rafael


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
