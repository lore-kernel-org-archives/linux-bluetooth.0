Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3CCC77B73
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 May 2023 00:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjESArV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 May 2023 20:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjESArU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 May 2023 20:47:20 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353B1E7F
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 17:47:18 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f4e7ce15c4so14616271cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 17:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684457237; x=1687049237;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kaPXAXGKtBY0p7lIjxfScfkRYinZvcRZ9yKfgw9pHPI=;
        b=GrI8wRzddvKeL6WKZlLGsFv2XZus+p9+JXmAyV2yfVr5H0kGhd0cyFabKXVF8+1Ls2
         EpD4Pkr6R7AnuBmkdgJbT8OL1G42hBj2AMmmzyojoBtz0o1y0YCx8uAf2rPo+38S0J3O
         YJnY/tbhidEa9Yx2jp8fCNsQXrsJ7LaJMTfWNh0DFsvYLrfgwTvFEdV+iX6qjIhsqTK0
         iFUJl351oqY4nbuMakTff9Fbtgh4VrhBZXJoYsIS/VajncLSBSLnk/p7yBzKexeNUD6t
         Th1OkL/NzZ6AlHnRAHgh/9/lVLaxYa1oG21HaqW2fXwoK9m7i46M5ypRXLqwo/BeTyip
         7ExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684457237; x=1687049237;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kaPXAXGKtBY0p7lIjxfScfkRYinZvcRZ9yKfgw9pHPI=;
        b=Ju0lQajwgZWrDyFiSRpAlidk9FtR0AD6LrR3RDTciE4KV7LxPKDbq8TGPxcOQiXeFi
         Nk6FXRQiX9d1MS8Dl2C09fVrE+0IDmyNSa9hjMkam2II17eZ5xyL3owqo/LSIV52AUdP
         Ws4qBAVeIUAvJWCPEiMURwOfqKSHTmwiW59W9e39PiW2v11+Ya2fviv1LGzLx0EnW5v9
         4c6XbzGLaJyqmFvj11j1fHPzjlAK1d5BSZowZ+n584kOZtZ0QbiSvFlAddDI8t2YVxgR
         Fbhz3gucX4upE5JYbYwvOQx74kTjuYZMz0IneNDUU9RFUCpgOrOyxEu9TffJamQxZsBM
         3aHw==
X-Gm-Message-State: AC+VfDxtUOu9BlaHSnvzsocmkoag3hMPgy8yJaM/3q5eIKIFqlps41Bl
        H2tE2P4RT1/xjPnG8h0s7k80QNooIOY=
X-Google-Smtp-Source: ACHHUZ4chSBvPGO6u/ApDz4E1X8trsvZWK5SjESzNZqd3bJ04D479gGqXqf6BaVfMKA0s+rgzp7ygw==
X-Received: by 2002:a05:622a:1990:b0:3f3:bae4:5996 with SMTP id u16-20020a05622a199000b003f3bae45996mr645614qtc.42.1684457237056;
        Thu, 18 May 2023 17:47:17 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.129.240])
        by smtp.gmail.com with ESMTPSA id x10-20020ac87eca000000b003ef2c959d1bsm895048qtj.67.2023.05.18.17.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:47:16 -0700 (PDT)
Message-ID: <6466c714.c80a0220.35ffa.4dbe@mx.google.com>
Date:   Thu, 18 May 2023 17:47:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2625265539449765193=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] monitor: Fix not parsing BT_HCI_EVT_NUM_COMPLETED_PACKETS properly
In-Reply-To: <20230518232049.1656554-1-luiz.dentz@gmail.com>
References: <20230518232049.1656554-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2625265539449765193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=749061

---Test result---

Test Summary:
CheckPatch                    FAIL      1.81 seconds
GitLint                       PASS      0.73 seconds
BuildEll                      PASS      26.98 seconds
BluezMake                     PASS      866.74 seconds
MakeCheck                     PASS      11.87 seconds
MakeDistcheck                 PASS      152.15 seconds
CheckValgrind                 PASS      248.23 seconds
CheckSmatch                   WARNING   335.57 seconds
bluezmakeextell               PASS      100.97 seconds
IncrementalBuild              PASS      1428.68 seconds
ScanBuild                     WARNING   1029.29 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,2/2] monitor: Add latency when decoding BT_HCI_EVT_NUM_COMPLETED_PACKETS
WARNING:SPACING: Unnecessary space before function pointer arguments
#1434: FILE: monitor/packet.c:11639:
+	void (*func) (struct timeval *tv, uint16_t index, const void *data,

WARNING:SPACING: Unnecessary space before function pointer arguments
#1506: FILE: monitor/packet.c:11826:
+	void (*func) (struct timeval *tv, uint16_t index, const void *data,

WARNING:SPACING: Unnecessary space before function pointer arguments
#1591: FILE: monitor/vendor.h:28:
+	void (*evt_func) (struct timeval *tv, uint16_t index,

/github/workspace/src/src/13247515.patch total: 0 errors, 3 warnings, 1358 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13247515.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1805:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3552:52: warning: array of flexible structuresmonitor/bt.h:3540:40: warning: array of flexible structuresmonitor/msft.c: note: in included file:monitor/msft.h:88:44: warning: array of flexible structuresmonitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1805:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3552:52: warning: array of flexible structuresmonitor/bt.h:3540:40: warning: array of flexible structures
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
monitor/packet.c:12356:2: warning: Null pointer passed to 2nd parameter expecting 'nonnull'
        memcpy(tx, tv, sizeof(*tv));
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============2625265539449765193==--
