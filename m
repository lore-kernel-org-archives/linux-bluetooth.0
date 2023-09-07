Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB7FEC8743
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 17:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245188AbjIGRkm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 13:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245187AbjIGRk1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 13:40:27 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641A026B5
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 10:39:54 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-44e8d9e6ca0so477475137.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Sep 2023 10:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694108389; x=1694713189; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3SIc5eqfLpYClqyMrpYhRMKz7tJZN9G4f8wXC03Tv8c=;
        b=VLOZp1Mpy3tf4RxQltSAts/iswi1oKgIY7FtC55pqwyCgNOaUuHPAkgcZDLOeW8iaD
         3+U1ypeHu92BFGRMg7aaHySI4Y8fR+kXDsF3sXvJMmjP595YYJqt23ZGyDnDfvQhSj3U
         QiLGWRqlkYvQmVpbyH6LzCmsi/cmD12qVUKhLabog1AGnIDhh7LqlmjKjCJyb4nXtNew
         b/u3De/enXRFN7nJ7FPy8HH0UA9d35aGUNAYGiXASSn404ebO/B49wzYE+KQqfBRbiWM
         OWGWMoeFxpdLqSNG/OfWmyp6goV3YrIK+DHk/lFPciD9AEG2dZNbg9BX8jYEMcddKwmt
         SS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694108389; x=1694713189;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3SIc5eqfLpYClqyMrpYhRMKz7tJZN9G4f8wXC03Tv8c=;
        b=YvGUW9bl/6hA/Y48/rawfu1qjH9ejKMBAFixEDW1rItpxVyDWBm0kd5Tl2ZGPlx3y5
         tCX9xZCLzgO6hvvPQazIPZ2anmgl84JVNlgqqpRJI5wvqKWKursC6CjMmQBpm/HMie4z
         7VkS+H1fFWVVm/8iX35lgtB8AjSul5D/zWrCbZbHElMEcKrKBHFCmZjLU8qmIdO1BJOm
         wdOuAibFgrtbK1uNpxnMQ6Yh3JULUoj6+i4LCjkH8aiCok4UPACmuNngtus/RtyYtLnX
         tmzl7IXFKCuh3VOfGurhm0MT4rMoTZ4C8uBTTVaMAvgSsXJ4jrPlQXR3nNFwrT1G7Oy6
         CImA==
X-Gm-Message-State: AOJu0YwbLpKNSncN20meF+50xuGfP/3EhvZKCYw1X6ZHs6GvUSFXRwp/
        xQbhov1xCNRYc2GBtJ5tU0PONPOFc+g=
X-Google-Smtp-Source: AGHT+IGkcZ4SQpmuEOpBnPKFeEvcgVj5+7lEIvd2SJznoK3ZBHuEjmOOSNrIUy86OyfHscBDlxcOJw==
X-Received: by 2002:a67:f941:0:b0:44e:9cdc:6fe5 with SMTP id u1-20020a67f941000000b0044e9cdc6fe5mr406348vsq.17.1694108389442;
        Thu, 07 Sep 2023 10:39:49 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.96.214])
        by smtp.gmail.com with ESMTPSA id u6-20020a0cdd06000000b0063d20fa8341sm6498699qvk.8.2023.09.07.10.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 10:39:49 -0700 (PDT)
Message-ID: <64fa0ae5.0c0a0220.6d213.8192@mx.google.com>
Date:   Thu, 07 Sep 2023 10:39:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5950314757255509084=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: shared/bass: Add Set Broadcast_Code opcode handler
In-Reply-To: <20230907151229.7306-2-iulia.tanasescu@nxp.com>
References: <20230907151229.7306-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5950314757255509084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=782237

---Test result---

Test Summary:
CheckPatch                    PASS      1.80 seconds
GitLint                       PASS      2.37 seconds
BuildEll                      PASS      27.39 seconds
BluezMake                     PASS      845.83 seconds
MakeCheck                     PASS      11.51 seconds
MakeDistcheck                 PASS      162.80 seconds
CheckValgrind                 PASS      257.55 seconds
CheckSmatch                   WARNING   350.77 seconds
bluezmakeextell               PASS      105.80 seconds
IncrementalBuild              PASS      2088.23 seconds
ScanBuild                     PASS      1073.11 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1859:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============5950314757255509084==--
