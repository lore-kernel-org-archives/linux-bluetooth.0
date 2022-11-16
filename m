Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A838C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Nov 2022 21:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbiKPVAh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbiKPVAQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Nov 2022 16:00:16 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E4C6F379
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Nov 2022 12:57:53 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id c1so31540255lfi.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Nov 2022 12:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ox/3yJdPHTXA5wAj9i08kmQI0g1IX/dKA8EFYN2yMBk=;
        b=qir84JHyH1ym/20n+gpMnkP9lj00R1V/n9zAJ56mDmRneB0aUgm9cV5wbeapkepGNg
         d+lDdAuZTTwIf76tJ7do3gSI+nFJrW5MR2mdDBd9TCl0/Vnw45jqv0pKJdzLKhk1eFWD
         JHdzYp+6v1NtLpab6RYFZc8YDKIsjXL5d9Rjri8+kQF20wtdYrbysP4KnynF+H/5YFu+
         ThefvDoaPmHCIBpNgwCPcok4d5EQmqpc7RmanDrc1bfuYcattuzL1AFmiJNclWrhlBNV
         3tDdzbEykMuMV62HW7iFT842UkYxA63IM6RICh7sLksR/xSy1s2rpLkCa6AMwZD3uGih
         8yHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ox/3yJdPHTXA5wAj9i08kmQI0g1IX/dKA8EFYN2yMBk=;
        b=Dk8ylHxiBLmq5moSVACPqUYgOXo3WbfRWnhThc4zakygxnMh+eiCFWMwfkVv1/5yxU
         jv+ztJlSKMebXYLSMsGSdp7rQaoubjKvZG15kykD1iMl2LJnBVSeHm1a1cnoe1dh/Gw2
         aaZizruqx2LuXui39SiXTz4uwzaIkl5T3sF4MSi1358/niI4hKvxjc+momgY5uqMUCck
         0GmsvAXrJujW9/evS35oGDQC3Svf9shki1o0YSBhknr8SocclU478iUdHi34/rdP5mGB
         BobF8JPTwVp7Y3G6YZGj6lQSBCU6J2P9du+31sXfzFHJzLUKqaG+MEt19LduMfCj9mAy
         +/jw==
X-Gm-Message-State: ANoB5pnjveOEapWZJtW0bugju5rp7jd86mvys4TbZ9Tdgp2LR8bN2Spm
        HbbD9xeZfLCnsjEfLkKjPf4sMFQ4fPVIuIcCEOg+jI4D
X-Google-Smtp-Source: AA0mqf5IVu7wIiBFITZn8SCY1JCM1+5Ifw7z1J6fw4M804exy7Qh8Vq6xjvM9pfrKduOonHpwOfhtrvLweHbdZxYSCg=
X-Received: by 2002:a19:8c54:0:b0:494:70b2:26bb with SMTP id
 i20-20020a198c54000000b0049470b226bbmr7416424lfj.26.1668632271852; Wed, 16
 Nov 2022 12:57:51 -0800 (PST)
MIME-Version: 1.0
References: <20221104071810.22720-1-kiran.k@intel.com>
In-Reply-To: <20221104071810.22720-1-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 16 Nov 2022 12:57:40 -0800
Message-ID: <CABBYNZJsL-pqbK95EOEQOvj=9sTr=aTZL527262eC64SDicGrg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] bluetooth: Remove codec id field in vendor codec definition
To:     Kiran K <kiran.k@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        Chethan T N <chethan.tumkur.narayan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran, Chethan,

On Fri, Nov 4, 2022 at 12:18 AM Kiran K <kiran.k@intel.com> wrote:
>
> From: Chethan T N <chethan.tumkur.narayan@intel.com>
>
> As per the specfication vendor codec id is defined.
> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E page 2127

We need the fixes tag, the monitor also seems to be wrong in this
respect so I will push a fix for it once that is done please add its
output.

> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  include/net/bluetooth/hci.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index e004ba04a9ae..581539cbb856 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1424,7 +1424,6 @@ struct hci_std_codecs_v2 {
>  } __packed;
>
>  struct hci_vnd_codec_v2 {
> -       __u8    id;
>         __le16  cid;
>         __le16  vid;
>         __u8    transport;
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
