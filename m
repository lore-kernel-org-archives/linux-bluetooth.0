Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3FDC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Feb 2021 21:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEBE964E01
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Feb 2021 21:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhBLVIH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Feb 2021 16:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhBLVIE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Feb 2021 16:08:04 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DA8C061786
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Feb 2021 13:07:23 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id k22so7724ljg.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Feb 2021 13:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VlR52M94jQPdRoy6eLB69Z+9oUzIOTTcSaf7tpVWbJ4=;
        b=MSwR1h6MDhUxo0yiV3c6SQTj1hw7+v3Eolwjz02Iko3mt10tFuZeJBkqo9cEmyAm/3
         wZg59YJsgisxpuNJdxckxWFqk4CKCBgml8QW+FocQG4RShdeNJwbR5XhjLZWoRExrfpO
         HelC8vG1oGfqT2BtRWjxyzkt+dp/5OWsRP3GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VlR52M94jQPdRoy6eLB69Z+9oUzIOTTcSaf7tpVWbJ4=;
        b=dDD6YcrYgw/jHChPe8DuazOlRq9ZbBxwWer5nJOH0AVR09k4xQcw7bW/j/f054ctQk
         qo81RpjCs4bVrfZ3o4Jf5yd2Q1IMcnxbxMXNUdx+48FFK0xin0g3yR2zO895W7xMG3Yr
         hSRSxj6wSO43ucSf1AWPcVaYqQG0ZodMsP8CSOPdXVCQ143JMxi6cBLUvyP3cisq9hXB
         JbyIq3iqiNgtJo9xJbNzKbMnCHotDK0vMsoeFCOiLU1qPjrGybqRmQcDsWtusqjSzUEb
         Qn1BVp2LXV5uEE3aCrPzCNNePSa9EW8psdMd5/s+l0eiiU20xEV4DJaHGNd3c99Kvy0g
         Js2A==
X-Gm-Message-State: AOAM532fZyj9fwtN/06m6yuDZss2siQFm7M1S5Hw1vbqiz+bUNpsKLus
        cMTrvkrAFR1wMYHnXoq8cgQL7N8jYS2H5lXF6RmAbA==
X-Google-Smtp-Source: ABdhPJyMDRq3AK+YRc0gQE/z0DA/gXqukuPb6RfvRrxr/FmDzPJw6oXkDm6N7CZY3vZisOnP5dTiCAaIl5KILbr3COA=
X-Received: by 2002:a05:651c:291:: with SMTP id b17mr2791491ljo.274.1613164042137;
 Fri, 12 Feb 2021 13:07:22 -0800 (PST)
MIME-Version: 1.0
References: <20210211172813.BlueZ.v1.1.I0b1ea92cf6c47ac45a2b3b9264b6b64fb8437442@changeid>
 <CABBYNZ+pgtoSzLyHh5kwfyAU+LpJRi5FngwJ8y_qVkopU-WORA@mail.gmail.com>
In-Reply-To: <CABBYNZ+pgtoSzLyHh5kwfyAU+LpJRi5FngwJ8y_qVkopU-WORA@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Fri, 12 Feb 2021 13:07:11 -0800
Message-ID: <CABmPvSEbSTO9_eJU8ae1nw4uAQutqjB+o7KhO7eW6DNsaRdLmg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] adapter: Add adapter cleanup watchdog
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Thu, Feb 11, 2021 at 5:58 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Miao,
>
> On Thu, Feb 11, 2021 at 5:33 PM Miao-chen Chou <mcchou@chromium.org> wrot=
e:
> >
> > This adds a watchdog timer to prevent race caused by rapid index_added(=
)
> > event following index_removed() event during system resume. The issue
> > can happen on the platform where the power of controller would be cut
> > off when the system goes to suspend. If there is an audio device paired
> > and connected before the suspend, there is a chance that index_added()
> > event happens before the device is fully torn down. The D-Bus interface
> > of the same device cannot be added during the loading of paired device,
> > and then the session_cb() of AVDTP arrives and triggers device_free().
> > The symptom is that device wouldn't be presented to D-Bus interface at
> > all.
> >
> > The watchdog timeout is set to 1000 ms based on AVDTP disconnection
> > timeout. The experiments shows that it took about ~50ms for session_cb(=
)
> > to arrive after index_removed().
>
> Is this the grace time that we take from avdtp_unref to disconnect:
Yes. I admit that it might not be a good pick. My understanding on
this disconnection timeout is slightly different from your
explanation. This timeout is set to unref a AVDTP session if there is
no user (A2DP or other profile) on it. Therefore this disconnection
timeout doesn't include the round time from the point where the
session->io[1] gets closed to the point session_cb() gets invoked. As
a part of session_cb(), avdtp_unref() -> avdtp_free() ->
btd_device_unref() [2] -> device_free().
[1] https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/profiles/audio/=
avdtp.c#n734
[2] https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/profiles/audio/=
avdtp.c#n1145

>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/profiles/audio/av=
dtp.c#n1208
>
> I think we should actually inform the driver when the adapter is
> removed so they can release any reference to the device they may have
> or retry connecting, etc. Do you know which reference prevents the
> device to be freed.
I don't quite understand the comment on the driver's reference of the
device, perhaps I should tell the story with more detail. In
userspace, the reference chain looks like this: device <- AVDTP <-
A2DP when the peer is connected. Before suspend, the kernel
disconnects the peer device as part of suspend preparation, and the
userspace gets informed on the disconnection. Upon resume the
userspace starts to process the disconnection of the peer device, and
the reference chain gets unref with the order A2DP -> AVDTP -> device.
In both normal cases and failure cases, this chain of unref is
performed in the same way (orderwide and timewide). The key factor
here is the time it takes to resume the controller (including USB
re-enumeration, FW loading/reset) up to the point index_added() gets
poked. This issue was first discovered in the scenario where
remote_wakeup is set if there is at least one peer device connected
before suspend (BTW, this is fixed at [3]), and the controller would
not perform global suspend. Upon resume the FW would not be reloaded,
and it takes less time for the controller to resume. As a result,
index_added() is likely to occur before session_cb() gets invoked
during the peer device being torn-down.
Given that there is no actual bug in userspace, I think it might be
safer to enforce the watchdog for rapid re-added without messing up
the correct torn-down logic.

[3] https://chromium-review.googlesource.com/c/chromiumos/third_party/kerne=
l/+/2601256/

Here is a snippet of logs captured with this watchdog patch.

=3D bluetoothd: Endpoint unregistered: sender=3D:1.50
path=3D/org/chromium/Cras/Bluetooth/A2DPSource       2021-02-11
16:19:12.635282
=3D bluetoothd: profiles/audio/media.c:media_endpoint_destroy()
sender=3D:1.50 path=3D/org/chromium/Cra..   2021-02-11 16:19:12.635307
=3D bluetoothd: profiles/audio/avdtp.c:avdtp_unregister_sep() SEP
0x56d277ab5400 unregistered: type..    2021-02-11 16:19:12.635316
=E2=80=A6
=3D bluetoothd: src/adapter.c:btd_adapter_unref() Freeing adapter
/org/bluez/hci0                                         2021-02-11
16:19:12.652638
=3D bluetoothd: src/adapter.c:adapter_free() 0x56d277a9e150
                                                          2021-02-11
16:19:12.652693
=3D bluetoothd: src/adapter.c:adapter_free() Set cleanup watchdog for
adapter 0                                            2021-02-11
16:19:12.652742
=3D bluetoothd: src/adapter.c:start_cleanup_watchdog_timer() Cleanup
watchdog timer set for adapter..       2021-02-11 16:19:12.652787
=3D bluetoothd: Postpone adding adapter 0

2021-02-11 16:19:12.653100
=3D bluetoothd: profiles/audio/avdtp.c:session_cb()

2021-02-11 16:19:12.675178
=3D bluetoothd: profiles/audio/avdtp.c:avdtp_ref() 0x56d277aecca0: ref=3D2
                                                      2021-02-11
16:19:12.675254
=3D bluetoothd: profiles/audio/avdtp.c:avdtp_unref() 0x56d277aecca0:
ref=3D1                                                   2021-02-11
16:19:12.675306
=3D bluetoothd: profiles/audio/avdtp.c:connection_lost() Disconnected
from 28:11:A5:E1:4F:67                      2021-02-11 16:19:12.675359
=3D bluetoothd: profiles/audio/avdtp.c:avdtp_unref() 0x56d277aecca0:
ref=3D0                                                   2021-02-11
16:19:12.675396
=3D bluetoothd: profiles/audio/avdtp.c:avdtp_free() 0x56d277aecca0
                                                        2021-02-11
16:19:12.675428
=3D bluetoothd: src/device.c:btd_device_unref() Freeing device
/org/bluez/hci0/dev_28_11_A5_E1_4F_67    2021-02-11 16:19:12.675539
=3D bluetoothd: src/device.c:device_free() 0x56d277ac5c70

2021-02-11 16:19:12.675819
=3D bluetoothd: src/adapter.c:expire_cleanup_watchdog() expire cleanup
watchdog for adapter 0                   2021-02-11 16:19:13.655248
=3D bluetoothd: src/adapter.c:index_added() index 0

2021-02-11 16:19:13.655337
>
> > The following test steps were performed:
> > (1) Pair and connect to Bose QC35
> > (2) Call powerd_dbus_suspend
> > (3) Suspend the device, wait for 30 seconds and resume the device.
> > (4) Verify if device shows up on the paired device list.
> >
> > ---
> > Hi BlueZ Maintainers,
> >
> > This issue was discovered during a platform bring-up where the reload o=
f
> > the Bluetooth firmware is fast enough and index_added() arrives before
> > the torn-down of an audio device.
> >
> > Chrome OS Bluetooth Team
> >
> >  src/adapter.c | 131 +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 130 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index c1f976323..e0ee16085 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -86,6 +86,11 @@
> >  #define DISTANCE_VAL_INVALID   0x7FFF
> >  #define PATHLOSS_MAX           137
> >
> > +/* The unit is millisecons, and the value refers to the disconnection =
timeout
> > + * of AVDTP session.
> > + */
> > +#define CLEANUP_WATCHDOG_TIMEOUT       1000
> > +
> >  /*
> >   * These are known security keys that have been compromised.
> >   * If this grows or there are needs to be platform specific, it is
> > @@ -121,6 +126,13 @@ static GSList *adapter_drivers =3D NULL;
> >  static GSList *disconnect_list =3D NULL;
> >  static GSList *conn_fail_list =3D NULL;
> >
> > +/* Watchdog timer of rapid index added after index removed */
> > +static guint cleanup_watchdog_timer;
> > +/* List of struct cleanup_watchdog, used to prevent rapid index added =
after
> > + * index removed.
> > + */
> > +static struct queue *cleanup_watchdogs;
> > +
> >  struct link_key_info {
> >         bdaddr_t bdaddr;
> >         unsigned char key[16];
> > @@ -288,6 +300,14 @@ typedef enum {
> >         ADAPTER_AUTHORIZE_CHECK_CONNECTED
> >  } adapter_authorize_type;
> >
> > +struct cleanup_watchdog {
> > +       uint16_t index;         /* adapter index */
> > +       time_t target_ts;       /* targeted timestamp for index added t=
o be
> > +                                * triggered
> > +                                */
> > +       bool should_add;
> > +};
> > +
> >  static struct btd_adapter *btd_adapter_lookup(uint16_t index)
> >  {
> >         GList *list;
> > @@ -517,6 +537,9 @@ static void adapter_stop(struct btd_adapter *adapte=
r);
> >  static void trigger_passive_scanning(struct btd_adapter *adapter);
> >  static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
> >                                                         uint8_t mode);
> > +static void index_added(uint16_t index, uint16_t length, const void *p=
aram,
> > +                                                       void *user_data=
);
> > +static gboolean expire_cleanup_watchdog(gpointer user_data);
> >
> >  static void settings_changed(struct btd_adapter *adapter, uint32_t set=
tings)
> >  {
> > @@ -5319,9 +5342,81 @@ static void remove_discovery_list(struct btd_ada=
pter *adapter)
> >         adapter->discovery_list =3D NULL;
> >  }
> >
> > +static void cleanup_watchdog_free(void *data)
> > +{
> > +       struct cleanup_watchdog *watchdog =3D data;
> > +
> > +       free(watchdog);
> > +}
> > +
> > +static void start_cleanup_watchdog_timer(time_t current_ts)
> > +{
> > +       double diff_ts;
> > +       struct cleanup_watchdog *watchdog;
> > +
> > +       if (cleanup_watchdog_timer)
> > +               return;
> > +
> > +       watchdog =3D queue_peek_head(cleanup_watchdogs);
> > +       if (!watchdog)
> > +               return;
> > +
> > +       diff_ts =3D difftime(watchdog->target_ts, current_ts) * 1000;
> > +       cleanup_watchdog_timer =3D g_timeout_add(diff_ts, expire_cleanu=
p_watchdog,
> > +                                               NULL);
> > +
> > +       DBG("Cleanup watchdog timer set for adapter %u with %f ms",
> > +               watchdog->index, diff_ts);
> > +}
> > +
> > +static gboolean expire_cleanup_watchdog(gpointer user_data)
> > +{
> > +       time_t current_ts;
> > +       struct cleanup_watchdog *watchdog;
> > +
> > +       g_source_remove(cleanup_watchdog_timer);
> > +       cleanup_watchdog_timer =3D 0;
> > +
> > +       time(&current_ts);
> > +
> > +       while (watchdog =3D queue_peek_head(cleanup_watchdogs)) {
> > +               if (watchdog->target_ts <=3D current_ts) {
> > +                       queue_pop_head(cleanup_watchdogs);
> > +
> > +                       DBG("expire cleanup watchdog for adapter %u",
> > +                               watchdog->index);
> > +
> > +                       if (watchdog->should_add)
> > +                               index_added(watchdog->index, 0, NULL, N=
ULL);
> > +
> > +                       cleanup_watchdog_free(watchdog);
> > +               } else {
> > +                       start_cleanup_watchdog_timer(current_ts);
> > +                       return FALSE;
> > +               }
> > +       }
> > +
> > +       return FALSE;
> > +}
> > +
> > +static bool match_cleanup_watchdog_by_index(const void *data,
> > +                                               const void *user_data)
> > +{
> > +       const uint16_t *index =3D user_data;
> > +       const struct cleanup_watchdog *watchdog =3D data;
> > +
> > +       if (!watchdog || !index)
> > +               return false;
> > +
> > +       return watchdog->index =3D=3D *index;
> > +}
> > +
> >  static void adapter_free(gpointer user_data)
> >  {
> > +       struct cleanup_watchdog *watchdog;
> >         struct btd_adapter *adapter =3D user_data;
> > +       time_t current_ts;
> > +       uint16_t index =3D adapter->dev_id;
> >
> >         DBG("%p", adapter);
> >
> > @@ -5384,6 +5479,23 @@ static void adapter_free(gpointer user_data)
> >         g_free(adapter->current_alias);
> >         free(adapter->modalias);
> >         g_free(adapter);
> > +
> > +       DBG("Set cleanup watchdog for adapter %u", index);
> > +       watchdog =3D queue_find(cleanup_watchdogs,
> > +                               match_cleanup_watchdog_by_index, NULL);
> > +       if (watchdog) {
> > +               queue_remove(cleanup_watchdogs, watchdog);
> > +       } else {
> > +               watchdog =3D new0(struct cleanup_watchdog, 1);
> > +               watchdog->index =3D index;
> > +       }
> > +
> > +       time(&current_ts);
> > +       watchdog->should_add =3D false;
> > +       watchdog->target_ts =3D current_ts + (CLEANUP_WATCHDOG_TIMEOUT =
/ 1000);
> > +
> > +       queue_push_tail(cleanup_watchdogs, watchdog);
> > +       start_cleanup_watchdog_timer(current_ts);
> >  }
> >
> >  struct btd_adapter *btd_adapter_ref(struct btd_adapter *adapter)
> > @@ -9568,6 +9680,18 @@ static void index_added(uint16_t index, uint16_t=
 length, const void *param,
> >                                                         void *user_data=
)
> >  {
> >         struct btd_adapter *adapter;
> > +       struct cleanup_watchdog *watchdog;
> > +
> > +       if (!!cleanup_watchdog_timer) {
> > +               watchdog =3D queue_find(cleanup_watchdogs,
> > +                                       match_cleanup_watchdog_by_index=
,
> > +                                       &index);
> > +               if (watchdog) {
> > +                       warn("Postpone adding adapter %u", index);
> > +                       watchdog->should_add =3D true;
> > +                       return;
> > +               }
> > +       }
> >
> >         DBG("index %u", index);
> >
> > @@ -9829,8 +9953,10 @@ int adapter_init(void)
> >
> >         if (mgmt_send(mgmt_master, MGMT_OP_READ_VERSION,
> >                                 MGMT_INDEX_NONE, 0, NULL,
> > -                               read_version_complete, NULL, NULL) > 0)
> > +                               read_version_complete, NULL, NULL) > 0)=
 {
> > +               cleanup_watchdogs =3D queue_new();
> >                 return 0;
> > +       }
> >
> >         error("Failed to read management version information");
> >
> > @@ -9880,6 +10006,9 @@ void adapter_shutdown(void)
> >
> >         DBG("");
> >
> > +       queue_destroy(cleanup_watchdogs, cleanup_watchdog_free);
> > +       cleanup_watchdogs =3D NULL;
> > +
> >         powering_down =3D true;
> >
> >         for (list =3D g_list_first(adapter_list); list;
> > --
> > 2.30.0.478.g8a0d178c01-goog
> >
>
>
> --
> Luiz Augusto von Dentz
Regards,
Miao
