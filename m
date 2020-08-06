Return-Path: <SRS0=ILT4=BQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E58DC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Aug 2020 03:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 001142086A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Aug 2020 03:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VpcB5IBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgHFDst (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgHFDss (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Aug 2020 23:48:48 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1FEC061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2020 20:48:48 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id p25so3289118qkp.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Aug 2020 20:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7+zYpV/8KSJzoPyXral7BRHxWQemzQJ45iKZeuf/8Ic=;
        b=VpcB5IBtErOIL7CZYsSzoR87GxbT0tfoyOtlxj0pZNzsUxbIybITtM+InDRqXyJEMg
         gjPEe0aRfQ9dtKsJ4lU9DzpZPxsBBjtj/jqbG9jCkbtTIBcGi0wH0kQY9QazJB734ObQ
         MVAt8j7GqQkW4oAUXp6H4tsNGO5OL4SjUcS5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7+zYpV/8KSJzoPyXral7BRHxWQemzQJ45iKZeuf/8Ic=;
        b=ZuSNQ2t9LnnujwZYR7IuiveVspadO75X5p0XxoiIftZMRFQAluH9H6zAiInSAIlMHe
         XWGPoKlvWfoKFQdTiXFd/XsUm3GA2HlZEK5+B4XKizza1B5azvxFmnmw8ZQUc7klZtZC
         IOaLhSU9PoDhXG7yOe3hv6GgBn8u0KVSDHp74Z7XNTjFL8fQ8rtVhXTcUx402GmcsAwb
         rTkBvQVNvKy8TGOm7J9udBos66NMiBCDSINetuJEaKn0ZirGh5jVTcsF9WEs7m2SplAA
         aOQJpn67KumOoz6Nzdr7MtVvZRCMFIp0/sDNNA+4xTA5sZgyebfcOTdmpYErMyPh4wDc
         P1tg==
X-Gm-Message-State: AOAM531/bksPYZyaF3ed8H8ummQTGt0u0N0qxtOzMH+82Q2IQj2XIMy5
        3dYCj53uCtV5OXWwf9tk+IjGpsUWu5/crsIFANG5qA==
X-Google-Smtp-Source: ABdhPJyoSQKE8nHeGlAA4xLPh7nVoXluGFdF6qwbCdq0yPkGBJ443BSldmJkhXxkAgGPV76qYBf6nLoAp8xu6nuz7CM=
X-Received: by 2002:a05:620a:144e:: with SMTP id i14mr6343030qkl.453.1596685727081;
 Wed, 05 Aug 2020 20:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200729015540.1848987-1-abhishekpandit@chromium.org>
 <5f20d725.1c69fb81.6d882.1d23@mx.google.com> <CABBYNZJMHCWm9-F3R1vpqcaazcieA=Dp9+fppQzmm+_-hfhzcw@mail.gmail.com>
In-Reply-To: <CABBYNZJMHCWm9-F3R1vpqcaazcieA=Dp9+fppQzmm+_-hfhzcw@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Wed, 5 Aug 2020 20:48:34 -0700
Message-ID: <CANFp7mVDnNCFm+sObXMwgAmV=uFAdeam-DM7eNd1rOTKUTf+hQ@mail.gmail.com>
Subject: Re: [RFC Bluez PATCH 3/3] adapter: Reconnect audio on controller resume
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, Aug 4, 2020 at 11:54 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Abhishek,
>
> On Tue, Jul 28, 2020 at 6:55 PM Abhishek Pandit-Subedi
> <abhishekpandit@chromium.org> wrote:
> >
> > During system suspend, all peer devices are disconnected. On resume, HID
> > devices will reconnect but audio devices stay disconnected. As a quality
> > of life improvement, keep track of the last audio device disconnected
> > during suspend and try to reconnect when the controller resumes from
> > suspend.
> >
> > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> > ---
> > Hey Luiz,
> >
> > On our internal review, two things stood out in this commit that we
> > weren't able to come to a consensus on internally:
> >
> > * Is it better to use the audio device class or should we compare to the
> >   A2DP, HFP and HSP uuids?
> > * Constructing the dbus message internally before calling dev_connect
> >   looks a bit weird. I couldn't figure out how to internally trigger
> >   this function (since it seems to require a msg to respond to on
> >   success/failure). Any thoughts?
> >
> >
> >  src/adapter.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  src/device.c  | 27 +++++++++++++++++
> >  src/device.h  |  2 ++
> >  src/main.conf |  6 ++++
> >  4 files changed, 117 insertions(+)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 5e896a9f0..b1073c439 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -90,6 +90,7 @@
> >  #define IDLE_DISCOV_TIMEOUT (5)
> >  #define TEMP_DEV_TIMEOUT (3 * 60)
> >  #define BONDING_TIMEOUT (2 * 60)
> > +#define RECONNECT_AUDIO_DELAY (5)
> >
> >  #define SCAN_TYPE_BREDR (1 << BDADDR_BREDR)
> >  #define SCAN_TYPE_LE ((1 << BDADDR_LE_PUBLIC) | (1 << BDADDR_LE_RANDOM))
> > @@ -269,6 +270,15 @@ struct btd_adapter {
> >         struct btd_device *connect_le;  /* LE device waiting to be connected */
> >         sdp_list_t *services;           /* Services associated to adapter */
> >
> > +       /* audio device to reconnect after resuming from suspend */
> > +       struct reconnect_audio_info {
> > +               bdaddr_t addr;
> > +               uint8_t addr_type;
> > +               bool reconnect;
> > +        } reconnect_audio;
> > +       guint reconnect_audio_timeout;  /* timeout for reconnect on resume */
> > +       uint32_t reconnect_audio_delay; /* delay reconnect after resume */
> > +
> >         struct btd_gatt_database *database;
> >         struct btd_adv_manager *adv_manager;
> >
> > @@ -6256,6 +6266,7 @@ static void load_config(struct btd_adapter *adapter)
> >         /* Get discoverable mode */
> >         adapter->stored_discoverable = g_key_file_get_boolean(key_file,
> >                                         "General", "Discoverable", &gerr);
> > +
> >         if (gerr) {
> >                 adapter->stored_discoverable = false;
> >                 g_error_free(gerr);
> > @@ -6271,6 +6282,16 @@ static void load_config(struct btd_adapter *adapter)
> >                 gerr = NULL;
> >         }
> >
> > +       /* Get audio reconnect delay */
> > +       adapter->reconnect_audio_delay = g_key_file_get_integer(
> > +               key_file, "General", "ReconnectAudioDelay", &gerr);
> > +
> > +       if (gerr) {
> > +               adapter->reconnect_audio_delay = RECONNECT_AUDIO_DELAY;
> > +               g_error_free(gerr);
> > +               gerr = NULL;
> > +       }
> > +
> >         g_key_file_free(key_file);
> >  }
> >
> > @@ -7820,6 +7841,15 @@ static void dev_disconnected(struct btd_adapter *adapter,
> >         if (device) {
> >                 adapter_remove_connection(adapter, device, addr->type);
> >                 disconnect_notify(device, reason);
> > +
> > +               if (reason == MGMT_DEV_DISCONN_LOCAL_HOST_SUSPEND &&
> > +                   device_class_is_audio(device)) {
> > +                       adapter->reconnect_audio.reconnect = true;
> > +                       adapter->reconnect_audio.addr_type =
> > +                               btd_device_get_bdaddr_type(device);
> > +                       bacpy(&adapter->reconnect_audio.addr,
> > +                             device_get_address(device));
> > +               }
> >         }
> >
> >         bonding_attempt_complete(adapter, &addr->bdaddr, addr->type,
> > @@ -8766,6 +8796,53 @@ static void connected_callback(uint16_t index, uint16_t length,
> >         eir_data_free(&eir_data);
> >  }
> >
> > +static gboolean reconnect_audio_timeout(gpointer user_data)
> > +{
> > +       struct btd_adapter *adapter = user_data;
> > +
> > +       adapter->reconnect_audio_timeout = 0;
> > +
> > +       if (adapter->reconnect_audio.reconnect) {
> > +               struct btd_device *dev = btd_adapter_find_device(
> > +                       adapter, &adapter->reconnect_audio.addr,
> > +                       adapter->reconnect_audio.addr_type);
> > +
> > +               adapter->reconnect_audio.reconnect = false;
> > +
> > +               if (!dev || btd_device_is_connected(dev))
> > +                       return FALSE;
> > +
> > +               device_internal_connect(dev);
> > +       }
> > +
> > +       return FALSE;
> > +}
> > +
> > +static void controller_resume_callback(uint16_t index, uint16_t length,
> > +                                      const void *param, void *user_data)
> > +{
> > +       const struct mgmt_ev_controller_resume *ev = param;
> > +       struct btd_adapter *adapter = user_data;
> > +
> > +       if (length < sizeof(*ev)) {
> > +               btd_error(adapter->dev_id, "Too small device resume event");
> > +               return;
> > +       }
> > +
> > +       DBG("Controller resume with wake event 0x%x", ev->wake_reason);
> > +
> > +       if (adapter->reconnect_audio_timeout > 0) {
> > +               g_source_remove(adapter->reconnect_audio_timeout);
> > +               adapter->reconnect_audio_timeout = 0;
> > +       }
> > +
> > +       if (adapter->reconnect_audio.reconnect) {
> > +               adapter->reconnect_audio_timeout =
> > +                       g_timeout_add_seconds(adapter->reconnect_audio_delay,
> > +                                             reconnect_audio_timeout, adapter);
> > +       }
> > +}
> > +
> >  static void device_blocked_callback(uint16_t index, uint16_t length,
> >                                         const void *param, void *user_data)
> >  {
> > @@ -9389,6 +9466,11 @@ static void read_info_complete(uint8_t status, uint16_t length,
> >                                                 user_passkey_notify_callback,
> >                                                 adapter, NULL);
> >
> > +       mgmt_register(adapter->mgmt, MGMT_EV_CONTROLLER_RESUME,
> > +                                               adapter->dev_id,
> > +                                               controller_resume_callback,
> > +                                               adapter, NULL);
> > +
> >         set_dev_class(adapter);
> >
> >         set_name(adapter, btd_adapter_get_name(adapter));
> > diff --git a/src/device.c b/src/device.c
> > index bb8e07e8f..8b165ffa4 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -747,6 +747,12 @@ gboolean device_is_trusted(struct btd_device *device)
> >         return device->trusted;
> >  }
> >
> > +bool device_class_is_audio(struct btd_device *device)
> > +{
> > +       /* Look for major service classes Audio (0x20) + Rendering (0x4) */
> > +       return ((device->class >> 16) & 0x24) == 0x24;
> > +}
> > +
> >  static gboolean dev_property_get_address(const GDBusPropertyTable *property,
> >                                         DBusMessageIter *iter, void *data)
> >  {
> > @@ -6853,6 +6859,27 @@ struct btd_service *btd_device_get_service(struct btd_device *dev,
> >         return NULL;
> >  }
> >
> > +/* Internal function to connect to a device. This fakes the dbus message used to
> > + * call the "Connect" api on the device so that the same function can be called
> > + * by bluez internally.
> > + */
> > +bool device_internal_connect(struct btd_device *dev)
> > +{
> > +       DBusMessage *msg;
> > +
> > +       if (!device_is_connectable(dev))
> > +               return false;
> > +
> > +       msg = dbus_message_new_method_call("org.bluez",
> > +                                               device_get_path(dev),
> > +                                               DEVICE_INTERFACE,
> > +                                               "Connect");
> > +       /* Sending the message usually sets serial. Fake it here. */
> > +       dbus_message_set_serial(msg, 1);
> > +
> > +       dev_connect(dbus_conn, msg, dev);
> > +}
> > +
> >  void btd_device_init(void)
> >  {
> >         dbus_conn = btd_get_dbus_connection();
> > diff --git a/src/device.h b/src/device.h
> > index 956fec1ae..82f97b5bd 100644
> > --- a/src/device.h
> > +++ b/src/device.h
> > @@ -98,6 +98,7 @@ bool device_is_connectable(struct btd_device *device);
> >  bool device_is_paired(struct btd_device *device, uint8_t bdaddr_type);
> >  bool device_is_bonded(struct btd_device *device, uint8_t bdaddr_type);
> >  gboolean device_is_trusted(struct btd_device *device);
> > +bool device_class_is_audio(struct btd_device *device);
> >  void device_set_paired(struct btd_device *dev, uint8_t bdaddr_type);
> >  void device_set_unpaired(struct btd_device *dev, uint8_t bdaddr_type);
> >  void btd_device_set_temporary(struct btd_device *device, bool temporary);
> > @@ -186,6 +187,7 @@ int btd_device_connect_services(struct btd_device *dev, GSList *services);
> >  uint32_t btd_device_get_current_flags(struct btd_device *dev);
> >  void btd_device_flags_changed(struct btd_device *dev, uint32_t supported_flags,
> >                               uint32_t current_flags);
> > +bool device_internal_connect(struct btd_device *dev);
> >
> >  void btd_device_init(void);
> >  void btd_device_cleanup(void);
> > diff --git a/src/main.conf b/src/main.conf
> > index f41203b96..c6bb78a84 100644
> > --- a/src/main.conf
> > +++ b/src/main.conf
> > @@ -82,6 +82,12 @@
> >  # 0 = disable timer, i.e. never keep temporary devices
> >  #TemporaryTimeout = 30
> >
> > +# How long to wait after controller resume before reconnecting to last used
> > +# audio device.
> > +# The value is in seconds.
> > +# Default: 5
> > +#ReconnectAudioDelay = 5
> > +
> >  [Controller]
> >  # The following values are used to load default adapter parameters.  BlueZ loads
> >  # the values into the kernel before the adapter is powered if the kernel
> > --
> > 2.28.0.rc0.142.g3c755180ce-goog
>
> Usually connection policy is handled by the policy plugin since there
> may be platforms that want implement their own connection policies on
> top of bluetoothd so they can just disable the policy plugin, iirc we
> do have reconnection policies for unexpected disconnect which should
> probably be used in the event a suspend actually trigger a
> disconnection see:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/plugins/policy.c#n761
>
> We might need a reason code to indicate to the policy when a
> disconnect happens due to suspend logic.

I am emitting a new reason code for disconnect (local disconnect due
to suspend, 0x5). If this is just passing through the reason from the
mgmt event, I can continue using that.

Will update this patch to use the policy plugin and send up another revision.

Thanks
Abhishek

>
> --
> Luiz Augusto von Dentz
