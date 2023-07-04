Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FCDEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jul 2023 09:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjGDJPo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Jul 2023 05:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjGDJPj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Jul 2023 05:15:39 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299C810CA
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Jul 2023 02:15:36 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7659924cd9bso575183485a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Jul 2023 02:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688462135; x=1691054135;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7yaXsGR387VZXBSBeSAIuv1c/LxBCl1LfUUZpreikWk=;
        b=JwJujg5nHGFsqSlbyDwedhmbHJyUP24UG2N/Dln8lOAIn3eje/uUkqdAJxMi8BbEPD
         f2fIGtcoHqn25KmFNeriI6FPDX0gPWj9JFw6+XvV/kAUEeAwj7mNG/CfvFmIig86K8bd
         SNGDWNHQuqED/S74hrLYu02Rvu5Gt1+Noa5sYbKmwxzACplbVIlsW4WjzPVlPImsFB59
         YlXLEyK1EfLX6++pqEol2NtuUQvWosnvnm0rWgq0LQnTIZD/6VJBSuJxFGHts+fBrZPb
         r95z8OfhvV35vnTAXKrLaGAsYPJjz2DfXKH3CsVUVh3qNh1hA230q/mP2qP4rqNewYAs
         T9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688462135; x=1691054135;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7yaXsGR387VZXBSBeSAIuv1c/LxBCl1LfUUZpreikWk=;
        b=BGyMl9G5LP0EtQlp1skHhc1fIbfGEts8VGrvb3SdLnnMMDVm04Fd0KtdSwuIWOaYnO
         dDo5f3XYukXXfnU5NWdZ+RkNiy+9wy1AQJotjVFood+Dz0sFJg+/+qoMU72O+frd7eKE
         Kw7GW66z8n0IfiQo/ZVBvzuXRpMN6MvOht67kuw6NMclxmEynVKFP0giQvk1p1S0ZhAJ
         2J5i09D/B6pMlmR4i/YLQb7g7wKw4+Vr+38I970N0Zm2aPVxocvFT+V2LTPCjNKUNt39
         7rYDokDhfSGBascUUq+w2Rel5Bwt7tE0eKAc4s2W0c62lWzPDwC7wD27+SHIcf1n/E+G
         ZqWg==
X-Gm-Message-State: ABy/qLacnqRGLhdMrVN67Pxajj9sSYBPd45GG7We6uNJUuwHM/Piuju6
        hw67R/gHl5GN/E+x1h2Wo2ibmmBl0A0=
X-Google-Smtp-Source: APBJJlHTOtMGkJSavwt0k8JKI9vE4MFiZ8PdICBznCkbVT140BQIzuj19yNgi2TuVUQBoOtq2kPVzA==
X-Received: by 2002:a37:f718:0:b0:766:fd2c:fca1 with SMTP id q24-20020a37f718000000b00766fd2cfca1mr13164853qkj.75.1688462135069;
        Tue, 04 Jul 2023 02:15:35 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.188.80])
        by smtp.gmail.com with ESMTPSA id i12-20020a05620a144c00b00765ab6d3e81sm9349093qkl.122.2023.07.04.02.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 02:15:34 -0700 (PDT)
Message-ID: <64a3e336.050a0220.760a9.7427@mx.google.com>
Date:   Tue, 04 Jul 2023 02:15:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5998621574667517551=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: monitor: Add decoding support for Sync Receiver events
In-Reply-To: <20230704074144.5587-2-claudia.rosu@nxp.com>
References: <20230704074144.5587-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5998621574667517551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=762233

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      26.52 seconds
BluezMake                     PASS      782.29 seconds
MakeCheck                     PASS      11.23 seconds
MakeDistcheck                 PASS      155.31 seconds
CheckValgrind                 PASS      250.03 seconds
CheckSmatch                   WARNING   334.74 seconds
bluezmakeextell               PASS      101.71 seconds
IncrementalBuild              PASS      651.12 seconds
ScanBuild                     WARNING   1007.16 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1832:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3552:52: warning: array of flexible structuresmonitor/bt.h:3540:40: warning: array of flexible structures
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
monitor/packet.c:12370:2: warning: Null pointer passed to 2nd parameter expecting 'nonnull'
        memcpy(tx, tv, sizeof(*tv));
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============5998621574667517551==--
