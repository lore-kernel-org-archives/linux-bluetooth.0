Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833A8C77B7D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 May 2023 07:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjERHMj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 May 2023 03:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjERHMh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 May 2023 03:12:37 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6F81BC3
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 00:12:37 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-623921866bfso1486816d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 00:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684393956; x=1686985956;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ue+54R+9AexdNj2GUOLrfH6oLieCilawxb7/tXwHT3s=;
        b=ICeSBZ+d2lgUMMlohaCoG4U3XWQBaXW11nhaQ6/DiyxBUjFpOm7n3EaecMF2av+CEd
         AvLhh+15dqk9fXnaFA5Pi944GEDxltvrLbQvtdpI+9K6nyasSIJBwSjh5fgcwPuupgfq
         d9zdIG/sbwABvHJTdtave36SRMSVgO221KhjUmCKmQgKjEoD1lM+3mlnsOOOONdgv2nb
         sgx7kdreQm41h3pv401VrZGbrYqN2lH5Hk8Y7Mpu/2sk5zcSWQ7Lih4932ws+i73FVLd
         XxYxGLfEt/bpmnG23a+L+oq9S/TAJF48peG2TqUNJKZCT8LGTn2V3KvWKlmfBIr3B5uJ
         8kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684393956; x=1686985956;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ue+54R+9AexdNj2GUOLrfH6oLieCilawxb7/tXwHT3s=;
        b=dpugnWVwUchKQGucYfyI3N07Qs+zD7CjdVC24A6m4eA1OUbLALxQETS4NB7+fCcK0p
         hUHoRS7uji3WFM1kqizN2dllZR8N8kbiWaADN5+jQi9c8zLWMGw1KdzHo3f1qvsk0ock
         /N0LbJl4jmIRtQ4ruYRTfFMVHY2iSbiBTbSCBOpUS3orCyCGYhear5E7FMBS9bgOE96Z
         +524vBA0PqODKW2dlqkvgmL/r+EoLrobg2s4pXcMsAdDzMQnVS0uFDkS28jzE8t5fsss
         irFAMmVRJTUqca6N4CGyRkt6NBYKcV48plVfUoe/OeURP/aE0GQi0bI/UaqMQLs2aG9z
         H3uw==
X-Gm-Message-State: AC+VfDxcfbKppLRfBWkmusFKJko1TQDcsFa5SBa790oprc5dYhTdiDJA
        lwi9yt+Kf3KmzEuDA+ItGQwbq3hFx8g=
X-Google-Smtp-Source: ACHHUZ5mMp/yvaLocUeFFxNgIafNRI5EntSuiyVNspx3YCVyhhSnSvUnVGHWmYZ/q42NbgaKRKrGmg==
X-Received: by 2002:ad4:5f0c:0:b0:621:712c:fa03 with SMTP id fo12-20020ad45f0c000000b00621712cfa03mr3738102qvb.44.1684393956175;
        Thu, 18 May 2023 00:12:36 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.120.48])
        by smtp.gmail.com with ESMTPSA id f15-20020a0cc30f000000b00622cddd7edesm320080qvi.129.2023.05.18.00.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 00:12:35 -0700 (PDT)
Message-ID: <6465cfe3.0c0a0220.7523e.0eb6@mx.google.com>
Date:   Thu, 18 May 2023 00:12:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5791565250632701281=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: btnxpuart: Fix compiler warnings
In-Reply-To: <20230518065219.2472678-1-neeraj.sanjaykale@nxp.com>
References: <20230518065219.2472678-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5791565250632701281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btnxpuart.c:1264
error: drivers/bluetooth/btnxpuart.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5791565250632701281==--
