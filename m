Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49597C28D13
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Aug 2022 13:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242742AbiHYNum (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Aug 2022 09:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242829AbiHYNuJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Aug 2022 09:50:09 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F0524BCD
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Aug 2022 06:50:05 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u14so23344475oie.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Aug 2022 06:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc;
        bh=ZMdGxwSpOKK0gNV8miX+L3+hGl/idUFqKq7wnHFVIFg=;
        b=JDzXMoKNnLW+qjPTQUtYbngkTmnBKzgMlUnrRDCp8ecwmxU9UyiE59dbOeh/mp9WnL
         erJrDIqBdgbH6Fe+UG+UA81WV+10VgQKPWcJjfxVvwg17GStjS4vEmO3HojiNbgPrkNL
         26GWhkzzTiPSIUBe8K8ZVdzOos7CDhti98sSR11C0fqXNK5KyNfqm/M/oJh3mJ9fLd0z
         1Tn1X/Mr9H5yDXNPZPNpHFBJwPvLkUPgeQZRrbW09clzq+cGCKXLhSDk8LzcMMJt97CA
         mlV80kXECTdH6Fy9hmunR6a4jczCtSBpelLp+k+MP/5KaqtAgiVxE0YQs+IPqCq5G6Kd
         5n0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=ZMdGxwSpOKK0gNV8miX+L3+hGl/idUFqKq7wnHFVIFg=;
        b=jKHXD5NUCTDJz0mNk/lVqFcd+qMzaKJtnEZ8jn4FfDE0obz5FbN1yFJFxjV1riEnsI
         abPS/luKebxVAL9jBWP3FtqoQWUrDrd69cpCIW1plqHauCYtp2vnqwanMnbOpFtjz+GY
         qW5VSW+K8LP3Oui0Wk5AvLX6SA8/sR6+kZzjPOhaEUM3tPeMpKyzeuZEVhMV/HI+gPFT
         Hxz5by1jOQEAPwJcpY/ybpACb68P/slBEeOHcn8QuUcbd9dnmukzQVdSisKfquT3Xz8N
         HNr50L4FwQDKUj9P2K+DtXg5LDdIQCuVrulrPcNiiQvrmtNxSLloBwb3OgJn5EXqqVkK
         zblQ==
X-Gm-Message-State: ACgBeo2g/xqLmlbq7/TkIEeL9ZeQEpKgb21L8WEHYmt/cTu4poKKkEvT
        TcMaojG2Fd23/0WzNfat1rZRedLIRLrK9Q==
X-Google-Smtp-Source: AA6agR5Ey4V7N4aBpa8kF4H0VGMj9aCAO34Ikro3pvi8eUAeFUTKrqLYNbIzSDz/oD2fZK1GakKhPQ==
X-Received: by 2002:a05:6808:15a2:b0:344:9c1a:1a2c with SMTP id t34-20020a05680815a200b003449c1a1a2cmr1810055oiw.84.1661435404766;
        Thu, 25 Aug 2022 06:50:04 -0700 (PDT)
Received: from [172.17.0.2] ([23.102.131.203])
        by smtp.gmail.com with ESMTPSA id l19-20020a4ac613000000b0044b491ccf97sm829624ooq.25.2022.08.25.06.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 06:50:04 -0700 (PDT)
Message-ID: <63077e0c.4a0a0220.4c900.375c@mx.google.com>
Date:   Thu, 25 Aug 2022 06:50:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0396029981737580852=="
MIME-Version: 1.0
Subject: RE: adapter: Implement PowerState property
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hadess@hadess.net
In-Reply-To: <db39101f70c945026e76d7b49ee358d9a2330358.camel@hadess.net>
References: <db39101f70c945026e76d7b49ee358d9a2330358.camel@hadess.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0396029981737580852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: corrupt patch at line 20
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0396029981737580852==--
