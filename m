Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1293447745-8697-4-git-send-email-michal.labedzki@tieto.com>
References: <1293447745-8697-1-git-send-email-michal.labedzki@tieto.com>
	<1293447745-8697-4-git-send-email-michal.labedzki@tieto.com>
Date: Mon, 27 Dec 2010 07:52:31 -0400
Message-ID: <AANLkTinXwbHZt4SSaz+tUUH+7QnQo7L4FKFKetmQm9Qx@mail.gmail.com>
Subject: Re: [PATCH 4/4] Better filtering input string contain bdaddr
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Dec 27, 2010 at 7:02 AM, Michal Labedzki
<michal.labedzki@tieto.com> wrote:
> +               if (((*ptr < 'A' || *ptr > 'F') &&
> +                       (*ptr < 'a' || *ptr > 'f') &&
> +                       (*ptr < '0' || *ptr > '9')) ||
> +                       ( (ptr - str) == 2 && *ptr != ':')) {
> +                       bt_free(ba);
> +                       goto err_bdaddr;
> +               }

The logic above seems wrong. Make sure you are not mixing || and &&.

> +
> +               ++i;
> +               ++ptr;

I think the usual coding style in bluez uses post-increment in these
cases (e.g. i++).

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
