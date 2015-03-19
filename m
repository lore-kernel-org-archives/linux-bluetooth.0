Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Mar 2015 12:29:36 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] doc: Add initial 6LoWPAN API definition
Message-ID: <20150319102936.GB7070@t440s.lan>
References: <1426756230-422-1-git-send-email-johan.hedberg@gmail.com>
 <1426760605.3386.38.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426760605.3386.38.camel@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

On Thu, Mar 19, 2015, Jukka Rissanen wrote:
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
> 
> We should probably say "... remote 6LoWPAN node" here instead.

Indeed. I'll change it.

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
> 
> Ditto

Sure.

> > +Start Server Command
> 
> The specification talks about "Router" so should we use same terminology
> here instead of "Server"?

Actually this would be the Node role. So I'll rename it to 'Start Node
Command'.

> > +Stop Server Command
> 
> Ditto.

Sure.

Johan
