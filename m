Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 May 2013 07:43:55 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Gomes <vinicius.gomes@openbossa.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Jefferson Delfes <jefferson.delfes@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: GATT Clients and Servers in the kernel (was Re:[PATCH BlueZ v3
 06/16] attrib...)
Message-ID: <20130503044355.GB3742@x220>
References: <CAE6HaM=ogwUXRFM1+Pv-O9Cg0W3ueOpATMtU8kW2=D4Ghb93JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE6HaM=ogwUXRFM1+Pv-O9Cg0W3ueOpATMtU8kW2=D4Ghb93JA@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Thu, May 02, 2013, Vinicius Gomes wrote:
> > the long term plan is to use standard types like bool, char, uint8_t
> > and also void * here. However we might want to also see how to get
> > rid of g_ prefix as well. Especially g_attrib seems to be a good
> > candidate to get rid of.
> >
> > I also like to see ATT and GATT being implemented as src/shared/
> > under LGPL so we can be easily share it in the future. I already
> > have some (unpublished) code for src/shared/att.[ch] and
> > src/shared/gatt.[ch] already, but I think what we first need to do
> > is to figure out how we handle clients and servers from the kernel
> > side. Especially with the background of the kernel auto-connecting
> > LE channels in the future.
> 
> I am assuming you were talking about the connection establishment. If
> not, I am not following.
> 
> I can only think of an evolutionary approach of what we are already
> doing:
> 
> -  when we are the initiating side, the kernel will only auto-connect
> devices that have an associated socket blocking on connect(); the
> kernel may even use the white list if it seems appropriate (no
> resolvable addresses in the list of "to be connected" sockets for
> example).

You'll need to sync up with Marcel regarding how this should be done
(I'll be effectively offline until next Tuesday so you wont be getting
more clarifications from me before that).

I've never thought that doing tying connect() to the auto-connect
procedure is a good idea, and based on my last chat with Marcel a few
days ago he was agreeing. Having a pending connect() for potentially
days or even months is not really very intuitive compared to how
connect() is typically used. Instead, I think the ATT server socket
should always be the point of entry of new connections, regardless of
who is initiating. We'll then have a new mgmt command to add devices to
a kernel-side list, potentially along with the necessary scan
parameters, and the kernel will then do the passive scanning based on
that.

Johan
