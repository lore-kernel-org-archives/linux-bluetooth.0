Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <d89ddf300904282055t51ad4fa9nfebbdac7b9f686b@mail.gmail.com>
References: <d89ddf300904282055t51ad4fa9nfebbdac7b9f686b@mail.gmail.com>
Date: Tue, 28 Apr 2009 23:02:57 -0600
Message-ID: <d89ddf300904282202p689398e1l3fced664a009f3a8@mail.gmail.com>
Subject: Re: discoverable vs. jaunty
From: Brad Midgley <bmidgley@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

> headless:~# dbus-send --system --type=method_call --print-reply
> --dest=org.bluez /org/bluez/hci0 org.bluez.Adapter.SetMode
> string:discoverable
> Error org.freedesktop.DBus.Error.UnknownMethod: Method "SetMode" with
> signature "s" on interface "org.bluez.Adapter" doesn't exist

I see from some digging that this API was changed.

I'm finding the best source of info on this is test/ under the version
of the source matching my bluez version. The test-adapter script there
has perfectly working python example for changing discovery settings.

-- 
Brad Midgley
