Return-Path: <mtortonesi@ing.unife.it>
From: Mauro Tortonesi <mtortonesi@ing.unife.it>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] l2cap xfer fails
Date: Wed, 28 Jan 2004 12:36:42 +0100
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
References: <200401281135.58062.mtortonesi@ing.unife.it> <200401281200.07012.mtortonesi@ing.unife.it> <1075288960.12766.66.camel@pegasus>
In-Reply-To: <1075288960.12766.66.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200401281236.42748.mtortonesi@ing.unife.it>
List-ID: <bluez-devel.lists.sourceforge.net>

On Wednesday 28 January 2004 12:22, Marcel Holtmann wrote:
> Hi Mauro,
>
> > what i wanted to say is that i can transfer (over L2CAP) data from
> > console, but transfer of files redirected to stdin always fails. perhaps
> > i am doing something wrong? such as calling write(2) over L2CAP sockets
> > with buffers larger that 762 bytes?
>
> I haven't checked the nc6 Bluetooth support so far, but the L2CAP is a
> SOCK_SEQPACKET and it has an in and an out MTU. The default MTU is 672
> and this means if you send data with a larger buffer, the write() will
> fail.

you're right. in fact:

nc6 --mtu=672 -b address -p psm

works perfectly.

-- 
Aequam memento rebus in arduis servare mentem...

Mauro Tortonesi                 mtortonesi@ing.unife.it
                                mauro@deepspace6.net
                                mauro@ferrara.linux.it
Deep Space 6 - IPv6 with Linux  http://www.deepspace6.net
Ferrara Linux User Group        http://www.ferrara.linux.it
