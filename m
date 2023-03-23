Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D72C74A5B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 18:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjCWSQa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 14:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCWSQ3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 14:16:29 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A01546B2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 11:16:28 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id k2so23089888pll.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 11:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679595388;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j2/t3LoIqCu7uVL7NxlVmBH4rAsd3ycwQWrzperGA/M=;
        b=VWhLMVnzx8Qtqg/tqq1rgIRBiiq+r7yH6/jAXx8b5tJMrm/F8uqk+DAKCxSpoapPZ0
         vT/p9DxZlW7dCxy2R3Mb2g5lyxgH+dBHXrOEcynecvv3EgGddz2gw1ZYtmmTnK/Az1tl
         a1ZTGJqXIUBfeK9ZQ6qfeopZMFNs9muoB+oUuirh+8iVV8eoICbHasSd3AdVjaZAXUDj
         h5GWhztQ45oJ5S7X6RRhP5flY/VuQa/VjCIeA+cNK1HcNRkys6ECmJ6AjE1Z4F86K0fr
         EEluFPERMlT4PefLl5FJSsZ9BeTU6jN6NYIqSosrnQ73CHKzkk9TFHovFR+SuxkVRYbe
         sp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679595388;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2/t3LoIqCu7uVL7NxlVmBH4rAsd3ycwQWrzperGA/M=;
        b=BeQ51IEG7E/1hSL8bNnEyGMUQ5P5hsU7jriNBxkaHEXaTT2PTnGj/aFnKH7B/oXMAV
         t1aocVd5D9sTqkaTXHTTeb0khhrAue1UFywu08pO8LPPDVfaQ5CufjAoAkoy6jFPxge3
         4X5LSECkHJ8gvOB43oqiSjXuBG7oCAqeZHPoIjTU3q3kakaIxOM5rGQOT/622Wo8lOn8
         MrOPezDMVn2HmAPEPbLTjJRcMF8+3Wg+TgGCjbVhKE4i32wi51zfxpMf0jDU7Ydoh8WP
         Ex0hPMYihrZhRSA0MpyRyudXWFHxRbdkDYHliotfXJ309vGGbMCRCi9+C8j+BmBBid05
         kEsQ==
X-Gm-Message-State: AO0yUKVMXJqad3nex6I+weHbRNbCSFfjPAiEjJzoEzsoYkk3MCeqfT5w
        nABkcj2efCgr1fyMmady383fDDVdKFU=
X-Google-Smtp-Source: AK7set+LiDxHrxfBQFei2M7y+uib8jsIjFLa0EpRkGINGimbDgob6voO4o4GNIgYlcfH2aMj+vFDJA==
X-Received: by 2002:a05:6a20:65a9:b0:da:a6ef:5344 with SMTP id p41-20020a056a2065a900b000daa6ef5344mr479478pzh.21.1679595387618;
        Thu, 23 Mar 2023 11:16:27 -0700 (PDT)
Received: from [172.17.0.2] ([13.64.10.195])
        by smtp.gmail.com with ESMTPSA id u15-20020a62ed0f000000b0062a474cd46asm1928751pfh.137.2023.03.23.11.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 11:16:27 -0700 (PDT)
Message-ID: <641c977b.620a0220.8a061.4161@mx.google.com>
Date:   Thu, 23 Mar 2023 11:16:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5410984036046613482=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, Larry.Finger@lwfinger.net
Subject: RE: [2/2] Bluetooth: Add device 13d3:3571 to device tables
In-Reply-To: <20230323174604.30088-2-Larry.Finger@lwfinger.net>
References: <20230323174604.30088-2-Larry.Finger@lwfinger.net>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5410984036046613482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:542
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5410984036046613482==--
