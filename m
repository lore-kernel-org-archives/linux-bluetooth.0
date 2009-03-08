Return-Path: <cyrus@holtmann.org>
Date: Sun, 8 Mar 2009 18:31:55 +0000
From: James Le Cuirot <chewi@aura-online.co.uk>
To: linux-bluetooth@vger.kernel.org
Subject: bnep should not depend on IPv6
Message-ID: <20090308183155.2d68c6e4@symphony>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I've been playing with networking in Bluez to some degree of success. I
found that whenever a PANU client tried to connect to my NAP, the bnep0
interface would fail to come up. It would only start working after
bringing it up manually. I checked out the log and found errors that
said "Bad file descriptor(9)". I looked at the source and traced this
back to network/connection.c where there are two calls to socket() with
AF_INET6 given as an argument. I don't have IPv6 support included in my
kernel so I changed these to AF_INET and everything started working.
I'm don't know what the real fix for this is, probably some kind of
ifdef construct, but I'm sure you'll know what to do.

Cheers,
James
