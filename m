Return-Path: <SRS0=5fy2=7I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DB0C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 May 2020 14:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76FAE20723
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 May 2020 14:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVDGwRP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgEZOiM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 May 2020 10:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEZOiL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 May 2020 10:38:11 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECDCC03E96D
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2020 07:38:11 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e10so17859716edq.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2020 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=fZO/WEUTygcKbpKhHsTEt5/8S36pBcFGVUf44p3YB/U=;
        b=qVDGwRP3/IuY7kg1sDMsRANwNsg4xEQiHDjqptwc0ZgN3XpNYGf1RF2ZTR9ttrDiN6
         BUvAPTsBcP+t55RkiSV01+eM6/6Epza6a0vy/4WaggSmvGokUADgFEMVo0CR8LIn4Qj8
         /NDXVFQLddUBauGkNNOCNupcmiCteXVEaIfRfYSrznFVUWl9v5Ki2hxwnEUFUCcBimAs
         mVStdAURsVqnUhb5wBDC5F4LfAsKhU51qzhcOjjQoAjLvoKz3SnV3BV89yIa7FG8puF6
         ir4ZxnhdjABzUCAi+ZihQrZtZM8lVCUs9xN0b4q1So5QNlWuvj6TeFIviWWIoKVxTJGO
         HtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fZO/WEUTygcKbpKhHsTEt5/8S36pBcFGVUf44p3YB/U=;
        b=dZv2bFn3plC7xitpmQKG2Lk50lSK8BXSaC/2eojT07mG99dzUZW75krhemi3XvHLIu
         9uxyVBaAKrPOeWFND+o5KFT9tM5Z3AsBhkDtrbgxBk82Not7SkWkCghR8D+pmpD8u86i
         +6WjTh3yA2ZAtzG7IG8hBGZj0nt2aL4XzWzat2ZKWDK812NlmhSkOud+v/TKBKzSjFM4
         syMs64DESiXw6vLNpFMNMPWLHOolsVuV3iWojjN8qksX9FOT24semDZuEW+F1NY+PhmU
         H4OWhtqfHHeLhbFw68pcMF62bpvMTPRytP9zq8tNzv/USK+nH5BRRWqTXm2+zup7ODvs
         6D3A==
X-Gm-Message-State: AOAM531vd9h8+7xJfSKhEtIWYykZQUVlICUZTy5CnTRdx5TI5aBaR9GF
        ui0jk+219XvTVzuRMdaDjdWaLL/CI6kpfHedl3ivPLJBzik=
X-Google-Smtp-Source: ABdhPJwX36fG3QN6kk6vhRlV1TnDqLmXIwtULdNaqMRqsedNGh04h7AGqdOHI6qKYxX6Qm3XfF2te7iQujcFjfzQdco=
X-Received: by 2002:a05:6402:3128:: with SMTP id dd8mr20735626edb.156.1590503890133;
 Tue, 26 May 2020 07:38:10 -0700 (PDT)
MIME-Version: 1.0
From:   Christopher de Vidal <cbdevidal.jk1@gmail.com>
Date:   Tue, 26 May 2020 10:37:33 -0400
Message-ID: <CAA2KLba+-VC+zytj=gwie8FOBwE6H78R78h5_Fqfn_Jnd=BvKA@mail.gmail.com>
Subject: UUIDs for every single physical peripheral's service and characteristics?
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Help a newbie? I'm seeking to build a niche product for sale, a
Raspberry Pi-based device which during the initial setup acts a BLE
peripheral. (Python using dbus to Bluez.) It has a single service and
19 characteristics. I get that the first "U" in UUID stands for
unique. Must that be unique among each physical product, or may it be
unique among the product line?

So if I sell 1,000 units (which would be a success), would I need to
obtain 1,000 service UUIDs and 19,000 characteristic UUIDs? Or just 20
total, for the entire product line?

The goal is so that the iOS/Android app can have that pre-set in the
code and quickly discover the device, pair it automagically.

I suppose the risk is of a conflict of two similar devices which are
in the same vicinity of the phone, and both set into peripheral mode
at the same time. But that would be a minimal risk which I could
accommodate for.

Christopher de Vidal

Would you consider yourself a good person? Have you ever taken the
'Good Person' test? It's a fascinating five minute quiz. Google it.
