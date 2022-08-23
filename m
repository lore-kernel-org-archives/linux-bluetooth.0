Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CE7C28D13
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Aug 2022 00:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbiHWA26 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 20:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237871AbiHWA25 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 20:28:57 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2A11CB0F
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 17:28:56 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id q2so13903938edb.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 17:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3PqTa4Wf3v0Bl4Y/+nYhv4ari+wLY1mF7jRZbgByGrg=;
        b=nmMR+eeL/3d90s+8VJK5wm/77hiOmyGtrj9lcDLyz1PlqdnR+v4qqSQrM6bp44jNhF
         zTpiQgdkSE1SymvikOeeWYzW5FojQOeU5NlRMIMGBI46+avH88Qy/9L+OCbBCUDhsnab
         +T0NyBpq2XLxvpoDU6iLKvkah4Fr8Mfy/wgfbqcC90yIY2zvUGw0lpDCaQhOWkjlq1sZ
         VygqtLihVy5S60l+tJUIW1N20LCc8NMFUPzrwLqU59tvnJWNL6pO13wjgN3wkRxa2q2o
         6Xv8XWRUKga5GitDf0gJlDPZlDGCLL/qQmGY7vqN10q2SBMp5fuRjvG9s9iuZs+aQ/ZX
         vAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3PqTa4Wf3v0Bl4Y/+nYhv4ari+wLY1mF7jRZbgByGrg=;
        b=Nc1T+eZEIESSjIQic08Lmy7c86WGV+7yt+2vBHhEmNr+9BV/NWYXzISzWstqoX+NlA
         6cSO7aADwLhAiYKIaJ24eogEDcc67wkMgjg7RLhtYMr6N47xmwnL5kMtGl+0iRyst3mf
         GKYHcZQSLd93MUEIBaGRLlUnK06VkO0u5uxXBjdgfjUwPfJ7k5eY13rqWsj6ThTJsaNs
         yQnl9rLkn9a76oRnDd89OIlauYEU2Lom4AzF/YZeL3JphhbWPneWStbtHR/UTN52fT9j
         uUeQvtW3M1OjFO28bgBFAvtB8PhZGf8zwnYjbvH49F5EXBQo03ZtOBCNHg9t4QdYez4F
         xT0w==
X-Gm-Message-State: ACgBeo0ruSw4Auy71zE3PP/b/b5G6mamvNEqS3Jem+SEPdYAt2g3MzSn
        3a9baT5E3zPKdTHWp9Q6ImD69lSyNllX+jl2ak6PGw==
X-Google-Smtp-Source: AA6agR5JM9qwTs3Mrn2cjDLLQWe0uceL1LQWp/0ghm0diMC6/+YMvmB7kENDNT12nV2JiubZpL3RuZ+YUVQGfKMzOXQ=
X-Received: by 2002:a05:6402:f29:b0:446:6629:bbb6 with SMTP id
 i41-20020a0564020f2900b004466629bbb6mr1357155eda.384.1661214534890; Mon, 22
 Aug 2022 17:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220822125221.Bluez.1.I541cbea9d6295f531c796bf3bda96b22db76bc19@changeid>
 <CABBYNZJUgTNazWNQUEsVxufkpX5g39iom-DKZqX2eTQQA+RA=A@mail.gmail.com>
In-Reply-To: <CABBYNZJUgTNazWNQUEsVxufkpX5g39iom-DKZqX2eTQQA+RA=A@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 23 Aug 2022 08:28:43 +0800
Message-ID: <CAJQfnxE4dgXZYHcS0PR6yFAHa4FZhqkTPk+jhg-Xe6Ps9NbOpA@mail.gmail.com>
Subject: Re: [Bluez PATCH] adapter: Reset pending settings when receiving MGMT error
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, 23 Aug 2022 at 06:54, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Sun, Aug 21, 2022 at 11:33 PM Archie Pusaka <apusaka@google.com> wrote:
> >
> > Hi Paul,
> >
> > On Mon, 22 Aug 2022 at 14:15, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> > >
> > > Dear Archie,
> > >
> > >
> > > Thank you for the patch.
> > >
> > >
> > > Am 22.08.22 um 06:53 schrieb Archie Pusaka:
> > > > From: Archie Pusaka <apusaka@chromium.org>
> > >
> > > I think the tag in the email subject needs to be [PATCH BlueZ] to be
> > > detected by the build bot.
> >
> > Is the bot the one who just commented about the test result? If so
> > probably it can detect this format as well.
> > >
> > > > We set the pending settings flag when sending MGMT_SETTING_*
> > > > commands to the MGMT layer and clear them when receiving success
> > > > reply, but we don't clear them when receiving error reply. This
> > > > might cause a setting to be stuck in pending state.
> > >
> > > Were you able to reproduce a problem on real hardware?
> >
> > I only received some reports, but unfortunately I cannot repro on real
> > hardware. The symptom is BlueZ can't be turned off, snoop logs shows
> > that MGMT_OP_SET_POWERED fails to be sent, and we are stuck with it
> > since the next commands to toggle power are ignored.
>
> Weird how can you tell MGMT_OP_SET_POWERED fails to be sent or you
> meant it was sent but the kernel returned an error? It would be great
> to include these errors.

Yeah, the kernel returned an error, NOT_AUTHORIZED If I remembered
correctly. It was caused by a timed out disconnection procedure, so
it's weird that the return value is NOT_AUTHORIZED, but I didn't check
why.
Will include this in the commit message.

On Tue, 23 Aug 2022 at 06:51, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Sun, Aug 21, 2022 at 9:54 PM Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > We set the pending settings flag when sending MGMT_SETTING_*
> > commands to the MGMT layer and clear them when receiving success
> > reply, but we don't clear them when receiving error reply. This
> > might cause a setting to be stuck in pending state.
> >
> > Therefore, also clear the pending flag when receiving error.
> > Furthermore, this patch also postpone setting the pending flag
> > until we queue the MGMT command in order to avoid setting it too
> > soon but we return early.
> >
> > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> >
> > ---
> >
> >  src/adapter.c | 45 +++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 37 insertions(+), 8 deletions(-)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index ec26aab1a7..4da1fcc3e5 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -640,14 +640,21 @@ static void new_settings_callback(uint16_t index, uint16_t length,
> >         settings_changed(adapter, settings);
> >  }
> >
> > +struct set_mode_data {
> > +       struct btd_adapter *adapter;
> > +       uint32_t setting;
> > +};
> > +
> >  static void set_mode_complete(uint8_t status, uint16_t length,
> >                                         const void *param, void *user_data)
> >  {
> > -       struct btd_adapter *adapter = user_data;
> > +       struct set_mode_data *data = user_data;
> > +       struct btd_adapter *adapter = data->adapter;
> >
> >         if (status != MGMT_STATUS_SUCCESS) {
> >                 btd_error(adapter->dev_id, "Failed to set mode: %s (0x%02x)",
> >                                                 mgmt_errstr(status), status);
> > +               adapter->pending_settings &= ~data->setting;
> >                 return;
> >         }
> >
> > @@ -677,6 +684,7 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
> >  {
> >         struct mgmt_mode cp;
> >         uint32_t setting = 0;
> > +       struct set_mode_data *data;
> >
> >         memset(&cp, 0, sizeof(cp));
> >         cp.val = mode;
> > @@ -699,15 +707,23 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
> >                 break;
> >         }
> >
> > -       adapter->pending_settings |= setting;
> > -
> >         DBG("sending set mode command for index %u", adapter->dev_id);
> >
> > +       data = g_try_new0(struct set_mode_data, 1);
>
> Use new0 instead of g_try_new0.

Hmm, we use g_try_new0 in property_set_mode() though, so I thought I
should follow.
But anyway, will change to g_new0.
>
> > +       if (!data)
> > +               goto failed;
> > +
> > +       data->adapter = adapter;
> > +       data->setting = setting;
> > +
> >         if (mgmt_send(adapter->mgmt, opcode,
> >                                 adapter->dev_id, sizeof(cp), &cp,
> > -                               set_mode_complete, adapter, NULL) > 0)
> > +                               set_mode_complete, data, g_free) > 0) {
> > +               adapter->pending_settings |= setting;
> >                 return true;
> > +       }
> >
> > +failed:
> >         btd_error(adapter->dev_id, "Failed to set mode for index %u",
> >                                                         adapter->dev_id);
> >
> > @@ -718,6 +734,7 @@ static bool set_discoverable(struct btd_adapter *adapter, uint8_t mode,
> >                                                         uint16_t timeout)
> >  {
> >         struct mgmt_cp_set_discoverable cp;
> > +       struct set_mode_data *data;
> >
> >         memset(&cp, 0, sizeof(cp));
> >         cp.val = mode;
> > @@ -734,11 +751,19 @@ static bool set_discoverable(struct btd_adapter *adapter, uint8_t mode,
> >                                                                         mode);
> >         }
> >
> > +       data = g_try_new0(struct set_mode_data, 1);
> > +       if (!data)
> > +               goto failed;
> > +
> > +       data->adapter = adapter;
> > +       data->setting = 0;
> > +
> >         if (mgmt_send(adapter->mgmt, MGMT_OP_SET_DISCOVERABLE,
> >                                 adapter->dev_id, sizeof(cp), &cp,
> > -                               set_mode_complete, adapter, NULL) > 0)
> > +                               set_mode_complete, data, g_free) > 0)
> >                 return true;
> >
> > +failed:
> >         btd_error(adapter->dev_id, "Failed to set mode for index %u",
> >                                                         adapter->dev_id);
>
> Looks like the data pointer is leaked in case it fails to be sent/queued.

Sorry, my bad. Will fix this.
>
> > @@ -2877,6 +2902,7 @@ static gboolean property_get_mode(struct btd_adapter *adapter,
> >
> >  struct property_set_data {
> >         struct btd_adapter *adapter;
> > +       uint32_t setting;
> >         GDBusPendingPropertySet id;
> >  };
> >
> > @@ -2901,6 +2927,8 @@ static void property_set_mode_complete(uint8_t status, uint16_t length,
> >
> >                 g_dbus_pending_property_error(data->id, dbus_err,
> >                                                         mgmt_errstr(status));
> > +
> > +               adapter->pending_settings &= ~data->setting;
> >                 return;
> >         }
> >
> > @@ -2969,8 +2997,6 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
> >
> >         mode = (enable == TRUE) ? 0x01 : 0x00;
> >
> > -       adapter->pending_settings |= setting;
> > -
> >         switch (setting) {
> >         case MGMT_SETTING_POWERED:
> >                 opcode = MGMT_OP_SET_POWERED;
> > @@ -3024,11 +3050,14 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
> >                 goto failed;
> >
> >         data->adapter = adapter;
> > +       data->setting = setting;
> >         data->id = id;
> >
> >         if (mgmt_send(adapter->mgmt, opcode, adapter->dev_id, len, param,
> > -                       property_set_mode_complete, data, g_free) > 0)
> > +                       property_set_mode_complete, data, g_free) > 0) {
> > +               adapter->pending_settings |= setting;
> >                 return;
> > +       }
> >
> >         g_free(data);
> >
> > --
> > 2.37.1.595.g718a3a8f04-goog
>
> --
> Luiz Augusto von Dentz

Thanks,
Archie
