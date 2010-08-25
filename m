Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Aug 2010 16:29:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Colin Didier <didier@archos.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] No error message on interrupted syscall
Message-ID: <20100825132900.GB26560@jh-x301>
References: <20100825085454.GB27072@cybione.org>
 <20100825112831.GB23943@jh-x301>
 <20100825130749.GB7199@cybione.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100825130749.GB7199@cybione.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Colin,

On Wed, Aug 25, 2010, Colin Didier wrote:
> An interrupted syscall is not an error when returning from poll().
> ---
>  audio/pcm_bluetooth.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)

This one has also been pushed upstream. Thanks.

Johan
