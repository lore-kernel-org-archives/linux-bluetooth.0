Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1359083227-13122-7-git-send-email-vinicius.gomes@openbossa.org>
References: <1359083227-13122-1-git-send-email-vinicius.gomes@openbossa.org>
	<1359083227-13122-7-git-send-email-vinicius.gomes@openbossa.org>
Date: Fri, 25 Jan 2013 06:55:16 -0400
Message-ID: <CAJdJm_ObwE7wNMKr62WSUsMirgfJKnvLENTjo=NXef5NaB--iw@mail.gmail.com>
Subject: Re: [RFC BlueZ 6/6] gas: Move all the code to only one file
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Thu, Jan 24, 2013 at 11:07 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> +static int gatt_init(void)
> +{
> +       btd_profile_register(&gatt_profile);
> +
> +       return 0;
> +}
> +
> +static void gatt_exit(void)
> +{
> +       btd_profile_register(&gatt_profile);

It should be btd_profile_unregister() here.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
