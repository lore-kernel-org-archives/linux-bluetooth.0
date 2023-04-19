Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D79C77B78
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Apr 2023 21:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjDSVTZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 17:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjDSVTP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 17:19:15 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F54572A0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 14:19:12 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4eed6ddcae1so697037e87.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 14:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681939150; x=1684531150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FipGjb+LjqJPRO/z2xDjXElOlan963pPXcLN+5XgW1g=;
        b=qAYUB8RFVpBbnVoqBD+yZeJ3T6RzsBY8Ghnu3lpRfI/+c7NXVpRSBDe6NhvTag1Tv0
         sc3/FowYNHnlh1Lso4ECi/1FyvtHhXi+5aMBPumZTl7FuYm3LrVHx69osy+zuam5b7Aw
         k6QVj5AY8SWLQBILhPhrVPT/N7fGyvP67XSz5Up8G3WCWCF51KWaowZZ4482NMq9OOeQ
         smo+tGga0pUnDfjIIW5xfrx8HHUiL5rrn+YS6DPiTk0+Crbiye1QdJJnom3DRt8N9wtL
         5eY4bJ8jBfOevzxgXAlqc/fMJTXLNlpzaEgmd4le40nvl3l0mVSlCsGIcmamRPWUecGc
         I59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939150; x=1684531150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FipGjb+LjqJPRO/z2xDjXElOlan963pPXcLN+5XgW1g=;
        b=UtWXyuDF7mtbFvt3jVVxm/7DVCZDh91WrfBhC5StTsxXWrf5u3I2f+hdiJOwevNFH5
         skvQ9qzF8zT7NX/o4VBiiZIV2fS5578Y4lhkxmKnAUooElfOLIvU8jx4lOW5FmaudpyO
         EDTzj430D+zQsKGW3HHmy+Ic4D4b0QDITSFm14N7fsANKOKN61MzEGw6zkFehpuTcdXz
         ArCK0Rd65C8IIXcR/s/m4S5mhUAByF2h3FxxSc/CY1A6OShqnXs6rbBw/rcGFqW0fRYg
         AdrBkX3d/UNVs+TzT4cmqaV4LHSsEWWjNmd5bq3fESw8nBPjouLNJvwzN8sAEK/nNVnr
         vpzA==
X-Gm-Message-State: AAQBX9eseXoxweNiyKFqR3ZYBE7T9T843Cl0OWnVvoF8sHgAK4zgH2eL
        Jw7YZcPX83H89HRWTrMIYIG++imUV+rPYVxV3EzM8XfP2qA=
X-Google-Smtp-Source: AKy350Z0AknS4Lx1Zia3LEI70nGaJBdok+iutrLQ2mFRcYewqtVPJOxV2dbuXqHvP9jRKR+34jCOmKX1bTSvih6L2Dw=
X-Received: by 2002:a05:6512:b8c:b0:4d8:86c2:75ea with SMTP id
 b12-20020a0565120b8c00b004d886c275eamr1580299lfv.3.1681939149798; Wed, 19 Apr
 2023 14:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230419142333.1687267-1-neeraj.sanjaykale@nxp.com> <643ffcb8.050a0220.2c7ce.94df@mx.google.com>
In-Reply-To: <643ffcb8.050a0220.2c7ce.94df@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 19 Apr 2023 14:18:57 -0700
Message-ID: <CABBYNZL06LYHZsUboWUsS4B2Kz7vTiT5W-yVbfjW+v082EGCDg@mail.gmail.com>
Subject: Re: [v2] Bluetooth: btnxpuart: Enable flow control before checking
 boot signature
To:     linux-bluetooth@vger.kernel.org
Cc:     neeraj.sanjaykale@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Neeraj,

On Wed, Apr 19, 2023 at 7:40=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
>
> This is an automated email and please do not reply to this email.
>
> Dear Submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> While preparing the CI tests, the patches you submitted couldn't be appli=
ed to the current HEAD of the repository.
>
> ----- Output -----
>
> error: patch failed: drivers/bluetooth/btnxpuart.c:755
> error: drivers/bluetooth/btnxpuart.c: patch does not apply
> hint: Use 'git am --show-current-patch' to see the failed patch
>
> Please resolve the issue and submit the patches again.

You probably need to rebase since I pushed the following changes:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D183d1a0466eb3e75cb9e60f031cac2a4f2dffb80

--=20
Luiz Augusto von Dentz
