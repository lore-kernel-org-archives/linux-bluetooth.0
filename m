Return-Path: <cyrus@holtmann.org>
Message-ID: <1345136955.28588.5.camel@zingle>
Subject: Re: Moving bluetooth plugin to gstreamer
From: Tim-Philipp =?ISO-8859-1?Q?M=FCller?= <t.i.m@zen.co.uk>
To: Discussion of the development of and with GStreamer
	<gstreamer-devel@lists.freedesktop.org>
Cc: linux-bluetooth@vger.kernel.org,
	Thiago Sousa Santos <thiagossantos@gmail.com>
Date: Thu, 16 Aug 2012 18:09:15 +0100
In-Reply-To: <CABBYNZJ16G7zOEm+AJwmb8SeEtRyGzfiKFf+QsK8NdQGUUGqDA@mail.gmail.com>
References: <CABBYNZJ16G7zOEm+AJwmb8SeEtRyGzfiKFf+QsK8NdQGUUGqDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2012-08-16 at 16:25 +0300, Luiz Augusto von Dentz wrote:

Hi,

> Since we now have a proper library for SBC codec
> (http://git.kernel.org/?p=bluetooth/sbc.git;a=summary) and its patent
> has expired June 2, 2010. (source:
> http://en.wikipedia.org/wiki/SBC_(codec)), I wonder if it wouldn't be
> a good idea to move the plugin to gstreamer tree?
> 
> The plugin has the following elements:
> 
> bluetooth:  sbcenc: Bluetooth SBC encoder
> bluetooth:  sbcdec: Bluetooth SBC decoder
> bluetooth:  sbcparse: Bluetooth SBC parser
> bluetooth:  avdtpsink: Bluetooth AVDTP sink
> bluetooth:  a2dpsink: Bluetooth A2DP sink
> bluetooth:  rtpsbcpay: RTP packet payloader

Sounds like a good idea to me.

We'd probably add them to gst-plugins-bad first though, since that's
where new plugins are usually added before they get moved to -good or
elsewhere. And probably only to git master (ie. for the upcoming
0.11/1.0 API version).

Would the idea be that you'd turn libsbc from noinst into a proper
library, or would we just move that over into the plugin as well?

  Cheers
 -  Tim


