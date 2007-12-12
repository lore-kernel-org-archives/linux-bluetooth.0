Return-Path: <cyrus@holtmann.org>
Message-ID: <8c7950360712120931u1177fbf2jdd0fbff1d24dea51@mail.gmail.com>
Date: Wed, 12 Dec 2007 12:31:22 -0500
From: "Shane Volpe" <shanevolpe@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1197474566.5644.12.camel@aeonflux>
MIME-Version: 1.0
References: <8c7950360712120508j3da5da11sf79e1c321cc37865@mail.gmail.com>
	<1197474566.5644.12.camel@aeonflux>
Subject: Re: [Bluez-users] PAN security questions
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Marcel,
The paraphrase exchange is unencrypted correct?  So I would really
need to come up with some method of security   as it would be easy to
get the password by sniffing.  I guess this is probably not a big
issue as I could use a gpg key or ssh style key and require some
encrypted ack message sent with gpg or ssh and if it is not encrypted
with the right key then just boot the connection.  I would be
interested in hearing how others handle it.   The only way this would
fail is if someone leaked one of the private keys.
Regards,
Shane

On Dec 12, 2007 10:49 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Shane,
>
> > PAND MAN file lists the following options regarding security:
> > --encrypt -E
> >     Enable encryption
> > --secure -S
> >     Secure connection
> >
> > The PAND howto (http://bluez.sourceforge.net/contrib/HOWTO-PAN)
> > explains --encrypt as follows:
> >      "activates BT security (authentication and encryption)"
> >
> > so then what does the option --secure do?
>
> the --encrypt does authentication and then encrypt the link. With the
> --secure you do the authentication, then encrypt the link and then make
> sure the link key will be re-generated. It is an extra step of
> protection since the link key itself has no expiration date.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> SF.Net email is sponsored by:
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://sourceforge.net/services/buy/index.php
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>



-- 
Registered Linux User: #293401

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
