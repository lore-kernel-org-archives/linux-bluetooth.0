Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EB8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 01:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239289AbhLHBea (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Dec 2021 20:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbhLHBea (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Dec 2021 20:34:30 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD3FC061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Dec 2021 17:30:59 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id m25so918057qtq.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Dec 2021 17:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Z478CKRuA9y5dCxgm+TOOq9VpFg/HCyL72e3VZJ659Q=;
        b=OLZyHsoXFumVrVJ0r0WlP8I9BFmodz7Pev25wqG/BI4/W8RMpCMUURV3GW+3AbeNyU
         3UPo3oqVj8l3Rcs7qXPn4W2DFmSdBBeR0PWwVRWFTAHkrfQms3GbZ+zRgjRwDqhF2mLg
         78b1KD79OdDks6u3LhxozU1wGn3eapTK3yS6ZW4o6k8W1d2/l+kWtq7r9huoBKFbMA8y
         Nhv4phdNbMuaMU7j2OgzXEv6IqZTxTIjCcrTczO5rQPHm21r6noX31KOZWfzroF2opuF
         x1n96dry756waEzEcfDRfoSFpWYsFq9iphD0T7DgJjghZsABX8dphQAR2DSKOqyA1//G
         6z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Z478CKRuA9y5dCxgm+TOOq9VpFg/HCyL72e3VZJ659Q=;
        b=7GIQ15hPEp4wLx+g2R75Tyy69a5oG9EW1w/hDCt8W5VTpHljdMp75UWQVe3LE3U9hZ
         nhmDKOn6Ky3l5mDcnx25fnWJju+Ie096IMAiFAvJmB87djRPh6hPaFM3yJBMl/1P/cYY
         +O5RYv5CkpR2mowIfoPrWhd1qtnGhHeZGDXeMjCW7zPfh1ZNnnf27ooaztM/cTpbzLis
         eEVvuN+YXQnB5H/iC4D8tj/NcX9+peiY4CT1gD8zK1+Q4V9z8+88C4/hYgl/4sr+G68Y
         pHPd54Y+mCLoGVkiaLKUkPSwGeAuhFehCze7N7PhJbJmNXw29Ggr3fYUSHtgirlqLXe5
         d1hA==
X-Gm-Message-State: AOAM532Svo+ddXk2WID69SMapbdbqd31ntUvTrlTveEah9vOIdeR2lTY
        GeggQqJUw0c1BAzhVidBBRXw7avq0lzP7g==
X-Google-Smtp-Source: ABdhPJyEKuQ+R2rnlOMiummrjSAzuCuTGpa581Hf60hms6iTVXMwBhumUPwnwzMh0FAMXDVLjFOWVQ==
X-Received: by 2002:ac8:7d4d:: with SMTP id h13mr3892742qtb.448.1638927058629;
        Tue, 07 Dec 2021 17:30:58 -0800 (PST)
Received: from [172.17.0.2] ([13.92.211.52])
        by smtp.gmail.com with ESMTPSA id n74sm680993qkn.83.2021.12.07.17.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 17:30:57 -0800 (PST)
Message-ID: <61b00ad1.1c69fb81.1179.40c4@mx.google.com>
Date:   Tue, 07 Dec 2021 17:30:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3881879912636984348=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: Replace random number generation function
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211208005446.196637-2-hj.tedd.an@gmail.com>
References: <20211208005446.196637-2-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3881879912636984348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=591967

---Test result---

Test Summary:
CheckPatch                    PASS      6.41 seconds
GitLint                       PASS      4.35 seconds
Prep - Setup ELL              PASS      43.18 seconds
Build - Prep                  PASS      0.47 seconds
Build - Configure             PASS      8.22 seconds
Build - Make                  PASS      186.52 seconds
Make Check                    PASS      9.53 seconds
Make Distcheck                PASS      222.57 seconds
Build w/ext ELL - Configure   PASS      8.31 seconds
Build w/ext ELL - Make        PASS      176.44 seconds



---
Regards,
Linux Bluetooth


--===============3881879912636984348==--
