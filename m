Return-Path: <cyrus@holtmann.org>
Message-ID: <1327328885.32646.82.camel@novo.hadess.net>
Subject: Re: [RFC PATCH 0/2] auto-pairing plugin
From: Bastien Nocera <hadess@hadess.net>
To: Scott James Remnant <scott@netsplit.com>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org
Date: Mon, 23 Jan 2012 14:28:05 +0000
In-Reply-To: <1327111197-11446-1-git-send-email-scott@netsplit.com>
References: <1327111197-11446-1-git-send-email-scott@netsplit.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2012-01-20 at 17:59 -0800, Scott James Remnant wrote:
> A few core changes here to support retrying of connections without
> losing the original connection request, temporary D-Bus device object
> or Agent information - and plugin callbacks for when bonding is
> complete and cancelled.
> 
> This lets us implement an auto-pair plugin that tries the PIN 0000 for
> commonly dumb devices, and retries using the Agent when that PIN fails.
> For added cutesyness we save the blacklist we use to avoid repeatedly
> sending 0000, so if there really are any devices out there with
> different default PINs we can learn about them over time.

I'd agree to this if you could make it use the XML database that
gnome-bluetooth uses:
http://git.gnome.org/browse/gnome-bluetooth/tree/wizard/pin-code-database.xml

That would mean that we can try the automatic password, and then
fallback to asking for a PIN if it fails (like it would have for those
devices without any input that use "1234" as the pairing).

> Net effect - another thing done in the UI Agent moved into bluetoothd
> where it belongs.
> 
> *** BLURB HERE ***
> 
> Scott James Remnant (2):
>   plugin: add bonding complete and cancel callbacks with optional retry
>   autopair: add autopair plugin
> 
>  Makefile.am        |    5 +
>  acinclude.m4       |    6 ++
>  plugins/autopair.c |  209 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/adapter.c      |    2 +-
>  src/device.c       |   86 +++++++++++++++++++++
>  src/device.h       |   12 +++
>  6 files changed, 319 insertions(+), 1 deletions(-)
>  create mode 100644 plugins/autopair.c
> 


