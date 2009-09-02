Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 02 Sep 2009 20:11:54 +0200
From: "Peter Kornatowski" <pkorn@gmx.net>
In-Reply-To: <1251902279.3326.1413.camel@localhost.localdomain>
Message-ID: <20090902181154.125080@gmx.net>
MIME-Version: 1.0
References: <20090902115213.61720@gmx.net>
 <1251902279.3326.1413.camel@localhost.localdomain>
Subject: Re: error in setting speakergain in own application
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

-------- Original-Nachricht --------
> Datum: Wed, 02 Sep 2009 15:37:59 +0100
> Von: Bastien Nocera <hadess@hadess.net>
> An: Peter Kornatowski <pkorn@gmx.net>
> CC: linux-bluetooth@vger.kernel.org
> Betreff: Re: error in setting speakergain in own application

> On Wed, 2009-09-02 at 13:52 +0200, Peter Kornatowski wrote:
> > Hi,
> > 
> > I have a linux application where i do some stuff with bluez (4.50) over
> dbus. I have 3 headsets with which I test (Jabra BT530, Sora B-Speech,
> official PS3-BT headset) and on all I get the same behaviour/error.
> > 
> > I would like to set the speakergain of a headset from my linux-app. I
> tried two methods:
> > 
> > a) call the method "SetProperty":
> > 
> > GValue value;
> > value.g_type = 0; // also tried: value = { 0 };
> > guint16 ugain = (guint16)gain; // also tried: guint ugain = (guint)gain;
> > g_value_init(&value, G_TYPE_UINT);
> > g_value_set_uint(&value, ugain);
> > dbus_g_proxy_call(proxy, "SetProperty", &error, G_TYPE_STRING,
> >   "SpeakerGain", G_TYPE_VALUE, &value, G_TYPE_INVALID, G_TYPE_INVALID);
> 
> This would work (and you don't need to use a GValue, the call will take
> care of marshalling the value to the proper type:
> dbus_g_proxy_call(proxy, "SetProperty", &error, G_TYPE_STRING,
>   "SpeakerGain", G_TYPE_UINT, ugain, G_TYPE_INVALID, G_TYPE_INVALID);

Thanks for the idea, but now I get the following error:
Method "SetProperty" with signature "su" on interface "org.bluez.Headset" doesn't exist

So the value is not set to the proper type, it still remains "u".
Do you have any other ideas?

Greetings, Peter

> 
> > g_value_unset(&value);
> 
> Cheers
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Neu: GMX Doppel-FLAT mit Internet-Flatrate + Telefon-Flatrate
für nur 19,99 Euro/mtl.!* http://portal.gmx.net/de/go/dsl02
