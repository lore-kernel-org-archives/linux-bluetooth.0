Return-Path: <SRS0=1iyh=56=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45F7C2BB86
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 00:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 815272075E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 00:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAECq4dI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390369AbgDNAJ4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Apr 2020 20:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390364AbgDNAJy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Apr 2020 20:09:54 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C72C0A3BDC
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 17:09:54 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id u20so8975978oic.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2020 17:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B1nsyhLQuQrAGYoOCtEEWkJmr2vuB/c7EPh8g9SVViQ=;
        b=kAECq4dIFNVbyzp4Saijskoj05OodS2Jxj9qKw762C0wRMlImg6mOuNNPy8QUU99s4
         ZOU0PWnHBZrebrZAq3bj4Z3FBAb0q762HJkEfG6TlfRGyfPzQNLFPqPUzqvHyFnO0Ce4
         +D5vbHKg/wJA99cT/HCbmGtlo0Iezo3KtLRnD0euVv6jSbkahDjgnS42RYinhprVtXpg
         cLMkzx/zBqE3bhNNPN6f6Qzs0ixYYn7vg24G+YNeOxIvCsbMof4GbFADxFpNHVJsrso8
         D5Tr+S9+HgJlgtPw+Ov5akwqlYbP/JmPUXmWZS75g+vvLeGSEKTa2OXfxAGy2GxXnUJc
         nsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B1nsyhLQuQrAGYoOCtEEWkJmr2vuB/c7EPh8g9SVViQ=;
        b=GB/mDprkAVbH3Xh/nNrU6eAPaNfzbF/skTJNJH4Mdc1Cs8zQxG9oP73ibq1M5YtMhB
         3O5k0pyUlVWo+nX1Pv3REokJYJ4E7SXok/XrirsjQCDL96XtetFjMxfPqaNieomHVdWY
         spsNOwmMmtSmJxbX5ApV4j9QpoDN/lioDCjFi1huLFw8NuOoFupeC6SdLFM9nmo3YsFn
         95VdgLmmy6WyQM5iHkQ4tSO2yRqlOnXIdinou/toChFOwZeSdaK7eUjaGfT8GYbKpqxf
         M2OC7a0NEQ0ch3OSh1hV3gnnvhL0+m9Ssmtccg6yajUfkK0JX9wwCh9yYmDlL5DQRTiv
         7Frg==
X-Gm-Message-State: AGi0PuYRl58A+z7rdhdbcnjjsLu+mOyc/h8eUz4GfUrv5KUIlFMNVL5E
        +IyoZ8wUw5dNHJxXrW1R+YIw5VVQY4rQrW52OmxlwhrN
X-Google-Smtp-Source: APiQypLkB6u6co/OkKsweYfK9mHPbkhyxT2G3um6QX1KNQmogb42u1Hs79lPektXRFZJ5ILU5astWp67brV3OIJ322w=
X-Received: by 2002:aca:f584:: with SMTP id t126mr11869219oih.108.1586822993951;
 Mon, 13 Apr 2020 17:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200321195404.fvyku5hmcuqxt7sg@pali> <20200413162513.2221-1-pali@kernel.org>
In-Reply-To: <20200413162513.2221-1-pali@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 13 Apr 2020 17:09:42 -0700
Message-ID: <CABBYNZLvuDMoFhFSFq50hnjG24DatsHDHNiN2axeC75fSmDRsw@mail.gmail.com>
Subject: Re: [PATCH 0/3] bluez: Export SDP "Remote audio volume control" item
 for HSP profile
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Mon, Apr 13, 2020 at 9:25 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> This patch series fixes handling of zero value in feature list and
> provides Remote audio volume control support for HSP profile in both HS
> and AG roles.
>
> Luiz, you wrote that you do not have time to work on this, so I
> implemented it myself in this patch series. Could you please find time
> at least for reviewing and merging these patches? Thanks.
>
> Pali Roh=C3=A1r (3):
>   src/profile: Distinguish between zero-set HFP AG features and unset
>     HFP AG features
>   src/profile: Export Remote Audio Volume Control SDP value for HSP HS
>     role via first bit in features value
>   src/profile: Add default SDP record for Headset role of HSP 1.2
>     profile with Erratum 3507
>
>  src/profile.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 104 insertions(+), 8 deletions(-)
>
> --
> 2.20.1

Ive make some changes to remove the need to a flag to detect when the
features should be added or not, it is now applied, thanks.

--=20
Luiz Augusto von Dentz
