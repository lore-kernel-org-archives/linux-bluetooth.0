Return-Path: <cyrus@holtmann.org>
Message-ID: <1345173220.13726.31.camel@aeonflux>
Subject: Re: Moving bluetooth plugin to gstreamer
From: Marcel Holtmann <marcel@holtmann.org>
To: Tim-Philipp =?ISO-8859-1?Q?M=FCller?= <t.i.m@zen.co.uk>
Cc: Discussion of the development of and with GStreamer
	<gstreamer-devel@lists.freedesktop.org>,
	linux-bluetooth@vger.kernel.org,
	Thiago Sousa Santos <thiagossantos@gmail.com>
Date: Fri, 17 Aug 2012 05:13:40 +0200
In-Reply-To: <1345136955.28588.5.camel@zingle>
References: <CABBYNZJ16G7zOEm+AJwmb8SeEtRyGzfiKFf+QsK8NdQGUUGqDA@mail.gmail.com>
	 <1345136955.28588.5.camel@zingle>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tim,

> > Since we now have a proper library for SBC codec
> > (http://git.kernel.org/?p=bluetooth/sbc.git;a=summary) and its patent
> > has expired June 2, 2010. (source:
> > http://en.wikipedia.org/wiki/SBC_(codec)), I wonder if it wouldn't be
> > a good idea to move the plugin to gstreamer tree?
> > 
> > The plugin has the following elements:
> > 
> > bluetooth:  sbcenc: Bluetooth SBC encoder
> > bluetooth:  sbcdec: Bluetooth SBC decoder
> > bluetooth:  sbcparse: Bluetooth SBC parser
> > bluetooth:  avdtpsink: Bluetooth AVDTP sink
> > bluetooth:  a2dpsink: Bluetooth A2DP sink
> > bluetooth:  rtpsbcpay: RTP packet payloader
> 
> Sounds like a good idea to me.
> 
> We'd probably add them to gst-plugins-bad first though, since that's
> where new plugins are usually added before they get moved to -good or
> elsewhere. And probably only to git master (ie. for the upcoming
> 0.11/1.0 API version).
> 
> Would the idea be that you'd turn libsbc from noinst into a proper
> library, or would we just move that over into the plugin as well?

as Luiz pointed out, that has already been done. It is standalone now
with its own GIT tree and a released 1.0 tarball for distributions to
package.

Regards

Marcel


