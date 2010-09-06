Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Sep 2010 14:15:16 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Add new plugin to set adapter class
Message-ID: <20100906111516.GA23167@jh-x301>
References: <1283770089.7529.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283770089.7529.9.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Mon, Sep 06, 2010, Bastien Nocera wrote:
> +if HAL
>  builtin_modules += hal
>  builtin_sources += plugins/hal.c
> +else
> +builtin_modules += formfactor
> +builtin_sources += plugins/formfactor.c
> +endif

Previously it was possible to --disable-hal and be sure that whatever is
defined in main.conf gets used (this is e.g. something that has been
important for us in Maemo/MeeGo). Your patch seems to make one of the
two automated adapter class sources always be used and so potentially
overriding what main.conf says. So I'd prefer to keep the possibility of
disably any such plugins completely.

Johan
