Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1306942320-12400-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1306942320-12400-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Date: Wed, 1 Jun 2011 11:43:47 -0400
Message-ID: <BANLkTik3r6-4ik6+bvJ0kJbGKMYxDUprQg@mail.gmail.com>
Subject: Re: [PATCH v3] Add support of secure pin code in mgmt code
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

On Wed, Jun 1, 2011 at 11:32 AM, Waldemar Rymarkiewicz
<waldemar.rymarkiewicz@tieto.com> wrote:
> @@ -135,13 +135,13 @@ int btd_event_request_pin(bdaddr_t *sba, bdaddr_t *dba)
>
>        memset(pin, 0, sizeof(pin));
>        pinlen = read_pin_code(sba, dba, pin);
> -       if (pinlen > 0) {
> +       if (pinlen > 0 && (secure && pinlen == 16)) {

I think this does not make sense. Regardless of secure being TRUE or
FALSE, "pinlen > 0" will never influence the condition check, so this
is actually equivalent to "if (secure && pinlen == 16)". Maybe you
meant:

if (pinlen > 0 || (secure && pinlen == 16))

?

>                btd_adapter_pincode_reply(adapter, dba, pin, pinlen);
>                return 0;
>        }
>
>        return device_request_authentication(device, AUTH_TYPE_PINCODE, 0,
> -                                                               pincode_cb);
> +                                                       secure, pincode_cb);
>  }
>
>  static int confirm_reply(struct btd_adapter *adapter,

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
