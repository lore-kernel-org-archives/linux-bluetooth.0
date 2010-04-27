Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <n2h2d5a2c101004270133xa4ea7dd5za238a58f9e67613@mail.gmail.com>
References: <t2m2c3916b71004261612i68ccba50h78c83ab3a02713cb@mail.gmail.com>
	 <g2l2d5a2c101004270020mb94d092cnef88b98b147beba0@mail.gmail.com>
	 <n2h2d5a2c101004270133xa4ea7dd5za238a58f9e67613@mail.gmail.com>
Date: Tue, 27 Apr 2010 14:51:58 +0300
Message-ID: <q2z2c3916b71004270451r957e5befp631d413d4f316afe@mail.gmail.com>
Subject: Re: obexd OPP pull problem
From: Daniel Abraham <daniel.shrugged@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Apr 27, 2010 at 11:33 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> This should fix at least the D-Bus error:
>
> http://gitorious.org/obexd/vudentzs-clone/commit/32e48446b6b8cd72e15988c673a60c7fb47b0862

Actually, that's not what I see. I'm using the "pull-business-card"
script (which doesn't use any try-except block), and it doesn't crash
with an exception, even though "dbus-monitor --session" shows the
error (below). Is it lost somehow before it reaches Python's D-Bus
caller object?

method call sender=:1.147 -> dest=:1.142 serial=4 path=/;
interface=org.openobex.Client; member=PullBusinessCard
   array [
      dict entry(
         string "Destination"
         variant             string "00:1C:26:FC:15:AF"
      )
   ]
   string "d.vcf"
method call sender=:1.142 -> dest=org.freedesktop.DBus serial=18
path=/org/freedesktop/DBus; interface=org.freedesktop.DBus;
member=AddMatch
   string "type='signal',interface='org.freedesktop.DBus',member='NameOwnerChanged',arg0=':1.147'"
method return sender=:1.142 -> dest=:1.147 reply_serial=4
error sender=:1.142 -> dest=:1.147
error_name=org.openobex.Error.Failed reply_serial=4
   string "Method not allowed"
method call sender=:1.142 -> dest=org.freedesktop.DBus serial=21
path=/org/freedesktop/DBus; interface=org.freedesktop.DBus;
member=RemoveMatch
   string "type='signal',interface='org.freedesktop.DBus',member='NameOwnerChanged',arg0=':1.147'"
signal sender=org.freedesktop.DBus -> dest=(null destination)
serial=10 path=/org/freedesktop/DBus; interface=org.freedesktop.DBus;
member=NameOwnerChanged
   string ":1.147"
   string ":1.147"
   string ""
