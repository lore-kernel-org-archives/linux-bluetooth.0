Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1307688624-5519-1-git-send-email-luiz.dentz@gmail.com>
References: <1307688624-5519-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 10 Jun 2011 10:26:49 -0400
Message-ID: <BANLkTi=Y8qekQKsX_1fY01sF0A4Ja1tiSA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix L2CAP security check
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Jun 10, 2011 at 2:50 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 3163330..efda44c 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -611,8 +611,8 @@ auth:
>        if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend))
>                return 0;
>
> -       hci_conn_auth(conn, sec_level, auth_type);
> -       return 0;
> +       if (!(hci_conn_auth(conn, sec_level, auth_type)))
> +               return 0;

Too much nitpicking, but why the extra parenthesis?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
