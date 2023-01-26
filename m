Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831E3C05027
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Jan 2023 13:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjAZNoB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Jan 2023 08:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjAZNn6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Jan 2023 08:43:58 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101EBB755
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 05:43:52 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id e8so1245055qts.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jan 2023 05:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:reply-to:references
         :in-reply-to:subject:to:mime-version:from:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYCd+Y2a1E5CxHut3DUr2TCm+aNTOa6IRNXeQ+InEfA=;
        b=TYEnYsRrpGDTXS6ZXNoYGEaZC22Cof6p4Lv39Fp0cknOokMxHNPbCgQ03py3DZoRNX
         25dmtDrZEOvxBS7TyBU4ze0DNVH5XsB3s4bJqlRr8MDAYaliSu8J1s3L/iopaAv85JIn
         pklkCKLId/wLSY8dwlbqpNwOv8eVenaZmXnBBj5zt+AfXMHHvkm3EG/WSAr7Sr3HYERS
         0ay6ZlKAOu1Zu6xTiVihgD+9lOTkebneE4q117mzkfMOTzLEaWT2qQZj3nSWAHJfLdTa
         cd0Y5G+XCCFWjVypEm7nRXbc3dhGSdLHkzLXer/ax2nuJcHN5NnKuRJqEjIHWQuAcnoz
         JKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:reply-to:references
         :in-reply-to:subject:to:mime-version:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FYCd+Y2a1E5CxHut3DUr2TCm+aNTOa6IRNXeQ+InEfA=;
        b=wKp07ilXWT1/pvgrlro10Pgo+uH8H+jWaQrSylW5YEJOT1PUtcXCCBXtpYL/0AqMUV
         vQEkG9iuwXEsiH1TwmT8+rRMS25bPWNgxUyXj27INn2pf82NFYBYs2o9aaB0eM3hVEVS
         7NRNG4ITGhm1qXELGB1KivsyD9WcQfar5etrWqQvGZOU9+SrLsmfraVxgaZhrEMbpzvh
         u9PX1f+Yycm6Gh+UMHfPC8nsQfdhqDT0TAtg1v5Bm39Q3N0VEoitfC9P72gq81D2/1t0
         nDSdhHW4lTJVB8VNsZMa3OghvUA983utl4fn71NHNevtihMdTDDhoGp4iIywuOJ3zeG/
         xLpQ==
X-Gm-Message-State: AFqh2kqCR9P5kPI2954N8ogQMvFj3gR4i/ord27sr5iet3hENRUOzvJ3
        VyoJNOyIdx/xK98dq9HZnQdOjQo2hKwe6w==
X-Google-Smtp-Source: AMrXdXsHZB29/M8utd+oQPFaDgL+sczE7mSBQWdMKchNeoDC19zyd7g3CSLnGYa0ZVRJqZFsmd1/Fg==
X-Received: by 2002:ac8:5488:0:b0:3b6:9a0d:85b with SMTP id h8-20020ac85488000000b003b69a0d085bmr32542448qtq.40.1674740631578;
        Thu, 26 Jan 2023 05:43:51 -0800 (PST)
Received: from [172.17.0.2] ([172.176.217.64])
        by smtp.gmail.com with ESMTPSA id j3-20020ac84043000000b003b63187dbe1sm749879qtl.27.2023.01.26.05.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 05:43:50 -0800 (PST)
Message-ID: <63d28396.c80a0220.af856.2122@mx.google.com>
Date:   Thu, 26 Jan 2023 05:43:50 -0800 (PST)
From:   bluez.test.bot@gmail.com
Content-Type: multipart/mixed; boundary="===============5351782364333776931=="
MIME-Version: 1.0
To:     linux-bluetooth@vger.kernel.org, pchelkin@ispras.ru
Subject: RE: Bluetooth: hci_sync: cancel cmd_timer if hci_open failed
In-Reply-To: <20230126133613.815127-2-pchelkin@ispras.ru>
References: <20230126133613.815127-2-pchelkin@ispras.ru>
Reply-To: linux-bluetooth@vger.kernel.org
To:     linux-bluetooth@vger.kernel.org, pchelkin@ispras.ru
Subject: RE: [4.14/4.19/5.4/5.10/5.15] Bluetooth: hci_sync: cancel cmd_timer if hci_open failed
In-Reply-To: <20230126133817.819879-1-pchelkin@ispras.ru>
References: <20230126133817.819879-1-pchelkin@ispras.ru>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5351782364333776931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sync.c:4703
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5351782364333776931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_core.c:1632
error: net/bluetooth/hci_core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5351782364333776931==--
