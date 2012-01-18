Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jan 2012 14:13:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd v2 1/4] MAP: Implementation of MAP AP core functions
Message-ID: <20120118121337.GB6655@x220>
References: <1326461618-26864-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326461618-26864-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Fri, Jan 13, 2012, Slawomir Bochenski wrote:
> +	union {
> +		uint32_t val32u;
> +		uint16_t val16u;
> +		uint8_t val8u;
> +		char *valstr;
> +	};

To keep consistent with some other places in BlueZ code, could you do
this as:

	union {
		uint32_t u32;
		uint16_t u16;
		uint8_t u8;
		char *str;
	} val;

After which you'd access these as entry->val.u32, etc.

Johan
