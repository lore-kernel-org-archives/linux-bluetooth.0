Return-Path: <james.cameron@hp.com>
Date: Tue, 29 Jun 2004 08:48:03 +1000
From: James Cameron <james.cameron@hp.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] pand/main.c, restore signals for dev-up script
Message-ID: <20040628224803.GA20139@hp.com>
References: <20040627233437.GD28828@hp.com> <1088408656.3774.136.camel@pegasus> <20040628085356.GA8871@hp.com> <1088413518.3774.167.camel@pegasus> <20040628095541.GB8871@hp.com> <1088417629.3774.177.camel@pegasus> <20040628101927.GC8871@hp.com> <1088419197.3774.183.camel@pegasus> <20040628120612.GF8871@hp.com> <1088427271.3774.198.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1088427271.3774.198.camel@pegasus>
Sender: james.cameron@hp.com
List-ID: <bluez-devel.lists.sourceforge.net>

On Mon, Jun 28, 2004 at 02:54:31PM +0200, Marcel Holtmann wrote:
> what do you wanna do with that information? Actually I never needed it.

Select access policies.  Probably not a terribly reliable access
control, but at least ringing alarms if I sight a connection from an
unexpected address would be useful.

I'm using 100m range modules in a rural environment, on top of a
mountain.

See http://quozl.netrek.org/bluetooth/ for the coverage mapping that I
did; it was quite enjoyable.  Some of the configuration information
there is out of date; I haven't reviewed it in light of the current
Debian package versions.

-- 
James Cameron
