Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLJ2WWeOLwn8XPkYaRBA9dZ9zhgF5xuehChXXxcZt4TdA@mail.gmail.com>
References: <1449557617-3413-1-git-send-email-hychao@chromium.org>
	<CABBYNZK-0g8Q4u8UCEuPic7sxXYnT0yP7S0vn+643Pa24Kze_w@mail.gmail.com>
	<CANyK0SnnkH5xyhCCCGuZBySHA88517nijyb=3Q8M_6E5mCe6Kw@mail.gmail.com>
	<CANyK0Sm+Ard+-xoKopoYG-OSuSUxDVmA+DrpkiggMFBF9g94Vw@mail.gmail.com>
	<CABBYNZK8CTh2LAQvg+CDtwRFzaUsfCj+U9ODWP6BGDsgpOk7UQ@mail.gmail.com>
	<CABBYNZLJ2WWeOLwn8XPkYaRBA9dZ9zhgF5xuehChXXxcZt4TdA@mail.gmail.com>
Date: Thu, 24 Mar 2016 18:58:43 +0800
Message-ID: <CANyK0SkeUPLsS-XTZpiSSN8c6dh6-V44sJXFv2ZDi9Kk0dZ-Hw@mail.gmail.com>
Subject: Re: [PATCH] audio/a2dp - Fix unbalanced setup ref/unref
From: Hsin-yu Chao <hychao@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,
I suppose you mean the plugin/policy.c and yes we are using it. We got
reports about this crash from end user, however the crash rate is low
and not happening for me either. Since BT adapters are built-in for
almost all Chromebooks, I don't think the 'adapter removal' should
happen except cases that there's any problem in driver/FW.

I spent some time look at this backtrace and check code around the
path of a2dp_cancel() -> avdtp_abort().
The crash happens in a2dp_cancel() where the setup_unref() is called,
seems because of the a2dp_setup pointer is already freed. My first
guess is that code from avdtp_abort() somehow decreases the
a2dp_setup's refcount to zero.
Function avdtp_abort() could return cancel_request(session,
ECANCELED); if session->req is non-null. And depending on the
req->signal_id, corresponding callback function in a2dp.c(e.g
reconf_cfm) got called, and eventually called setup_cb_free() and
setup_unref() so that the associated a2dp_setup object got free'd.

However these calls to setup_cb_free() shouldn't be blamed, because
the refcount has always been increased earlier when each a2dp_setup_cb
is allocated. And that makes me guess there's unbalanced manipulation
of a2dp_setup's refcount elsewhere.

I checked other places where an a2dp_setup is ref/unref'ed, and there
are a few places I don't understand.
 - a2dp.c: transport_cb() has a setup_unref() call which decreases the
refcont of a2dp_setup. But it's not clear to me why this call is
needed.
 - a2dp.c: open_ind() has a2dp_setup_get() call which increases the
refcount of a2dp_setup, while this a2dp_setup pointer is not assigned
to new place.

Could you share with me any idea or hint?

Thanks!
Hsin-yu


On Wed, Mar 23, 2016 at 9:12 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Hsin-yu,
>
> On Wed, Mar 23, 2016 at 12:33 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Hsin-yu,
>>
>> On Wed, Mar 23, 2016 at 8:01 AM, Hsin-yu Chao <hychao@chromium.org> wrote:
>>> Hi Luiz,
>>> We're now observing below crash pretty often on Chrome OS, and I still
>>> couldn't figure out the root cause.
>>> The only clue I got is that this crash happens after your commit 33b447d
>>> "audio: Fix possible crash when removing device".
>>>
>>> Thread 0 CRASHED [SIGABRT @ 0x00000000 ] MAGIC SIGNATURE THREAD
>>> 0x00007f6c4b0c7b82 (libc-2.19.so -raise.c:56 ) raise
>>> 0x00007f6c4b0c989f (libc-2.19.so -abort.c:89 ) abort
>>> 0x00007f6c4b10d527 (libc-2.19.so -libc_fatal.c:175 ) __libc_message
>>> 0x00007f6c4b113e08 (libc-2.19.so -malloc.c:4991 ) malloc_printerr
>>> 0x00007f6c4b11461a (libc-2.19.so -malloc.c:3837 ) _int_free
>>> 0x00007f6c4ba9d2d5 (bluetoothd -a2dp.c:2150 ) a2dp_cancel
>>> 0x00007f6c4baa68ab (bluetoothd -transport.c:231 ) media_owner_remove
>>> 0x00007f6c4baa6f64 (bluetoothd -transport.c:244 )
>>> media_transport_remove_owner
>>> 0x00007f6c4baa73b0 (bluetoothd -transport.c:734 ) media_transport_free
>>> 0x00007f6c4bb0ddac (bluetoothd -object.c:658 ) remove_interface
>>> 0x00007f6c4bb0eb6c (bluetoothd -object.c:1382 ) g_dbus_unregister_interface
>>> 0x00007f6c4baa7620 (bluetoothd -transport.c:182 ) media_transport_destroy
>>> 0x00007f6c4baa436f (bluetoothd -media.c:246 ) clear_endpoint
>>> 0x00007f6c4baa46f1 (bluetoothd -media.c:468 ) release_endpoint
>>> 0x00007f6c4baa61ef (bluetoothd -media.c:1879 ) path_free
>>> 0x00007f6c4bb0ddac (bluetoothd -object.c:658 ) remove_interface
>>> 0x00007f6c4bb0eb6c (bluetoothd -object.c:1382 ) g_dbus_unregister_interface
>>> 0x00007f6c4b9b1ad4 (libglib-2.0.so.0.3400.3 -gslist.c:894 ) g_slist_foreach
>>> 0x00007f6c4bada802 (bluetoothd -adapter.c:4171 ) adapter_remove
>>> 0x00007f6c4bae88a3 (bluetoothd -adapter.c:7453 ) index_removed
>>> 0x00007f6c4bb12c6f (bluetoothd -queue.c:251 ) queue_foreach
>>> 0x00007f6c4bb14386 (bluetoothd -mgmt.c:280 ) can_read_data
>>> 0x00007f6c4bb20ff5 (bluetoothd -io-glib.c:170 ) watch_callback
>>> 0x00007f6c4b991c7e (libglib-2.0.so.0.3400.3 -gmain.c:2715 )
>>> g_main_context_dispatch
>>> 0x00007f6c4b992087 (libglib-2.0.so.0.3400.3 -gmain.c:3290 )
>>> g_main_context_iterate
>>> 0x00007f6c4b9924f9 (libglib-2.0.so.0.3400.3 -gmain.c:3484 ) g_main_loop_run
>>> 0x00007f6c4ba94f90 (bluetoothd -main.c:661 ) main
>>> 0x00007f6c4b0b2fb5 (libc-2.19.so -libc-start.c:292 ) __libc_start_main
>>> 0x00007f6c4ba95770 (bluetoothd + 0x00019770 )
>>> 0x00007ffdd7f667b7
>>>
>>> Could you share any idea or hint on this crash?
>>
>> Try with valgrind it usually give a much better picture what is going
>> on. If the patch you mention is related to the problem then you would
>> see:
>>
>> bluetoothd[31136]: profiles/audio/a2dp.c:a2dp_cancel() aborting setup 0x8856b10
>> bluetoothd[31136]: profiles/audio/a2dp.c:setup_unref() 0x8856b10: ref=0
>> bluetoothd[31136]: profiles/audio/a2dp.c:setup_free() 0x8856b10
>> bluetoothd[31136]: profiles/audio/avdtp.c:avdtp_unref() 0x884f9d0: ref=1
>> bluetoothd[31136]: src/service.c:change_state() 0x870fa80: device
>> 94:20:53:2E:08:CE profile a2dp-sink state changed: disconnecting ->
>> disconnected (0)
>> bluetoothd[31136]: profiles/audio/avdtp.c:avdtp_unref() 0x884f9d0: ref=0
>> bluetoothd[31136]: src/service.c:change_state() 0x8a4b3b0: device
>> 94:20:53:2E:08:CE profile Headset Voice gateway state changed:
>> connected -> disconnecting (0)
>> bluetoothd[31136]: src/service.c:change_state() 0x8a4b3b0: device
>> 94:20:53:2E:08:CE profile Headset Voice gateway state changed:
>> disconnecting -> disconnected (0)
>> bluetoothd[31136]: src/service.c:btd_service_unref() 0x8a4b3b0: ref=2
>> bluetoothd[31136]: profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP:
>> connected signaling channel to 94:20:53:2E:08:CE
>> bluetoothd[31136]: profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP
>> imtu=672, omtu=895
>> bluetoothd[31136]: profiles/audio/avdtp.c:session_cb()
>> bluetoothd[31136]: profiles/audio/avdtp.c:avdtp_parse_resp() DISCOVER
>> request succeeded
>> bluetoothd[31136]: profiles/audio/avdtp.c:avdtp_discover_resp() seid 5
>> type 1 media 0 in use 0
>> bluetoothd[31136]: profiles/audio/avdtp.c:avdtp_discover_resp() seid 3
>> type 1 media 0 in use 0
>> bluetoothd[31136]: profiles/audio/avdtp.c:avdtp_discover_resp() seid 2
>> type 1 media 0 in use 0
>> bluetoothd[31136]: profiles/audio/avdtp.c:avdtp_discover_resp() seid 1
>> type 1 media 0 in use 0
>> bluetoothd[31136]: profiles/audio/avdtp.c:session_cb()
>> bluetoothd[31136]: profiles/audio/avdtp.c:avdtp_parse_resp()
>> GET_CAPABILITIES request succeeded
>> bluetoothd[31136]:
>> profiles/audio/avdtp.c:avdtp_get_capabilities_resp() seid 5 type 1
>> media 0
>> bluetoothd[31136]: profiles/audio/avdtp.c:session_cb()
>> bluetoothd[31136]: profiles/audio/avdtp.c:avdtp_parse_resp()
>> GET_CAPABILITIES request succeeded
>> bluetoothd[31136]:
>> profiles/audio/avdtp.c:avdtp_get_capabilities_resp() seid 3 type 1
>> media 0
>> bluetoothd[31136]: profiles/audio/avdtp.c:session_cb()
>> bluetoothd[31136]: profiles/audio/avdtp.c:avdtp_parse_resp()
>> GET_CAPABILITIES request succeeded
>> bluetoothd[31136]:
>> profiles/audio/avdtp.c:avdtp_get_capabilities_resp() seid 2 type 1
>> media 0
>> bluetoothd[31136]: profiles/audio/avdtp.c:session_cb()
>> bluetoothd[31136]: profiles/audio/avdtp.c:avdtp_parse_resp()
>> GET_CAPABILITIES request succeeded
>> bluetoothd[31136]:
>> profiles/audio/avdtp.c:avdtp_get_capabilities_resp() seid 1 type 1
>> media 0
>> bluetoothd[31136]: profiles/audio/avdtp.c:connection_lost()
>> Disconnected from 94:20:53:2E:08:CE
>>
>> It is not completely correct because it seems we are not able to
>> cancel the connection request itself, but it doesn't crash for me.
>
> Ive sent a patch-set regarding this, it should fix a couple of problem
> that may or may not be related to your crash. Btw, are you guys using
> our the connection policy plugin in chrome OS? That seems to have some
> problem when the adapter disappear while connecting.
>
> --
> Luiz Augusto von Dentz
