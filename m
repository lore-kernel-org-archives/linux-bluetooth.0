Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 May 2014 10:56:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vikrampal <vikram.pal@samsung.com>
Cc: linux-bluetooth@vger.kernel.org,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	bharat.panda@samsung.com, p.sinha@samsung.com, cpgs@samsung.com
Subject: Re: Add SDP discovery support to gatttool with BR
Message-ID: <20140514075617.GA28535@t440s.lan>
References: <004201cf6a99$bbc7d590$335780b0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <004201cf6a99$bbc7d590$335780b0$@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikram,

On Thu, May 08, 2014, Vikrampal wrote:
> I am new to BlueZ community. I'd like to contribute to BlueZ community. I
> went through BlueZ's TODO items. 
> To get started, I have selected adding SDP discovery support to gatttool
> with BR as my first work.
> 
> - Add sdp discovery support to gatttool with BR (--sdp, default is 0x1f)

Not sure what exactly you mean here. ATT over BR/EDR uses a fixed PSM so
separate discovery of this is not necessary. The core spec says:

"The use of a fixed PSM allows rapid reconnection of the L2CAP channel
for Attribute Protocol as a preliminary SDP query is not required."

Based on git blame this item was added 5th Oct 2010, i.e. in the very
early days of the LE specification. I suspect that there might have been
some confusion regarding the ATT PSM back then. While this kind of PSM
discovery it's not completely pointless, we don't do it for any other
fixed PSM profiles either (e.g. A2DP & AVRCP) so I think it's better to
spend time on more valuable tasks instead.

I've now removed the ATT PSM related items from the TODO file (which btw
could use much more cleanups in general).

Johan
