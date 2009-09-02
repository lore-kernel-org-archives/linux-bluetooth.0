Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 02 Sep 2009 13:52:13 +0200
From: "Peter Kornatowski" <pkorn@gmx.net>
Message-ID: <20090902115213.61720@gmx.net>
MIME-Version: 1.0
Subject: error in setting speakergain in own application
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have a linux application where i do some stuff with bluez (4.50) over dbus. I have 3 headsets with which I test (Jabra BT530, Sora B-Speech, official PS3-BT headset) and on all I get the same behaviour/error.

I would like to set the speakergain of a headset from my linux-app. I tried two methods:

a) call the method "SetProperty":

GValue value;
value.g_type = 0; // also tried: value = { 0 };
guint16 ugain = (guint16)gain; // also tried: guint ugain = (guint)gain;
g_value_init(&value, G_TYPE_UINT);
g_value_set_uint(&value, ugain);
dbus_g_proxy_call(proxy, "SetProperty", &error, G_TYPE_STRING,
  "SpeakerGain", G_TYPE_VALUE, &value, G_TYPE_INVALID, G_TYPE_INVALID);
g_value_unset(&value);

>From error->message I always get: Invalid arguments in method call
I get the same error when trying to set it through d-feet (but probably because d-feet can't set a value type?).


b) call the method "SetSpeakerGain" (it is deprecated, but the deprecated signal "SpeakerGainChanged" still works, too):

guint16 ugain = (guint16)gain; // also tried: guint ugain = (guint)gain;
dbus_g_proxy_call(proxy, "SetSpeakerGain", &err, G_TYPE_UINT, ugain, G_TYPE_INVALID, G_TYPE_INVALID);

>From error->message I always get: Method "SetSpeakerGain" with signature "u" on interface "org.bluez.Headset" doesn't exist
Calling this method with d-feet works fine, the new value is transferred to the headset.


Does anyone have any idea how this could work? Thanks!


Greetings,
Peter
-- 
GRATIS für alle GMX-Mitglieder: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://portal.gmx.net/de/go/maxdome01
