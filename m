Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1298989535-403-2-git-send-email-dmitriy.paliy@nokia.com>
References: <1298989535-403-1-git-send-email-dmitriy.paliy@nokia.com>
	<1298989535-403-2-git-send-email-dmitriy.paliy@nokia.com>
Date: Tue, 1 Mar 2011 11:39:30 -0400
Message-ID: <AANLkTikHo9orirjN8YPxnPaKfauJ-FdM8nWfkGHNLBkw@mail.gmail.com>
Subject: Re: [PATCH] Fix response on adapter RequestSession method
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Tue, Mar 1, 2011 at 10:25 AM, Dmitriy Paliy <dmitriy.paliy@nokia.com> wrote:
> @@ -795,17 +816,31 @@ static void confirm_mode_cb(struct agent *agent, DBusError *derr, void *data)
>                return;
>        }
>
> -       err = set_mode(req->adapter, req->mode, NULL);
> -       if (err < 0)
> +       err = set_mode(req->adapter, req->mode, req->msg);
> +       if (err < 0) {
>                reply = btd_error_failed(req->msg, strerror(-err));
> -       else
> +               goto proceed;
> +       }
> +
> +       if (!req->adapter->pending_mode) {
>                reply = dbus_message_new_method_return(req->msg);
> +               goto proceed;
> +       }
> +
> +       goto done;
>
> +proceed:
> +       /*
> +        * Send reply immidiately only if there was an error changing
> +        * mode, or change is not needed. Otherwise, reply is sent in
> +        * set_mode_complete.
> +        */
>        g_dbus_send_message(req->conn, reply);
>
>        dbus_message_unref(req->msg);
>        req->msg = NULL;
>
> +done:
>        if (!find_session(req->adapter->mode_sessions, req->owner))
>                session_unref(req);
>  }

I think you can avoid all those gotos and make this code simpler. I'll
descride the steps that could be done without changing the behavior of
your original patch:

1) move if (!req->adapter->pending_mode) {...} block into the else
clause of the previous if(), i.e.:

    if (err < 0) {
        reply = btd_error_failed(req->msg, strerror(-err));
        goto proceed;
    } else if (!req->adapter->pending_mode) {
        reply = dbus_message_new_method_return(req->msg);
        goto proceed;
    }

2) Now we can drop both "goto proceed" statements and the "proceed"
label, replacing with a if():

...
    if (err < 0)
        reply = btd_error_failed(req->msg, strerror(-err));
    else if (!req->adapter->pending_mode)
        reply = dbus_message_new_method_return(req->msg);

    if (err < 0 || !req->adapter->pending_mode) {
        /* your comment here; note there is a typo on the original
comment (immidiately -> immediately) */
        g_dbus_send_message(req->conn, reply);

        dbus_message_unref(req->msg);
        req->msg = NULL;
    }
...

3) finally you can drop the "goto done" and the "done" label as well.


Note that you changed the behavior of the original code regarding the
attribution of the "reply" variable. If the reply variable is
guaranteed to the NULL before the code code, I suppose you could
replace the " if (err < 0 || !req->adapter->pending_mode)" with just
"if (reply != NULL)".

Anyway, take this just as suggestion. I'm sure the logic can be
changed to avoid all those goto's and two labels.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
