Return-Path: <cyrus@holtmann.org>
Subject: Re: error in setting speakergain in own application
From: Bastien Nocera <hadess@hadess.net>
To: Peter Kornatowski <pkorn@gmx.net>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20090902115213.61720@gmx.net>
References: <20090902115213.61720@gmx.net>
Content-Type: text/plain
Date: Wed, 02 Sep 2009 15:37:59 +0100
Message-Id: <1251902279.3326.1413.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2009-09-02 at 13:52 +0200, Peter Kornatowski wrote:
> Hi,
> 
> I have a linux application where i do some stuff with bluez (4.50) over dbus. I have 3 headsets with which I test (Jabra BT530, Sora B-Speech, official PS3-BT headset) and on all I get the same behaviour/error.
> 
> I would like to set the speakergain of a headset from my linux-app. I tried two methods:
> 
> a) call the method "SetProperty":
> 
> GValue value;
> value.g_type = 0; // also tried: value = { 0 };
> guint16 ugain = (guint16)gain; // also tried: guint ugain = (guint)gain;
> g_value_init(&value, G_TYPE_UINT);
> g_value_set_uint(&value, ugain);
> dbus_g_proxy_call(proxy, "SetProperty", &error, G_TYPE_STRING,
>   "SpeakerGain", G_TYPE_VALUE, &value, G_TYPE_INVALID, G_TYPE_INVALID);

This would work (and you don't need to use a GValue, the call will take
care of marshalling the value to the proper type:
dbus_g_proxy_call(proxy, "SetProperty", &error, G_TYPE_STRING,
  "SpeakerGain", G_TYPE_UINT, ugain, G_TYPE_INVALID, G_TYPE_INVALID);

> g_value_unset(&value);

Cheers

