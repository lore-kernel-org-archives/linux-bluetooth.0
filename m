Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF564C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 17:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FAAA20702
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 17:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dj/anq63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgHUR7j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgHUR7h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 13:59:37 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B93CC061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 10:59:37 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id ba10so2166468edb.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 10:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ihrURKlCPLS27xOORytx5XcBleBdUwAl2x0TGY8PiF4=;
        b=Dj/anq63kq997RdOBOsbWjPwMUK0etdBnZvIKd35K2Teu0e1f0Jh8y7GsMe3RY68gH
         ej9Xkww8NGbgsdUes7etngA02NqgAkdeqVLeRjVjUECBVYjogsqMxoq6lz+1IVIy/42e
         JqEc3o+kZNUm2yWgW3wMtsN7Oz1WCI8jgF9xM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ihrURKlCPLS27xOORytx5XcBleBdUwAl2x0TGY8PiF4=;
        b=qoanl3yCEjM/nx7tuk1OVNHjqaVJ3fwAYVe0MRGTvXau5675QpbqjN1PD5cV9SfL0R
         70+NtmBoQ8u584HaRHPvGdcF29GFXqMjYaXXlaP+o1BHy+1TR8WI+kwiUqeB4m1BEvXy
         VDw3ciRbrjxfEkjlrnWylXR2OP7HwWIssviEx42NtvIy16sXM+aaHXyaUoHvitil3t6G
         35MiujfeG35DcUd0mgBk46F1myei4G4yoaNkfWnVEH+B7mB8NzYbus511Q6qYY7W9Ujx
         ChEVn4DM1gm3N5Q2V9kewCXVHJF7zRs9fMaOHipfmC49UifE0G1ngJv9commRq+eUSNt
         oMPw==
X-Gm-Message-State: AOAM532RUJubIhwFGP4TpxvAA9dZxHGCV1k99CGJ00VfhIypgmW+YZye
        0dNwMUncOw5Gj77TmZPk4SG614yiOjMUNA==
X-Google-Smtp-Source: ABdhPJz2+eYsgJPf1rHTQN8Q4/IX49lZxDxmQ4WtXFTgySvYfvW4DUqDozCHStCL+q9hFDlr0uSRqA==
X-Received: by 2002:aa7:d45a:: with SMTP id q26mr3889984edr.95.1598032775609;
        Fri, 21 Aug 2020 10:59:35 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id b7sm1665773ejp.65.2020.08.21.10.59.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 10:59:35 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id x5so2716383wmi.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 10:59:34 -0700 (PDT)
X-Received: by 2002:a7b:c5c1:: with SMTP id n1mr4092377wmk.125.1598032774448;
 Fri, 21 Aug 2020 10:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200821073714.19626-1-sonnysasaka@chromium.org> <CABBYNZJN0V5iPkJgbh3Xc8cF4Qdp0azcoPM7bjsto4VeVjrzFA@mail.gmail.com>
In-Reply-To: <CABBYNZJN0V5iPkJgbh3Xc8cF4Qdp0azcoPM7bjsto4VeVjrzFA@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Fri, 21 Aug 2020 10:59:22 -0700
X-Gmail-Original-Message-ID: <CAO271m=T7z2BpjPiurcrvyzaed1bG36tQTZTZz4g-VMq7NMW=Q@mail.gmail.com>
Message-ID: <CAO271m=T7z2BpjPiurcrvyzaed1bG36tQTZTZz4g-VMq7NMW=Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] adapter: Fix crash in discovery_disconnect
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thanks for the feedback, I have sent a v2 of this patch.

On Fri, Aug 21, 2020 at 10:38 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Fri, Aug 21, 2020 at 12:42 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > discovery_disconnect crashed because the adapter pointer has been freed
> > before. This patch makes sure that discovery list is cleaned up before
> > adapter pointer is freed.
> >
> > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> >
> > ---
> >  src/adapter.c | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 5e896a9f0..c0b02bf3f 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -5316,12 +5316,25 @@ static void free_service_auth(gpointer data, gpointer user_data)
> >         g_free(auth);
> >  }
> >
> > +static void remove_discovery_list(struct btd_adapter *adapter)
> > +{
> > +       g_slist_free_full(adapter->set_filter_list, discovery_free);
> > +       adapter->set_filter_list = NULL;
> > +
> > +       g_slist_free_full(adapter->discovery_list, discovery_free);
> > +       adapter->discovery_list = NULL;
> > +}
> > +
> >  static void adapter_free(gpointer user_data)
> >  {
> >         struct btd_adapter *adapter = user_data;
> >
> >         DBG("%p", adapter);
> >
> > +       // Make sure the adapter's discovery list is cleaned up before freeing
> > +       // the adapter.
>
> Please use C style comments.
>
> > +       remove_discovery_list(adapter);
> > +
> >         if (adapter->pairable_timeout_id > 0) {
> >                 g_source_remove(adapter->pairable_timeout_id);
> >                 adapter->pairable_timeout_id = 0;
> > @@ -6846,11 +6859,7 @@ static void adapter_stop(struct btd_adapter *adapter)
> >
> >         cancel_passive_scanning(adapter);
> >
> > -       g_slist_free_full(adapter->set_filter_list, discovery_free);
> > -       adapter->set_filter_list = NULL;
> > -
> > -       g_slist_free_full(adapter->discovery_list, discovery_free);
> > -       adapter->discovery_list = NULL;
> > +       remove_discovery_list(adapter);
> >
> >         discovery_cleanup(adapter, 0);
> >
> > --
> > 2.26.2
>
> Otherwise it looks good.
>
> --
> Luiz Augusto von Dentz
