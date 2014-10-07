Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412666365-9562-6-git-send-email-marcin.kraglak@tieto.com>
References: <1412666365-9562-1-git-send-email-marcin.kraglak@tieto.com>
	<1412666365-9562-6-git-send-email-marcin.kraglak@tieto.com>
Date: Tue, 7 Oct 2014 19:08:35 -0400
Message-ID: <CAHrH25RGO8AC2N1cqWvZ_rb6axYHxQs_Yn4s8h=Or38Z2cF7cA@mail.gmail.com>
Subject: Re: [PATCH 5/6] shared/gatt: Add gatt-client include service iterator
From: Arman Uguray <armansito@chromium.org>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,


> @@ -1635,6 +1635,36 @@ bool bt_gatt_characteristic_iter_next(struct bt_gatt_characteristic_iter *iter,
>         return true;
>  }
>
> +bool bt_gatt_include_service_iter_init(struct bt_gatt_include_service_iter *i,
> +                                       const bt_gatt_service_t *service)

I would use "iter" instead of "i" to keep it consistent with the rest
of the code (here and elsewhere).

Thanks,
Arman
