Return-Path: <cyrus@holtmann.org>
Subject: Re: obexd: obex_handle_input: poll event HUP ERR
From: Bastien Nocera <hadess@hadess.net>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4C20E1C8.9020409@gmail.com>
References: <4C206507.40402@gmail.com> <20100622073841.GA13989@jh-x301>
	 <4C206924.50303@gmail.com> <20100622075833.GA14319@jh-x301>
	 <4C206E7F.5000604@gmail.com> <20100622081345.GA14746@jh-x301>
	 <4C20E1C8.9020409@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Tue, 22 Jun 2010 17:34:50 +0100
Message-ID: <1277224491.9334.40.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2010-06-22 at 18:16 +0200, Jiri Slaby wrote:
> On 06/22/2010 10:13 AM, Johan Hedberg wrote:
> > On Tue, Jun 22, 2010, Jiri Slaby wrote:
> >> Yeah, -a solved the problem. What does it mean to have an agent
> >> registered? What is agent?
> > 
> > If you don't want obexd to go blindly accepting files from random remote
> > devices you'll probably want some sort of user interaction on the server
> > side, right? One possibility would be to have a GUI process show a
> > "Accept file from ..." dialog every time there's an incoming request.
> > You might also want to choose exactly where on the filesystem obexd
> > stores the incoming file. Such choices would be made by an agent, i.e.
> > a process separate from obexd that has through D-Bus told obexd that it
> > can take care of incoming requests. There's an example command line
> > agent written in python available at test/simple-agent in the obexd
> > source tree. The actual D-Bus API of an agent is documented in
> > doc/agent-api.txt in the same source tree.
> 
> I have gnome-bluetooth-2.30, but I guess it was not converted to act
> also as obexd Agent yet.

gnome-bluetooth doesn't have any Obex server bits. You'd need to use
gnome-user-share to have Obex server capabilities, and it doesn't use
obexd right now, but obex-data-server.

Patches welcome :)

Cheers

