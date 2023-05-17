Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483E8C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 May 2023 23:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjEQXJk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 May 2023 19:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjEQXJj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 May 2023 19:09:39 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DC161A4
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 16:09:18 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-334d7bb7155so3779405ab.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 16:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684364958; x=1686956958;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PwYVaWlbiGqf3/jq+HQARwafBGFuoD1T723fscQ89jg=;
        b=N8i7DVLmgmXtdw8y7Wa9xXLBvoDz8fkLAGiywV+ZErfZhOBZGAvXVW/9CWLqQf1pew
         bgv6/XIQ+t/a1B6N6jjSvcfXgCjuyWaZHXhRYoRdqQptoz1vUSqeDmsfBGUW7TyloiLT
         XK2sK15TYsj8kmKW63Js0m0sNfAOOgXiETWq8if56zowcZq2SdJ0VA+yl7noCn6ZDwL3
         oceDqRovasjF1qwFglpFNBdxy1iSg8A0Rh51M/5VdguwjsPirL8LwgMo4ZwChTcteRDy
         qGRYJbEgqQuzU1KbsG72zR1FcM3LTlU1EZV+kCcLR7MLQBLnEiiWQsCTHc6gJuUg3yzj
         DgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684364958; x=1686956958;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PwYVaWlbiGqf3/jq+HQARwafBGFuoD1T723fscQ89jg=;
        b=XFX5D7aXXYPLAfSUt9FCR9762HCY0fvVlp4sC9zRpUy2vsHC/xgrqcVaHW9cwG6OIs
         hzCCUbZZ1hl+P04utreikwjZcJW7G95xqiNkoDu7HbvsZPfwcF6uRZd2kz8SuegFVyx+
         6CR5sPk0r9vgAfXjTyZSYl9omPqpj6zhCYYUhcK1OKswKq3kF4dZue0kG/DoR+w1fc98
         +EZGEvJ/psYGOO+zRqnzWqyL1fZj+x8Vr9YPJa+nLve7do5zKl9Hi2lt21x1KX/pFO7O
         AYc0TYFMQMdWrFQWA+pIziQlBx7u7tBaoNVuYRXOr+ThWBStV8wNLHl+T6GBNOEGwofp
         BrqQ==
X-Gm-Message-State: AC+VfDxYAQ8J6n062c2X/CUK/MFBiePGoCY7mH3LB98e7szAqZDqkQBL
        +MY6o0t9fguU0aRSC3UgpGJ5c7sU/xE=
X-Google-Smtp-Source: ACHHUZ6GPzuhqu/s3oU+klYbhbhi5Rh8ueJmCsND+YppyUYdECN8sSLv/F2Du8H9elsW+Bn9I/74fQ==
X-Received: by 2002:a92:d242:0:b0:334:7263:6283 with SMTP id v2-20020a92d242000000b0033472636283mr2887743ilg.14.1684364957855;
        Wed, 17 May 2023 16:09:17 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.92.210])
        by smtp.gmail.com with ESMTPSA id b8-20020a920b08000000b0033842c3f6b4sm413906ilf.83.2023.05.17.16.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 16:09:17 -0700 (PDT)
Message-ID: <64655e9d.920a0220.309d7.08f6@mx.google.com>
Date:   Wed, 17 May 2023 16:09:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8597806994343513789=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] monitor: Fix using PACKET_FILTER_SHOW_SCO_DATA for ISO packets
In-Reply-To: <20230517215852.1395512-1-luiz.dentz@gmail.com>
References: <20230517215852.1395512-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8597806994343513789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=748669

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      26.47 seconds
BluezMake                     PASS      791.91 seconds
MakeCheck                     PASS      11.49 seconds
MakeDistcheck                 PASS      155.08 seconds
CheckValgrind                 PASS      247.47 seconds
CheckSmatch                   WARNING   336.29 seconds
bluezmakeextell               PASS      101.00 seconds
IncrementalBuild              PASS      660.64 seconds
ScanBuild                     PASS      1013.03 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1801:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3552:52: warning: array of flexible structuresmonitor/bt.h:3540:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============8597806994343513789==--
