Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1297891081-27976-4-git-send-email-bgix@codeaurora.org>
References: <1297891081-27976-1-git-send-email-bgix@codeaurora.org>
	<1297891081-27976-4-git-send-email-bgix@codeaurora.org>
Date: Mon, 14 Feb 2011 18:41:06 -0300
Message-ID: <AANLkTi=dwj0Bc_509JW8-HfkYBfzmfSzR0GJxNqoLXye@mail.gmail.com>
Subject: Re: [PATCH 3/3] Add gatttool enhancements for UPF
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@nokia.com,
	padovan@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Wed, Feb 16, 2011 at 6:18 PM, Brian Gix <bgix@codeaurora.org> wrote:
> @@ -90,9 +91,9 @@ static GIOChannel *do_connect(gboolean le)
>
>        /* This check is required because currently setsockopt() returns no
>         * errors for MTU values smaller than the allowed minimum. */
> -       if (opt_mtu != 0 && opt_mtu < ATT_MIN_MTU_L2CAP) {
> +       if (opt_mtu != 0 && opt_mtu < 23) {
>                g_printerr("MTU cannot be smaller than %d\n",
> -                                                       ATT_MIN_MTU_L2CAP);
> +                                                       23);
>                return NULL;
>        }

The changes above seem unrelated to this patch.

>
> @@ -277,6 +278,14 @@ static gboolean characteristics(gpointer user_data)
>        return FALSE;
>  }
>
> +static void char_write_cb(guint8 status, const guint8 *pdu, guint16 plen,
> +                                                       gpointer user_data)
> +{
> +       if (plen == 1)
> +               g_print("Attrib Write Succeeded\n");
> +       else
> +               g_printerr("Attrib Write failed: %s\n", att_ecode2str(status));

Why not check by the status instead of plen ?

Also, I'd suggest "Characteristic write" instead of "Attrib Write".

> +}
>  static void char_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
>                                                        gpointer user_data)
>  {
> @@ -427,7 +436,40 @@ static gboolean characteristics_write(gpointer user_data)
>                goto error;
>        }
>
> +       gatt_write_char(attrib, opt_handle, value, len, char_write_cb, value);
> +       gatt_read_char(attrib, opt_handle, char_read_cb, attrib);

Why both read and write ?

> +
> +       return FALSE;
> +
> +error:
> +       g_main_loop_quit(event_loop);
> +       return FALSE;
> +}
> +
> +static gboolean characteristics_cmd(gpointer user_data)
> +{
> +       GAttrib *attrib = user_data;
> +       uint8_t *value;
> +       size_t len;
> +
> +       if (opt_handle <= 0) {
> +               g_printerr("A valid handle is required\n");
> +               goto error;
> +       }
> +
> +       if (opt_value == NULL || opt_value[0] == '\0') {
> +               g_printerr("A value is required\n");
> +               goto error;
> +       }
> +
> +       len = attr_data_from_string(opt_value, &value);
> +       if (len == 0) {
> +               g_printerr("Invalid value\n");
> +               goto error;
> +       }
> +
>        gatt_write_cmd(attrib, opt_handle, value, len, mainloop_quit, value);
> +       gatt_read_char(attrib, opt_handle, char_read_cb, attrib);

Same question here.

>
>        return FALSE;
>
> @@ -531,6 +573,8 @@ static GOptionEntry gatt_options[] = {
>                "Characteristics Value/Descriptor Read", NULL },
>        { "char-write", 0, 0, G_OPTION_ARG_NONE, &opt_char_write,
>                "Characteristics Value Write", NULL },
> +       { "char-cmd", 0, 0, G_OPTION_ARG_NONE, &opt_char_cmd,
> +               "Characteristics Value Cmd", NULL },

Suggestion:  "Characteristic Value write using Write Command" (or
something similar).

>        { "char-desc", 0, 0, G_OPTION_ARG_NONE, &opt_char_desc,
>                "Characteristics Descriptor Discovery", NULL },
>        { "listen", 0, 0, G_OPTION_ARG_NONE, &opt_listen,
> @@ -561,7 +605,7 @@ int main(int argc, char *argv[])
>        GError *gerr = NULL;
>        GAttrib *attrib;
>        GIOChannel *chan;
> -       GSourceFunc callback;
> +       GSourceFunc callback = NULL;
>
>        context = g_option_context_new(NULL);
>        g_option_context_add_main_entries(context, options, NULL);
> @@ -602,9 +646,11 @@ int main(int argc, char *argv[])
>                callback = characteristics_read;
>        else if (opt_char_write)
>                callback = characteristics_write;
> +       else if (opt_char_cmd)
> +               callback = characteristics_cmd;
>        else if (opt_char_desc)
>                callback = characteristics_desc;
> -       else {
> +       else if (!opt_listen) {
>                gchar *help = g_option_context_get_help(context, TRUE, NULL);
>                g_print("%s\n", help);
>                g_free(help);
> @@ -625,7 +671,8 @@ int main(int argc, char *argv[])
>        if (opt_listen)
>                g_idle_add(listen_start, attrib);
>
> -       g_idle_add(callback, attrib);
> +       if (callback)
> +               g_idle_add(callback, attrib);
>
>        g_main_loop_run(event_loop);

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
