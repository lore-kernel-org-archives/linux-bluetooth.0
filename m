Return-Path: <SRS0=eDkG=EA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CFDC388F7
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Oct 2020 16:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0298D20853
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Oct 2020 16:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUmoLWT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417265AbgJYQoh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Oct 2020 12:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbgJYQoh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Oct 2020 12:44:37 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06584C061755
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Oct 2020 09:44:37 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id t9so5050080qtp.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Oct 2020 09:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=cfV91v4iPTtYTleP8xNQQK27v6VS850Tu4Q37i6rTK0=;
        b=lUmoLWT9bNTbVIN18DHt9/nHmYYEUm/Zb8NF5fq7jK9LXFmzpEXD4ZI6Er/+ZHE5tb
         xn9U/CEwxqURT6p26AkZLCJGLUZQWCVMbA3xcA5zUJ0K97g1w3aRolsKrRn8yPYhDuBG
         CoWSKjrQc5eTSfaT+wLO1t3oe+ZtR7k+0XxQmWH6XiSr4qJrJ06ja+vZfjJDQSmpCtQe
         HollcIs+V6xFhu1qbcz2f1IOO3pdZz0sasD0lSOMljsWunpvGRYcqpOcBK/afF9mOKmO
         WUx+p0ORLV6brOrf2RnC7IC44TGGmbGEf+61Notjs7l1XzYgChcPUhEPqWrHztEnr8ER
         Zkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=cfV91v4iPTtYTleP8xNQQK27v6VS850Tu4Q37i6rTK0=;
        b=hP1XMktWfITxMxmini2IqBi1Bjg2ehwqX3vt+ngst7qhI4LjN8HsnF0F92AH7Wy0Fg
         zCKi/uT0kF/VLjx55fTodTGN6w46Bv+lTxRGO/pKtpan8E9yXVOMJlJnoeeoi5rFU9tO
         Jg0dgFrovk05m9mtmVa5VWn6Hq2Fxq3btWCVajR04loyxC/7Mf2UdQxg5Soa//K89VcW
         GxPf/LcohJ5d1gf/Cep9RbA2lxGrD2ZPIYM83jy/aeAkK8QxOCAkgg3SDBbGP33swns0
         zJbVMgLBZy+A7Bx3YD/Z/DCsnUGlWyHNLyBvBzTnuDGG8RFKNqgl/rAkdundFRe7NdJI
         FfcA==
X-Gm-Message-State: AOAM532l8ECamoyUgcWpkH+6W8g08npdviBHsNPoXUEKb0PXaMuZ+AFt
        vzDwuULlV/wrmXUlZ41P6FApxdS0lX8wBg==
X-Google-Smtp-Source: ABdhPJynzfn6ePeJeRTWo8MI5buyEMtmJfXeoaCmT06L/9gTFgsbqphf0yKIGrBb9A0LUJ39pEFy6g==
X-Received: by 2002:ac8:d8d:: with SMTP id s13mr11573926qti.42.1603644275104;
        Sun, 25 Oct 2020 09:44:35 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.215.11])
        by smtp.gmail.com with ESMTPSA id r201sm4832707qke.55.2020.10.25.09.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 09:44:34 -0700 (PDT)
Message-ID: <5f95ab72.1c69fb81.5f673.b73f@mx.google.com>
Date:   Sun, 25 Oct 2020 09:44:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6308720480282036816=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marijns95@gmail.com
Subject: RE: [BlueZ] audio/a2dp: a2dp_channel should have a refcount on avdtp session
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201025162730.47247-1-marijns95@gmail.com>
References: <20201025162730.47247-1-marijns95@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6308720480282036816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=370053

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


--===============6308720480282036816==--
