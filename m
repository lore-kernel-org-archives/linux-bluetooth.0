Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC61EC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 14:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B94A6206E2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 14:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E751pbe/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGGOHh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGGOHh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jul 2020 10:07:37 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CEAC061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2020 07:07:36 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q4so14321584lji.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2020 07:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gDREQy+iX7HB0ezoJS82NhBL+1QVhEDLJwBBM3IlKVU=;
        b=E751pbe/T/QDenU9q3rnAZg2lLouy6lQHJuiFlRqxv76ijGVdnbxydwpRNouqqBz0v
         8+jbzOHLTLJD4R0SSx/DyOZ6qh+A31chBilwZDoCXKhaZQIj1ORQBP9x8fbSHdhI7tRJ
         Hz7C540+BqiEpvZh3td9fUB2MH+beBQt8UPfpNaUtC5Jn/9ZRofHNdxZH0b7IELK7cv5
         wyTKdqs8ME9e9i91NXE05GB9OPYgTgNB73Bgx2SM3rB8qYN2i8p/NOCsaceOqsmXiJJK
         hgDhMJpKHKEe7Kj6eLMQ9DSdAXz2CUSSfXbk9hh3yr4pUQUpFW7eoUUmOHt3ZHbli6E7
         NeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gDREQy+iX7HB0ezoJS82NhBL+1QVhEDLJwBBM3IlKVU=;
        b=YfZFDZEuLMcS/6Vg67Pxko65IfqCF431ykryoiJ9dyf9s7udUBtobsnzoU9vbsOFF/
         +tcnNiONXMqUhnVt6fG2lyR/8FqhnZhn9JaxsOY4ZJtivnpi7NbICdl4eYLPvhgM/yth
         rMWvzz7LMZ80UTFex4jQmgFkXfmcFeOXDzSZ+1JxBKhXA5awI7D4bu17JNqC/1x7BXEv
         uqFon1S0oaIiWa6KKk+pmILtlsJMlqZJeecdJFfIPkWmBz0WaKPdJlSyPt+hzHlpQOS0
         TcyYKHjo3gMfMAQQY4oRqqKJYJniv3cJs+6MnV0NUBvYz0dZ1aBw7x/p/G+VSn/r14Qv
         KlUQ==
X-Gm-Message-State: AOAM532/bVZomb5j7Tfo3FevLSmS9FcAAtE0V1t3DnGq09aav3I2J1Dz
        9usolvQu7L5c+Zn/zzXr3PN1Ze3k67/A9ofI/DJ56pQXc+U=
X-Google-Smtp-Source: ABdhPJzaKe5FqnlDMenR5uHO3gdltJ3BsiK6cIEE7E6p9QU2Q1NFx1IMH/AtBAL/lEYvRDGNuMHU5wIZTdjjwusjXx8=
X-Received: by 2002:a2e:8684:: with SMTP id l4mr1838103lji.75.1594130855060;
 Tue, 07 Jul 2020 07:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200707003937.187125-1-alainm@chromium.org> <4B0E4627-26D8-4D70-ABE9-6CB7A9E86D35@holtmann.org>
In-Reply-To: <4B0E4627-26D8-4D70-ABE9-6CB7A9E86D35@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 7 Jul 2020 10:07:23 -0400
Message-ID: <CALWDO_Vq7t-6sX9UWravhcb64K_2LpsD-xGZsZec__2VcYwBgw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: create CONFIG_BT_DEBUG_FUNC_NAME
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel

On Tue, Jul 7, 2020 at 2:32 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> > Creates a CONFIG_BT_DEBUG_FUNC_NAME option to include function names in
> > debug statements.
> >
> > Unlike other platforms __func__ isn't a string literal so it cannot be
> > automatically concatenated by the pre-processor.  As a result, the
> > function name is passed as a parameter to the tracing function.  Since
> > pr_debug is a function like macro, the normal expansion of BT_PREFIX_PA=
RAM
> > does not work as it gets processed within the first parameter as well,
> > for this reason, BT_DBG is split into two versions.
> >
> > This patch was built tested with all 4 possible combinations of
> > CONFIG_BT_DEBUG_FUNC_NAME and CONFIG_BT_FEATURE_DEBUG configurations.
>
> can we please limit this to FEATURE_DEBUG since dynamic debug doesn=E2=80=
=99t need it. It can switch on function name debugging on a per debug state=
ment. And even for FEATURE_DEBUG I would rather have it optional that can b=
e enabled when needed via the experimental feature itself.
I agree on making this dependent on FEATURE_DEBUG as it may simplify
the configuration, but I don't think I like having this enabled via an
experimental feature as it complicates the tracing macros quite a bit
for no good reason.  I don't see a scenario where someone would turn
on CONFIG_DEBUG_FUNC_NAME but not want it enabled.

>
> Regards
>
> Marcel
>
