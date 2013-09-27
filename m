Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1380291161-10232-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1380291161-10232-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 27 Sep 2013 14:01:31 -0400
Message-ID: <CAJdJm_OYf-QjS9iS6vON7jw8biq0_8g0KpoHBW_-Gb0-U6w3Pg@mail.gmail.com>
Subject: Re: [RFC 10/16] android: Add Android Makefile for libbluetooth
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Sep 27, 2013 at 10:12 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> +# to suppress the "pointer of type 'void *' used in arithmetic" warning
> +LOCAL_CFLAGS += -Wno-pointer-arith
> +
> +# to suppress the "missing initializer near initialization" warning
> +LOCAL_CFLAGS += -Wno-missing-field-initializers
> +
> +# to suppress the "may be used uninitialized in this function" warning
> +LOCAL_CFLAGS += -Wno-maybe-uninitialized

I wonder why you are suppressing all those warnings. Do you plan to
re-enable them once the implementation is more complete?

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
