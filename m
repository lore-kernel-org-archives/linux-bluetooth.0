Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Feb 2011 00:00:52 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix potential bug in le_advertising_report()
Message-ID: <20110223030052.GA16014@jh-x301>
References: <1298396669-5530-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1298396669-5530-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi André,

On Tue, Feb 22, 2011, Andre Guedes wrote:
> In the current implementation of le_advertising_report(), the variable
> 'info' has an invalid memory address after the 'for' loop. If 'info'
> is dereferenced it will access invalid memory.
> 
> This patch fixes this potential bug and improves the code's readability.
> ---
>  plugins/hciops.c |   15 ++++++++++-----
>  1 files changed, 10 insertions(+), 5 deletions(-)

The patch has been pushed upstream. Thanks.

Johan
