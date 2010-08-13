Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Aug 2010 08:41:02 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Add mode callback to btd_adapter
Message-ID: <20100813124102.GA3546@jh-x301>
References: <AANLkTi=Jh5fsqye6-Ry+VSNWftufDFCdyNEn6fcNrW84@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTi=Jh5fsqye6-Ry+VSNWftufDFCdyNEn6fcNrW84@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Fri, Aug 13, 2010, Daniel Örstadius wrote:
> +typedef void (*btd_adapter_mode_cb) (struct btd_adapter *adapter,
> +						gboolean powered);
> +void btd_adapter_register_mode_callback(struct btd_adapter *adapter,
> +						btd_adapter_mode_cb cb);

In general this seems fine, but I think for completeness there should
also be a unregister function. Also, since we've traditionally used the
term mode to include also the discoverable state the name should
probably be something like btd_adapter_register_powered_callback and
btd_adapter_powered_cb.

Johan
