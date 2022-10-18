Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5111C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Oct 2022 20:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJRUbg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Oct 2022 16:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJRUb2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Oct 2022 16:31:28 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5BA6B64E
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 13:31:26 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id r14so24631674lfm.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 13:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UDPB3Q6dSE9ijvVfoNnjvYPTT4vjLzhzpnvMtyDXCP4=;
        b=p/gy3gmyVdt5byNX1LDEMcFgHR2BKKNN8U13Rl0zGMsgshw/Beq9O97ZrzYxx/2JcZ
         ar/Jl/GiEvAZy9F873zQBF9RgNm8NX3G3uAJGOv8aiuCXdYarWRRn1e6u5t3CY1i+1rh
         gpnngKU7ErtArzXc+Nmyc6FXO9EnL4623dTUgv8f0z4Bz2/flZFyNKvrzkd5Z7J/31SM
         u9dRVgq5p47aD6aEwxvG8qUovJHgckr0musrb3M97RZnUQIIUpjwNkhibu+cfK8XG2bK
         Kx31eRgt+kvQ5NA6ag7pM23syBoVTExmDr+2GSN+5SbIc07oyCX0dAbVn3fBf/RuOvFl
         Yprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDPB3Q6dSE9ijvVfoNnjvYPTT4vjLzhzpnvMtyDXCP4=;
        b=fhteE+P8QJGN7YM52qMkE9hBIiyTzTCQ+VPqud1vfzLtelDbt4J5pPpOqf/A1FtEdc
         mMHiNCZn82v7uEUEjKOYs5lqmKf7NJrwO2q3Q4f8LCVeNK7bFGgzTdC947uucCJXMTM2
         jqPHvT/81rFGZs78epRyBZpoVlWJtovmNL1Ez7lvq+Sx9lPDj7ch9mNjRsd8Tf3eRQ1T
         yEBXr7H+HwoT6sIiwQNevnPdKSrpkyDdK5WWKStrr0jb63l+aiOUOEeteQSU8NBqGy8Q
         ZhK5NwqCERNXyQMOdOxGBYAQRjOQCtN6tKndV+S/sqLtKFfDfTSo01uX7tKTHHsLxYCm
         nPxQ==
X-Gm-Message-State: ACrzQf0lKU55k7odQqmqkNgkAv2fnscTjAHQIuaaDkD/HswYLNh5opzO
        XDXjbua6Er3gqkbIzz1ukhr4ZLBKslSaYBqniIpPZXca
X-Google-Smtp-Source: AMsMyM6oMmZJF4u8au7+QWG4g+LO++YOqXBOnwDSvrsUNbrHsNFYRhcRw+qWGq9lYf42mCSZ0FaufQrN+qYTvJKLrXQ=
X-Received: by 2002:a05:6512:483:b0:4a2:6905:dfae with SMTP id
 v3-20020a056512048300b004a26905dfaemr1638148lfq.57.1666125084064; Tue, 18 Oct
 2022 13:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221018191911.589564-2-Igor.Skalkin@opensynergy.com> <634f045d.630a0220.5e841.f646@mx.google.com>
In-Reply-To: <634f045d.630a0220.5e841.f646@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 18 Oct 2022 13:31:12 -0700
Message-ID: <CABBYNZKo9pDLhReauaNDiCrQb_VvjecNc9u6y4NZCtg4q4gV-Q@mail.gmail.com>
Subject: Re: virtio_bt: Fix alignment in configuration struct
To:     linux-bluetooth@vger.kernel.org
Cc:     igor.skalkin@opensynergy.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Igor,

On Tue, Oct 18, 2022 at 12:58 PM <bluez.test.bot@gmail.com> wrote:
>
> This is an automated email and please do not reply to this email.
>
> Dear Submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.
>
> ----- Output -----
> error: patch failed: drivers/bluetooth/virtio_bt.c:306
> error: drivers/bluetooth/virtio_bt.c: patch does not apply
> error: patch failed: include/uapi/linux/virtio_bt.h:9
> error: include/uapi/linux/virtio_bt.h: patch does not apply
> hint: Use 'git am --show-current-patch' to see the failed patch
>
>
> Please resolve the issue and submit the patches again.

This is very likely due to your mail server changing the format of the
patch, you can use gmail to send the email like you did previously,
that doesn't affect the commit author which is what needs to match the
Signed-off-by.

>
> ---
> Regards,
> Linux Bluetooth
>


-- 
Luiz Augusto von Dentz
