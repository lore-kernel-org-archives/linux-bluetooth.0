Return-Path: <sybren@thirdtower.com>
Date: Wed, 5 Nov 2003 13:14:05 +0100
From: Sybren Stuvel <sybren@thirdtower.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Sybren Stuvel <sybren@thirdtower.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm patch
Message-ID: <20031105121405.GA9763@sybren.thirdtower.com>
References: <200311050945.34166.sybren@thirdtower.com> <1068027414.10388.149.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1068027414.10388.149.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, Nov 05, 2003 at 11:16:54AM +0100, Marcel Holtmann wrote:
> I have no problem with the patch, but if you talk about PPP over RFCOMM
> you should better use dund.

I tried dund, but I couldn't get it to work together with Affix on my
Sharp Zaurus (running OpenZaurus 3.2). I'll try again and come up with
some info that might actually be useful for solving the mistery ;-)

> And why do you need this for scripting? You can bind a RFCOMM channel
> to a device and all stuff would be done in background without user
> interaction.

I wanted to delay the starting of pppd until the connection was actually
made. I thought it was the easiest to just parse rfcomm's output.

Greetz,
Sybren

PS: What is the list's policy on PGP-signed messages? 
-- 
(o_   Q: God, root, what is difference?
//\   A: God can change the byte order on the CPU, root can't.
V_/_
