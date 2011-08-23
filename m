Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Tue, 23 Aug 2011 13:28:22 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: Add support to Disconnect fd passing
 connections
Message-ID: <20110823162822.GA26522@joana>
References: <1314033585-22244-1-git-send-email-padovan@profusion.mobi>
 <1314033585-22244-2-git-send-email-padovan@profusion.mobi>
 <1314116296.3373.213.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314116296.3373.213.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2011-08-23 09:18:13 -0700]:

> Hi Gustavo,
> 
> > Disconnect can also be called for connections created with ConnectFD
> > ---
> >  doc/serial-api.txt |    3 +++
> >  serial/port.c      |   14 ++++++++++----
> >  2 files changed, 13 insertions(+), 4 deletions(-)
> > 
> > diff --git a/doc/serial-api.txt b/doc/serial-api.txt
> > index 98b0ad4..09a4c0d 100644
> > --- a/doc/serial-api.txt
> > +++ b/doc/serial-api.txt
> > @@ -53,5 +53,8 @@ Methods		fd ConnectFD(string pattern) [experimental]
> >  			In that case one of patterns of the Connect method should
> >  			be suplied instead of the TTY device.
> >  
> > +			Connection created with Serial.ConnectFD only accept
> > +			as parameter the same parameters ConnectFD accepts.
> > +
> >  			Possible errors: org.bluez.Error.InvalidArguments
> >  					 org.bluez.Error.DoesNotExist
> 
> I really fail to see how this is all going to work. We already had this
> problem with the PrivateNetwork API in ConnMan. We can not use the fd as
> a unique reference.

I'm considering that UUID(or channel name, or a friendly name like "sap") is a
second reference. You do:

Serial.ConnectFD("sap")

and then

Serial.Disconnect("sap")

	Gustavo
