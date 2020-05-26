Return-Path: <SRS0=5fy2=7I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15700C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 May 2020 21:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE9EB20776
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 May 2020 21:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTx90x9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389678AbgEZViW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 May 2020 17:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388740AbgEZViV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 May 2020 17:38:21 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C8CC061A0F
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2020 14:38:21 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id a68so17578734otb.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2020 14:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m3h/FxGWTRKS1oam1BnagiVapK6RlqWY0aMF96XJ264=;
        b=BTx90x9vYurFWnG8AwBCwz/5lKPhtdMz+izMIcnSbtN8o2k6l+3rlZCpYbVlCd1Lc3
         AAjBbB1R8UIpnvfoQoFFywFWsX0W9g8DN+7WVhTY/YupPaM2DHLz3LxvoXI1OBF2DUeV
         RK0ErTmd+RjH8QfPUNxvL8PYzYUtE/sKQO92kbS2tLuMY4Y/9o6clJfn0pH0mFTSmjhk
         YPKmTYP2w3aBqnmJaM+ZOMi9yHgXCbtO8ylsX+gA2+ERQ3R3FWodoltx8++MfjYTdt77
         H9c+y3dv/KFdQjFnnDiN5yAtks3EMLF1qfO361xZYnRpr7e9Qi8xPImktbNBr5zZU96x
         GDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3h/FxGWTRKS1oam1BnagiVapK6RlqWY0aMF96XJ264=;
        b=XBEGt5ri6ASNxnDAd+C+px6JA8tAnqbXENcwTJ9a0rtdaXEfhGuKjS+NNd0Fki6225
         rp/bHVIeeiM58dnxG+QHzvvBxs08UwTRnjBhCWxKuZ1+j62oP6sPf5Dk2JiTOkwJhKrJ
         bAtE8IFBkugIF6AhWNkz7Ma+1o9R3QDOBHKhDfYcwpz3cg1i8gkFlo921r4TSo+a+TqX
         +YYOFixHh/VvRQVEjyjlEMZQ9lg4ZWWim/nShHyLThBJHIZ6H8jCN21VWziL3qty943y
         qvxWNYRnkBTHjNskwfKmz8EVN5mm10w8PtAibOwmq+uxQ3aDQ7rHJPHbNiRZCTPownku
         M0MA==
X-Gm-Message-State: AOAM530Pz25683TmOhfxLA9Qz2Y+F5S/yX234beXv6EWrd2IJp5xhGPy
        OQaZTtzZoA7v6JQlO9jUNSZUDI/Q3s72evVzTW4=
X-Google-Smtp-Source: ABdhPJw9+s/+PMvMKy2gggxA5OKQ1zLuZY9Hp5aaYIAG2DEAaIA5EvPz0lbubxYINurMTnLnCco4zUkq1akey2IRNcU=
X-Received: by 2002:a05:6830:14c4:: with SMTP id t4mr2437835otq.79.1590529100694;
 Tue, 26 May 2020 14:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAA2KLba+-VC+zytj=gwie8FOBwE6H78R78h5_Fqfn_Jnd=BvKA@mail.gmail.com>
 <CALWDO_W+8SDCOn_b_4_FB-KR43xjyYB8u+kSgQ1YVx1Mp_FG=g@mail.gmail.com> <CAA2KLbaXKro_KTHzZf+PyWejqKG=vjz1oro-2W=jcqj_nC+O4Q@mail.gmail.com>
In-Reply-To: <CAA2KLbaXKro_KTHzZf+PyWejqKG=vjz1oro-2W=jcqj_nC+O4Q@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 26 May 2020 14:38:09 -0700
Message-ID: <CABBYNZK3Vms+xaJT+4VUkfr1=Jv5QKMnP99JMRdDwrnpeR093Q@mail.gmail.com>
Subject: Re: UUIDs for every single physical peripheral's service and characteristics?
To:     Christopher de Vidal <cbdevidal.jk1@gmail.com>
Cc:     Alain Michaud <alainmichaud@google.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Christopher,

On Tue, May 26, 2020 at 9:25 AM Christopher de Vidal
<cbdevidal.jk1@gmail.com> wrote:
>
> So let me make sure I understand. The devices themselves have their
> own Bluetooth addresses (similar to MAC addresses, I don't know the
> proper term) which are unique among every physical device sold. And
> also there is one (and only one) service UUID which is shared among
> all 1,000+ peripherals which I sell, and 19 characteristic UUIDs that
> are shared among the physical peripherals. The devices come with their
> own Bluetooth "MAC" and I only need to obtain 20 UUIDs in total for
> the product line. Did I get that right?

Check out this article (Step 4: Assign UUIDs to Custom Services and
Characteristics):

https://www.novelbits.io/bluetooth-gatt-services-characteristics/
