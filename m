Return-Path: <cyrus@holtmann.org>
Message-ID: <1355786586.1815.43.camel@aeonflux>
Subject: Re: [PATCH BlueZ] test: Update simple-agent to new API
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 18 Dec 2012 00:23:06 +0100
In-Reply-To: <1355784500-28062-1-git-send-email-jprvita@openbossa.org>
References: <1355784500-28062-1-git-send-email-jprvita@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joao Paulo,

> The method org.bluez.Device.Pair() doesn't have arguments anymore. This
> commit fixes the following error:
> 
>   $ test/simple-agent hci0 4C:B1:99:F1:BC:E9
>   Agent registered
>   ERROR:dbus.connection:Unable to set arguments (u'/test/agent', u'Keybo
>   ardDisplay') according to signature '': <type 'exceptions.TypeError'>:
>    Fewer items found in D-Bus signature than in Python arguments
>   Traceback (most recent call last):
>     File "/usr/lib/python2.7/site-packages/dbus/connection.py", line 586
>   , in msg_reply_handler
>       reply_handler(*message.get_args_list(**get_args_opts))
>     File "/usr/lib/python2.7/site-packages/dbus/proxies.py", line 391, i
>   n _introspect_reply_handler
>       self._introspect_execute_queue()
>     File "/usr/lib/python2.7/site-packages/dbus/proxies.py", line 378, i
>   n _introspect_execute_queue
>       proxy_method(*args, **keywords)
>     File "/usr/lib/python2.7/site-packages/dbus/proxies.py", line 132, i
>   n __call__
>       **keywords)
>     File "/usr/lib/python2.7/site-packages/dbus/connection.py", line 566
>   , in call_async
>       message.append(signature=signature, *args)
>   TypeError: Fewer items found in D-Bus signature than in Python argumen
>   ts
> ---
>  test/simple-agent | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

patch has been applied.

Regards

Marcel


