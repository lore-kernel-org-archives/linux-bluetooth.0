Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Oct 2010 15:32:07 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Pawlik <lucas.pawlik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix problem with invalid read from array
Message-ID: <20101006133206.GA8696@jh-x301>
References: <1286369566-1453-1-git-send-email-lucas.pawlik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1286369566-1453-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, Oct 06, 2010, Lukasz Pawlik wrote:
> This patch fix problem with reading data from out of the array range in
> function used to create EIR response.

You'll need to explain in more detail exactly what was wrong with the
old code and how your patch fixes it (and why it is the correct fix).

> -	uint8_t data[240];
> +	uint8_t data[242];

Why 242? The core spec defines the EIR data as a 240 byte field.

> -					uuid128_data[SIZEOF_UUID128 - k])
> +					uuid128_data[SIZEOF_UUID128 - 1 - k])

This change looks fine (the index of the last byte is sizeof(uuid128) - 1).

Johan
