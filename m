Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1446127830.4709.16.camel@cortland.com>
References: <1446127830.4709.16.camel@cortland.com>
Date: Thu, 29 Oct 2015 20:48:45 +0200
Message-ID: <CABBYNZKDMNG26tv8xUOsL=VY6CWBkFJp09N_NsUoG2qTWP7HoA@mail.gmail.com>
Subject: Re: Cannot connect to hfp headset
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Steve Brown <sbrown@cortland.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

On Thu, Oct 29, 2015 at 4:10 PM, Steve Brown <sbrown@cortland.com> wrote:
> Reverting "[PATCH] core/service: Fix calling driver .accept multiple
> times" (4522ac85dd6dc1db4d49507330b4abc3bbaf4e6c) restores connecting.
>
> Below is a log of the connection failure. I added a few more DBG's.
>
> Steve
>
> Oct 29 09:58:09 w7 bluetoothd[13126]: src/device.c:connect_profiles() /org/bluez/hci0/dev_F4_73_CA_00_38_EB (all), client :1.134
> Oct 29 09:58:09 w7 bluetoothd[13126]: src/service.c:btd_service_ref() 0xad10b0: ref=2
> Oct 29 09:58:09 w7 bluetoothd[13126]: src/service.c:change_state() 0xad10b0: device F4:73:CA:00:38:EB profile Headset Voice gateway state changed: disconnected -> connecting (0)
> Oct 29 09:58:12 w7 bluetoothd[13126]: src/adapter.c:connected_callback() hci0 device F4:73:CA:00:38:EB connected eir_len 15
> Oct 29 09:58:12 w7 pulseaudio[11787]: [pulseaudio] bluez5-util.c: Properties changed in device /org/bluez/hci0/dev_F4_73_CA_00_38_EB
> Oct 29 09:58:12 w7 bluetoothd[13126]: src/profile.c:connect_io()
> Oct 29 09:58:13 w7 bluetoothd[13126]: src/profile.c:ext_connect()
> Oct 29 09:58:13 w7 bluetoothd[13126]: src/profile.c:ext_connect() Headset Voice gateway connected to F4:73:CA:00:38:EB
> Oct 29 09:58:13 w7 bluetoothd[13126]: src/service.c:service_accept() service->state:connecting
> Oct 29 09:58:13 w7 bluetoothd[13126]: src/profile.c:ext_connect() conn->service:0x0xad10b0 service_accept:-114
> Oct 29 09:58:13 w7 bluetoothd[13126]: src/service.c:service_accept() service->state:connecting

Looks like there are multiple calls to service_accept which will now
fail since the service is already connecting, I will take a look how
to fix it tomorrow.

> Oct 29 09:58:13 w7 bluetoothd[13126]: src/service.c:btd_service_connecting_complete()
> Oct 29 09:58:13 w7 bluetoothd[13126]: src/service.c:change_state() 0xad10b0: device F4:73:CA:00:38:EB profile Headset Voice gateway state changed: connecting -> disconnected (-5)
> Oct 29 09:58:13 w7 bluetoothd[13126]: src/device.c:device_profile_connected() Headset Voice gateway Input/output error (5)
> Oct 29 09:58:13 w7 bluetoothd[13126]: src/device.c:device_profile_connected() returning response to :1.134
> Oct 29 09:58:13 w7 bluetoothd[13126]: src/service.c:btd_service_unref() 0xad10b0: ref=1
> Oct 29 09:58:17 w7 bluetoothd[13126]: src/adapter.c:dev_disconnected() Device F4:73:CA:00:38:EB disconnected, reason 3
> Oct 29 09:58:17 w7 bluetoothd[13126]: src/adapter.c:adapter_remove_connection()
> Oct 29 09:58:17 w7 bluetoothd[13126]: plugins/policy.c:disconnect_cb() reason 3
> Oct 29 09:58:17 w7 bluetoothd[13126]: src/adapter.c:bonding_attempt_complete() hci0 bdaddr F4:73:CA:00:38:EB type 0 status 0xe
> Oct 29 09:58:17 w7 bluetoothd[13126]: src/device.c:device_bonding_complete() bonding (nil) status 0x0e
> Oct 29 09:58:17 w7 bluetoothd[13126]: src/device.c:device_bonding_failed() status 14
> Oct 29 09:58:17 w7 bluetoothd[13126]: src/adapter.c:resume_discovery()
> Oct 29 09:58:17 w7 pulseaudio[11787]: [pulseaudio] bluez5-util.c: Properties changed in device /org/bluez/hci0/dev_F4_73_CA_00_38_EB
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
