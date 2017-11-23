Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1511442764.16347.71.camel@hadess.net>
References: <20171122135038.17555-1-hadess@hadess.net> <CABBYNZK8u+N9HJfSZw26VVqXLGMM_tBHQavz7rrQkR52KOy3Bw@mail.gmail.com>
 <CABBYNZK+cizf-dBCiHPaPLsTFxmZgDA_FUovwL9weEOPGfF_Ng@mail.gmail.com> <1511442764.16347.71.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 23 Nov 2017 15:14:57 +0200
Message-ID: <CABBYNZ+VO-5wbR7gaxRkO56v9odbcgHGW3L3_y1Z13Caii0Efg@mail.gmail.com>
Subject: Re: [PATCH] audio/control: Fix invalid read on exit
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Thu, Nov 23, 2017 at 3:12 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Thu, 2017-11-23 at 14:51 +0200, Luiz Augusto von Dentz wrote:
>> Hi Bastien,
>>
>> On Thu, Nov 23, 2017 at 12:23 PM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>> > Hi Bastien,
>> >
>> > On Wed, Nov 22, 2017 at 3:50 PM, Bastien Nocera <hadess@hadess.net>
>> > wrote:
>> > > Make control_disconnect() a no-op if control was already
>> > > disconnected and freed.
>> > >
>> > > bluetoothd[8436]: profiles/audio/avrcp.c:avrcp_disconnect() path
>> > > /org/bluez/hci0/dev_38_71_DE_C0_FC_26
>> > > ==8436== Invalid read of size 8
>> > > ==8436==    at 0x41FFB9: control_disconnect (control.c:130)
>> > > ==8436==    by 0x469E0A: service_remove (service.c:177)
>> > > ==8436==    by 0x475869: device_remove (device.c:4071)
>> > > ==8436==    by 0x45DEF9: adapter_remove (adapter.c:5485)
>> > > ==8436==    by 0x466B2A: adapter_cleanup (adapter.c:8679)
>> > > ==8436==    by 0x40BE16: main (main.c:782)
>> > > ==8436==  Address 0x84b8ac8 is 8 bytes inside a block of size 48
>> > > free'd
>> > > ==8436==    at 0x4C30D18: free (vg_replace_malloc.c:530)
>> > > ==8436==    by 0x50D44AD: g_free (in /usr/lib64/libglib-
>> > > 2.0.so.0.5400.2)
>> > > ==8436==    by 0x488AED: remove_interface (object.c:667)
>> > > ==8436==    by 0x488FE9: g_dbus_unregister_interface
>> > > (object.c:1391)
>> > > ==8436==    by 0x469E20: service_remove (service.c:179)
>> > > ==8436==    by 0x475869: device_remove (device.c:4071)
>> > > ==8436==    by 0x45DEF9: adapter_remove (adapter.c:5485)
>> > > ==8436==    by 0x466B2A: adapter_cleanup (adapter.c:8679)
>> > > ==8436==    by 0x40BE16: main (main.c:782)
>> > > ==8436==  Block was alloc'd at
>> > > ==8436==    at 0x4C31A1E: calloc (vg_replace_malloc.c:711)
>> > > ==8436==    by 0x50D43F0: g_malloc0 (in /usr/lib64/libglib-
>> > > 2.0.so.0.5400.2)
>> > > ==8436==    by 0x41FC09: control_init (control.c:320)
>> > > ==8436==    by 0x42006D: control_init_remote (control.c:361)
>> > > ==8436==    by 0x469D59: service_probe (service.c:160)
>> > > ==8436==    by 0x46E464: probe_service (device.c:4207)
>> > > ==8436==    by 0x46E4C2: dev_probe (device.c:4226)
>> > > ==8436==    by 0x46989B: btd_profile_foreach (profile.c:708)
>> > > ==8436==    by 0x47239D: device_probe_profiles (device.c:4285)
>> > > ==8436==    by 0x50ED51C: g_slist_foreach (in /usr/lib64/libglib-
>> > > 2.0.so.0.5400.2)
>> > > ==8436==    by 0x50ED54A: g_slist_free_full (in
>> > > /usr/lib64/libglib-2.0.so.0.5400.2)
>> > > ==8436==    by 0x45F1EE: load_devices (adapter.c:3864)
>> > > ==8436==    by 0x465E59: adapter_register (adapter.c:7741)
>> > > ==8436==    by 0x465E59: read_info_complete (adapter.c:8284)
>> > > ==8436==    by 0x48D277: request_complete (mgmt.c:261)
>> > > ==8436==    by 0x48DD44: can_read_data (mgmt.c:353)
>> > > ==8436==    by 0x4999A2: watch_callback (io-glib.c:170)
>> > > ==8436==    by 0x50CEBB6: g_main_context_dispatch (in
>> > > /usr/lib64/libglib-2.0.so.0.5400.2)
>> > > ==8436==    by 0x50CEF5F: ??? (in /usr/lib64/libglib-
>> > > 2.0.so.0.5400.2)
>> > > ==8436==    by 0x50CF271: g_main_loop_run (in /usr/lib64/libglib-
>> > > 2.0.so.0.5400.2)
>> > > ==8436==    by 0x40BDE8: main (main.c:770)
>> > > ---
>> > >  profiles/audio/control.c | 2 +-
>> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > >
>> > > diff --git a/profiles/audio/control.c b/profiles/audio/control.c
>> > > index edc4a98ce..707276d29 100644
>> > > --- a/profiles/audio/control.c
>> > > +++ b/profiles/audio/control.c
>> > > @@ -127,7 +127,7 @@ int control_disconnect(struct btd_service
>> > > *service)
>> > >  {
>> > >         struct control *control =
>> > > btd_service_get_user_data(service);
>> > >
>> > > -       if (!control->session)
>> > > +       if (!control || !control->session)
>> > >                 return -ENOTCONN;
>> > >
>> > >         avctp_disconnect(control->session);
>> > > --
>> > > 2.14.3
>> >
>> > Applied, thanks.
>>
>> Johan just pointed out that this is probably not fixing the problem
>> since it is not a NULL pointer deference as the pointer is valid,
>> instead what is probably happening is that control_unregister is
>> being
>> which frees the control but as that is pointed by a second service
>> (probably both target and remote services are supported) that then
>> cause the crash you are experiencing.
>
> I only compile tested it as I could not reproduce the crash afterwards.
> It only happened occasionally when Ctrl+C'ing a running bluetoothd.
>
> I'd either add leave that code as-is (with the patch), or add an
> assert, so it would be clear that the condition is not supposed to
> happen.

Ive send a patch resetting the service user_data if the control is
freed, that should take care of the problem.

-- 
Luiz Augusto von Dentz
