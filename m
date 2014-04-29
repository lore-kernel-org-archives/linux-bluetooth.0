Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Apr 2014 11:03:04 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH 10/36] android/gatt: Add ATT msg handler
Message-ID: <20140429080304.GC21742@t440s.lan>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1398734107-4793-12-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398734107-4793-12-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Apr 29, 2014, Lukasz Rymanowski wrote:
> +	if (device->server_id)
> +		g_attrib_unregister(device->attrib, device->server_id);

I think the consistent style for async operation id checks is id > 0

> +	dev->server_id = g_attrib_register(attrib, GATTRIB_ALL_REQS,
> +						GATTRIB_ALL_HANDLES,
> +						att_handler, dev, NULL);
> +	if (!dev->server_id)
> +		error("gatt: Could not attache to server");

And id == 0 here

Johan
