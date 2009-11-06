Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Nov 2009 22:54:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Battery information
Message-ID: <20091106205424.GA16451@jh-x301>
References: <1257533769.23167.194.camel@localhost.localdomain>
 <20091106195819.GA15510@jh-x301>
 <1257538523.23167.203.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1257538523.23167.203.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Nov 06, 2009, Bastien Nocera wrote:
> > I don't really see the point of this patch. What's the benefit of
> > returning "OK" instead of "ERROR" in this case, especially since the
> > added command handler doesn't do anything? As far as I see returning
> > "ERROR" is the right behavior for us when we encounter a command which
> > we don't understand (there are also no other side effects on our side
> > when we send an error, i.e. the connection is allowed proceed normally).
> 
> Nobody likes errors showing up in their /var/log/messages. In any case,
> that was a minimal patch to avoid that.

If that's the main issue here I'd rather just change the error() into a
debug() in the code. You'll get much more than just one message like
that when connecting e.g. to a CSR based headset since they use lots of
vendor-specific AT commands.

Johan
