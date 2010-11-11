Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 11:35:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Bruna Moreira <bruna.moreira@openbossa.org>
Subject: Re: [PATCH 1/7] Fix invalid memory access when EIR field length is
 zero
Message-ID: <20101111093526.GC4132@jh-x301>
References: <1289411487-6113-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289411487-6113-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 10, 2010, Anderson Lizardo wrote:
> -	uint8_t *uuid16;
> -	uint8_t *uuid32;
> -	uint8_t *uuid128;
> +	uint8_t *uuid16 = 0;
> +	uint8_t *uuid32 = 0;
> +	uint8_t *uuid128 = 0;

0 is for integers, NULL for pointers. However, in this case I don't see
why the inialization is needed at all since the rest of the patch seems
to take care of the bug by itself.

Johan
