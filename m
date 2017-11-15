Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "ruslan.kuzmin@nami.ru" <ruslan.kuzmin@nami.ru>
To: "luiz.dents@gmail.com" <luiz.dents@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re : Re: How connect to bluez two headphones
Date: Wed, 15 Nov 2017 11:55:55 +0000
Message-ID: <1510746956433.43869@nami.ru>
Content-Type: text/plain; charset="koi8-r"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 нояб. 2017 г. в 07:36 Luiz Augusto von Dentz <luiz.dentz@gmail.com> написал(а):

	Hi Ruslan,

	On Mon, Nov 13, 2017 at 10:44 AM, Руслан Кузьмин
	<kuzminruslan@icloud.com> wrote:
	Excuse me for my English.I am developer.My task connect two Bluetooth headphones to one Bluetooth adapter.I know in Windows and in bluez4 this feature worked.In bluez5 in connection with pulseaudio created only one virtual A2DP speaker.
	Long time I am searched reason in pulseaudio (more precisely in pulseaudio sources) but how I knowed what dbus send from bluez to pulseaudio command ClearConfiguration when I am trying connect second headphone. I want to know where in sources of bluez5 limited count of working A2DP profiles.May I am write self hook for pulseaudio for two Bluetooth A2DP headphones?

	PulseAudio is currently registering only one source, you will probably
	need to introduce an option in default.pa in order to add more
	endpoints to connect multiple devices.

	-- 
	Luiz Augusto von Dentz
	--

In my default.pa i have only this lines bound with bluetooth :


### Automatically load driver modules for Bluetooth hardware
ifexists module-bluetooth-policy.so
load-module module-bluetooth-policy
endif

ifexists module-bluetooth-discover.so
load-module module-bluetooth-discover headset=ofono
endif
 

In file pulseaudio-11.0/src/modules/bluetooth/module-bluez5-policy.c list args:


PA_MODULE_USAGE(
"auto_switch=<Switch between hsp and a2dp profile? (0 - never, 1 - media.role=phone, 2 - heuristic> "
"a2dp_source=<Handle a2dp_source card profile (sink role)?> "
"ag=<Handle headset_audio_gateway card profile (headset role)?> "
"hfgw=<Handle hfgw card profile (headset role)?> DEPRECATED");


In file pulseaudio-11.0/src/modules/bluetooth/module-bluetooth-discover.c args:


PA_MODULE_USAGE(
"headset=ofono|native|auto (bluez 5 only)"
"autodetect_mtu=<boolean> (bluez 5 only)"
);

How with that args do more endpoints?
Excuse me for letter from another email - Server vger.kernel.org think what in letter HTML and adding letter in SPAM
Regards ,Ruslan.
