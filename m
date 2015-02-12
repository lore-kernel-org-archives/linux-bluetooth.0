Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Feb 2015 16:57:33 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
Subject: Re: [PATCH ] tools/gatt-client: print read/write error messages
Message-ID: <20150212145733.GA6577@t440s.P-661HNU-F1>
References: <1423752296-6763-1-git-send-email-bharat.panda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423752296-6763-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Thu, Feb 12, 2015, Bharat Panda wrote:
> +static char *ecode_to_string(uint8_t ecode)

This should be static const char *

> +{
> +	char *err = NULL;
> +
> +	switch (ecode) {
> +		case BT_ATT_ERROR_INVALID_HANDLE:
> +			err = "ERROR: Invalid Handle";
> +			break;

First of all, please follow the coding style: the case statement should
start at the same indentation as the switch. Secondly, you can make this
all more compact by removing the err variable:

	case BT_ATT_ERROR_INVALID_HANDLE:
		return "Invalid Handle";
	case ...:
		return "...";

Johan
