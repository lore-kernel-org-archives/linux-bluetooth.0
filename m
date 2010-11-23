Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Nov 2010 12:10:21 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Suraj Sumangala <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com
Subject: Re: [PATCH] hciattach: makes set_speed return error if any one
 operation fail
Message-ID: <20101123111021.GA4245@jh-x301>
References: <1290508783-31183-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290508783-31183-1-git-send-email-suraj@atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

On Tue, Nov 23, 2010, Suraj Sumangala wrote:
> This patch lets set_speed function changing UART baud rate
> to return an error code if any one operation fails
> instead of returning only the last operation's status.
> 
> ---
>  tools/hciattach.c |   13 ++++++++++---
>  1 files changed, 10 insertions(+), 3 deletions(-)

Pushed upstream. Thanks.

Johan
