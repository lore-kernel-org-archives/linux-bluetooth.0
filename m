Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Aug 2011 11:40:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Gustavo Padovan <padovan@profusion.mobi>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH Bluez v2] Fix get/set_hfp_active to match name conventions
Message-ID: <20110824084030.GD19274@dell>
References: <1313256696.2254.11.camel@THOR>
 <20110822080752.GB11306@dell>
 <1314010822.4957.2.camel@THOR>
 <1314144843.4095.50.camel@THOR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314144843.4095.50.camel@THOR>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Tue, Aug 23, 2011, Peter Hurley wrote:
> Well, after some troubleshooting here, it turns out the problem is with
> my commercial and well-known but broken mail transport server. The
> boundary server *always* encodes CharSet="utf-8" as base64-encoded
> (which is why the listserv tag is garbled).
> 
> Is it ok if I use iso 8859-1 instead?

I suppose it doesn't make much of a difference since we're using English
here. Another option that could work is to use attachments, and yet
another (what I'd actually prefer if it's possible) to switch to an
un-broken mail server.

Johan
