Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A46C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 20:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 821DB2415B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 20:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDHMhXah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbgKTU13 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 15:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730702AbgKTU12 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 15:27:28 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BCCC0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 12:27:28 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id b16so8095727qtb.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 12:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=WfzK7PPYWGNMwGAfvdGEiVHaXfzdWfLQuU0NKP5BFus=;
        b=HDHMhXahzD/zOZ5IqNIUsh6l+Mg5fPXvAL5Q8YoSfZhpmRq5HCpHdaMrj1N9UjhwEL
         dX+UZLyKqJA+tyT/JkWRa6EFmcKSVm02sZXM1fqlwdDTMvMQgaFQA6X37hNVhS/QDKny
         anivmlRxPZ1BJOBFhhXygudWth2G/GxRxkkl/LKjq9vTxmlZnF6etwSofrcc1ajgMtWN
         9L2lFXkhqGFt7s14CYUtI8V2i5L7asjLHSPXNxE2zBD3IA+999o4lKTR+Wh1cxMNMLy5
         JQGMHX0ReLKVKLDY+RNuWjvgUxgL0vzN03Nzbk5gQZxx1tZTh/2Cfm+VgixALMJpdN/U
         9RFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=WfzK7PPYWGNMwGAfvdGEiVHaXfzdWfLQuU0NKP5BFus=;
        b=ZZGPGikfhEGegui19M/m74KsG7ijX4pnORD7X7glwgCRLy27h2NcFEl2TSTX7vAVPy
         8w/pLV2zAzsf3+zLAVaHWpEIrIo3lTXzCZexoXNRjEEh5x7nW0eWyYy2Q6BGg0DtpD8d
         v5hUL6o9duYxI6p+t89JXDkywuhWj+TusSqszTBic/SvLr+q4hgqGm55dwUWbF2WvySp
         uItyl0Dfxq1RXFNWnHu0lJ5VPTkzGB5zIr3i4/t29ilB2gTs9jSk7eA3vBCW69UUHVI7
         UqVya4NbJxHfGVxu+q0CytEbZRswG+jq3dQ84FzlUmcJEAXUKiaQsIlCko4rLkW3T0w2
         Aktw==
X-Gm-Message-State: AOAM53247jR01J9j8FpZl274KISOY5NGWz1K8Xk9MtXE2sshVrtQlopL
        JsQMCrWJsC3gGzDwgsDYn3zYA4g79U/Xng==
X-Google-Smtp-Source: ABdhPJyxYZnuMiMn/9CM8b+WqUY0mHYKXPTJ7Ij98lbBy0owjIrX/Wl2qrR+sP8Nfb7/IqAvzB9CWQ==
X-Received: by 2002:aed:3b7b:: with SMTP id q56mr18754406qte.377.1605904047689;
        Fri, 20 Nov 2020 12:27:27 -0800 (PST)
Received: from [172.17.0.2] ([40.75.121.244])
        by smtp.gmail.com with ESMTPSA id k188sm2769022qkd.98.2020.11.20.12.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 12:27:27 -0800 (PST)
Message-ID: <5fb826af.1c69fb81.2b100.279a@mx.google.com>
Date:   Fri, 20 Nov 2020 12:27:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1328797990218356148=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [1/6] monitor: Fix potential memory leak
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201120200712.491219-1-tedd.an@intel.com>
References: <20201120200712.491219-1-tedd.an@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1328797990218356148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=388665

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
monitor: Fix potential memory leak
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#12: 
   ==258684== 1,500 bytes in 1 blocks are definitely lost in loss record 3 of 3

- total: 0 errors, 1 warnings, 64 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] monitor: Fix potential memory leak" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============1328797990218356148==--
