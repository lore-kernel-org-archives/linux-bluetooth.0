Return-Path: <SRS0=kLeu=CG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADE0C433E2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Aug 2020 17:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917B720C56
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Aug 2020 17:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/9pAo88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgH1R4W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Aug 2020 13:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgH1R4V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Aug 2020 13:56:21 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2689C061264
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2020 10:56:20 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n23so1596145otq.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2020 10:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=98Dw+kNTUpfY8xqkmQIkoZ3Vt1R+Nz7p3iSUI0oX40Q=;
        b=u/9pAo88LddfZji/ypCVpF4QPKGlJbLhypbkTEKgf+v+oCCi36aqje3Esu7weHIC19
         NdoC7fzdlCeOtv831AP5obhWgtE113JIqR/bN0748eHFyB0jTDJ6uf8VSSQpoTnJTgOk
         Va3y7HV7E2Mgp6VCeP0Zv2gXR3KNFi2ch4dzUu+Z6Hs6uw6HgTJv1a2D63qAv8CyZSJi
         tCuYMm3l3h6Kx7kRUzirnL7+cC9mA4sDtflS04X1iEzi/SotFeufqGuH/uI/AJtJ7YP6
         JvdpjQlqDQIGQvX2QcywE1OoCoB1CFSFIqr+dMV4L4NODY8O0w31neTb0rRxEBgP4Rjf
         kw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=98Dw+kNTUpfY8xqkmQIkoZ3Vt1R+Nz7p3iSUI0oX40Q=;
        b=LuLiVY8n7uLXPnSvfy8MCifOAQ/vEgIBUnCupoJIIMy8mXF2XfiXi/DMrR4bYnyZs4
         FQGRtKrsVo5cWz2CcZ9FLtz5qvtOIhGeHpXvfKnMAKYY+TRooRSYaD0iaJkvRLoGIyfR
         gTp2p3Lv7/Td7SK9a1B6ramwadTjcnaH1zwnRK3eJNkBg2sFfAfUaVJl0v26BWM9ljAi
         H9izCtW77ZDHf2xPaib/jziyn50CaAMziWUo98D4dsnqmL0s8RYcW6RIZv6SZyGz0KM/
         jIkGDE7VYDZ/ghYEo2zDp5vlFTP1KKUS2mcJod5GD3ZdrTqRLvY75nvkrfvVOg3QmWIF
         TXgg==
X-Gm-Message-State: AOAM5336VfhxMiHqkxJvE6CxNq+DgYcGk7/TWg8IYyo6MzdrjuM+j+4Z
        euJA3Pz9o330UMGLgpTMpQrDQcAwD8xK0/7jDMJfFjVi
X-Google-Smtp-Source: ABdhPJwJUERDOxMuNrRiNWPBaReFaD9U3/ducgk1rZF0lQihABTcSwRNbDID2sPQ6mNkTap8MqpDcDgzB+U08mGbsAg=
X-Received: by 2002:a9d:7e7:: with SMTP id 94mr2027147oto.91.1598637378712;
 Fri, 28 Aug 2020 10:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200818232822.1645054-1-abhishekpandit@chromium.org>
 <20200818162807.Bluez.v2.3.I26efd89de3a70af1cd9775d457d0c10f4aafd4cb@changeid>
 <CABBYNZLb_ETfO1VyAf+1rXpRT_XroQLq7u=uK6PGcrOKR7PHxA@mail.gmail.com>
 <CANFp7mV03KvqpOH=LBU=0tBDhgK5K2YJ6rxYvkDKmyer4n_gLw@mail.gmail.com>
 <CABBYNZ+SYSgzR_wX5Cn+5zUjep6HazCdJvAgZ0EE0uLkB_PEGg@mail.gmail.com> <CANFp7mU-gunJi5pAMY0zqE-BFGB6XDE=nPpxjU0Lqf7RBKDDpw@mail.gmail.com>
In-Reply-To: <CANFp7mU-gunJi5pAMY0zqE-BFGB6XDE=nPpxjU0Lqf7RBKDDpw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 28 Aug 2020 10:56:08 -0700
Message-ID: <CABBYNZ+VR7xG=TuK8VBg+6mg8C2hB=x9EWXhxV1CJYmNNhA4ng@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 3/3] policy: Reconnect audio on controller resume
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

On Fri, Aug 28, 2020 at 10:31 AM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> Hi Luiz,
>
> On Fri, Aug 28, 2020 at 10:09 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Abhishek,
> >
> > On Thu, Aug 27, 2020 at 2:08 PM Abhishek Pandit-Subedi
> > <abhishekpandit@chromium.org> wrote:
> > >
> > > Hi Luiz,
> > >
> > > On Wed, Aug 26, 2020 at 11:32 PM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Abhishek,
> > > >
> > > > On Tue, Aug 18, 2020 at 4:28 PM Abhishek Pandit-Subedi
> > > > <abhishekpandit@chromium.org> wrote:
> > > > >
> > > > > During system suspend, all peer devices are disconnected. On resume, HID
> > > > > devices will reconnect but audio devices stay disconnected. As a quality
> > > > > of life improvement, mark audio devices that were disconnected due to
> > > > > suspend and attempt to reconnect them when the controller resumes (after
> > > > > a delay for better co-existence with Wi-Fi).
> > > > >
> > > > > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > > > ---
> > > > >
> > > > > Changes in v2:
> > > > > - Refactored to use policy instead of connecting directly in adapter
> > > > >
> > > > >  plugins/policy.c | 64 +++++++++++++++++++++++++++++++++++++++++++++---
> > > > >  src/adapter.c    | 45 ++++++++++++++++++++++++++++++++++
> > > > >  src/adapter.h    |  6 +++++
> > > > >  src/main.c       |  1 +
> > > > >  src/main.conf    |  9 +++++++
> > > > >  5 files changed, 121 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/plugins/policy.c b/plugins/policy.c
> > > > > index de51e58b9..b07a997b9 100644
> > > > > --- a/plugins/policy.c
> > > > > +++ b/plugins/policy.c
> > > > > @@ -75,6 +75,9 @@ static const int default_intervals[] = { 1, 2, 4, 8, 16, 32, 64 };
> > > > >  static int *reconnect_intervals = NULL;
> > > > >  static size_t reconnect_intervals_len = 0;
> > > > >
> > > > > +static const int default_reconnect_delay = 5;
> > > > > +static int resume_reconnect_delay = 5;
> > > > > +
> > > > >  static GSList *reconnects = NULL;
> > > > >
> > > > >  static unsigned int service_id = 0;
> > > > > @@ -93,6 +96,8 @@ struct policy_data {
> > > > >         uint8_t ct_retries;
> > > > >         guint tg_timer;
> > > > >         uint8_t tg_retries;
> > > > > +
> > > > > +       bool reconnect_on_resume;
> > > > >  };
> > > > >
> > > > >  static struct reconnect_data *reconnect_find(struct btd_device *dev)
> > > > > @@ -214,6 +219,7 @@ static gboolean policy_connect_sink(gpointer user_data)
> > > > >
> > > > >         data->sink_timer = 0;
> > > > >         data->sink_retries++;
> > > > > +       data->reconnect_on_resume = false;
> > > > >
> > > > >         service = btd_device_get_service(data->dev, A2DP_SINK_UUID);
> > > > >         if (service != NULL)
> > > > > @@ -222,16 +228,20 @@ static gboolean policy_connect_sink(gpointer user_data)
> > > > >         return FALSE;
> > > > >  }
> > > > >
> > > > > -static void policy_set_sink_timer(struct policy_data *data)
> > > > > +static void policy_set_sink_timer_internal(struct policy_data *data, int timeout)
> > > > >  {
> > > > >         if (data->sink_timer > 0)
> > > > >                 g_source_remove(data->sink_timer);
> > > > >
> > > > > -       data->sink_timer = g_timeout_add_seconds(SINK_RETRY_TIMEOUT,
> > > > > -                                                       policy_connect_sink,
> > > > > +       data->sink_timer = g_timeout_add_seconds(timeout, policy_connect_sink,
> > > > >                                                         data);
> > > > >  }
> > > > >
> > > > > +static void policy_set_sink_timer(struct policy_data *data)
> > > > > +{
> > > > > +       policy_set_sink_timer_internal(data, SINK_RETRY_TIMEOUT);
> > > > > +}
> > > > > +
> > > > >  static void sink_cb(struct btd_service *service, btd_service_state_t old_state,
> > > > >                                                 btd_service_state_t new_state)
> > > > >  {
> > > > > @@ -743,10 +753,30 @@ static void reconnect_set_timer(struct reconnect_data *reconnect)
> > > > >  static void disconnect_cb(struct btd_device *dev, uint8_t reason)
> > > > >  {
> > > > >         struct reconnect_data *reconnect;
> > > > > +       struct btd_service *service;
> > > > > +       struct policy_data *data;
> > > > > +       bool do_reconnect = false;
> > > > >
> > > > >         DBG("reason %u", reason);
> > > > >
> > > > > -       if (reason != MGMT_DEV_DISCONN_TIMEOUT)
> > > > > +       switch(reason) {
> > > > > +       case MGMT_DEV_DISCONN_LOCAL_HOST:
> > > > > +       case MGMT_DEV_DISCONN_REMOTE:
> > > > > +               do_reconnect = true;
> > > > > +               break;
> > > > > +       /* Disconnect due to suspend will queue reconnect on resume for a2dp */
> > > > > +       case MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND:
> > > > > +               service = btd_device_get_service(dev, A2DP_SINK_UUID);
> > > > > +               if (service && (data = policy_get_data(dev))) {
> > > > > +                       data->reconnect_on_resume = true;
> > > > > +               }
> > > >
> > > > Can't we just program the timer directly here? Or would that wakeup
> > > > the system, I would imagine all timers are disabled while suspended
> > > > which means when the system resumes so does the timers which would
> > > > then trigger the reconnection logic.
> > >
> > > This approach works if every resume is user initiated and keeps the
> > > device awake long enough to reconnect to the audio device. On
> > > ChromeOS, this isn't always the case. We have a feature called Dark
> > > Resume that occurs when the system wakes to handle an event that
> > > doesn't require user intervention and suspends again without ever
> > > turning on the screen. See:
> > > https://chromium.googlesource.com/chromiumos/platform2/+/master/power_manager/docs/dark_resume.md.
> > > A primary user for this is a periodic wake-up that checks battery
> > > percentage and shuts down the system if it's too low.
> >
> > Ok I didn't know such a feature exists in ChromeOS, but doesn't Dark
> > Resumes should be handled by the kernel instead of each userspace
> > component? I suppose there quite a few timers that may have side
> > effects if dark resumes actually resume them.
> >
>
> I'm not aware of the history around it but I found another page with
> more context of use cases (like actually letting a user space
> application run as would happen on a smartphone):
> https://www.chromium.org/chromium-os/chromiumos-design-docs/lucid-sleep
>
> > > One of the tests I ran specifically for this is a suspend stress test
> > > with a wake time between 2-4s (i.e. suspend_stress_test -c 10
> > > --wake_min 2 --wake_max 3) which emulates dark resumes. If we set the
> > > timer when disconnecting, the device would attempt a connection on one
> > > of the wakeups and fail (since we suspended without completing the
> > > connection).
> >
> > We could perhaps check if the kernel is capable of emitting
> > suspend/resume events and if not just program the timer, or
> > alternatively add another config option to indicate when the system
> > supports such concept of Dark Resumes.
> >
>
> How does the following sound:
>
> * On disconnect, I always queue the reconnect but with the resume
> delay set instead of the interval[0] value. I also set the
> resume_reconnect flag
> * On every resume event (or dark resume event), I reset the timer and
> add resume_delay seconds if resume_reconnect is set
> * The first time the reconnect_timeout runs, I clear the resume_reconnect flag
>
> The delay will only be reapplied if the kernel is capable of emitting
> suspend/resume events and/or dark resume events.

That should work as well, does full resumes need to reset the timer
though? Or we don't have any means to identify the resume type? Well
either way I guess the difference would be quite small since the
timeout is the same just when it is programmed (on suspend vs on
resume).

> > > >
> > > > > +               break;
> > > > > +       /* All other cases do not result in reconnect */
> > > > > +       default:
> > > > > +               break;
> > > > > +       }
> > > > > +
> > > > > +       if (!do_reconnect)
> > > > >                 return;
> > > > >
> > > > >         reconnect = reconnect_find(dev);
> > > > > @@ -761,6 +791,23 @@ static void disconnect_cb(struct btd_device *dev, uint8_t reason)
> > > > >         reconnect_set_timer(reconnect);
> > > > >  }
> > > > >
> > > > > +static void controller_resume_cb(uint8_t wake_reason, const bdaddr_t *addr,
> > > > > +                                       const uint8_t addr_type)
> > > > > +{
> > > > > +       struct btd_device *dev;
> > > > > +       GSList *l;
> > > > > +
> > > > > +       /* Check if any devices needed to be reconnected on resume */
> > > > > +       for (l = devices; l; l = g_slist_next(l)) {
> > > > > +               struct policy_data *data = l->data;
> > > > > +
> > > > > +               if (data->reconnect_on_resume) {
> > > > > +                       policy_set_sink_timer_internal(data,
> > > > > +                                                      resume_reconnect_delay);
> > > > > +               }
> > > > > +       }
> > > > > +}
> > > > > +
> > > > >  static void conn_fail_cb(struct btd_device *dev, uint8_t status)
> > > > >  {
> > > > >         struct reconnect_data *reconnect;
> > > > > @@ -854,9 +901,17 @@ static int policy_init(void)
> > > > >         auto_enable = g_key_file_get_boolean(conf, "Policy", "AutoEnable",
> > > > >                                                                         NULL);
> > > > >
> > > > > +       resume_reconnect_delay = g_key_file_get_integer(
> > > > > +                       conf, "Policy", "ReconnectAudioDelay", &gerr);
> > > > > +
> > > > > +       if (gerr) {
> > > > > +               g_clear_error(&gerr);
> > > > > +               resume_reconnect_delay = default_reconnect_delay;
> > > > > +       }
> > > > >  done:
> > > > >         if (reconnect_uuids && reconnect_uuids[0] && reconnect_attempts) {
> > > > >                 btd_add_disconnect_cb(disconnect_cb);
> > > > > +               btd_add_controller_resume_cb(controller_resume_cb);
> > > > >                 btd_add_conn_fail_cb(conn_fail_cb);
> > > > >         }
> > > > >
> > > > > @@ -869,6 +924,7 @@ done:
> > > > >  static void policy_exit(void)
> > > > >  {
> > > > >         btd_remove_disconnect_cb(disconnect_cb);
> > > > > +       btd_remove_controller_resume_cb(controller_resume_cb);
> > > > >         btd_remove_conn_fail_cb(conn_fail_cb);
> > > > >
> > > > >         if (reconnect_uuids)
> > > > > diff --git a/src/adapter.c b/src/adapter.c
> > > > > index 5e896a9f0..7526feb9e 100644
> > > > > --- a/src/adapter.c
> > > > > +++ b/src/adapter.c
> > > > > @@ -139,6 +139,7 @@ static GSList *adapter_drivers = NULL;
> > > > >
> > > > >  static GSList *disconnect_list = NULL;
> > > > >  static GSList *conn_fail_list = NULL;
> > > > > +static GSList *controller_resume_list = NULL;
> > > > >
> > > > >  struct link_key_info {
> > > > >         bdaddr_t bdaddr;
> > > > > @@ -8766,6 +8767,45 @@ static void connected_callback(uint16_t index, uint16_t length,
> > > > >         eir_data_free(&eir_data);
> > > > >  }
> > > > >
> > > > > +static void controller_resume_notify(const uint8_t wake_reason,
> > > > > +                                       const bdaddr_t *addr,
> > > > > +                                       const uint8_t addr_type)
> > > > > +{
> > > > > +       GSList *l;
> > > > > +
> > > > > +       for (l = controller_resume_list; l; l = g_slist_next(l)) {
> > > > > +               btd_controller_resume_cb resume_cb = l->data;
> > > > > +               resume_cb(wake_reason, addr, addr_type);
> > > > > +       }
> > > > > +}
> > > > > +
> > > > > +static void controller_resume_callback(uint16_t index, uint16_t length,
> > > > > +                                      const void *param, void *user_data)
> > > > > +{
> > > > > +       const struct mgmt_ev_controller_resume *ev = param;
> > > > > +       struct btd_adapter *adapter = user_data;
> > > > > +
> > > > > +       if (length < sizeof(*ev)) {
> > > > > +               btd_error(adapter->dev_id, "Too small device resume event");
> > > > > +               return;
> > > > > +       }
> > > > > +
> > > > > +       DBG("Controller resume with wake event 0x%x", ev->wake_reason);
> > > > > +
> > > > > +       controller_resume_notify(ev->wake_reason, &ev->addr.bdaddr,
> > > > > +                                ev->addr.type);
> > > > > +}
> > > > > +
> > > > > +void btd_add_controller_resume_cb(btd_controller_resume_cb func)
> > > > > +{
> > > > > +       controller_resume_list = g_slist_append(controller_resume_list, func);
> > > > > +}
> > > > > +
> > > > > +void btd_remove_controller_resume_cb(btd_controller_resume_cb func)
> > > > > +{
> > > > > +       controller_resume_list = g_slist_remove(controller_resume_list, func);
> > > > > +}
> > > > > +
> > > > >  static void device_blocked_callback(uint16_t index, uint16_t length,
> > > > >                                         const void *param, void *user_data)
> > > > >  {
> > > > > @@ -9389,6 +9429,11 @@ static void read_info_complete(uint8_t status, uint16_t length,
> > > > >                                                 user_passkey_notify_callback,
> > > > >                                                 adapter, NULL);
> > > > >
> > > > > +       mgmt_register(adapter->mgmt, MGMT_EV_CONTROLLER_RESUME,
> > > > > +                                               adapter->dev_id,
> > > > > +                                               controller_resume_callback,
> > > > > +                                               adapter, NULL);
> > > > > +
> > > > >         set_dev_class(adapter);
> > > > >
> > > > >         set_name(adapter, btd_adapter_get_name(adapter));
> > > > > diff --git a/src/adapter.h b/src/adapter.h
> > > > > index f8ac20261..5527e4205 100644
> > > > > --- a/src/adapter.h
> > > > > +++ b/src/adapter.h
> > > > > @@ -67,6 +67,12 @@ typedef void (*btd_conn_fail_cb) (struct btd_device *device, uint8_t status);
> > > > >  void btd_add_conn_fail_cb(btd_conn_fail_cb func);
> > > > >  void btd_remove_conn_fail_cb(btd_conn_fail_cb func);
> > > > >
> > > > > +typedef void (*btd_controller_resume_cb)(const uint8_t wake_reason,
> > > > > +                                       const bdaddr_t *addr,
> > > > > +                                       const uint8_t addr_type);
> > > > > +void btd_add_controller_resume_cb(btd_controller_resume_cb func);
> > > > > +void btd_remove_controller_resume_cb(btd_controller_resume_cb func);
> > > >
> > > > If we can program the timer just before we suspend this is not really
> > > > necessary, but if you still thing that would be a good idea to notify
> > > > Id put it in btd_adapter_driver with a callback for suspend and
> > > > resume, that way we don't have to maintain multiple lists for each of
> > > > the callbacks.
> > >
> > > The adapter driver seems like a reasonable place to put this so let me
> > > port that over.
> > >
> > > >
> > > > >  struct btd_adapter *adapter_find(const bdaddr_t *sba);
> > > > >  struct btd_adapter *adapter_find_by_id(int id);
> > > > >  void adapter_foreach(adapter_cb func, gpointer user_data);
> > > > > diff --git a/src/main.c b/src/main.c
> > > > > index 2c083de67..a1c3e7e9f 100644
> > > > > --- a/src/main.c
> > > > > +++ b/src/main.c
> > > > > @@ -131,6 +131,7 @@ static const char *policy_options[] = {
> > > > >         "ReconnectAttempts",
> > > > >         "ReconnectIntervals",
> > > > >         "AutoEnable",
> > > > > +       "ReconnectAudioDelay",
> > > > >         NULL
> > > > >  };
> > > > >
> > > > > diff --git a/src/main.conf b/src/main.conf
> > > > > index f41203b96..8d74a2aec 100644
> > > > > --- a/src/main.conf
> > > > > +++ b/src/main.conf
> > > > > @@ -198,3 +198,12 @@
> > > > >  # This includes adapters present on start as well as adapters that are plugged
> > > > >  # in later on. Defaults to 'false'.
> > > > >  #AutoEnable=false
> > > > > +
> > > > > +# Audio devices that were disconnected due to suspend will be reconnected on
> > > > > +# resume. ReconnectAudioDelay determines the delay between when the controller
> > > > > +# resumes from suspend and a connection attempt is made. A longer delay can be
> > > > > +# better for co-existence with Wi-Fi.
> > > > > +# The value is in seconds.
> > > > > +# Default: 5
> > > > > +#ReconnectAudioDelay = 5
> > > > > +
> > > > > --
> > > > > 2.28.0.297.g1956fa8f8d-goog
> > > > >
> > > >
> > > >
> > > > --
> > > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
> Thanks,
> Abhishek



-- 
Luiz Augusto von Dentz
