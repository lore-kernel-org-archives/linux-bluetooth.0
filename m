Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327335872.32646.103.camel@novo.hadess.net>
References: <1327100744-28782-1-git-send-email-scott@netsplit.com>
	<1327320873.32646.77.camel@novo.hadess.net>
	<CA+bD78h+vp5EY+HSvArRSfySr3EWSi3f0qvK+PiKX6OH8Q7w-A@mail.gmail.com>
	<1327334612.32646.97.camel@novo.hadess.net>
	<CAHZ1yCk3twweh031ff1UyLJtr3kkgQDAXiT56M0ANyiNe3uqhw@mail.gmail.com>
	<1327335872.32646.103.camel@novo.hadess.net>
Date: Mon, 23 Jan 2012 08:26:35 -0800
Message-ID: <CAHZ1yC=1gz9PgRtnJoHQCWDdpTZ9r4OR-AY9etam0wXD0qkhzg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Generate PIN for keyboards inside bluetoothd
From: Scott James Remnant <keybuk@chromium.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: Scott James Remnant <scott@netsplit.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 23, 2012 at 8:24 AM, Bastien Nocera <hadess@hadess.net> wrote:

> Are you going to add a mention in the documentation for the new function
> that it can only be called for 2.0 Bluetooth keyboards, or are there
> other devices it will handle?
>

I will mention; right now it's 2.0 Bluetooth keyboards since that's
what the HID profile spec says to do for them, and not for anything
else.

Scott
