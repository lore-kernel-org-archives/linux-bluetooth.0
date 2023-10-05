Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666C9E92728
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Oct 2023 18:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjJESuv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Oct 2023 14:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjJESuu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Oct 2023 14:50:50 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDA99F
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Oct 2023 11:50:49 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41954a3e282so7457991cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Oct 2023 11:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696531848; x=1697136648; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mikXtVK4rcEyKixf0DSl9o7ust0wbH/7KeI/rw9cIZ8=;
        b=Z1hy3X8AT3aSFsdV2gq6IFNBy8ZtrW1WZyxGGIz7f/5bIB3jR/d8KqAo+FJMqF3+r3
         utWHRbVqjGhIOiT5BEtaq1Vet5N4id3zTRKmHaV1sqTqyqZ0bh/r79SNUxCZWHLvHn+6
         SFm2huk1yY9XfhXqY8A1q1eSMBJSwopD+4wOEEvra1otXoqQsHyzNMr2f3ZAJAzo1MVx
         ErViKdFiK2/nFhXhe3TU1kvNBxeqBAYty8C1q4RnNhLIEP4IRmWpxntFOclHyzlpQtOe
         CYkIRhd5+lDcCONv8/M17FFgBSRcaoKaRKSXEqrPofRxhaCuXXA+XJddFA4NOqlAaOnk
         GXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696531848; x=1697136648;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mikXtVK4rcEyKixf0DSl9o7ust0wbH/7KeI/rw9cIZ8=;
        b=p9UWQKc0YzbKdGhWKEKvWDvI3b9a+jTywoalDBkYVsQs58VwVwuX7GlzRhCHPBWs5+
         T9JGSM2MbvGUJVWD33V/gueU2xlmeTw7vjs2qwJ3a89uXtqQz9JumYLmbA6LPJl1uD0A
         Sioy24j+v8awoEk9O77IlXAXMpPEtQIICs1PwOEiIMBY44Nyxa9u8PPga8HI8wL/ZQ6d
         +snwr0RCK92USNMnrgG/cBX7jYEgXUGBGe+IBkfly+NIHiCjrCZ6agBlwbPKeEPtDOEQ
         +3jEpJD7B01CGNRirHVwDDyRoRXgk6SjNKxNfrtz8ZG9rDNCjExZxpVhbJVFtnkABiUi
         shJg==
X-Gm-Message-State: AOJu0Ywus9imrzFyH9dbXpnMcjuP63cZv5PGLSja+iLBzTl1tcIuxLBG
        EfwpEy7UGSYCVCDns1H5P5LCGIj6Cck=
X-Google-Smtp-Source: AGHT+IGns/iOaFV3KC//FacgszNqNwDHYaWfiQ0rBOJ725EypBw9P5rcgmN6tG2fM0YEAplV3fEChg==
X-Received: by 2002:a05:622a:1ba9:b0:418:a58:1cd2 with SMTP id bp41-20020a05622a1ba900b004180a581cd2mr5874656qtb.51.1696531848205;
        Thu, 05 Oct 2023 11:50:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.33.114])
        by smtp.gmail.com with ESMTPSA id z21-20020ac84555000000b00418be3e365fsm674833qtn.1.2023.10.05.11.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 11:50:47 -0700 (PDT)
Message-ID: <651f0587.c80a0220.44320.402a@mx.google.com>
Date:   Thu, 05 Oct 2023 11:50:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5515485224059194612=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/2] battery: mark all battery DBus APIs non-experimental
In-Reply-To: <ceaf8aa40e0967b01b86008b16a26bbb111a2cf6.1696524938.git.pav@iki.fi>
References: <ceaf8aa40e0967b01b86008b16a26bbb111a2cf6.1696524938.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5515485224059194612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=790359

---Test result---

Test Summary:
CheckPatch                    PASS      1.05 seconds
GitLint                       PASS      0.70 seconds
BuildEll                      PASS      28.38 seconds
BluezMake                     PASS      869.09 seconds
MakeCheck                     PASS      12.86 seconds
MakeDistcheck                 PASS      164.12 seconds
CheckValgrind                 PASS      264.21 seconds
CheckSmatch                   PASS      359.30 seconds
bluezmakeextell               PASS      109.93 seconds
IncrementalBuild              PASS      1485.18 seconds
ScanBuild                     PASS      1107.90 seconds



---
Regards,
Linux Bluetooth


--===============5515485224059194612==--
