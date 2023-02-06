Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85219C636CD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Feb 2023 00:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBFAyM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Feb 2023 19:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBFAyL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Feb 2023 19:54:11 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930E313DFA
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Feb 2023 16:54:10 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id h24so11278095qta.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Feb 2023 16:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cnf84Gx87hqq0g6YozW4yuxzu+j4qVN9BY9niDBm9RY=;
        b=jDOrOj+p75TsKEa69FT/KlSZA0nGXclk7uiUxaZnfbxoP/fVANII0zpZgXfHtmz5c/
         U2cdP62aIBMpSruD0bP9gX3xlxlu30hFGNkoRbuNITYmHN1MQ3YNgv3DP7yXLy08M41c
         gepz7s6UDKD/uWuLJpx41RMHOXXWKcExWiyfvl3vAIWVnEJ18vny/RYputTEmXO89cqq
         GEFG/lBUILKgApjGiJFpB+ikekWnYDjKpiccwuCz04rQQ3q8YZcDDSr1OBxBiXAUJGbc
         GVNFRs67KlEr7y1vkp6NXuv38sUy2oF0GdwBzf29H/A/Q14Hx4wDbzhIZpu/0ZzZqLjo
         9Yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnf84Gx87hqq0g6YozW4yuxzu+j4qVN9BY9niDBm9RY=;
        b=W5NWGtoJsA8vHHGf0QvtlPDSqdpBY+TwGCCpIAE3o0fLlNbKR0SXTzqUPYnLGVsttW
         eIvMkoXiJuIn4wQvGpyS49oK1B2EvusGMMXKHJcLkXlP5bcSrA5P1lxskXZQitf2Ks9t
         xjyHKV08PE+yWPqhXqpJsDzRChdXxGCMqUiC297pXuZ147RHgQ68jSa1yulWi4CFs29H
         +Q8dC9ZXkVOVB1r1/TN6lRsvAddtwXy8je3uqQx3srDBeyoGAPVATpE1SwQlnW4UKLwH
         3/9I/SOTtz2mtSzfeSmNa2u45NsNF+hdcAjT3BgzgajH8bQjHKDwjccXsGMw+/Ehby6b
         p1GQ==
X-Gm-Message-State: AO0yUKWzafbZQbXtET45ripu5kE9iFm3JyLUheC4K3/qcnWMirafSXCW
        gJQ8M35GlEfDhMg+wtn9X9WQELrT+J8=
X-Google-Smtp-Source: AK7set8bKb/3k5MJW6nSHr1LN2IRGaF3Iv37v2NNtHZX1lP6UHgeLTuZDcf/HYiKqht0g+i4awkucA==
X-Received: by 2002:a05:622a:100b:b0:3b9:a441:37f3 with SMTP id d11-20020a05622a100b00b003b9a44137f3mr32647908qte.64.1675644849379;
        Sun, 05 Feb 2023 16:54:09 -0800 (PST)
Received: from [172.17.0.2] ([172.176.163.144])
        by smtp.gmail.com with ESMTPSA id s25-20020a05620a16b900b0072ed644bb0dsm5601159qkj.97.2023.02.05.16.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 16:54:09 -0800 (PST)
Message-ID: <63e04fb1.050a0220.a02fa.e6b6@mx.google.com>
Date:   Sun, 05 Feb 2023 16:54:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2899784114507301041=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, steev@kali.org
Subject: RE: Attempt at adding WCN6855 BT support
In-Reply-To: <20230206001634.2566-2-steev@kali.org>
References: <20230206001634.2566-2-steev@kali.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2899784114507301041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/sc8280xp.dtsi:1207
error: arch/arm64/boot/dts/qcom/sc8280xp.dtsi: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2899784114507301041==--
