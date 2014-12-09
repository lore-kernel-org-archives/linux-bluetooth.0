Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Dec 2014 10:07:56 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 07/15] core: device: Use bt_att_register_disconnect.
Message-ID: <20141209080756.GA4214@t440s.lan>
References: <1418085655-7304-1-git-send-email-armansito@chromium.org>
 <1418085655-7304-8-git-send-email-armansito@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418085655-7304-8-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Mon, Dec 08, 2014, Arman Uguray wrote:
> +	dev->att = bt_att_ref(g_attrib_get_att(attrib));

I'd expect a function called "get" to return a new reference, so the
extra ref() shouldn't be needed.

Btw, I hope this is just a temporary function that you've introduced to
be able to do the conversions in smaller bits, and that it'll be removed
as soon as the conversions are done?

Johan
