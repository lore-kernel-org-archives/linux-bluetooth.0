Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4587C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 04:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCPEQn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 00:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCPEQl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 00:16:41 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54388448C
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 21:16:36 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id s12so504866qtq.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 21:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678940195;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6JN88kkdSkdozEcTNjhU9vgdl/91eFsqXte21+lZB1M=;
        b=pr/dsgERxJbEJTmvXsmWkQn2xjyf5iiNsBEduJjIZKdv06VozTad0HMCBGx4MRQBH5
         dfAcsdTC+7XJAJOKQyhX9Fi3u4imYnm9PqPjBsNS2asMOGIQO2zDw9c1Iyvx11Ls5oar
         oM4QzGgtIOrycCH2oiphYU9e16mAFTdWRVbwiA6lUp1LPDiCHg57sGTlAEjZI4tVhotF
         BrMrxg3xCIBskdgIeQZNZX+vGPTiwOI/LaBcREoBCQ+FZzxNjJXIkXJVjHENzh+cV81l
         sy/LSYmpXlmpqTyQEs13K7/ZOs8LoDzLRIzn+Ogtv1e2y0dLPblLebmuKjY3Ug9jiQwx
         Rblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678940195;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JN88kkdSkdozEcTNjhU9vgdl/91eFsqXte21+lZB1M=;
        b=kvUtUWC/3P7O4PZGn77u9W/DRn8sJ32YjCO88UhbUCqiMzMXBC+ZjhUDdVIRzfFNAe
         rMvPh7TKd+YujR7k4+rnlq2t5rPE/k+wRhH4IIelynNwb7a6awM4IWW1/IT/9uIBJovp
         1P6JZV4zFe6Z4sozwu7IP6LX3BPFQ7v3H6GVWvKr0jT1/TSSy3Y3GpnKZGnpg0Eq/hGn
         eS0hf+NuZeh4PZlyv/gicBY9Ik9Obf+c+m0MrmaG0R00yxVmw8PT1OSEtv5QROziKqNu
         kYmJcOnsjsMoURmJDfugBENOL3qmzaQZjKjoiTdwz7xNTe4hvuwiMPapO+IoE7kHY1+1
         gdrw==
X-Gm-Message-State: AO0yUKXRYKNVtQT3SLZZVqQ+8AqfKG4uFJzWvJuaQnfojsrTiYL415Kw
        3Cm4tmHHYN5uPu1AHkAviDwcuf+DQFo=
X-Google-Smtp-Source: AK7set848gLhpYJeRIPtwt+p/HGvMBxwU58KitYPBEIwV234dL+laQTm8kw3oqfJoYV0iXOVTpNx2Q==
X-Received: by 2002:a05:622a:54:b0:3bf:a335:6a82 with SMTP id y20-20020a05622a005400b003bfa3356a82mr3472446qtw.28.1678940195041;
        Wed, 15 Mar 2023 21:16:35 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.74.33])
        by smtp.gmail.com with ESMTPSA id x4-20020ac84a04000000b003b82489d8acsm4987473qtq.21.2023.03.15.21.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 21:16:34 -0700 (PDT)
Message-ID: <64129822.c80a0220.edc3.51fb@mx.google.com>
Date:   Wed, 15 Mar 2023 21:16:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7048024028787565634=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, steev@kali.org
Subject: RE: Add WCN6855 Bluetooth support
In-Reply-To: <20230316034759.73489-2-steev@kali.org>
References: <20230316034759.73489-2-steev@kali.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7048024028787565634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/sc8280xp.dtsi:1209
error: arch/arm64/boot/dts/qcom/sc8280xp.dtsi: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7048024028787565634==--
