Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "ruslan.kuzmin@nami.ru" <ruslan.kuzmin@nami.ru>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "luiz.dents@gmail.com" <luiz.dents@gmail.com>
Subject: How connect two headphones to one Bluetooth adapter.
Date: Wed, 29 Nov 2017 15:36:00 +0000
Message-ID: <1511969761135.29141@nami.ru>
Content-Type: text/plain; charset="koi8-r"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz.
I am not registred in email-list because from that email to me from vger.kernel.org recieve error, but from my iphone email vger.kernel.org think i  am send HTML message - and add me a SPAM.
If you may send your email to that email direct please.

 Excuse me ,in last message i am did bad titile . My problem not "How connect two headphones to Bluetooth" , my problem How connect two headphones to ONE Bluetooth adapter.    
 I am conducted a study source codes of Bluez. What  i  am understand.


>From file  bluez-5.46/profiles/audio/avdtp.c :
	if (lsep->info.inuse)
		return NULL;

How i am undestand count of endpoints for one Bluez adapter depend from count calling D-bus functions "RegisterEndpoint".



>From file pulseaudio-11.0/src/modules/bluetooth/bluez-util5.c :
 if (pa_streq(interface, BLUEZ_ADAPTER_INTERFACE)) {
            pa_bluetooth_adapter *a;
            if ((a = pa_hashmap_get(y->adapters, path))) {
                pa_log_error("Found duplicated D-Bus path for adapter %s", path);
                return;
            } else
            a = adapter_create(y, path);
            pa_log_debug("Adapter %s found", path);
            parse_adapter_properties(a, &iface_i, false);
            if (!a->valid)
                return;
            register_endpoint(y, path, A2DP_SOURCE_ENDPOINT, PA_BLUETOOTH_UUID_A2DP_SOURCE);
            register_endpoint(y, path, A2DP_SINK_ENDPOINT, PA_BLUETOOTH_UUID_A2DP_SINK);

How i am undestand in pulseaudio for one adapter - only two endponts - one sink and one source 


>From ADVANCED AUDIO DISTRIBUTION PROFILE SPECIFICATION  (2015-07-14):
  - The profile does not support a synchronized point-to-multipoint distribution



>From https://www.bluetooth.com/specifications:

Bluetooth BR/EDR enables continuous wireless connections and uses a point-to-point (P2P) network topology to establish one-to-one (1:1) device communications. 




My questions:
1)  Am I right with my conclusions?
2)  Bluez is it suitable for connecting two headphones to one adapter? - how i am seen : yes (queue for server sources and sinks)
3)  Pulseaudio is it suitable for connecting two headphones to one adapter? - how i am seen : not (only two D-bus calls RegisterEndpoint - for sink and for source)
4)  Why two headphones with one Bluetoth adapter working on Windows XP? ( https://www.youtube.com/watch?v=yOxg23jXSio&t=5s)

Best regards,Ruslan.


