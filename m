Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696BCC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 03:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B67E23A56
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 03:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgLHDJW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Dec 2020 22:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgLHDJV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Dec 2020 22:09:21 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75EBC061749
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Dec 2020 19:08:41 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id l200so17928749oig.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Dec 2020 19:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E/aytqDuHe2pEJS5xiyzNcHzNbDOEr6yTnpdOjuR3fU=;
        b=DRWzcpnHGcSZG6gjM192JEiCGQm9BfyYAne9XuRbrzkXPgbdq/587faLJUtlHaJ1J4
         yZIOBZWsrJ1jzJ3slx5yDOIH92FwByNNDZ4d6ak/8+YHT0ukqBnRqXTkJukHu0nPAfy/
         zfg9hHkQFetTg//iqztOgVb1FRUZgU44fDTN6JdukiQyHCSYuaLdGtbVIGPj2BrL69aD
         CAnYt+P+w5rjPx0iayUGe6lQKIFGlCRYSNv1yAzFy64i7fDu/Mw3tWCT2L2dMKF42rep
         A8vVzWiM49Vi/ifdY19b+tZ/vnxa9HwzmzMMRdf7K6TWv4lCv91ha2URjyJcXgcPfPhW
         kRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/aytqDuHe2pEJS5xiyzNcHzNbDOEr6yTnpdOjuR3fU=;
        b=SGqDO4Q7G6ATf+SEdrzP/v0Ipm5sM/rf2OdEsoxhNJkHMEAibLdsZ5otHAHnX/g9bV
         kJY/RxR3GR7zaLOla7PBd2T1ETyQiV6zwEmBiuAzw4NIdFDigJo/bsxDmoATKHc7DP70
         MaDKzxJYUf5rKiZ5ypdGEJ90rTrGrp1vYhi6fJINxngMY8H7yzg6q+ALnI1vB97l2+Ad
         L+whjMrfGzcn8+wa7mp8SOOFGdXwPGSWXmqTqoFDLL2Ohm0P0wdxb/OXsrNpLIFqxIpJ
         rgi9I6fM3wkPowDFmW5h3iVSjT/oMb/SI10xRdAenXBBmwoydEkPQpx5rd3JbbpIwJ3h
         v/sg==
X-Gm-Message-State: AOAM530lRj7SuSh6OgBDHfJbu/GT/6QK/WHCflV/MbzK4ANu2lNpeL/7
        5lwfUnPt1PZToqQNlAMAaQw6lPttgewDmbaIaH0=
X-Google-Smtp-Source: ABdhPJzgrTlN5AYi5nze4IxYo8FDwLdbILCSrLoZ+rwa5u8urFHmwyBq6IU180/WlFlt8TaVjD2u/tsZ3GvTKMEfc70=
X-Received: by 2002:a05:6808:1d8:: with SMTP id x24mr1344338oic.64.1607396920905;
 Mon, 07 Dec 2020 19:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20201207234924.140606-1-abhishekpandit@chromium.org>
 <20201207154903.bluez.1.I3e043a481273442748bcff0728b2f0e208017cd2@changeid>
 <CABBYNZ+XBS_di4pqxiLKDA0EF0-wHPYpL=BqdvMWXw5bgp8=3Q@mail.gmail.com> <CANFp7mV7iDGzWP93ZbAA_HnEgjks5YtoHr0djb-z-u2VoQbQkg@mail.gmail.com>
In-Reply-To: <CANFp7mV7iDGzWP93ZbAA_HnEgjks5YtoHr0djb-z-u2VoQbQkg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 7 Dec 2020 19:08:29 -0800
Message-ID: <CABBYNZJup1HNUBdzEAF=TnGnQCe4a-xN4VASrxtTEJqVsUvQ0Q@mail.gmail.com>
Subject: Re: [bluez PATCH 1/1] policy: Refactor reconnect policy for resume
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

On Mon, Dec 7, 2020 at 5:19 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Hi Luiz,
>
> On Mon, Dec 7, 2020 at 4:36 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Abhishek,
> >
> > On Mon, Dec 7, 2020 at 3:49 PM Abhishek Pandit-Subedi
> > <abhishekpandit@chromium.org> wrote:
> > >
> > > Airpods incorrectly emit a connection timeout as the disconnect reason
> > > when a different device connects to it and triggers the automatic
> > > reconnection by mistake. See hci trace below:
> > >
> > > > HCI Event: Disconnect Complete (0x05) plen 4
> > >         Status: Success (0x00)
> > >         Handle: 256
> > >         Reason: Connection Timeout (0x08)
> > > @ MGMT Event: Device Disconnected (0x000c) plen 8
> > >         BR/EDR Address: E4:90:FD:7D:E7:5F (OUI E4-90-FD)
> > >         Reason: Connection timeout (0x01)
> > > @ MGMT Event: Device Disconnected (0x000c) plen 8
> > >         BR/EDR Address: E4:90:FD:7D:E7:5F (OUI E4-90-FD)
> > >         Reason: Connection timeout (0x01)
> > > @ MGMT Event: Device Disconnected (0x000c) plen 8
> > >         BR/EDR Address: E4:90:FD:7D:E7:5F (OUI E4-90-FD)
> > >         Reason: Connection timeout (0x01)
> > > @ MGMT Event: Device Disconnected (0x000c) plen 8
> > >         BR/EDR Address: E4:90:FD:7D:E7:5F (OUI E4-90-FD)
> > >         Reason: Connection timeout (0x01)
> > > < HCI Command: Write Scan Enable (0x03|0x001a) plen 1
> > >         Scan enable: Page Scan (0x02)
> > > > HCI Event: Command Complete (0x0e) plen 4
> > >       Write Scan Enable (0x03|0x001a) ncmd 2
> > >         Status: Success (0x00)
> > > < HCI Command: Create Connection (0x01|0x0005) plen 13
> > >         Address: E4:90:FD:7D:E7:5F (OUI E4-90-FD)
> > >         Packet type: 0xcc18
> > >           DM1 may be used
> > >           DH1 may be used
> > >           DM3 may be used
> > >           DH3 may be used
> > >           DM5 may be used
> > >           DH5 may be used
> > >         Page scan repetition mode: R2 (0x02)
> > >         Page scan mode: Mandatory (0x00)
> > >         Clock offset: 0x0000
> > >         Role switch: Allow slave (0x01)
> > > > HCI Event: Command Status (0x0f) plen 4
> > >       Create Connection (0x01|0x0005) ncmd 1
> > >
> > > To fix this behavior, separate the ReconnectUUIDs into services that
> > > reconnect on timeout and on resume. This ensures that the a2dp-sink
> > > profile reconnects are correctly applied only on resume from suspend and
> > > adds the option to reconnect other profiles automatically on resume.
> > >
> > > Reviewed-by: Alain Michaud <alainm@chromium.org>
> > > ---
> > >
> > >  plugins/policy.c | 72 ++++++++++++++++++++++++++++++++++++------------
> > >  src/main.conf    |  9 +++++-
> > >  2 files changed, 62 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/plugins/policy.c b/plugins/policy.c
> > > index ba9e1be02..a3cc3445e 100644
> > > --- a/plugins/policy.c
> > > +++ b/plugins/policy.c
> > > @@ -44,19 +44,22 @@
> > >
> > >  struct reconnect_data {
> > >         struct btd_device *dev;
> > > -       bool reconnect;
> > > +       bool on_timeout;
> > > +       bool on_resume;
> > >         GSList *services;
> > >         guint timer;
> > >         bool active;
> > >         unsigned int attempt;
> > > -       bool on_resume;
> > > +       bool mark_on_suspend;
> > >  };
> > >
> > >  static const char *default_reconnect[] = {
> > > -                       HSP_AG_UUID, HFP_AG_UUID, A2DP_SOURCE_UUID,
> > > -                       A2DP_SINK_UUID, NULL };
> > > +                       HSP_AG_UUID, HFP_AG_UUID, A2DP_SOURCE_UUID, NULL };
> > >  static char **reconnect_uuids = NULL;
> > >
> > > +static const char *default_reconnect_resume[] = { A2DP_SINK_UUID, NULL };
> > > +static char **reconnect_resume_uuids = NULL;
> > > +
> > >  static const size_t default_attempts = 7;
> > >  static size_t reconnect_attempts = 0;
> > >
> > > @@ -551,14 +554,14 @@ static void reconnect_reset(struct reconnect_data *reconnect)
> > >         }
> > >  }
> > >
> > > -static bool reconnect_match(const char *uuid)
> > > +static bool reconnect_match_internal(const char *uuid, char **matchlist)
> > >  {
> > >         char **str;
> > >
> > > -       if (!reconnect_uuids)
> > > +       if (!matchlist)
> > >                 return false;
> > >
> > > -       for (str = reconnect_uuids; *str; str++) {
> > > +       for (str = matchlist; *str; str++) {
> > >                 if (!bt_uuid_strcmp(uuid, *str))
> > >                         return true;
> > >         }
> > > @@ -566,6 +569,16 @@ static bool reconnect_match(const char *uuid)
> > >         return false;
> > >  }
> > >
> > > +static bool reconnect_match(const char *uuid)
> > > +{
> > > +       return reconnect_match_internal(uuid, reconnect_uuids);
> > > +}
> > > +
> > > +static bool reconnect_resume_match(const char *uuid)
> > > +{
> > > +       return reconnect_match_internal(uuid, reconnect_resume_uuids);
> > > +}
> > > +
> > >  static struct reconnect_data *reconnect_add(struct btd_service *service)
> > >  {
> > >         struct btd_device *dev = btd_service_get_device(service);
> > > @@ -687,10 +700,15 @@ static void service_cb(struct btd_service *service,
> > >          * be the first profile that's connected so we might have an
> > >          * entry but with the reconnect flag set to false.
> > >          */
> > > -       if (!reconnect->reconnect)
> > > -               reconnect->reconnect = reconnect_match(profile->remote_uuid);
> > > +       if (!reconnect->on_timeout)
> > > +               reconnect->on_timeout = reconnect_match(profile->remote_uuid);
> > > +
> > > +       if (!reconnect->on_resume)
> > > +               reconnect->on_resume =
> > > +                       reconnect_resume_match(profile->remote_uuid);
> > >
> > > -       DBG("Added %s reconnect %u", profile->name, reconnect->reconnect);
> > > +       DBG("Added %s reconnect on timeout(%u), resume(%u)",
> > > +               profile->name, reconnect->on_timeout, reconnect->on_resume);
> > >  }
> > >
> > >  static gboolean reconnect_timeout(gpointer data)
> > > @@ -704,7 +722,7 @@ static gboolean reconnect_timeout(gpointer data)
> > >         reconnect->timer = 0;
> > >
> > >         /* Mark any reconnect on resume as handled */
> > > -       reconnect->on_resume = false;
> > > +       reconnect->mark_on_suspend = false;
> > >
> > >         err = btd_device_connect_services(reconnect->dev, reconnect->services);
> > >         if (err < 0) {
> > > @@ -750,7 +768,7 @@ static void disconnect_cb(struct btd_device *dev, uint8_t reason)
> > >                 return;
> > >
> > >         reconnect = reconnect_find(dev);
> > > -       if (!reconnect || !reconnect->reconnect)
> > > +       if (!reconnect || !(reconnect->on_timeout || reconnect->on_resume))
> > >                 return;
> > >
> > >         reconnect_reset(reconnect);
> > > @@ -759,11 +777,11 @@ static void disconnect_cb(struct btd_device *dev, uint8_t reason)
> > >
> > >         switch (reason) {
> > >         case MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND:
> > > -               if (btd_device_get_service(dev, A2DP_SINK_UUID)) {
> > > +               if (reconnect->on_resume) {
>
> Note: Previously, only A2DP-SINK would reconnect if disconnected during suspend.
>
> > >                         DBG("%s configured to reconnect on resume",
> > >                                 device_get_path(dev));
> > >
> > > -                       reconnect->on_resume = true;
> > > +                       reconnect->mark_on_suspend = true;
> > >
> > >                         /* If the kernel supports resume events, it is
> > >                          * preferable to set the reconnect timer there as it is
> > > @@ -774,7 +792,8 @@ static void disconnect_cb(struct btd_device *dev, uint8_t reason)
> > >                 }
> > >                 break;
> > >         case MGMT_DEV_DISCONN_TIMEOUT:
> > > -               reconnect_set_timer(reconnect, -1);
> > > +               if (reconnect->on_timeout)
> > > +                       reconnect_set_timer(reconnect, -1);
> > >                 break;
> > >         default:
> > >                 DBG("Developer error. Reason = %d", reason);
> > > @@ -790,7 +809,7 @@ static void policy_adapter_resume(struct btd_adapter *adapter)
> > >         for (l = reconnects; l; l = g_slist_next(l)) {
> > >                 struct reconnect_data *reconnect = l->data;
> > >
> > > -               if (reconnect->on_resume &&
> > > +               if (reconnect->mark_on_suspend &&
> > >                     device_get_adapter(reconnect->dev) == adapter) {
> > >                         reconnect_set_timer(reconnect, resume_delay);
> > >                 }
> > > @@ -804,7 +823,7 @@ static void conn_fail_cb(struct btd_device *dev, uint8_t status)
> > >         DBG("status %u", status);
> > >
> > >         reconnect = reconnect_find(dev);
> > > -       if (!reconnect || !reconnect->reconnect)
> > > +       if (!reconnect || !(reconnect->on_timeout || reconnect->on_resume))
> > >                 return;
> > >
> > >         if (!reconnect->active)
> > > @@ -845,6 +864,7 @@ static int policy_init(void)
> > >  {
> > >         GError *gerr = NULL;
> > >         GKeyFile *conf;
> > > +       bool has_reconnect_uuids;
> > >
> > >         service_id = btd_service_add_state_cb(service_cb, NULL);
> > >
> > > @@ -892,6 +912,15 @@ static int policy_init(void)
> > >         auto_enable = g_key_file_get_boolean(conf, "Policy", "AutoEnable",
> > >                                                                         NULL);
> > >
> > > +       reconnect_resume_uuids = g_key_file_get_string_list(
> > > +               conf, "Policy", "ReconnectResumeUUIDs", NULL, &gerr);
> > > +
> > > +       if (gerr) {
> > > +               g_clear_error(&gerr);
> > > +               reconnect_resume_uuids =
> > > +                       g_strdupv((char **)default_reconnect_resume);
> > > +       }
> > > +
> > >         resume_delay = g_key_file_get_integer(
> > >                         conf, "Policy", "ResumeDelay", &gerr);
> > >
> > > @@ -900,7 +929,11 @@ static int policy_init(void)
> > >                 resume_delay = default_resume_delay;
> > >         }
> > >  done:
> > > -       if (reconnect_uuids && reconnect_uuids[0] && reconnect_attempts) {
> > > +       has_reconnect_uuids =
> > > +               (reconnect_uuids && reconnect_uuids[0]) ||
> > > +               (reconnect_resume_uuids && reconnect_resume_uuids[0]);
> > > +
> > > +       if (reconnect_attempts && has_reconnect_uuids) {
> > >                 btd_add_disconnect_cb(disconnect_cb);
> > >                 btd_add_conn_fail_cb(conn_fail_cb);
> > >         }
> > > @@ -918,6 +951,9 @@ static void policy_exit(void)
> > >         if (reconnect_uuids)
> > >                 g_strfreev(reconnect_uuids);
> > >
> > > +       if (reconnect_resume_uuids)
> > > +               g_strfreev(reconnect_resume_uuids);
> > > +
> > >         g_free(reconnect_intervals);
> > >
> > >         g_slist_free_full(reconnects, reconnect_destroy);
> > > diff --git a/src/main.conf b/src/main.conf
> > > index ad36638b7..6f66acb14 100644
> > > --- a/src/main.conf
> > > +++ b/src/main.conf
> > > @@ -220,7 +220,7 @@
> > >  # timeout). The policy plugin should contain a sane set of values by
> > >  # default, but this list can be overridden here. By setting the list to
> > >  # empty the reconnection feature gets disabled.
> > > -#ReconnectUUIDs=00001112-0000-1000-8000-00805f9b34fb,0000111f-0000-1000-8000-00805f9b34fb,0000110a-0000-1000-8000-00805f9b34fb,0000110b-0000-1000-8000-00805f9b34fb
> > > +#ReconnectUUIDs=00001112-0000-1000-8000-00805f9b34fb,0000111f-0000-1000-8000-00805f9b34fb,0000110a-0000-1000-8000-00805f9b34fb
> > >
> > >  # ReconnectAttempts define the number of attempts to reconnect after a link
> > >  # lost. Setting the value to 0 disables reconnecting feature.
> > > @@ -237,6 +237,13 @@
> > >  # in later on. Defaults to 'false'.
> > >  #AutoEnable=false
> > >
> > > +# The ReconnectResumeUUIDs defines the set of remote services that should try
> > > +# to be reconnected after resume from suspend if they were connected before
> > > +# suspend. If a device is disconnected due to suspend, it will be queued for
> > > +# reconnect on resume first using the ResumeDelay value and then the remaining
> > > +# values in ReconnectIntervals.
> > > +#ReconnectResumeUUIDs=0000110b-0000-1000-8000-00805f9b34fb
> >
> > I don't follow the reasoning here really, we need to be consistent
> > with regards to policy so how about the other profiles listed to be
> > reconnected does it means they no longer are connected on resume? From
> > the looks of you it we cannot really tell if the device was
> > disconnected due to link supervision timeout or not so we can't really
> > assume the Connection timeout (0x01) is in fact a second device
> > connecting, IMO if it is a mistake on the manufacturer then this
> > should be made device specific even though I think you will have to
> > disable the reconnection logic altogether if we cannot trust the
> > reason for the disconnection or does it cleanup the A2DP stream before
> > disconnecting, in that case we should have consider a clean
> > disconnection.
>
> ReconnectUUIDs was overloaded to mean both "reconnect on link loss"
> and "reconnect only a2dp-sink if disconnected due to suspend". This
> patch removes that overloading and ReconnectUUIDs simply always means,
> "Reconnect if link loss". ReconnectResumeUUIDs means simply, "If this
> device was disconnected during suspend, attempt to reconnect it on
> resume." It's adding a Reconnect policy for disconnect reason =
> "Disconnect due to Suspend". I think this is more generic and enables
> adding other uuids to this policy.

To my understanding disconnected due to suspend was actually
considered a link loss due to suspend, if we were to carried out
different policies for these conditions the whole thing becomes a lot
more complicated, and to make matters worse this so far has been a
problem to a single manufacturer which in the future might actually
change the disconnect reason. How about the other profiles, if it were
connected to HFP shouldn't it be reconnected as well? Also would the
problem of stealing the connection still manifest when the laptop
resumes when one attempts to connect to the phone?

> If we really want link loss reconnects for a2dp-sink, I agree that we
> should be treating the Airpods differently because it is specific to
> that device.
>
> This is what I'm seeing on the Airpods when I connect from an Android
> phone (while already connected to Chromebook). There is no profile
> disconnect (no l2cap disconnection requests either).
>
> > HCI Event: Number of Completed Packets (0x13) plen 5                                                                        #1674 [hci0] 38.810693
>         Num handles: 1
>         Handle: 256
>         Count: 1
> < ACL Data TX: Handle 256 flags 0x02 dlen 969
>                                                        #1675 [hci0]
> 38.820328
>       Channel: 11011 len 965 [PSM 25 mode Basic (0x00)] {chan 2}
> < ACL Data TX: Handle 256 flags 0x00 dlen 7
>                                                        #1676 [hci0]
> 38.821054
>       Channel: 10756 len 3 [PSM 25 mode Basic (0x00)] {chan 3}
>       AVDTP: Suspend (0x09) Command (0x00) type 0x00 label 4 nosp 0
>         ACP SEID: 1
> > HCI Event: Number of Completed Packets (0x13) plen 5                                                                        #1677 [hci0] 38.835673
>         Num handles: 1
>         Handle: 256
>         Count: 1
> > HCI Event: Number of Completed Packets (0x13) plen 5                                                                        #1678 [hci0] 38.836347
>         Num handles: 1
>         Handle: 256
>         Count: 1
> > ACL Data RX: Handle 256 flags 0x02 dlen 6                                                                                   #1679 [hci0] 38.861708
>       Channel: 67 len 2 [PSM 25 mode Basic (0x00)] {chan 3}
>       AVDTP: Suspend (0x09) Response Accept (0x02) type 0x00 label 4
> nosp 0
> > HCI Event: Disconnect Complete (0x05) plen 4                                                                                #1680 [hci0] 62.656436
>         Status: Success (0x00)
>         Handle: 256
>         Reason: Connection Timeout (0x08)

This is a link loss in my books, so if any profiles on ReconnectUUIDs
were connected this still would trigger a reconnection and we can't
really remove everything from there, perhaps for Chrome OS only A2DP
is connected but in other cases HFP might be connected as well. Imo a
better way to handle this is with a quirk for broken reason, or
perhaps expose an interface where the upper layer can disable policies
on per-device, in which case the user can disable the UUIDs to be
reconnected.

>
> >
> > >  # Audio devices that were disconnected due to suspend will be reconnected on
> > >  # resume. ResumeDelay determines the delay between when the controller
> > >  # resumes from suspend and a connection attempt is made. A longer delay is
> > > --
> > > 2.29.2.576.ga3fc446d84-goog
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
