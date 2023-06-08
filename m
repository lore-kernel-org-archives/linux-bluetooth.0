Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5592C7EE43
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jun 2023 13:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbjFHNgV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jun 2023 09:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbjFHNgU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jun 2023 09:36:20 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0EC2695
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jun 2023 06:36:18 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-75d4dd6f012so54997785a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jun 2023 06:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686231377; x=1688823377;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rs4PGJZvCEARMPyEvCRDbauwQIUobRrs23fCs74nSs0=;
        b=Ee9OWAIBNonGBsQE4coxGjkI6b4m5w3cQSGuqAgpfiVnLSXgo0MKK6iqaCjGXetjM3
         lbDTuVe6xfP2/DSaKkkyj2yJOz/URU2Ga7NoDCx7ZgRHMSdhOA4x6J0I/Ob6z9JqZYUX
         trIALReWjYAVN/ZWHA2pOD26RHmVL8KiRVEciltVqs6yQYlsf8rs7Z3/F2B+bFXQlwSb
         i+VC9zsSn6rfBR8OS+PtIUhK6xutOILBlMTWQqrwj7QLgcmz4uEcCgF8N2NIqRMxVJoQ
         1JpbTBVpKhYivyF2ZG3MkK9AwwZY/NM9RF84sdaYrB7+IxxdZsE6CeZz9uTC9ip5TmyC
         EFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686231377; x=1688823377;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rs4PGJZvCEARMPyEvCRDbauwQIUobRrs23fCs74nSs0=;
        b=lJirpM/Auve4CKbpadWCMZqZs/DKIo+cYqhx2I/QFM+mWnOB1f6CUsbp08yO/wXaju
         Gaz7Gi6+A3TW2n3PHAmmePpkksgUmva1RT5ItDM6JrkbLa4UJ5f1yAPQBU9jBrcybOb3
         6E1s3toQ3bl+ieZtdDJ7xHbZ+zRlkcV4OylS/SmNT2hhGRtkHJuUf51LYV9oWt5MlvKB
         o1I8ZvykxVDeuGTezJ7iHmqmCkfjlT7nPkcOOahPA9ljE4ZikRRQWtclcZvmziRt4vVl
         TbVfKy3Zyo/1fSWZBFpfMrRmT6xqFnvL8I+X/Sgb4kVhSYR1o3da6b+co0nKQ6Gn/gR5
         7drQ==
X-Gm-Message-State: AC+VfDzNsomLIvP/+HDTggJyiCdTkrp8KKXHI2bnMTZERs9hyuc459FO
        aYMlskWLQpUczAQnnwXkJO6d7vjjnDA=
X-Google-Smtp-Source: ACHHUZ5X/T2LmzUzz9uCU9TumBB+/VsaKKkOP9bPBnppo9L+WuWsM+GKVNlmoRmLXItwQf2Q/k5uzQ==
X-Received: by 2002:a05:620a:86cc:b0:75b:23a0:de9d with SMTP id pr12-20020a05620a86cc00b0075b23a0de9dmr5245562qkn.27.1686231376375;
        Thu, 08 Jun 2023 06:36:16 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.204.176])
        by smtp.gmail.com with ESMTPSA id c22-20020ae9e216000000b0075cd3d61715sm328402qkc.47.2023.06.08.06.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 06:36:15 -0700 (PDT)
Message-ID: <6481d94f.e90a0220.753a5.1152@mx.google.com>
Date:   Thu, 08 Jun 2023 06:36:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6317217854340234373=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, nitin.jadhav@nxp.com
Subject: RE: Code handling for VOCS service
In-Reply-To: <20230608120945.4478-2-nitin.jadhav@nxp.com>
References: <20230608120945.4478-2-nitin.jadhav@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6317217854340234373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=755311

---Test result---

Test Summary:
CheckPatch                    PASS      1.56 seconds
GitLint                       PASS      0.73 seconds
BuildEll                      PASS      27.18 seconds
BluezMake                     PASS      872.62 seconds
MakeCheck                     PASS      12.79 seconds
MakeDistcheck                 PASS      155.29 seconds
CheckValgrind                 PASS      255.44 seconds
CheckSmatch                   PASS      341.24 seconds
bluezmakeextell               PASS      102.91 seconds
IncrementalBuild              PASS      1436.49 seconds
ScanBuild                     WARNING   1046.77 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/vcp.c:1273:3: warning: Null pointer passed to 1st parameter expecting 'nonnull'
                memcpy(vocs_audio_loc_n, value, sizeof(uint32_t));
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/vcp.c:1275:39: warning: Dereference of null pointer (loaded from variable 'vocs_audio_loc_n')
        DBG(vcp, "VOCS Audio Location 0x%x", *vocs_audio_loc_n);
                                             ^~~~~~~~~~~~~~~~~
src/shared/vcp.c:31:57: note: expanded from macro 'DBG'
        vcp_debug(_vcp, "%s:%s() " fmt, __FILE__, __func__, ## arg)
                                                               ^~~
2 warnings generated.



---
Regards,
Linux Bluetooth


--===============6317217854340234373==--
