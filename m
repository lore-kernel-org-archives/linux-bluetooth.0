Return-Path: <Steven.Singer@csr.com>
Message-ID: <3FE1BC0A.7070707@csr.com>
Date: Thu, 18 Dec 2003 14:39:06 +0000
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: ag@new-media-artists.de,
   BlueZ Mailing List
    <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Device Busy during "hcitool info" or
    "sdptoolsearch"
References: <FJENILNPNAGPJMMDOKDCKEKBDJAA.ag@new-media-artists.de>
    <3FE0C1B9.5090504@csr.com> <1071699104.21804.77.camel@pegasus>
In-Reply-To: <1071699104.21804.77.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
>>The create_connection-inquiry restriction is there because both
>>procedures need to get as much radio bandwidth as possible to work. In
>>particular, taking bandwidth away from paging can cause spurious failed
>>connections. In this case, create_connection wins. If you issue a
>>create_connection while an inquiry is in progress, we will terminate
>>the inquiry with an inquiry_complete event and start paging
>>immediately.
> 
> 
> this is a nice thing/feature to know. Is it documented anywhere in the
> firmware release notes?

This particular behaviour is not documented (if it were, it would be in
our HCI implementation document (bcore-me-007Pb), not the firmware
release note).

The Bluetooth baseband spec says that devices should free up as much
bandwidth as possible for inquiring and paging. It doesn't specify how
to handle a collision between two actions that both require a lot of
bandwidth.

Really, the host should cancel inquiry before trying to create a
connection. However, it would be churlish for us to design our code to
work only with perfect hosts. Where the spec allows it, a little bit of
flexibility can make things a bit easier for all concerned (not least,
by reducing the volume of support calls we get).

There are several places where we do this. Most of them are not
documented and the behaviour should not be relied on. Future versions
of the spec may mandate a particular behaviour.

If in doubt, whenever we get conflicting requests from the host, we
apply the Law of Least Astonishment [1]. Mostly this involves deciding
which course of action is going to cause least damage to the network.
We will prioritise some behaviours over others (so activities which
are essential to keeping an existing link up win over those that are
merely nice).

Naturally, we don't want to burn too much code space and processor
time dealing with things the host shouldn't be doing, so we tend to
pick simple heuristics. It's not worth trying to go for perfect
algorithms - that would require being psychic as on different
occasions the host may want different things.

Consequently, we do tend to change our minds between firmware
versions depending on what's easiest to implement and the feedback
we're getting from our customers.

 From BlueZ's point of view, you need to maximise the number
Bluetooth devices you work with. You should be trying to avoid
unspecified or manufacturer specific behaviour.

	- Steven

[1] http://www.schedler.org/cookie/the-tao-of-programming.html#4.0
-- 



**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************
