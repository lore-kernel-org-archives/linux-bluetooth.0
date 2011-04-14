Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Apr 2011 20:04:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Remove unnecessary code from pin handler
Message-ID: <20110414170454.GB7152@jh-x301>
References: <1302450491-26550-1-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1302450491-26550-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Sun, Apr 10, 2011, David Herrmann wrote:
> The source address is not used inside the pin handler and, thus,
> can be skipped.
> ---
>  src/event.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)

The patch has been applied. Thanks.

Johan
