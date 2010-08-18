Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Aug 2010 16:33:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Maemo6 MCE: handle race condition at startup
Message-ID: <20100818133332.GA7018@jh-x301>
References: <AANLkTikOj==zpA90bNAY0wVgXwQs1=a279RY8MNuz_KF@mail.gmail.com>
 <AANLkTimfQxLOTFVW64qrQLHYVjwsmDkxvuBkL-_eBKHR@mail.gmail.com>
 <AANLkTinmYUw=_BuaOE5MgEMvF9qU3Kr-=X52cQ5v-bfy@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTinmYUw=_BuaOE5MgEMvF9qU3Kr-=X52cQ5v-bfy@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Wed, Aug 18, 2010, Daniel Örstadius wrote:
> Patch without the off_requested part.
> 
> /Daniel
>
> From 3160d36371fe7c95ecd5a4eb3e167ac374dbc4d4 Mon Sep 17 00:00:00 2001
> From: Daniel Orstadius <daniel.orstadius@nokia.com>
> Date: Wed, 18 Aug 2010 15:48:28 +0300
> Subject: [PATCH] Maemo6 MCE: handle race condition at startup
> 
> Since bluetoothd power cycles the adapter at startup, it is possible
> that the plugin gets a reply from reading the state of the MCE and
> tries to power the adapter before it is down. The patch checks for
> that situation and if it occurs postpones powering the adapter to
> the powered state callback.
> ---
>  plugins/maemo6.c |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)

Thanks. This one is now also upstream.

Johan
