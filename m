Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <201003251545.52988.jcaden@libresoft.es>
References: <201003251545.52988.jcaden@libresoft.es>
Date: Thu, 25 Mar 2010 17:22:27 +0200
Message-ID: <2d5a2c101003250822g34187992m8509e17e825f50c8@mail.gmail.com>
Subject: Re: Problems with bt_io_listen
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: jcaden@libresoft.es
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Mar 25, 2010 at 4:45 PM, José Antonio Santos Cadenas
<jcaden@libresoft.es> wrote:
> Hi all,
>
> We are developing an implementation of HDP and MCAP for bluez. We are triying
> to perform many connections between two devices but when we make the second
> connection it is not created correctly.
>
> We are using a defer connection (we passed a confirm callback to the
> bt_io_listen function) and we think that we are missing something but  we
> can't find what. If we used the connection callback (not defer) all the
> connections are done successfully.
>
> We are listening with the following code:
>
> static void confirm_cb(GIOChannel *chan, gpointer user_data)
> {
>        ...
>        node->chan = g_io_channel_ref(chan);
>        ...
>        /* All is ok */
>        return;
> drop:
>        /* Connection refused */
>        g_io_channel_shutdown(chan, TRUE, NULL);
> }

Im not really sure what is the problem but maybe it is the missing
bt_io_accept, but of course it can be that you just hide it in those
...

> ....
> chan = bt_io_listen(BT_IO_L2CAP, NULL, confirm_cb, NULL,
>                                NULL, &gerr,
>                                BT_IO_OPT_SOURCE_BDADDR, &src,
>                                BT_IO_OPT_PSM, 0x1001,
>                                BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
>                                BT_IO_OPT_INVALID);
> ...

The listen part at least seems ok.


-- 
Luiz Augusto von Dentz
Computer Engineer
