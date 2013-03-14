Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1363285326-20089-6-git-send-email-deymo@chromium.org>
References: <1363285326-20089-1-git-send-email-deymo@chromium.org>
	<1363285326-20089-6-git-send-email-deymo@chromium.org>
Date: Thu, 14 Mar 2013 16:45:22 -0400
Message-ID: <CAJdJm_NpgRFV7qkoN_OAKYgS0Ff8kk8qJCH86sPvw5+qx4UHSQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] Agent's DisplayPasskey implementation
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org, marcel@holtmann.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Thu, Mar 14, 2013 at 2:22 PM, Alex Deymo <deymo@chromium.org> wrote:
> +       dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
> +                       DBUS_TYPE_UINT32, &passkey, DBUS_TYPE_UINT16, &entered,
> +                                                       DBUS_TYPE_INVALID);
> +
> +       snprintf(passkey_entered, 7, "%.6u", passkey);
> +       passkey_entered[6] = '\0';
> +       strncpy(passkey_remaining, passkey_entered, 7);
> +       if (entered > strlen(passkey_entered))
> +               entered = strlen(passkey_entered);
> +       passkey_entered[entered] = '\0';
> +
> +       rl_printf(AGENT_PROMPT "Passkey: " COLOR_BOLDGRAY "%s" COLOR_BOLDWHITE
> +               "%s\n" COLOR_OFF, passkey_entered, passkey_remaining+entered);
> +
> +       return dbus_message_new_method_return(msg);
> +}
> +

What about using the "%.*s" printf format specifier to simplify
things? Something like (not tested):


    snprintf(passkey_full, sizeof(passkey_full), "%.6u", passkey);
    passkey_full[6] = '\0';

    if (entered > strlen(passkey_full))
        entered = strlen(passkey_full);

    rl_printf(AGENT_PROMPT "Passkey: " COLOR_BOLDGRAY "%.*s" COLOR_BOLDWHITE
            "%s\n" COLOR_OFF, entered, passkey_full, passkey_full + entered);


Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
