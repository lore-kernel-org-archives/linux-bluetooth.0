Return-Path: <Sch@ttgen.net>
From: Fred =?utf-8?q?Sch=C3=A4ttgen?= <Sch@ttgen.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Encryption, authentication with Bluez
Date: Wed, 5 May 2004 16:04:50 +0200
Cc: Marcel Holtmann <marcel@holtmann.org>,
   Julien Campana <juliencampana@yahoo.fr>
References: <1083758037.1541.36.camel@fischer> <1083761997.4420.4.camel@pegasus>
In-Reply-To: <1083761997.4420.4.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200405051604.51052.Sch@ttgen.net>
List-ID: <bluez-devel.lists.sourceforge.net>

On Wednesday 05 May 2004 14:59, Marcel Holtmann wrote:
> Hi Julien,
>
> > With the hciconfig tool, authentication and encryption can be switch to
> > on/off.
> > But if I well understood, this affects the local device and therefore
> > every future connection.
>
> if you switch auth and encrypt on with hciconfig or in hcid.conf then
> you are in security mode 3.
>
> > Is there any way to have two connections, one using authentication and
> > not the other?
>
> This is security mode 2 (also called service level security) and of
> course this is possible. You can trigger auth or switch encryption with
> hcitool.

Marcel, some time ago you said you were planning to add an ioctl to let 
regular users trigger an authentication request. Is this possible in the 
meantime? Or are there any reasons why this isn't a good idea?

It would be very useful for our KDE stuff (obex push -> no authentication, 
other services -> authentication required). Otherwise I'd have to work around 
it with a small suid helper to ask for authentication, but I really want to 
avoid a hack like that.

regards
Fred

-- 
Fred Schaettgen
Sch@ttgen.net
