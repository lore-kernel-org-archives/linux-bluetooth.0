Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Dec 2009 07:34:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] dbus timeout handling
Message-ID: <20091217053448.GA22217@jh-x301>
References: <eb7933e20912110025y20eb4a6aw615660648d4756f8@mail.gmail.com>
 <eb7933e20912160211h165d90f2s4969c6cfea2d9b01@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <eb7933e20912160211h165d90f2s4969c6cfea2d9b01@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Wed, Dec 16, 2009, Daniel Örstadius wrote:
> From 70cc29c724c089e1468a6670c53e1f77d5b3ebcc Mon Sep 17 00:00:00 2001
> From: Daniel Orstadius <daniel.orstadius@gmail.com>
> Date: Wed, 16 Dec 2009 11:23:46 +0200
> Subject: [PATCH] dbus timeout handling
> 
> ---
>  gdbus/mainloop.c |   17 ++++++++++++++++-
>  1 files changed, 16 insertions(+), 1 deletions(-)

Thanks for the patch. I've pushed it upstream with one minor coding
style change: "> 0" instead of "!= 0" (Marcel requested this).

Johan
