Return-Path: <cyrus@holtmann.org>
Date: Sat, 30 Jan 2010 07:23:46 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Release conference call in telephony-maemo
Message-ID: <20100130152346.GA2714@jh-x301>
References: <eb7933e21001280719w32d2adfco89ce9b99940c968b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <eb7933e21001280719w32d2adfco89ce9b99940c968b@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Thu, Jan 28, 2010, Daniel Örstadius wrote:
> From 83c71f16e235290146ad77ebbd4e818d0b520540 Mon Sep 17 00:00:00 2001
> From: Daniel Orstadius <daniel.orstadius@gmail.com>
> Date: Thu, 28 Jan 2010 17:14:40 +0200
> Subject: [PATCH] Release conference call in telephony-maemo
> 
> Currently telephony-maemo only ends the first call found on
> receiving AT+CHUP (hang up) from the headset. This patch checks
> if the call is part of a conference call and in that case releases
> the whole conference.
> ---
>  audio/telephony-maemo.c |   28 +++++++++++++++++++++++++++-
>  1 files changed, 27 insertions(+), 1 deletions(-)

The patch has been pushed upstream (with a few minor cosmetic changes).
Thanks!

Johan
