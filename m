Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5EDC282DD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 21:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F9E2072A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 21:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wqtp3AzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbgAGVvt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:51:49 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:46574 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgAGVvs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 16:51:48 -0500
Received: by mail-ot1-f44.google.com with SMTP id r9so1488468otp.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 13:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mIzrUlwpuasXfRFksEDRq2nN01q9EX7/UpGXgw6X6V0=;
        b=Wqtp3AzSjfdmZTvlo0jlKjaHM0Ca/bZYYfbxtTl8pAD16IwbZvGrVFbY0H13yT9isg
         EHQfblFjg1J5D9bX9ZISRoHs9zyv2ekklo/oAp81CIgAE2qZDE2qnWwvS13uKVCAPnJu
         YuKolD9poBdW/qfshYwSFb8ASVnMCdb89C2n2aboRkslqe1gmUzjT//8tRSCJpwZTfKB
         PVgYgJlV+GyEX1fBj0xiYsulaOiH1qNpU9dT5PvweaADyiDVTG7UuzIs3HXE8UYBwoIG
         SZdTdIo5lQLzP7uL5CFLDLaYDmiUateMF5E6ZITQkEVuxVKsJchzJn++J/hoH75B++v3
         kTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mIzrUlwpuasXfRFksEDRq2nN01q9EX7/UpGXgw6X6V0=;
        b=O6WsAq1odKTyCxqzx+sEWmlHjEunwmI+hRVHNO/lGlJ318yKyKFzN7EaqtXTHacBET
         qAlpD4aXcAaAKw0HIBFpSMbN74hB39XEDsf9/DKY+89uJwgFZzl6xjOphAhGr12lQzbN
         Ci8Gqq89HNgx1VU/gFNxXPxn4thWkYQc4vhmYAjz1hkABYNeIfg9qoe6OLH6/l64ckDE
         ijqVEh0Jrw2Pe8XvGaTGlAvwEP27iJIbLk0bLV6RpQWaxogCpj+4WUeMGB0aNeFWvp31
         BP/yjWBym/3blJekGugRyOhviJpI7CFGyfOSp8rQLvQT4M+4vYu+haXhrZn330zpMwVj
         jMVg==
X-Gm-Message-State: APjAAAXCBWu4vWNzZj1y+p/Jx1dRaAVlQ1DciQFELMUu98hnpx0RhXqm
        BLs0phDZvxcCIZ4fDvQCoKD4c/qlRZH943P2q1rkE894
X-Google-Smtp-Source: APXvYqyawNKuRDJu+0jyF77nZUTWJaJzyjR5xur0Yv8S/1hIQzZpUlldx/BHpIfrjUtjaYBtlsHFaF0BxIG7NIH/vxg=
X-Received: by 2002:a9d:3cf:: with SMTP id f73mr1825525otf.11.1578433907813;
 Tue, 07 Jan 2020 13:51:47 -0800 (PST)
MIME-Version: 1.0
References: <d27a0f72-4c78-92ed-4b0a-1010a4b63f0e@tu-dresden.de>
In-Reply-To: <d27a0f72-4c78-92ed-4b0a-1010a4b63f0e@tu-dresden.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 7 Jan 2020 13:51:36 -0800
Message-ID: <CABBYNZKZsF=gRJh4LHNt9eOXVyfFsH0Et3xvxrPOcyhOYDjPnw@mail.gmail.com>
Subject: Re: Bluez does not connect to A2DP sink
To:     Thomas Ruprecht <thomas.ruprecht@tu-dresden.de>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Thomas,

On Tue, Jan 7, 2020 at 12:51 AM Thomas Ruprecht
<thomas.ruprecht@tu-dresden.de> wrote:
>
> Hi,
>
> I got a problem with bluez since 5.51 that was recently discussed in the
> thread https://marc.info/?l=linux-bluetooth&m=157081619423081&w=2: My
> headset auto-connects but is not registered as a2dp sink. Unfortunately,
> the proposed patch did not solve this issue for my setup.
>
> I also could track down this regression to commit 477ecca (policy: Add
> logic to connect a Sink); applying it to 5.50 yields the connection
> issues. After that, I applied your patch in commit 52faac4 (audio: Fix
> cancelling disconnect timeout), but it did not change. I used only these
> two commits on top of version 5.50 to isolate the problem (it is the
> same with version 5.51 and 5.52) and gathered the logs of running
> `bluetoothd -dn` and `btmon -w` for the three setups:
> * version 5.50 (patch-0),
> * version 5.50 + 477ecca (patch-1), and
> * version 5.50 + 477ecca + 52faac4 (patch-2).
> For all three logs I powered the headset on to connect it, waited a few
> moments, and then powered off to disconnect. You can find them at
> https://gist.github.com/6d733ba9ac6cf04c71625a08e8365178.

From the logs it looks like it does connects but it aborts after the
suspend, so it might not be related to reconnection policy but
something else that you device do not like, perhaps the suspend being
initiated or something like it? What headset model is this btw?

> @Luiz Augusto von Dentz: Sorry if I sent you this mail multiple times,
> it probably got filtered from the mailing list as I attached the logs in
> previous attempts.
>
> Please let me know if you need anything else. Thanks.
>
>


-- 
Luiz Augusto von Dentz
