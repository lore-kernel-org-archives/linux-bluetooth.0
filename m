Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290AAC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 19:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACEA62072E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 19:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbhADTRs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Jan 2021 14:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbhADTRs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Jan 2021 14:17:48 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12518C061574
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Jan 2021 11:17:08 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id n42so27027804ota.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Jan 2021 11:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nze1ZRTi+lPJcZAgMNp3yfEhtMgfJ/GjrSo00A5e/Eg=;
        b=fXVPRKC1SNuzwpwAJ6mp8qISZnupIHbWS5uTj8K9/nJJczYh11qS4yhEBlhlkosW1+
         dHjPPLTLEAb32wWpqsO9zWW+iKcTVH2OszHDhLxOTJ3BjED4qVJOOQQ1Po5C588twQbi
         KYz9xSMfWsl+UTpuDSqJMcUKapeVmDqJGzVDgom2htprczMFApaOZG7W03H7I80IYjIk
         q5NZmQxjKF09avcWg5Pq+cNjV6D2x+/sdgXLVCkYYc0NsWZrgB5Fw4RSeilYvzgVP46c
         +S/dVy+x3FJbsE6Hp2aTzSZ3z/5VcV/gJwewTUpa32ua1wfbsng3DOmQOID9aknu8xLe
         awQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nze1ZRTi+lPJcZAgMNp3yfEhtMgfJ/GjrSo00A5e/Eg=;
        b=FZZ1WVumHZ0y8A6rROpKpxclXy9KaCHJLS3PWcXixUWiu1oyVUEH6IkKFtv48StF47
         RJYeVfXuG92tVOkoV+ZBWkBDDGKdbJ7UqV8wqpglgIWBX7daQm8vfP+lLN/0IXEliz+2
         3gac0Fy4NWnG6lMk5vyKo0w3j+xaKpMSWtvM811O4MN2SWnixx6jrI5l7EL9cQjuG99Q
         Sov3DriNGJsg/5YH3/tW9R78gKVtq27CMTivejiLZxZLUUSdZNH+3IWcCTygYVcdlT1x
         IS50sOt7z1pJQJv6rIGuF8fXvsApmmcA9H6KVihpVIH5SGDxsFP82j2VO1VupL+pJ4le
         C0Zw==
X-Gm-Message-State: AOAM533jyFCaFDgJvjDvy+QoZP0xtt/K571Pr5Rr7w22aHSr2MT3KRHj
        TN4GGPIdisNCThHOlf6Oc8w2KfPg+7DwzzJxsWA=
X-Google-Smtp-Source: ABdhPJzPPp7zHfLf0EgMzlyAbx0Q/he611a5S9kwG4aQ6MNDMIZ+06gmc1UJeS1V5IpCDcB0RER/r732VmT5aYxv/Ws=
X-Received: by 2002:a05:6830:1319:: with SMTP id p25mr55367617otq.240.1609787827491;
 Mon, 04 Jan 2021 11:17:07 -0800 (PST)
MIME-Version: 1.0
References: <20201229143408.Bluez.v1.1.I7978a075910600058245dc6891c614cf4c7b004e@changeid>
 <CABBYNZJ8HOLJv6HFCCp1AYMw79nu7rpkQdmLLJR=uvC5CRH03w@mail.gmail.com>
In-Reply-To: <CABBYNZJ8HOLJv6HFCCp1AYMw79nu7rpkQdmLLJR=uvC5CRH03w@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 4 Jan 2021 11:16:56 -0800
Message-ID: <CABBYNZL1TuDtSmyYxwK6uCLk8fm8U2jwxPi0aERsoUgAATeL0A@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] adapter: Don't remove device if adapter is
 powered off
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Mon, Jan 4, 2021 at 11:09 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Mon, Dec 28, 2020 at 10:34 PM Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > If adapter is powered off when a device is being removed, there is a
> > possibility that the kernel couldn't clean the device's information,
> > for example the pairing information. This causes the kernel to
> > disagree with the user space about whether the device is paired.
> >
> > Therefore, to avoid discrepancy we must not proceed to remove the
> > device within the user space as well.
>
> This sounds like we have a bug in the kernel, aren't we calling
> btd_adapter_remove_bonding or is that failing if the adapter is not
> powered? Hmm it does like it:
>
> This command can only be used when the controller is powered.
>
> > Reviewed-by: Daniel Winkler <danielwinkler@google.com>
> > ---
> >
> >  src/adapter.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index ec6a6a64c5..a2abc46706 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -1238,6 +1238,14 @@ void btd_adapter_remove_device(struct btd_adapter *adapter,
> >  {
> >         GList *l;
> >
> > +       /* Test if adapter is or will be powered off.
> > +        * This is to prevent removing the device information only on user
> > +        * space, but failing to do so on the kernel.
> > +        */
> > +       if (!(adapter->current_settings & MGMT_SETTING_POWERED) ||
> > +                       (adapter->pending_settings & MGMT_SETTING_POWERED))
> > +               return;
>
> We might need to return an error here so we can reply with an error on
> Adapter.RemoveDevice.

After some investigation it looks like there is already a similar check:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/adapter.c#n3238

That perhaps needs to updated or perhaps this is the result of the
device being set to temporary which sets a timer to remove the device
and then in the meantime the adapter is powered off? In that case
perhaps we should clean up the devices set as temporary.

> >         adapter->connect_list = g_slist_remove(adapter->connect_list, dev);
> >
> >         adapter->devices = g_slist_remove(adapter->devices, dev);
> > --
> > 2.29.2.729.g45daf8777d-goog
> >
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
