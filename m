Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Apr 2014 11:01:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH 09/36] android/gatt: Add listening socket for GATT
Message-ID: <20140429080130.GB21742@t440s.lan>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1398734107-4793-11-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398734107-4793-11-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Apr 29, 2014, Lukasz Rymanowski wrote:
> +static void connect_event(GIOChannel *io, GError *gerr, void *user_data)
> +{
> +	struct gatt_device *dev = NULL;

This looks like an unnecessary initialization upon declaration, looking
at how the variable is handled in the rest of the function.

> +	/*TODO: Attach to attrib db */

Space after /*

> +	if (listening_sk == NULL) {

I think we're trying to make the coding style consistent by using
if (!ptr)

Johan
