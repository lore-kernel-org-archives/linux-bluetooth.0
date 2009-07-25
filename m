Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4A6A59F6.5000102@autonetmobile.com>
References: <1248254976-12090-1-git-send-email-gustavo@las.ic.unicamp.br>
	 <1248254976-12090-2-git-send-email-gustavo@las.ic.unicamp.br>
	 <1248256296.28545.124.camel@violet>
	 <4A6A59F6.5000102@autonetmobile.com>
Date: Sat, 25 Jul 2009 07:27:46 -0300
Message-ID: <2d5a2c100907250327i4430ecc6qcfd668168192cfcb@mail.gmail.com>
Subject: Re: "org.bluez.Adapter" doesn't exist
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Doug Moeller <dmoeller@autonetmobile.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jul 24, 2009 at 10:03 PM, Doug
Moeller<dmoeller@autonetmobile.com> wrote:
> # dbus-send --system --type=method_call --print-reply --dest=org.bluez
> /org/bluez/hci0 org.bluez.Adapter.GetMode
> Error org.freedesktop.DBus.Error.UnknownMethod: Method "GetMode" with
> signature "" on interface "org.bluez.Adapter" doesn't exist
>
>
> Bluetoothd output
>
>
> # bluetoothd -dn
> bluetoothd[18625]: Bluetooth daemon 4.38

There is no GetMode on Adapter interface, I suggest you to read the
documentation under doc/ directory, there is also some python scripts
which are useful for testing under tests/ directory. Another problem
is that you are using  hardcoded path /org/bluez/hci0, this won't work
anymore.

ps: The directories are relative to BlueZ repository:
git://git.kernel.org/pub/scm/bluetooth/bluez.git
ps2: http://git.kernel.org/?p=bluetooth/bluez.git;a=blob;f=doc/adapter-api.txt;h=1e03b4e2785e33d37c9579238e6a49ac719047de;hb=HEAD

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
