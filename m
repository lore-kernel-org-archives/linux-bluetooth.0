Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A86C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Dec 2020 06:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF54208BA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Dec 2020 06:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgL2Gpj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Dec 2020 01:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgL2Gpi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Dec 2020 01:45:38 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B825C0613D6
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 22:44:58 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id u12so11376697ilv.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 22:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=liT9v44sDFb7n1X4DhPkXATQRagrwsLjxcHACXfoutw=;
        b=F4UybZmr2euhPCv2YuM0TJ7AVqzEDRd0k/N/8I6mCp9LHwMKTZ8ufTkyr6PL++3gmD
         3MlAn5xwtfUVlH8UAtKZ/JLoIch+C4Lz39cn+52fV9kkSBbThJn+kXZRXHpLGEmP+oCg
         gnEDy87GClCl3HvCtyb8qHm4TMJcTESqyeyU7RkhEP/+US+eA1YExQiE3kILElfvkEfO
         0fnPJmrttD/Bc2GtOObWl+FeYVa5pQsW5+zi0VR+kMkNkOenLW8nUSHQf5g2NaVOsHmW
         pdMdLVg5mfDXd+R1UFC04VJVAWx0qxeITiRmF3YbW0lUomWvcRieyEjSYYXDuDLDooEb
         X1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=liT9v44sDFb7n1X4DhPkXATQRagrwsLjxcHACXfoutw=;
        b=sTlRR8hm4ovK0an0mmbw8vDtdkwRhjCGRHwJ9H3awuPyXO5f4HxLTyjrFuO8cPK7Jg
         tOzgH+ejGAeQ89WEVAR1H3set+hvBFI2dxlv2cr5HocDIa4zi+gYeoji8yJLqBmZp1cB
         uffYcMEmXI/AFi/ikBb+jJQalymTBtgHMwlKXRI75YEN1jnFmYvRnUkNk8GCqo5aP6O+
         USOwUlUDPwhWfJgOwhf69o+QdY1nTjw3Rf7ps6eMPdCUpgHZZguCg/RTm425RL3dnAls
         bOH4/AacoBm/HhOScKCTBiesDxFBkQp2zsy4OsEZGKcNsa7oML6Akcbqz6PadbCqP/+V
         nHyw==
X-Gm-Message-State: AOAM5307K1CBNfILHcbqM6SV8fWM7KfzbEwn3O5hsoJUvEYKlWT2Kz46
        DrFQHnMGe9e8BgDIbNruBWSZavZ/iDw=
X-Google-Smtp-Source: ABdhPJwyYd8n6H9PsvAhXkj4CHZ3htfails88at2/hfq7IfXwr5sugc9GB1ftryyaH1HaQgc6UFpuA==
X-Received: by 2002:a92:2912:: with SMTP id l18mr46313237ilg.173.1609224296851;
        Mon, 28 Dec 2020 22:44:56 -0800 (PST)
Received: from [172.17.0.2] ([52.184.192.162])
        by smtp.gmail.com with ESMTPSA id y12sm30453947ilk.32.2020.12.28.22.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 22:44:56 -0800 (PST)
Message-ID: <5fead068.1c69fb81.f9a35.186b@mx.google.com>
Date:   Mon, 28 Dec 2020 22:44:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1883704458934579852=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v1] adapter: Don't remove device if adapter is powered off
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201229143408.Bluez.v1.1.I7978a075910600058245dc6891c614cf4c7b004e@changeid>
References: <20201229143408.Bluez.v1.1.I7978a075910600058245dc6891c614cf4c7b004e@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1883704458934579852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=407063

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============1883704458934579852==--
