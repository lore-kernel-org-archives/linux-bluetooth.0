Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Oct 2010 17:16:25 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix telephony-maemo6: call notification with call on
 hold
Message-ID: <20101013141625.GA4828@jh-x301>
References: <AANLkTimb82Ykv9fg2Oew4YoN1767e5_NX4Tid+3wHOzE@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTimb82Ykv9fg2Oew4YoN1767e5_NX4Tid+3wHOzE@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Wed, Oct 13, 2010, Daniel Örstadius wrote:
> BlueZ sends +CLIP and RING when there is an incoming call and no
> currently active call. If there is an active call it sends AT+CCWA
> (call waiting notification).
> 
> Modification to send AT+CCWA instead of +CLIP and RING also when
> there is a call on hold (the incoming call goes into the waiting
> state).
> ---
>  audio/telephony-maemo6.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Pushed upstream. Thanks.

Johan
