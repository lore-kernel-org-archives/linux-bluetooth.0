Return-Path: <sybren@thirdtower.com>
From: Sybren Stuvel <sybren@thirdtower.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] rfcomm patch
Date: Wed, 5 Nov 2003 16:00:39 +0100
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
References: <200311050945.34166.sybren@thirdtower.com> <1068027414.10388.149.camel@pegasus> <20031105121405.GA9763@sybren.thirdtower.com>
In-Reply-To: <20031105121405.GA9763@sybren.thirdtower.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311051600.40995.sybren@thirdtower.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Wednesday 05 November 2003 13:14, Sybren Stuvel wrote:
> I tried dund, but I couldn't get it to work together with Affix on my
> Sharp Zaurus (running OpenZaurus 3.2). I'll try again and come up with
> some info that might actually be useful for solving the mistery ;-)

Apparently I didn't try dund, or I tried it the wrong way. Now that I'm 
looking at it with a fresh mind it works like a charm:

sybren root # dund --search --nodetach
dund[10733]: DUN daemon ver 1.1
dund[10733]: Inquiring
dund[10733]: Searching for LAP on 00:10:7A:4C:23:02
dund[10733]: Connecting to 00:10:7A:4C:23:02 channel 2
dund[10733]: Connection established
Using interface ppp0
Connect: ppp0 <--> /dev/rfcomm0
local  IP address 172.16.0.2
remote IP address 172.16.0.1
BSD-Compress (15) compression enabled
 
Thank you very much! This saves me a lot of fuss!
You made me a very happy man :)

Greetz,
Sybren
-- 
(o_   Q: God, root, what is difference?
//\   A: God can change the byte order on the CPU, root can't.
V_/_
