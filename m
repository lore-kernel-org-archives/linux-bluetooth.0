Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Mar 2015 12:28:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] doc: Add initial 6LoWPAN API definition
Message-ID: <20150319102809.GA7070@t440s.lan>
References: <1426756230-422-1-git-send-email-johan.hedberg@gmail.com>
 <1526447.VGJJGt7NUY@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1526447.VGJJGt7NUY@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Mar 19, 2015, Szymon Janc wrote:
> > +Connect Command
> > +===============
> > +
> > +	Command Code:		0x0004
> > +	Controller Index:	<controller id>
> > +	Command Parameters:	Address (6 Octets)
> > +				Address_Type (1 Octet)
> > +	Return Parameters:	Address (6 Octets)
> > +				Address_Type (1 Octet)
> > +				Network_Interface (16 Octets)
> > +
> > +	This command is used to connect to a remote 6LoWPAN server.
> > +
> > +	The returned Network_Interface parameter is a nul-terminated
> > +	string containing the created network interface name.
> > +
> > +	This command generates a Command Complete event on success or
> > +	a Command Status event on failure.
> 
> Shouldn't this always return command complete? ie for userspace to be
> able to easily handle multiple connect commands?
> (currently mgmt lib handles only 1 command at once but...)

Good catch. I'll fix it in v2.

> > +Disconnect Command
> > +==================
> > +
> > +	Command Code:		0x0005
> > +	Controller Index:	<controller id>
> > +	Command Parameters:	Address (6 Octets)
> > +				Address_Type (1 Octet)
> > +	Return Parameters:	Address (6 Octets)
> > +				Address_Type (1 Octet)
> > +
> > +	This command is used to disconnect from a remote 6LoWPAN server.
> > +
> > +	This command generates a Command Complete event on success or
> > +	a Command Status event on failure.
> 
> Same here.

Will fix.

Johan
