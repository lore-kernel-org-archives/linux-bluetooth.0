Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC20C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 22:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1598923AF8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 22:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbhAVW7t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbhAVW7X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jan 2021 17:59:23 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F59C0613D6
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jan 2021 14:58:43 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id a1so3462970qvd.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jan 2021 14:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=1Rd9kElv9zHhh8cCqDiqcF8x2iGLk6KSwHg8Thx0DqM=;
        b=rRtY6kBRBG6HRXwLF+E3+UDX18rIK8SHscsvTMlpLYabZkzI6gRjzmkHUX3weGtcfk
         cjlBC1idi0i5EPQOzTWMPEy/Ng9Hc6ArDg+9jm89jxtAo8A597d/M9S5oYEUgUa9hKF0
         caiMkDk5SVb99IIVd5jDaGVnHEooPkc8KQdPGn8Ebiffgiv73HPt+JSZXUdG8WwFxk5i
         lAUk6EvSbNzjM3VSF2ay+G3eBntJdUw9hByJ4Ln/34nyT9aJDSoXmK+QTPMLgvzLMzgO
         /1Gz5BeJZ1EMnKnkDlaMXnHxjudx+TFX/vsncZ3uts4pXBEVmmrcGOIxb++jMOct2Gij
         c58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=1Rd9kElv9zHhh8cCqDiqcF8x2iGLk6KSwHg8Thx0DqM=;
        b=M2PCEP8pZ7tgqiJ1ZMMHyMeItRPzOXkB9lfPP11R7tHh7gK0W56fMouK++iES+bBv4
         1+Xc2MZcZ65x1pUGAQctwwkBpysATDCBjx2x3WC//QlYWRutZ84aWW2KSxTPYo5N75IF
         FTf0fioqvCHXMhYGPbWnvY577v01fL/32EUhGm4+7LNcm0NeiTvJgYt6aQDxJ+OSCBmg
         Ap0IW3mBeDciZK+gs3RgW/hJURtV2m1MR8M/Hz66GREn8J30T/W3WJwgBs5GwIJ31E/X
         tA7BwtvVO6GKLfU/N1X5CngIS/VKdcxg2fqKTCQDSbRQE5/SMCwDnajWRefF8AC+TWal
         S/5A==
X-Gm-Message-State: AOAM533pbgMGWjr3l+HUV6uEZDIodOcN1mGrdFojZq/sfw+0/nFDdj0L
        58qhJF0FogtKYlzhk59HE+DW2G2Hec3Ev5aX
X-Google-Smtp-Source: ABdhPJyC8Wn7OOFAENTDL5D5fOFlSLalSoRcHBHrBdM3imojFjraHuiiu0TB3luCWOfVIBFGnotWIg==
X-Received: by 2002:a0c:80ca:: with SMTP id 68mr265181qvb.28.1611356322799;
        Fri, 22 Jan 2021 14:58:42 -0800 (PST)
Received: from [172.17.0.2] ([104.209.216.11])
        by smtp.gmail.com with ESMTPSA id u26sm7171779qkm.69.2021.01.22.14.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 14:58:42 -0800 (PST)
Message-ID: <600b58a2.1c69fb81.70de1.a75f@mx.google.com>
Date:   Fri, 22 Jan 2021 14:58:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0430580256805773507=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ] tools: Fix static analysis warnings
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210122194258.538970-1-brian.gix@intel.com>
References: <20210122194258.538970-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0430580256805773507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=420291

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


--===============0430580256805773507==--
