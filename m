Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1323820654-16820-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1323820654-16820-1-git-send-email-vinicius.gomes@openbossa.org>
Date: Wed, 14 Dec 2011 14:09:35 +0200
Message-ID: <CABBYNZJzb6nSbq6JpKOn3HxcaYvLSw0JWzzHQsYh+DtfFfb+7w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] Add support for getting the Encryption Key Size
 via btio
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Wed, Dec 14, 2011 at 1:57 AM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> +static gboolean get_key_size(int sock, BtIOType type, int *size,
> +                                                               GError **err)
> +{
> +       struct bt_security sec;
> +       socklen_t len;
> +
> +       memset(&sec, 0, sizeof(sec));
> +       len = sizeof(sec);
> +       if (getsockopt(sock, SOL_BLUETOOTH, BT_SECURITY, &sec, &len) == 0) {
> +               *size = sec.key_size;
> +               return TRUE;
> +       }
> +
> +       return FALSE;
> +}

It doesn't seems that the type is used for anything here, so you can
probably removed it.

-- 
Luiz Augusto von Dentz
