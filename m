Return-Path: <pb@nexus.co.uk>
Date: Mon, 16 Feb 2004 15:41:55 +0000
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Fred Sch??ttgen <bluez-devel@schaettgen.de>,
   bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] D-Bus interfaces
Message-ID: <20040216154155.GB32285@nexus.co.uk>
References: <1076265358.2670.36.camel@pegasus> <1076278554.14742.112.camel@akka.yeti.nocrew.org> <1076279508.6869.54.camel@pegasus> <200402090015.24318.bluez-devel@schaettgen.de> <20040216144615.GA318@nexus.co.uk> <1076945776.17824.6.camel@merlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1076945776.17824.6.camel@merlin>
From: Phil Blundell <pb@nexus.co.uk>
List-ID: <bluez-devel.lists.sourceforge.net>

on Mon, Feb 16, 2004 at 04:36:15PM +0100, Marcel Holtmann wrote:
> btw I tried to integrate the D-Bus patch for the PIN-Helper, but got
> compilation errors with the libraries from Debian Sid. Has anyone used
> this patch on Debian Sid?

Ah, yeah, you need an updated version to work with D-BUS 0.20.  I think 
http://handhelds.org/~pb/bluez-utils-2.3-dbus-20040119.diff
is the right file.  The version of bluez-pin in Sid is already updated.
Let me know if you still have trouble.

p.
