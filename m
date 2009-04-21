Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6edf6b480904201827n5049a614se097643adeba9932@mail.gmail.com>
References: <6edf6b480904201827n5049a614se097643adeba9932@mail.gmail.com>
Date: Mon, 20 Apr 2009 23:50:26 -0300
Message-ID: <2d5a2c100904201950s3d8b2b84p2ddb4e89ac5bfe50@mail.gmail.com>
Subject: Re: dbus of c program for adapter get/set properties
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: yesir yao <yesiryao@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On Mon, Apr 20, 2009 at 10:27 PM, yesir yao <yesiryao@gmail.com> wrote:
> hi, all:
>
> I need to use dbus api to control my bluetooth adapter in my C program.
> After I had read doc/adapter-api.txt and writed the codes, It can't work

The answer is very simple, you are using fixed/hardcoded object path
(/org/bluez/hci0) that is causing the problem. We made sure it won't
work by adding the pid to the path so no one will have a change to
hardcode an adapter path and the code still work after bluetoothd has
restarted, the correct way of doing this is via '/' path (the only
fixed path bluetoothd has) which implements org.bluez.Manager (see
doc/manager-api.txt).

About the G_DBUS_METHOD_FLAG_ASYNC are really not for clients,
although they hint the behavior of the daemon the client should know
better whether to block or not.

ps: check this http://smcv.pseudorandom.co.uk/2008/11/nonblocking/


-- 
Luiz Augusto von Dentz
Engenheiro de Computação
