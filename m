Return-Path: <SRS0=evP7=XW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429F0C4360C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 11:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCEE217D9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 11:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="1a9Vlt3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfI0L0S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Sep 2019 07:26:18 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:41079 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfI0L0S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Sep 2019 07:26:18 -0400
Received: by mail-io1-f48.google.com with SMTP id r26so15303752ioh.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2019 04:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cxiZ8mHz0j28rl819694tQyEygOkwVXX3aZ9Pse7uLs=;
        b=1a9Vlt3kr3NmheuNtoNX67f3qslKORHBNR7q19Sv30lw0wK6qofMEoxa/kK+Ac1vkO
         s3Ep5FpiUohvIfYo5i3Z18kTGo5ra6jBiZOdgPxnmiKxtXmm8KGSk3rgFdcdgF8gprod
         oqAu4T67jzfKVInb3zrIGgJUo1/a08wSGjVLOIdMDQmvTStxfp/fRCV1sf9eG6/SLXeS
         2rx738jR3oWkcdTIuwpMCabO+hfxPKwG2WTn6jrfs5HYUau6i6cFfrcaDfbjdrjTwcGj
         L5zpFVcHoThtp0Jfqko/RsHwpZkrIJhc911r5TJRQDxDCvxA4tJKHA/jmwj7TewpPajG
         mvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cxiZ8mHz0j28rl819694tQyEygOkwVXX3aZ9Pse7uLs=;
        b=rgzM22HQM5lxlh0c3UKA1WBs98sVMKWAwdAxHFn8DK6qbRDV/PBQXP9SRhf0LyiMHS
         48VIVE9I5+kDFqW5HcqaPHOCnyGVeq3EKGSoyCSnBpxBwyoFfUN3W4WrqLDmNNE5KPB2
         BLEMYslmx4flt57TgqQ12GBt848xwzHt7Beeq9LrXOQCM7DFgSSXoiYOXOVhSFuuEO4b
         n3gZV4gmAHmIsiVQ4Pg10wjhwglQunTvRsz0EhutP0OaRXd87Q66Yry2b7jNSd3i4RcH
         LLWWADh7ZDkGNdy9kPdbEk07ttk66GR9tZ0RrdTxrp9LYxG6DD0CKaS/blI4KburWsRD
         X2zA==
X-Gm-Message-State: APjAAAVDHZXAJxTms+j+lVH62cAJWTgCIoqxzurmz5T0I5fLw1JllpPo
        Pc75gIoxuoWzI0LgKiwvztjLYuZBaG30BOl0/ImPG5Iy35U=
X-Google-Smtp-Source: APXvYqxSsYwATsV23exUR8MTriIajcLCHkqqmlKJ2h+fRUd0Gq55i1W5aNE7Lww1hrfgDfFX4EY+Cxz7EISFbXoMJbc=
X-Received: by 2002:a92:de41:: with SMTP id e1mr4179079ilr.202.1569583577261;
 Fri, 27 Sep 2019 04:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <44f46ff3-216f-7205-336a-2d0fb150818a@mnmoran.org>
In-Reply-To: <44f46ff3-216f-7205-336a-2d0fb150818a@mnmoran.org>
From:   =?UTF-8?Q?Grzegorz_Ko=C5=82odziejczyk?= 
        <grzegorz.kolodziejczyk@codecoup.pl>
Date:   Fri, 27 Sep 2019 13:26:06 +0200
Message-ID: <CALevQMYsGYyZi-56YQajGCt-Gjojr=w7bnL0aGA=N48Yjg8G4A@mail.gmail.com>
Subject: Re: Meshctl GATT MTU Patch
To:     "Michael N. Moran" <mike@mnmoran.org>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Michael,

Please follow "Submitting patches" guideline from "bluez/HACKING"
developer readme.

Regards,
Grzegorz


czw., 26 wrz 2019 o 18:48 Michael N. Moran <mike@mnmoran.org> napisa=C5=82(=
a):
>
> The attached patch fixes a problem in the meshctl gatt
> provisioner where the GATT MTU is truncated.
>
>
> --
> Michael N. Moran           (h) 770 704 9751
> 218 Wilshire Terrace       (c) 678 521 5460
> White, GA, USA 30184       http://mnmoran.org
>
