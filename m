Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE0FC77B73
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Apr 2023 11:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjDTLQA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Apr 2023 07:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbjDTLPB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Apr 2023 07:15:01 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408EDB753
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 04:10:59 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6a437526b7cso654686a34.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Apr 2023 04:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681988924; x=1684580924;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3GSNmcBYme9XBAOGTsGWEVsuKkBOLBNbC6w/fAYZUDU=;
        b=nqrEgaPedYkONEXNjktm1nStMGayS78ORIk2pjn4AkTF5YEEC4lq5UZKAjWJyg4afb
         a7ozfgyizfuGINlE79ZUmmiSdem1RhLwiqlTraBrWiFjv/amCTkvn5uq+mgke6RCHIz9
         U8QUNI+aH/0MWCjeRCcUEOQcvd7MMMLIU9QSrG9ef0s9WcEdzvFOncnQDp2ggWsQ9EVC
         Qs53qSxW0CFltBbnMZylmBz2O0QWbBOl1J30peAIltkCMqc/MHpivgmcoxxysUF4Bb+z
         oCek+RX/pKvIA7fW4QVlM7pKaCuz3uGlTsHeLVeY3If8fEwvmPkMPw9+MvuitfPHGlBP
         A6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681988924; x=1684580924;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3GSNmcBYme9XBAOGTsGWEVsuKkBOLBNbC6w/fAYZUDU=;
        b=QdEE45WSWoRk5SA+BLaTCVMBN7EMS+3Xti6uWtEdKEtAzSBkwH8EGvw6GCZecr4v66
         1jGTHcrbceScRA0INu/ocPcQblCEYMtQjfLF5TkrZVAhdqyO28rdV8KfPaXBooVwNL2r
         rZyv5OrxmK6cTmZ4DZ8VTjO5s/lfm6+Zntbc2JwD6UUtwPctBFCewSkhKCYU7JbvInwo
         sfNWDDVqyuU+4X5rrFv077Uj7rX6Bbi0Dd/J5Oizs7Dti4F9Ow0uxfqqxXrkTiM8Fej6
         cRkuWojTAJJUICBuaegZN1hI36FIgUHPGXOdq+pJHVXZzBP45bqsrp9IgATMmgNhvYXt
         RcxA==
X-Gm-Message-State: AAQBX9dz7w2bCgDKgvh3Khc/D/wrhOlmQZARLtYYjJJlt+C+GmklOzJQ
        puM7ntjZ9qHj7f+nJ4SAQDJrwZkO/z0=
X-Google-Smtp-Source: AKy350Ysyf8+LyfJBw+qmCT/opR9LwLFbIJm3UZFQsENIl5n9J+wA68tkEqKs9/BK7sUfirCA+8BPA==
X-Received: by 2002:a9d:7dcb:0:b0:6a6:1691:aec7 with SMTP id k11-20020a9d7dcb000000b006a61691aec7mr515615otn.10.1681988924518;
        Thu, 20 Apr 2023 04:08:44 -0700 (PDT)
Received: from [172.17.0.2] ([13.66.72.36])
        by smtp.gmail.com with ESMTPSA id e5-20020a9d7305000000b0069f9203967bsm554624otk.76.2023.04.20.04.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 04:08:44 -0700 (PDT)
Message-ID: <64411d3c.9d0a0220.ed4ee.22b0@mx.google.com>
Date:   Thu, 20 Apr 2023 04:08:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5525351107325855960=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, aarongt.shen@gmail.com
Subject: RE: [BlueZ,v5] obexd: AuthorizePush: Support to return folder name for file storage
In-Reply-To: <20230420095557.22252-1-aarongt.shen@gmail.com>
References: <20230420095557.22252-1-aarongt.shen@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5525351107325855960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=741650

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      26.38 seconds
BluezMake                     PASS      757.47 seconds
MakeCheck                     PASS      10.92 seconds
MakeDistcheck                 PASS      149.95 seconds
CheckValgrind                 PASS      240.66 seconds
CheckSmatch                   PASS      324.94 seconds
bluezmakeextell               PASS      96.89 seconds
IncrementalBuild              PASS      611.16 seconds
ScanBuild                     PASS      981.95 seconds



---
Regards,
Linux Bluetooth


--===============5525351107325855960==--
