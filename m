Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ADEC761A6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Mar 2023 17:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjCaRKf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Mar 2023 13:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjCaRKe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Mar 2023 13:10:34 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BA612077
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 10:10:31 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id n14so22298374qta.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680282631;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wGriZLh0l+bPUBedIgsgfgg4SNJB+XWnlN940FaaOBA=;
        b=n93HHNQEArd8cv0nwswXLccRKQd6yAL+pybwfH95d8ldLjq3EC9D4J81puA1kqRHAa
         RkpjWNa7mObHgAsw3ev935rRGeYXgjmJBfMAQ3XY38G0UuC3GDj4fl/rBswr6+Cni53/
         SRBW77rZ9zQyZ35xAKFqNwEKcVRLHYzgBy9aTVSMFA4NsKY8VoiyhB1lnZEvvUr7Vgqj
         CkgNaqqGjPOEiy+VXeiLBjVcBbZFxbc2FMxT1QG5R5dHfJVRVqxykIk3u6BrWTYVnHJD
         m9nydW7UBmOHbY1RQy2dZ24RofktfEjZ9PCud2bfbN6dKXeAmnf8ZUOafb/BvGGbemIy
         FXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680282631;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wGriZLh0l+bPUBedIgsgfgg4SNJB+XWnlN940FaaOBA=;
        b=pMVM04eis5xdm+2qxmZ8YXy673qnmzBTH6Q2YWnPjyTfqnZZMXQM+lQ2PG3vXyMmx7
         fScyNj8Pi07FT05Kt9Qx4JmFi3G60mG6BdcrLVC+MbKJErAML2JfMEEcOe5QlV1y/2gZ
         uiA0NrDZfSSTK3gNDtwGZ49yif1XjuvQ5J6jypo5jrHgHpfZ0AriaZoa1qq8UF69QJqx
         Sc65X5WWYxbI5ngNaTwqmzr/RNCqVJBBzAnv1W7Z1F7lw4lJb3WrvX7M8i8zcgqWGjfn
         JRIYtwXY6sMUuiIZoKbnJzK4Lg/RASqdVhwlCcXJEs7c5swo62sEn8bDeNDgrJeNMvQw
         3VTw==
X-Gm-Message-State: AAQBX9ca6DYOkG0DRBqkv5FolK83vhIHrF+2zc/AeySNXI3CxDgkjr4w
        NNdhovgEQpTV2tMBdy2+6xNokxfRNc0=
X-Google-Smtp-Source: AKy350aG8LigXU9O6npnoXrSuef/Vz3n10Lmj3VvPs7oG1ePth3QFUX8NNffQu2boAeKi+nS2iJq/w==
X-Received: by 2002:a05:622a:100e:b0:3e4:e94a:5088 with SMTP id d14-20020a05622a100e00b003e4e94a5088mr17480547qte.23.1680282630781;
        Fri, 31 Mar 2023 10:10:30 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.196.123])
        by smtp.gmail.com with ESMTPSA id i63-20020a378642000000b007486fc7a74csm771258qkd.135.2023.03.31.10.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:10:30 -0700 (PDT)
Message-ID: <64271406.370a0220.96076.3f09@mx.google.com>
Date:   Fri, 31 Mar 2023 10:10:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1666126670843241622=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Split bt_iso_qos into dedicated structures
In-Reply-To: <20230331153927.35411-2-iulia.tanasescu@nxp.com>
References: <20230331153927.35411-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1666126670843241622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=735877

---Test result---

Test Summary:
CheckPatch                    PASS      0.87 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      26.26 seconds
BluezMake                     PASS      761.90 seconds
MakeCheck                     PASS      10.89 seconds
MakeDistcheck                 PASS      150.00 seconds
CheckValgrind                 PASS      240.87 seconds
CheckSmatch                   WARNING   323.20 seconds
bluezmakeextell               PASS      97.50 seconds
IncrementalBuild              PASS      609.39 seconds
ScanBuild                     PASS      964.60 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/bthost.c:584:28: warning: Variable length array is used.emulator/bthost.c:741:28: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============1666126670843241622==--
