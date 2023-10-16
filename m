Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD21BCDB465
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 15:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbjJPPiY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 11:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjJPPiW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 11:38:22 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5089BE6
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 08:38:21 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6c4b9e09528so3191560a34.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 08:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697470700; x=1698075500; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f52VUSbwaZK0gC3x5c7u3OkdQFDmyQyX85yG2odV81c=;
        b=crSMBbg82s44NmGkLySy7gqmLGx14Sy9TobiXZtuR6sZgRvtFjawnqDc9wwXxH6xJU
         +RVw5YjxRkXSUCyM2kCkDURylPPsC0udHJAjuUqq2emv3359C5KbAOcEOCxZHSVCHaQk
         O1EkUnLhyeyHlqJzJwt6yan6bhpxlI5zgm3SNQuBqIIidOQuv+TMbChnIGkTPi0BOFQc
         7syh1jK5WddNHtpG07og3C5xV1FxF4lX75eRLsSPRVM+fjxT7WXfCGMPHz7+3T7Z3ivd
         NP2f3V/VXbFWGFor1k8wk7AjEQ2gZ6n5mcypWM97afX/s2a/3Wg6r2D2/aVt6M+vEZqV
         YENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697470700; x=1698075500;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f52VUSbwaZK0gC3x5c7u3OkdQFDmyQyX85yG2odV81c=;
        b=tnmgTMSC511mIpSKHnVI2ypFvtQ0pBtMHKn6cpAeYtgXDpAhPxhpIa/AHs13gTb03r
         NEIolsqWHb4y7WMdaP7o7s4Num+UpmCliNyWDPI+smLMuA3fhzk0g0ZJ6v2SBK45gEqA
         yqXwZGLTNLlvV3wQErZ3+CdrR1yBCOKRvVLyNyUt4KS6yK9Gt124l/Q9/32ykRRw5qNJ
         /OKGLIDqZIhmGFLAZ9baxzEg8WSRcgAEP1Wi1KotBKoQog8gCU897Oghcguh1IfSY2LX
         CEkMuusvwTcoA0HOFlS2vXMweu9G6JhJMJ/D/nHlBA9ssimAvDtWyzFVL46UqprpYw5Z
         YtsA==
X-Gm-Message-State: AOJu0YxOYjOJv0hidTKy1OFCY8qrjPc8zNVjTlBGNc6SleCKKPNcLk7w
        rhmP6kR8G4ZD7lxqKitxL8UayFmTF+o=
X-Google-Smtp-Source: AGHT+IHLN6NYti9e89nOBrivXkPSw/5Z1MDfpTtS6SdeusO8l80cmLUzacTuhHq0heJ+xUTacevdUQ==
X-Received: by 2002:a05:6871:ae81:b0:1e9:e975:4418 with SMTP id zs1-20020a056871ae8100b001e9e9754418mr8434040oab.53.1697470700412;
        Mon, 16 Oct 2023 08:38:20 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.220.247])
        by smtp.gmail.com with ESMTPSA id r9-20020a056870e98900b001e578de89cesm2051687oao.37.2023.10.16.08.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 08:38:19 -0700 (PDT)
Message-ID: <652d58eb.050a0220.1e8e5.e0ae@mx.google.com>
Date:   Mon, 16 Oct 2023 08:38:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7522721721910812934=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michael.hunold@eu.panasonic.com
Subject: RE: Make initialization work for newer versions of TI CC2564
In-Reply-To: <20231016125526.749848-2-michael.hunold@eu.panasonic.com>
References: <20231016125526.749848-2-michael.hunold@eu.panasonic.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7522721721910812934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=793555

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      35.11 seconds
BluezMake                     PASS      1198.01 seconds
MakeCheck                     PASS      13.54 seconds
MakeDistcheck                 PASS      226.94 seconds
CheckValgrind                 PASS      348.68 seconds
CheckSmatch                   PASS      476.52 seconds
bluezmakeextell               PASS      150.97 seconds
IncrementalBuild              PASS      1084.78 seconds
ScanBuild                     PASS      1491.80 seconds



---
Regards,
Linux Bluetooth


--===============7522721721910812934==--
