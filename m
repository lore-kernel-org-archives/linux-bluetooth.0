Return-Path: <hakauvoni@gmail.com>
Message-ID: <e96e9eeb0709101343x389fcf0dp46950d56680bb7f3@mail.gmail.com>
Date: Mon, 10 Sep 2007 23:43:38 +0300
From: "Voni Hakau" <hakauvoni@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluez obex problem
Cc: marcel@holtmann.org
In-Reply-To: <1189451152.687.51.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e96e9eeb0709092329y686f2f38x479898e640438f03@mail.gmail.com>
	 <1189451152.687.51.camel@violet>
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel

On 9/10/07, Marcel Holtmann <marcel@holtmann.org> wrote:
> > i'm trying to use btobex (compiled from bluez' obex cvs package).
> > but i didn't manage to receive files as I need to supply btobex some "channel":
> > what is this channel ?
> > how can i get it ?
> > i just want my device to accept files pushed from other devices...
>
> you ahead and actually do read the Object Push Profile specification
> since you messed up the terminology here. The pull command is still a
> client connection that pulls something from a server and not a server
> that might accept incoming connections.

thank you very much for the reply.
is there a simple command-line OPP server or FTP server application anywhere ?
and just for the sake of knowledge - how can i know what channel to supply
btobex when it is needed ?

thank you
voni
