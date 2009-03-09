Return-Path: <cyrus@holtmann.org>
Date: Mon, 9 Mar 2009 17:00:19 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] [PATCH] Do no process a stream as connected if AVDTP set
	configuration failed
Message-ID: <20090309200019.GA6610@jh-x301>
References: <35c90d960903061659x433122ddrf6fb38ec02a50d60@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35c90d960903061659x433122ddrf6fb38ec02a50d60@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

On Fri, Mar 06, 2009, Nick Pelly wrote:
> Right now, if set configuration fails then the
> sink.c:stream_setup_complete seems to consider the stream connected.
> So the DBus AudioSink.Connect() call returns without error. But the
> stream is not actually ready.
> 
> I have a feeling we may want to do some more cleanup, but this patch
> does the trick for us.
> 
> It is easy to reproduce the problem with the HTC BH S100. If you
> quickly disconnect and then reconnect it will return AVDTP set
> configuration failed (presumably because it hasn't closed the SEP on
> its end yet), but Dbus does not return an error for Connect.

Thanks for the patch. I pushed a slightly modified fix since the
callback should always get NULL for the stream if there was an error:
http://git.kernel.org/?p=bluetooth/bluez.git;a=commitdiff;h=8f619dd6228f1cfa750e562d4e2ea89396e8b4fd

Johan
