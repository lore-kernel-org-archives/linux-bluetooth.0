Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Mar 2012 15:57:31 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Heart Rate Profile API
Message-ID: <20120302235731.GA32181@x220.ice.intel.com>
References: <1330070908-2361-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330070908-2361-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Fri, Feb 24, 2012, Santiago Carot-Nemesio wrote:
> +		Reset()
> +
> +			Restart the accumulation of energy expended from zero.
> +
> +			Possible Errors: org.bluez.Error.NotSupported
> +
> +Properties	boolean Reset [readonly]
> +
> +			True if energy expended is supportted.

The API looks good to me, but I think ResetSupported would make more
sense for this property name. Also, I'd have expected someone from INdT
to either give an ack or nack for this.

Johan
