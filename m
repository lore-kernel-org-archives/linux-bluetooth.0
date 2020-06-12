Return-Path: <SRS0=RDM4=7Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAF1C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 05:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3415020838
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jun 2020 05:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KFow5A5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgFLF3s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Jun 2020 01:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgFLF3r (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Jun 2020 01:29:47 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A8AC03E96F
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2020 22:29:45 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c17so9628428lji.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2020 22:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tyQtMFfX4yF5dGLQFugj1JSc48bYkNtW1ynyqp3TsWE=;
        b=KFow5A5HtfYPrgkRHExvNTyzcFu3WHz1GzYm2duF0iExHx2q9FB20zXwhxI5VbnN/0
         Qlib6CD60whS5W21IzXnJv4Yw7FvJv0ks9imznZZV92RJ86zKh0NdJJQUHI4gjPdKN2Y
         BgcAy06qG3SAS1HLcc4dqUHdmlQ01cAW0XPeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tyQtMFfX4yF5dGLQFugj1JSc48bYkNtW1ynyqp3TsWE=;
        b=MGztFR35EotN1qguYmfURyGv5FgzzhSkL/HkU5qc0//Iq7fnZDndxJfPyS+sUD1mxB
         OwPl4T+O4cAU+QQ3YsZO5Qbp+0upuFoprLSc5oYB9RO3HAnfjLnLqmp/RQrdozdaGsN3
         SbNdd+l+zuFeePld2HcBSuUjn08mqHJWEVLW4F/1O6Pl/KdhIOto1fFEIQJ7cJZiXn3P
         Z2CVLFHzz7hD0db+PKGlOqIzTsMq+yueNGKmAYNy/kdqQeRq4Qq26laUSE420FCzCpBr
         rhvONHCdxm9JRAhELjVeWPgLivpkdcpvS9ot4i8qTwUaGXXM7yGQiCXWvUg6Z3BYFJCX
         5gsw==
X-Gm-Message-State: AOAM532x2B8O39srJ+vS5ggwScCF6gKu6IIeuuBzpMwzqEo4iVad7bdl
        yTW4WyvusKnMPG7VJ6su85fTr6wt340JRqZEToYklA==
X-Google-Smtp-Source: ABdhPJx3t7E/bLZmptSTXVwSFB/wgmHuuZ3euoyrb24A8z8ZFmIZfm5NsTn3dXI03TEbG7OAVOxqPbD9yM7VYf0qWuY=
X-Received: by 2002:a2e:8456:: with SMTP id u22mr5683647ljh.73.1591939783872;
 Thu, 11 Jun 2020 22:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200608180241.BlueZ.v1.1.Ibf8331f6c835d53fe7ca978de962f93981573d9a@changeid>
 <CACumGOKqrBQJzYt_ayW6KRmu9QKCCPYiojdozvGwO3yTR-2Jyg@mail.gmail.com>
 <CACumGOKyAfdgP6t4PnNBzmVmFayV4b3gPOjux3aGg_de2T104g@mail.gmail.com>
 <CABmPvSE_wwju1pe7tZoZHywF7oAz8OvJCbebE4gZOe5OHVaLpg@mail.gmail.com>
 <CACumGO+iuMkMhZkfP7DyFvXSDyU-M2RMVc7cN1-pfHTh95CyUg@mail.gmail.com> <CABBYNZ+mV6Ge18=k6WEcS=9=_xNTj=SC1-McVkOAbb9az2bdQA@mail.gmail.com>
In-Reply-To: <CABBYNZ+mV6Ge18=k6WEcS=9=_xNTj=SC1-McVkOAbb9az2bdQA@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Thu, 11 Jun 2020 22:29:32 -0700
Message-ID: <CABmPvSG3FA0kFCHmLOnXNePX--Yq7yGB7-TtJzXXYdDtgufGzw@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] adapter: Fix the unref and reset of
 watch_client's members
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        Michael Sun <michaelfsun@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thanks for the update! Feel free to drop this patch if you've verified
it working. Here is how I verified my original changes for unref and
reset.
1) Intentionally changed the MGMT status other than MGMT_STATUS_SUCCESS
    in stop_discovery_complete() and start_discovery_complete() and built
    bluetoothd.
(2) In bluetoothctl console, issued scan on/scan off to invoke
    StartDiscovery and verified that new discovery requests can be processed.

For the use-after_free crash, I will take a look at the new patches.

Regards,
Miao

On Thu, Jun 11, 2020 at 2:02 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Miao,
>
> On Thu, Jun 11, 2020 at 12:18 PM Von Dentz, Luiz
> <luiz.von.dentz@intel.com> wrote:
> >
> > Hi Miao,
> >
> > On Wed, Jun 10, 2020 at 3:18 PM Miao-chen Chou <mcchou@chromium.org> wrote:
> > >
> > > Hi Luiz,
> > >
> > > For 0001-adapter-Do-not-remove-client-watch-directly-if-disco.patch,
> > > it looks good to me.
> > > For 0002-adapter-Consolitate-code-for-discovery-reply.patch, please
> > > see me following comments.
> > >
> > > +static void discovery_reply(struct watch_client *client, uint8_t status)
> > > +{
> > > +       DBusMessage *reply;
> > > +
> > > +       if (!client->msg)
> > > +               return;
> > > +
> > > +       if (!status) {
> > > It'd better to change this to "if (status == MGMT_STATUS_SUCCESS) {".
> > > +               g_dbus_send_reply(dbus_conn, client->msg, DBUS_TYPE_INVALID);
> > > +       } else  {
> > > +               reply = btd_error_busy(client->msg);
> > > +               g_dbus_send_message(dbus_conn, reply);
> > > +       }
> > > +
> > > +       dbus_message_unref(client->msg);
> > > +       client->msg = NULL;
> > > +}
> > > I also notice that we treated the status other than
> > > MGMT_STATUS_SUCCESS to be busy, but this can be addressed as a
> > > separate patch.
> >
> > Wasn't that the error we were generating before? Afaik both start and
> > stop discovery were doing the same in this regard.
> >
> > > For 0003-adapter-Fix-possible-crash-when-stopping-discovery.patch, I
> > > had few comments here.
> > > (1) I didn't see the corresponding changes to pass the pointer of the
> > > adapter as the user data when sending MGMT_OP_STOP_DISCOVERY command.
> > > Should it be part of the patch?
> >
> > Yep, it should be fixed now.
> >
> > > (2) This does resolve the crashing due to use-after-free of a
> > > watch_client. However, the following logic doesn't seem to be correct
> > > to me. If you recall the call path that we discussed, which is
> > > "client1 start_discovery() -> client1 start_discovery_complete() ->
> > > client1 stop_discovery() -> client2 start_discovery() -> client1
> > > detach from D-Bus which triggers discovery_disconnect() -> client1
> > > stop_discovery_complete() -> crash)",
> > > when client2 starts the discovery, client2 is added to
> > > adapter->discovery_list, so once stop_discovery_complete() is called
> > > with client1, client2 is the only client in adapter->discovery_list.
> > > And this statement remains true even with this patch. That being said,
> > > the following "client = adapter->discovery_list->data" would return
> > > client2, which is not supposed to be replied by
> > > stop_discovery_complete() issued by client1. Agree?
> >
> > Yep, that will need tracking of the client who initiated the
> > operation, I will send a patch for that later today.
>
> Ive pushed a couple more fixes to track better the clients:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=227cfdf8e01f639f74b36b179f8ccf9a2061e932
>
> I was not able to reproduce this race condition anymore, although I
> was only able to reproduce when doing start discovery and quitting
> bluetoothctl before the response.
>
> > > +       if (!adapter->discovery_list)
> > > +               return;
> > > +
> > > +       client = adapter->discovery_list->data;
> > >
> > > Thanks,
> > > Miao
> > >
> > > On Tue, Jun 9, 2020 at 2:25 PM Von Dentz, Luiz <luiz.von.dentz@intel.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > >
> > > > On Mon, Jun 8, 2020 at 6:11 PM Von Dentz, Luiz <luiz.von.dentz@intel.com> wrote:
> > > > >
> > > > > Hi Miao,
> > > > >
> > > > > On Mon, Jun 8, 2020 at 6:03 PM Miao-chen Chou <mcchou@chromium.org> wrote:
> > > > >>
> > > > >> This properly handles the unref of client->msg in
> > > > >> stop_discovery_complete() and the reset of it. This also handles the unref
> > > > >> of client->msg, the reset of client->watch and the reset of client->msg in
> > > > >> start_discovery_complete().
> > > > >>
> > > > >> The following test was performed:
> > > > >> (1) Intentionally changed the MGMT status other than MGMT_STATUS_SUCCESS
> > > > >> in stop_discovery_complete() and start_discovery_complete() and built
> > > > >> bluetoothd.
> > > > >> (2) In bluetoothctl console, issued scan on/scan off to invoke
> > > > >> StartDiscovery and verified that new discovery requests can be processed.
> > > > >>
> > > > >> Reviewed-by: Alain Michaud <alainm@chromium.org>
> > > > >> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> > > > >> ---
> > > > >>
> > > > >>  src/adapter.c | 5 +++++
> > > > >>  1 file changed, 5 insertions(+)
> > > > >>
> > > > >> diff --git a/src/adapter.c b/src/adapter.c
> > > > >> index 76acfea70..0857a3115 100644
> > > > >> --- a/src/adapter.c
> > > > >> +++ b/src/adapter.c
> > > > >> @@ -1652,6 +1652,9 @@ fail:
> > > > >>                 reply = btd_error_busy(client->msg);
> > > > >>                 g_dbus_send_message(dbus_conn, reply);
> > > > >>                 g_dbus_remove_watch(dbus_conn, client->watch);
> > > > >
> > > > >
> > > > > We shouldn't be removing the watch directly since the client may have registered filters so we let discovery_remove do it by calling discovery_free if necessary.
> > > > >
> > > > >>
> > > > >> +               client->watch = 0;
> > > > >> +               dbus_message_unref(client->msg);
> > > > >> +               client->msg = NULL;
> > > > >>                 discovery_remove(client, false);
> > > > >>                 return;
> > > > >>         }
> > > > >> @@ -1926,6 +1929,8 @@ static void stop_discovery_complete(uint8_t status, uint16_t length,
> > > > >>                 if (client->msg) {
> > > > >>                         reply = btd_error_busy(client->msg);
> > > > >>                         g_dbus_send_message(dbus_conn, reply);
> > > > >> +                       dbus_message_unref(client->msg);
> > > > >> +                       client->msg = NULL;
> > > > >>                 }
> > > > >>                 goto done;
> > > > >>         }
> > > > >> --
> > > > >> 2.26.2
> > > > >
> > > > >
> > > > > Ive sent similar fixes upstream, let me attach them here just in case.
> > > >
> > > > Any comments on these changes, I would like to push them as soon as possible.
>
>
>
> --
> Luiz Augusto von Dentz
