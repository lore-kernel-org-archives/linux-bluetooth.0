Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <h2s2c3916b71004261637le0d83946y724f6ddb538c093@mail.gmail.com>
References: <r2h2c3916b71004260229p48a39235m917ee7ebb0006efe@mail.gmail.com>
	 <x2z2c3916b71004260339j3cd86068g3b4adf5cd523c450@mail.gmail.com>
	 <g2s2d5a2c101004261124lcd36410dhbfe959945f0aa5a9@mail.gmail.com>
	 <h2s2c3916b71004261637le0d83946y724f6ddb538c093@mail.gmail.com>
Date: Tue, 27 Apr 2010 10:10:50 +0300
Message-ID: <o2w2d5a2c101004270010gf01c8228ve01bbbcb3e58fa67@mail.gmail.com>
Subject: Re: no client session close in obexd 0.23?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Daniel Abraham <daniel.shrugged@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Apr 27, 2010 at 2:37 AM, Daniel Abraham
<daniel.shrugged@gmail.com> wrote:
> Thanks!
>
> Followup question - I'm trying to use it, but it throws this exception:
> dbus.exceptions.DBusException: org.openobex.Error.InvalidArguments:
>
> What am I doing wrong? What is the right input?
>
> Here's a sample Python script:
>
> ---
>
> #!/usr/bin/env python
>
> import dbus
>
> bus = dbus.SessionBus()
> proxy = bus.get_object('org.openobex.client', '/')
> client = dbus.Interface(proxy, 'org.openobex.Client')
>
> address = '00:1C:26:FC:15:AF'
>
> print('Opening FTP session')
> path = client.CreateSession({'Target': 'ftp', 'Destination': address})
> print(path)
> client.RemoveSession(path)
> print('FTP session closed')
>
> ---
>
> Output:
>
> Opening FTP session
> /org/openobex/session0
> Traceback (most recent call last):
>  File "./test-ftp.py", line 14, in <module>
>    client.RemoveSession(path)
>  File "/usr/lib/python2.6/site-packages/dbus/proxies.py", line 140, in __call__
>    **keywords)
>  File "/usr/lib/python2.6/site-packages/dbus/connection.py", line
> 630, in call_blocking
>    message, timeout)
> dbus.exceptions.DBusException: org.openobex.Error.InvalidArguments:
>

It's a bug, could you please try this:

http://gitorious.org/~vudentz/obexd/vudentzs-clone/commit/fd4e8e2cef72542fb5bc924817f4b409415b3b54

I guess that should fix the problem.


-- 
Luiz Augusto von Dentz
Computer Engineer
