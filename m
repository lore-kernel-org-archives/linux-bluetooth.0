Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 03 Sep 2009 16:38:30 +0200
From: "Peter Kornatowski" <pkorn@gmx.net>
In-Reply-To: <7.0.1.0.2.20090903112603.0220ed58@gmx.net>
Message-ID: <20090903143830.68220@gmx.net>
MIME-Version: 1.0
References: <7.0.1.0.2.20090903112603.0220ed58@gmx.net>
Subject: Re: error in setting speakergain in own application
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

-------- Original-Nachricht --------
> Datum: Thu, 03 Sep 2009 11:26:47 +0200
> Von: Peter Kornatowski <pkorn@gmx.net>
> An: pkorn@gmx.net
> Betreff: Re: error in setting speakergain in own application

> Subject: Re: error in setting speakergain in own application
> From:	Bastien Nocera <hadess@hadess.net>
> To:	Peter Kornatowski <pkorn@gmx.net>
> Cc:	linux-bluetooth@vger.kernel.org
> 
> On Wed, 2009-09-02 at 20:11 +0200, Peter Kornatowski wrote:
>  > -------- Original-Nachricht --------
>  > > Datum: Wed, 02 Sep 2009 15:37:59 +0100
>  > > Von: Bastien Nocera <hadess@hadess.net>
>   ...snip...
>  >
>  > So the value is not set to the proper type, it still remains "u".
>  > Do you have any other ideas?
> 
> Never mind, I didn't read your code properly.
> 
> The original code should work, given that the proxy used is the correct
> one. Check what path the proxy object has using dbus_g_proxy_get_path()
> and check against what you see in D-Feet (repeat with the name and
> interface if you didn't find a discrepancy).

I checked it all, but because all signals work fine an error here was very unlikely. And it is all exactly the same like in d-feet: 
path:  /org/bluez/2516/hci0/dev_00_1D_82_XX_XX_XX
bus:   org.bluez
iface: org.bluez.Headset

But still getting this "Invalid arguments in method call" error... any other thoughts?

Greetings, Peter

> 
> Cheers
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Jetzt kostenlos herunterladen: Internet Explorer 8 und Mozilla Firefox 3 -
sicherer, schneller und einfacher! http://portal.gmx.net/de/go/chbrowser
