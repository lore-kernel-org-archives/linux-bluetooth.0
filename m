Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77040C5B57D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 01:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430E620673
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 01:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PTPIMvve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfGCBpz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:45:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40883 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGCBpz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Jul 2019 21:45:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so307844pgj.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2019 18:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:from:message-id;
        bh=/lftIQtLZlGqHRoK26mSXmm1GfXYSRk6g0mzKn2R2aY=;
        b=PTPIMvve4HBG50DH0saCw7nGG6AuNrHPjF+PVxADujOVxcRZlAr/MqrgC5GUEHgdu1
         sJkY2PGSxNmsyVA44HO7eEV9tzlO2lvEcXY9q2mRxbJEy1BC4d9VGpooNQVcNok3rNZD
         nx/IpaV6N1DeXtjrgx22bDlFxKg4t1aOS9gvngpBnrYKndVDbYQAPphUrbb0bvNESXUf
         lFxcPDwA15j73WiJ223IqDabLB2dHXz1xINgHGZWd0k3WKA9KeGf25Y3Gc1/tN122rML
         tYxFI8M9HR+TJvszLQPwBgCFz9spmq6QLilYJ3g6dzdJJtjrR/ildxnscEqkvPE9krLp
         Jmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:from:message-id;
        bh=/lftIQtLZlGqHRoK26mSXmm1GfXYSRk6g0mzKn2R2aY=;
        b=ddiQq3EWMyL5n1HtzTqbOXOo2/KqYtfnj7WzgAvw0G+EeOv7gY8d8CIfFRTIT12WEa
         x26dHDKx1Q8eAWnTXsHMLEYCL1Gq7cRK7UrGas1sv/0tBDnZRZrDja23wj7VWi+MY5rd
         FwYenmPUJEQlRD83Cx0bTrJ/xxneHMgFIx4y9GUpB6SZwbS1L91MDFFsDDMONzSrMBlj
         0qWlGWuZGL/Sw5jfxO2KdAHo8RzCNLrcvGJlhiwgrzADuNT6vGI7IhvXlDIA7zlONGJv
         WSehWafbFBkkvjfOSlGARD85bo4ISnXssQukfAnOSIri0Vi5nOVF//umEl5MZeMM0UEH
         JFww==
X-Gm-Message-State: APjAAAU8w5/a3JCfm1JjUFTydyNzIqnPeshiKO3Ac3eXvm1hUgVArC7N
        4JrqlSNUx71pfBVmpJdj8qzU
X-Google-Smtp-Source: APXvYqxNxcoYlACw3/2tFrNjhLnToQHzPPU9UU0atOYwAhFqTaoX7aETN9lLzKkG7T5LZI+JgLZHlA==
X-Received: by 2002:a63:dc02:: with SMTP id s2mr34150887pgg.286.1562118354549;
        Tue, 02 Jul 2019 18:45:54 -0700 (PDT)
Received: from ?IPv6:2409:4072:916:7317:c422:4e7a:6c9b:96f9? ([2409:4072:916:7317:c422:4e7a:6c9b:96f9])
        by smtp.gmail.com with ESMTPSA id a3sm351633pfo.49.2019.07.02.18.45.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 18:45:53 -0700 (PDT)
Date:   Wed, 03 Jul 2019 07:15:49 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20190630221408.8509-1-pbrobinson@gmail.com>
References: <20190630221408.8509-1-pbrobinson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Bluetooth: btsdio: Do not bind to non-removable BCM4356
To:     Peter Robinson <pbrobinson@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Message-ID: <D78E9769-8AFA-4BA1-AF16-CE4E4F08B14A@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Peter,

On 1 July 2019 3:44:08 AM IST, Peter Robinson <pbrobinson@gmail=2Ecom> wro=
te:
>BCM4356 devices soldered onto the PCB (non-removable) use an UART
>connection for bluetooth, such as the Rock960, but it also advertise
>btsdio support as a sdio function=2E

Sorry, I don't get the point of this patch=2E What if BCM4356 is used in d=
ifferent configuration on some other platform (using SDIO for Bluetooth but=
 still soldered on the PCB)? I haven't seen any such but just curious what =
if!

Thanks,
Mani
>
>Signed-off-by: Peter Robinson <pbrobinson@gmail=2Ecom>
>CC: Manivannan Sadhasivam <manivannan=2Esadhasivam@linaro=2Eorg>
>---
> drivers/bluetooth/btsdio=2Ec | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/bluetooth/btsdio=2Ec b/drivers/bluetooth/btsdio=2Ec
>index 83748b7b2033=2E=2Efd9571d5fdac 100644
>--- a/drivers/bluetooth/btsdio=2Ec
>+++ b/drivers/bluetooth/btsdio=2Ec
>@@ -286,6 +286,7 @@ static int btsdio_probe(struct sdio_func *func,
> 		switch (func->device) {
> 		case SDIO_DEVICE_ID_BROADCOM_43341:
> 		case SDIO_DEVICE_ID_BROADCOM_43430:
>+		case SDIO_DEVICE_ID_BROADCOM_4356:
> 			return -ENODEV;
> 		}
> 	}

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
