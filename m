Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349425021-16766-1-git-send-email-szymon.janc@tieto.com>
References: <1349425021-16766-1-git-send-email-szymon.janc@tieto.com>
Date: Fri, 5 Oct 2012 06:54:17 -0400
Message-ID: <CAJdJm_N7omVUmhsmWoOUyCmuWojAKN5Lms=6a0qwbsYbXCf_Bw@mail.gmail.com>
Subject: Re: [PATCH 1/7] adapter: Convert adapter_get_address into simple getter
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Oct 5, 2012 at 4:16 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> @@ -2578,6 +2557,7 @@ DBusMessage *device_create_bonding(struct btd_device *device,
>         if (device_is_bonded(device))
>                 return btd_error_already_exists(msg);
>
> +                               adapter_get_address(adapter),
>         bonding = bonding_request_new(msg, device, agent_path,
>                                         capability);
>

The above looks like a typo (and unfortunately, it compiles, due to the comma).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
