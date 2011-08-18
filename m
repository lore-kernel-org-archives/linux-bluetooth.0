Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1313502238-7581-2-git-send-email-prasadbhat22@gmail.com>
References: <1313502238-7581-1-git-send-email-prasadbhat22@gmail.com>
	<1313502238-7581-2-git-send-email-prasadbhat22@gmail.com>
Date: Thu, 18 Aug 2011 10:14:49 +0300
Message-ID: <CABBYNZKDWGCVwiwAjF=+-7Q7x9JUO+XxXbqgFRhPWMt3Q7H8Xw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/6] Implementation of video-sink for VDP
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Prasad Bhat <prasadbhat22@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Aug 16, 2011 at 4:43 PM, Prasad Bhat <prasadbhat22@gmail.com> wrote:
> +static GDBusMethodTable sink_methods[] = {
> +       { "Connect",            "",     "",     sink_connect,
> +                                               G_DBUS_METHOD_FLAG_ASYNC },
> +       { "Disconnect",         "",     "",     sink_disconnect,
> +                                               G_DBUS_METHOD_FLAG_ASYNC },
> +       { "IsConnected",        "",     "b",    sink_is_connected,
> +                                               G_DBUS_METHOD_FLAG_DEPRECATED },

I guess we won't need a deprecated method here.

> +       { "GetProperties",      "",     "a{sv}",sink_get_properties },
> +       { NULL, NULL, NULL, NULL }
> +};
> +
> +static GDBusSignalTable sink_signals[] = {
> +       { "Connected",                  "",     G_DBUS_SIGNAL_FLAG_DEPRECATED },
> +       { "Disconnected",               "",     G_DBUS_SIGNAL_FLAG_DEPRECATED },
> +       { "Playing",                    "",     G_DBUS_SIGNAL_FLAG_DEPRECATED },
> +       { "Stopped",                    "",     G_DBUS_SIGNAL_FLAG_DEPRECATED },

And here too. Please remember to remove in other parts of the code too.

> +       { "PropertyChanged",            "sv"    },
> +       { NULL, NULL }
> +};
> +

-- 
Luiz Augusto von Dentz
