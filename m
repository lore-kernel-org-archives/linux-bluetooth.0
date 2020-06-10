Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880C7C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 22:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 514C92072E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 22:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LlXS6q1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgFJWSL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgFJWSL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 18:18:11 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DABC03E96B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 15:18:10 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a9so4513275ljn.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 15:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=joN/NypMEb5B3vAjvRuQgl8f961A77Cll7A6oEoPNR0=;
        b=LlXS6q1YHBr9aToc+tYDsESfV1pu+vjA6+kraT1OiPIv3If8pviBMXOUIzdf5PGEkr
         O19uFXHKU85MMNFR/JzbacQk9/5RmKFSqADEGsydSOp1axbRxny8BA5lt7y0lTJ/VWhs
         a72jcG0QVzm2aklINzM65AWa7kVHF8B66R3p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=joN/NypMEb5B3vAjvRuQgl8f961A77Cll7A6oEoPNR0=;
        b=YuqGZgAqVcEjBJE5x/KxJdmHOgI06NeEaxK2Ha4b1DW+meLKQXEY/Gb23w/ai8MtwX
         OwQ3tF6MeZXW/BK7UCvQZf6gXq3O0xJmxpUoY0Rh22cU4THC8J22lmml9MfAlz07aI2x
         OQywJZk2emjM3TRj/9vWakzoL8SVgtAwYKmdHSihR258iAFqzwmnqql+Hj8OHGrbfvZu
         fS3G/xOWAyacXQWfpkyY/jRXYsU9lfPRwHY+pmoE8VyfVcPI8gzz6+it4Qq2hn8VvKgy
         gDVI5sQpm1vXz7ewPJSbITgjfKaOQgoFh3//HaI+Sb0Yl6dO9Y4hZJazuFlRwc1K9xCP
         +qAw==
X-Gm-Message-State: AOAM531zyux5cGoqwl59NJYOWB3VUVzNj2cX0EJsgqJ4kH2nsVuSv9zM
        hSaV7ySTcBqMQuRLVP1WaPARZuWLo3uf/skpdIur0g==
X-Google-Smtp-Source: ABdhPJzUE3Un/+FNrNx346o6rUAMWwizng/OriL22nIvH5O2hS+VgUUWTt41TZTKE321n68azkqFVKojb1Rj6VMEoRo=
X-Received: by 2002:a05:651c:10f:: with SMTP id a15mr2673341ljb.190.1591827489292;
 Wed, 10 Jun 2020 15:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200608180241.BlueZ.v1.1.Ibf8331f6c835d53fe7ca978de962f93981573d9a@changeid>
 <CACumGOKqrBQJzYt_ayW6KRmu9QKCCPYiojdozvGwO3yTR-2Jyg@mail.gmail.com> <CACumGOKyAfdgP6t4PnNBzmVmFayV4b3gPOjux3aGg_de2T104g@mail.gmail.com>
In-Reply-To: <CACumGOKyAfdgP6t4PnNBzmVmFayV4b3gPOjux3aGg_de2T104g@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Wed, 10 Jun 2020 15:17:58 -0700
Message-ID: <CABmPvSE_wwju1pe7tZoZHywF7oAz8OvJCbebE4gZOe5OHVaLpg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] adapter: Fix the unref and reset of
 watch_client's members
To:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
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

For 0001-adapter-Do-not-remove-client-watch-directly-if-disco.patch,
it looks good to me.
For 0002-adapter-Consolitate-code-for-discovery-reply.patch, please
see me following comments.

+static void discovery_reply(struct watch_client *client, uint8_t status)
+{
+       DBusMessage *reply;
+
+       if (!client->msg)
+               return;
+
+       if (!status) {
It'd better to change this to "if (status == MGMT_STATUS_SUCCESS) {".
+               g_dbus_send_reply(dbus_conn, client->msg, DBUS_TYPE_INVALID);
+       } else  {
+               reply = btd_error_busy(client->msg);
+               g_dbus_send_message(dbus_conn, reply);
+       }
+
+       dbus_message_unref(client->msg);
+       client->msg = NULL;
+}
I also notice that we treated the status other than
MGMT_STATUS_SUCCESS to be busy, but this can be addressed as a
separate patch.

For 0003-adapter-Fix-possible-crash-when-stopping-discovery.patch, I
had few comments here.
(1) I didn't see the corresponding changes to pass the pointer of the
adapter as the user data when sending MGMT_OP_STOP_DISCOVERY command.
Should it be part of the patch?
(2) This does resolve the crashing due to use-after-free of a
watch_client. However, the following logic doesn't seem to be correct
to me. If you recall the call path that we discussed, which is
"client1 start_discovery() -> client1 start_discovery_complete() ->
client1 stop_discovery() -> client2 start_discovery() -> client1
detach from D-Bus which triggers discovery_disconnect() -> client1
stop_discovery_complete() -> crash)",
when client2 starts the discovery, client2 is added to
adapter->discovery_list, so once stop_discovery_complete() is called
with client1, client2 is the only client in adapter->discovery_list.
And this statement remains true even with this patch. That being said,
the following "client = adapter->discovery_list->data" would return
client2, which is not supposed to be replied by
stop_discovery_complete() issued by client1. Agree?

+       if (!adapter->discovery_list)
+               return;
+
+       client = adapter->discovery_list->data;

Thanks,
Miao

On Tue, Jun 9, 2020 at 2:25 PM Von Dentz, Luiz <luiz.von.dentz@intel.com> wrote:
>
> Hi,
>
>
> On Mon, Jun 8, 2020 at 6:11 PM Von Dentz, Luiz <luiz.von.dentz@intel.com> wrote:
> >
> > Hi Miao,
> >
> > On Mon, Jun 8, 2020 at 6:03 PM Miao-chen Chou <mcchou@chromium.org> wrote:
> >>
> >> This properly handles the unref of client->msg in
> >> stop_discovery_complete() and the reset of it. This also handles the unref
> >> of client->msg, the reset of client->watch and the reset of client->msg in
> >> start_discovery_complete().
> >>
> >> The following test was performed:
> >> (1) Intentionally changed the MGMT status other than MGMT_STATUS_SUCCESS
> >> in stop_discovery_complete() and start_discovery_complete() and built
> >> bluetoothd.
> >> (2) In bluetoothctl console, issued scan on/scan off to invoke
> >> StartDiscovery and verified that new discovery requests can be processed.
> >>
> >> Reviewed-by: Alain Michaud <alainm@chromium.org>
> >> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> >> ---
> >>
> >>  src/adapter.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/src/adapter.c b/src/adapter.c
> >> index 76acfea70..0857a3115 100644
> >> --- a/src/adapter.c
> >> +++ b/src/adapter.c
> >> @@ -1652,6 +1652,9 @@ fail:
> >>                 reply = btd_error_busy(client->msg);
> >>                 g_dbus_send_message(dbus_conn, reply);
> >>                 g_dbus_remove_watch(dbus_conn, client->watch);
> >
> >
> > We shouldn't be removing the watch directly since the client may have registered filters so we let discovery_remove do it by calling discovery_free if necessary.
> >
> >>
> >> +               client->watch = 0;
> >> +               dbus_message_unref(client->msg);
> >> +               client->msg = NULL;
> >>                 discovery_remove(client, false);
> >>                 return;
> >>         }
> >> @@ -1926,6 +1929,8 @@ static void stop_discovery_complete(uint8_t status, uint16_t length,
> >>                 if (client->msg) {
> >>                         reply = btd_error_busy(client->msg);
> >>                         g_dbus_send_message(dbus_conn, reply);
> >> +                       dbus_message_unref(client->msg);
> >> +                       client->msg = NULL;
> >>                 }
> >>                 goto done;
> >>         }
> >> --
> >> 2.26.2
> >
> >
> > Ive sent similar fixes upstream, let me attach them here just in case.
>
> Any comments on these changes, I would like to push them as soon as possible.
