Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E016CC83003
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Aug 2023 12:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbjHXMuk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Aug 2023 08:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjHXMuI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Aug 2023 08:50:08 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B7C1FE3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Aug 2023 05:49:45 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bb07d274feso4945554a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Aug 2023 05:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692881348; x=1693486148;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YY3o+dbWU/US1gwwH/mt8oKuM5z18b2cxpZO2FIKFXc=;
        b=BBai6tx/DJi37CxLX5k0E01MHhr6oCffSGrZmbK4gFCwsE5a+Hk247IbSPQNczVxLM
         Hf+SEbWow6wNfJ8rkM9uOd/gIqQkEvmX7A5Q3lHoy6qmSZG9JMaYA5u830AYO+XgozER
         yrmITEObFJy8+PCx/QnxE/PhqpnmhTXiepi+/t5KcFosdSt3M/sNz1oYbRAP0PhbSMM9
         q8yO+DxancMEIdCigpdq1hXQ5UPfMOLcgODSg9vA+3A3zSaY3M3gmZ3Wwq/6yS5dbjci
         Q4QlsG74xYOnK8290aWwY8nqIBZeWT8RR47u9qO6qUFxeDCrlBEstfSWTl3Glag0Pp8/
         UI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692881348; x=1693486148;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YY3o+dbWU/US1gwwH/mt8oKuM5z18b2cxpZO2FIKFXc=;
        b=eptfZvhO2BnqSZAOR2EvbHRLk7SUBkYcI0QS4yxQ+Pr/igmAzHD8n701GlvUrNOY73
         jViG1DUtwyc8kTPTIqgfi0KD7suKDPLyopcz+eMznYOnYr5vZqvHCSDc8CjfzE7a97XW
         tRSGNQQ98w8EOGBWVn/Q2bjuW7i/VQA6WsyyTmjR5UGK2M/FpSc+NQpbRkA3fKYCS/z9
         wcrn2c+ud7USe3wJQe4Nh/TC7pE/21CBTxKvJmGWorsck1UpPU8wAEpFjY87789WDFGM
         QucU/XDorbE9jaZE/NyaqWTwtrFPRcBBz/5T2x95tEpgJqC9BcHvD9Fx/ez8jGUqeX4v
         cN3Q==
X-Gm-Message-State: AOJu0YwOytgghkB8igFjMYW1sAH+eHfeMORCtvhTnGBKTYGS7eb1eMBP
        r33q4sOHMRYb4BeGmnmkwJGSDUSZH4k=
X-Google-Smtp-Source: AGHT+IF/FPerf2VZ2UjN+2YcwrezrNbT0YPi0j81Gk3IvSnFh/PQTc/66YSzEDuWl79J/CbxSf6QFQ==
X-Received: by 2002:a05:6871:68e:b0:1b0:2f63:4ff6 with SMTP id l14-20020a056871068e00b001b02f634ff6mr20385506oao.1.1692881348262;
        Thu, 24 Aug 2023 05:49:08 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.180.52])
        by smtp.gmail.com with ESMTPSA id z26-20020a05683020da00b006b9348b6f51sm6570989otq.54.2023.08.24.05.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 05:49:07 -0700 (PDT)
Message-ID: <64e751c3.050a0220.fa43d.502c@mx.google.com>
Date:   Thu, 24 Aug 2023 05:49:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3264683208217665387=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Add mgmt event for BIGInfo report
In-Reply-To: <20230824102407.25883-2-iulia.tanasescu@nxp.com>
References: <20230824102407.25883-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3264683208217665387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=778937

---Test result---

Test Summary:
CheckPatch                    PASS      2.02 seconds
GitLint                       PASS      1.36 seconds
BuildEll                      PASS      33.49 seconds
BluezMake                     PASS      1179.64 seconds
MakeCheck                     PASS      13.23 seconds
MakeDistcheck                 PASS      194.96 seconds
CheckValgrind                 PASS      317.38 seconds
CheckSmatch                   WARNING   441.39 seconds
bluezmakeextell               PASS      132.17 seconds
IncrementalBuild              PASS      4149.24 seconds
ScanBuild                     PASS      1407.55 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1856:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structuresmonitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1856:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============3264683208217665387==--
