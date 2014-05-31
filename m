Return-Path: <cyrus@holtmann.org>
Date: Sat, 31 May 2014 19:22:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH 1/2] tools/btmgmt: Add set-io-cap command
Message-ID: <20140531162240.GA27901@t440s.ger.corp.intel.com>
References: <1401203866-8851-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1401203866-8851-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Tue, May 27, 2014, Lukasz Rymanowski wrote:
> +static void cmd_set_io_cap(struct mgmt *mgmt, uint16_t index,
> +						int argc, char **argv)
> +{
> +	struct mgmt_cp_set_io_capability cp;
> +	uint8_t cap = 0x01;

No reason to set this here as you anyway overwrite it later.

> +	cap = atoi(argv[1]);

strtol makes more sense (to support hex too) and is consistent to how
this is decoded for the pair command.

Since I needed this feature myself I fixed these things up with --amend
and pushed the patch. Thanks.

Johan
