Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: 5.40 --> 5.41 BLE regression for me
From: Travis Griggs <travisgriggs@gmail.com>
In-Reply-To: <726D281F-7FFA-490E-A02D-77E71E01DE15@gmail.com>
Date: Wed, 27 Jul 2016 15:32:01 -0700
Message-Id: <328F498E-7874-44C8-ADB3-681377082429@gmail.com>
References: <726D281F-7FFA-490E-A02D-77E71E01DE15@gmail.com>
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> On Jul 27, 2016, at 12:07 PM, Travis Griggs <travisgriggs@gmail.com> wrote:
> 
> This is surely my own fault. But my understanding of dbus is quaint enough that I don’t get what the problem is. I use a python3 variant/evolution of the example-advertisement and example-gatt-server to make my Linux SBC a BLE peripheral. Upgrading my bluez libraries from 5.40 to 5.41, I’m suddenly getting an error that I wasn’t seeing before:
> 
> ERROR:dbus.connection:Unable to set arguments (dbus.ObjectPath('/'), {}) according to signature None: <class 'ValueError'>: Unable to guess signature from an empty dict
> Traceback (most recent call last):
>  File "/usr/lib/python3/dist-packages/dbus/connection.py", line 604, in msg_reply_handler
>    reply_handler(*message.get_args_list(**get_args_opts))
>  File "/usr/lib/python3/dist-packages/dbus/proxies.py", line 401, in _introspect_reply_handler
>    self._introspect_execute_queue()
>  File "/usr/lib/python3/dist-packages/dbus/proxies.py", line 387, in _introspect_execute_queue
>    proxy_method(*args, **keywords)
>  File "/usr/lib/python3/dist-packages/dbus/proxies.py", line 137, in __call__
>    **keywords)
>  File "/usr/lib/python3/dist-packages/dbus/connection.py", line 584, in call_async
>    message.append(signature=signature, *args)
> ValueError: Unable to guess signature from an empty dict
> ERROR:dbus.connection:Unable to set arguments (dbus.ObjectPath('/nelson_irrigation/twig_pilot'), {}) according to signature None: <class 'ValueError'>: Unable to guess signature from an empty dict
> Traceback (most recent call last):
>  File "/usr/lib/python3/dist-packages/dbus/connection.py", line 604, in msg_reply_handler
>    reply_handler(*message.get_args_list(**get_args_opts))
>  File "/usr/lib/python3/dist-packages/dbus/proxies.py", line 401, in _introspect_reply_handler
>    self._introspect_execute_queue()
>  File "/usr/lib/python3/dist-packages/dbus/proxies.py", line 387, in _introspect_execute_queue
>    proxy_method(*args, **keywords)
>  File "/usr/lib/python3/dist-packages/dbus/proxies.py", line 137, in __call__
>    **keywords)
>  File "/usr/lib/python3/dist-packages/dbus/connection.py", line 584, in call_async
>    message.append(signature=signature, *args)
> ValueError: Unable to guess signature from an empty dict
> 
> One of the errors (the second) goes away if I just try to bring up advertising (no application/services defined).
> 
> The only thing I can see that I am doing significantly different from the original examples, is that I derive my PATH_BASE as ‘/nelson_irrigation/twig_pilot’ rather than '/org/bluez/example/service’. I notice that the PATH_BASE value is showing up in there. Does this PATH_BASE matter more than it used to (it was basically arbitrary before)? If so, what do I need to change to make it work again?

Argh. Ignore this.

I build debian packages with the latest and install those. The default bluetooth.service has to be tweaked to include the ‘-E’ option.

Did I see that 5.42 may see the -Experimental interface turned on by default? That would be cool… since 42 IS the answer.