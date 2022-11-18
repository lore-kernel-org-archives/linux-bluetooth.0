Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5ADC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 03:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbiKRDyb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 22:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240679AbiKRDy3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 22:54:29 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F30890588
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 19:54:28 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o7so3436121pjj.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 19:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ztczWXijhGQRo1d4NnGeahcr63XcLEpbblgIYN2rINw=;
        b=SlMzCBxSOvKmLW9+3TkQwY7w5fRauqd8xc0GlCkDR1KZiU1h1QKAzznWFgu35jRbWq
         U43qrTDxRPTXtBbCNEMJjDNjiStpKha5PhDV1OkM2mtqy5VpssUU9Wr9I6gkGcagE3Jb
         aRfpQk+wBWI1Mw+THPJEwImkbFmwu7Zdzjw8vFQECj9QCvN56JSQaOs7Kquegiygan7J
         fGihHkVvV0km6n3jV/vmLAxmNOqYGm7J7DHjQ3B09c/dQlyllOdo2N0ocLkNIuNmOHR/
         3AlPnF4XYChD89ku1afLygPk2ViEhnu6afvD/Mr/BVWPHKYs/kBnRjHUKA/+vss3ctgj
         3Rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztczWXijhGQRo1d4NnGeahcr63XcLEpbblgIYN2rINw=;
        b=fsDQRwQvzuU/bfDeWU+HND57GX9+/lrfieh/eNK9hyYHAvNfmI6jsFYupTi2XV2v5C
         wnWJsCX6szytLFeJpOzEsRLPY7Pae7WDL+0zXVFVQh0rT8HxGAHhrLexf5JlzvKR3rRK
         jX/fKujnQndtNzP5JtXIZzlBi4F2jGUHVpWXxyNmb+GZtuqBI171oRVXR6yQ4ZoZdz+C
         mxR3FWULB15j8Pin6SrOKRR3+/G6wbK9/ahl4+87zxDVSVVogXwFts1ERjoNs8k27Lm/
         W+Plt4fMnuDPztODPYdzcxJVxF7aZ/lKR8veW/HdkbYj/VVPqsLrLvOEKNJVZx6NrqOQ
         q+gQ==
X-Gm-Message-State: ANoB5pkAn2WoLksd+CNSjMK8OhGjkiXWVIt5kVWi/O9zMx3JS8tll8X5
        bfDP9cDbj3eBfZDrIyjFEqs/1HYD3NQ=
X-Google-Smtp-Source: AA0mqf6EkEaHXD4maJ/Oy2INjqPTEvopLRI6bkwpEYJNuecAS1LWpkXQ80gpMIpu8uiPfOmZehiazQ==
X-Received: by 2002:a17:90a:c685:b0:218:7b33:60c with SMTP id n5-20020a17090ac68500b002187b33060cmr4000893pjt.99.1668743667687;
        Thu, 17 Nov 2022 19:54:27 -0800 (PST)
Received: from [172.17.0.2] ([20.114.47.250])
        by smtp.gmail.com with ESMTPSA id c4-20020a17090a558400b00210c84b8ae5sm1630511pji.35.2022.11.17.19.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 19:54:27 -0800 (PST)
Message-ID: <637701f3.170a0220.331a1.284d@mx.google.com>
Date:   Thu, 17 Nov 2022 19:54:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5436581221235666979=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v3] doc: test patch - DO NOT MERGE
In-Reply-To: <20221116052513.57081-1-hj.tedd.an@gmail.com>
References: <20221116052513.57081-1-hj.tedd.an@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5436581221235666979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695796

---Test result---

Test Summary:
CheckPatch                    PASS      0.23 seconds
GitLint                       PASS      0.20 seconds
BuildEll                      PASS      27.05 seconds
BluezMake                     PASS      796.66 seconds
MakeCheck                     PASS      11.09 seconds
MakeDistcheck                 PASS      147.35 seconds
CheckValgrind                 PASS      239.43 seconds
bluezmakeextell               PASS      97.49 seconds
IncrementalBuild              PASS      653.81 seconds
ScanBuild                     PASS      967.18 seconds



---
Regards,
Linux Bluetooth


--===============5436581221235666979==--
