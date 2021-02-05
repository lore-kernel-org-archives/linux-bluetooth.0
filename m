Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A97CC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Feb 2021 04:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AD3164FC2
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Feb 2021 04:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhBEEkp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Feb 2021 23:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBEEkl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Feb 2021 23:40:41 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC1CC0613D6
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Feb 2021 20:40:01 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id r77so5733642qka.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Feb 2021 20:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=hAVPqFw6vu+ZlUjp4Qcu+3QbQRQMEHH8y7kbRktmSnk=;
        b=ZxZTvFe+rZ6wI0NwdzhuA+hRAZ2IpRV1qKrcN5mn2TNcvp/QJVmIQ99VgpBI7Tvnoi
         lx8/GudZyvk6Zl6GMP3+VPw7SPxnEA7rW4rWEmADTE02Wz3RfWTQgiMcUP0J9rKNQgco
         nnxDk+j3K4fnVfE0vAe/Xda/E2a5StuQmwTGVd7wf7E9qtxthuJ6mnJ9MZlNXTBUf++R
         sxUBy9Fn4rpvFyvhEoDzB8R2kQKrD1QsGwKZqSS4s8U2bNeCvRg3VH55WzrS0cwOfowZ
         G2fpeQ68zVh01CuGQjVeqn3KXKdXZtXby4E0rJKsLqHdNzrwHrTyCpzoZb2BV2RF3fbR
         2VbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=hAVPqFw6vu+ZlUjp4Qcu+3QbQRQMEHH8y7kbRktmSnk=;
        b=nSFCEAl7QIzeI9ExjQEXjfhEnOCORl4+DB8UpxyV5H8ySvi77iyMDiWX7IVZJ4LCO9
         PO/mruJ8lFYRKm9B+6IdwecmN9eu9dZKB90QZI7SxXAjMceseKYReF145drq0g08TMW9
         LPUnChEgOkdQTOB1sPy0E+dlUN3+Kx6VFjObKqR5jlTSzazY4pwB4DOK+yJdhWXkRECZ
         MevdtrfUqaUyKUnv/VKdcMpgdFNu9Ta0XwFJ6ZEM2+jwJ/kPSHbK3dZQJk9lLLVQH9V+
         /ttfoE7u8oZkFS9LZyV15s/eNok8wazgcOXFacjT1Rv3Uvgg4Jbn1vQTimCGJ1kc8ekI
         2zhw==
X-Gm-Message-State: AOAM532XfRzcGcZdEmqJHEqfm09aze4+AmrBvFErMx222gM9q5DeLc8I
        M2C3nieumw7AmnndpXgD8rO8XlN9aiiz1w==
X-Google-Smtp-Source: ABdhPJzo8wNUhIfDgDC88+YPV6VWfYtBCUMnQXE3av7bGA9ofV/NNSttS99cVBW3etiQqGIuhtzHDw==
X-Received: by 2002:a37:5c3:: with SMTP id 186mr2717729qkf.32.1612500000650;
        Thu, 04 Feb 2021 20:40:00 -0800 (PST)
Received: from [172.17.0.2] ([13.77.78.126])
        by smtp.gmail.com with ESMTPSA id h8sm6558041qtm.5.2021.02.04.20.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 20:39:59 -0800 (PST)
Message-ID: <601ccc1f.1c69fb81.4084.e3cb@mx.google.com>
Date:   Thu, 04 Feb 2021 20:39:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1382273541480888672=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v1] a2dp: set session to NULL when freeing channel
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210205114735.Bluez.v1.1.I68cf9b7c0c0c3c0e069011976e3008ff11374a28@changeid>
References: <20210205114735.Bluez.v1.1.I68cf9b7c0c0c3c0e069011976e3008ff11374a28@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1382273541480888672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=428439

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


--===============1382273541480888672==--
