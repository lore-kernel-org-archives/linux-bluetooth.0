Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2609BC05027
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 Feb 2023 19:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjBSTJr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 19 Feb 2023 14:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjBSTJq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 19 Feb 2023 14:09:46 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7309010256
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Feb 2023 11:09:45 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id e17so711962qvr.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Feb 2023 11:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0pQ1kB8uuV8lHgKvwxOpNfWxJmRhA22mxki0DXPcPVQ=;
        b=IMOX7QJkabYUUJvUUUSkiUVbPo99aBfLCizrslDMqXMNQvtEV0t1yMwwSyas5CzYmX
         5ZqZ7Fd0/ERkut6RAp5g2oOLBBwg9c+i9L0kdRJc9v96LtVWsWgt1JKsf77wWxPtTKF1
         29btFAGbxAsc4TubIJL5A6tV88rIdeVbmNl6zb1HCQ28i9UgAtpgU5BH/9usA7tRXdIN
         TDb8mopZkeSC9L2ysrbHsl8Bod/7CCZLW0m0BJdCm8xAvF5UXt3w5gGo0AejcE6lY3mL
         IbeVFiSoWW8M+o0POYLkZWGvrwnQBkLVSjg2Jmj8khpByjWx2AbokY4oQK/sx/dpW4SA
         BmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0pQ1kB8uuV8lHgKvwxOpNfWxJmRhA22mxki0DXPcPVQ=;
        b=uSLd4tAouWkz/lDJX3lYg6hhWR45ziyxP6hhUJmiNCtJt4CwTNlkX8rPVNllvsGOdj
         ZeeBKDLsnvyqbsa0TPCHlObKuhPDt9CZOhoVmhV9/416du44KDQpDItxT9rKm9FU3nnm
         muycZ/7OnQmVWRnLGy0YCc5fcKh3TFjnkSyIfjKYML8AUfn59xVlhjaqdxC3i63paOp3
         ScXohKSGD0PRAAKHcAQDJwmLBJ5VPVVAm9ajyTNEvEzh5znG9lvY2BbWeoHG5Q/3143p
         Uf9/XFmZ3WkqtvZi35O+bAFo0xscd1h73gv2io1xwYOE8B/XfXEFLTLbzq+rwKmFquW9
         WaBQ==
X-Gm-Message-State: AO0yUKUjLZkUrWtLGfiziO+j34OEu/W29Tr8J5fUfMTfXQuqAKfEKgcd
        NZv+Wa5JoUjmrzlvNBEN4rzR45WvYjM=
X-Google-Smtp-Source: AK7set9wYgs+18AKYqnTRKEHiKJZAuRuiC3l00AHVzSQTKPU4Kc/mQ/g4VXZyaZSaApIny/Gpxqudg==
X-Received: by 2002:a05:6214:b6d:b0:570:7026:2a19 with SMTP id ey13-20020a0562140b6d00b0057070262a19mr3033669qvb.36.1676833784425;
        Sun, 19 Feb 2023 11:09:44 -0800 (PST)
Received: from [172.17.0.2] ([172.177.36.112])
        by smtp.gmail.com with ESMTPSA id d4-20020ae9ef04000000b0073ba942f3a6sm5788532qkg.70.2023.02.19.11.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 11:09:44 -0800 (PST)
Message-ID: <63f273f8.e90a0220.f5ff3.e7db@mx.google.com>
Date:   Sun, 19 Feb 2023 11:09:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3135700686673134799=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] audio/transport: update BAP transport QOS values when changed
In-Reply-To: <f37329b52b85e536b8db17c0fa5e349578fff286.1676829559.git.pav@iki.fi>
References: <f37329b52b85e536b8db17c0fa5e349578fff286.1676829559.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3135700686673134799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=723301

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      26.22 seconds
BluezMake                     PASS      741.85 seconds
MakeCheck                     PASS      11.06 seconds
MakeDistcheck                 PASS      147.97 seconds
CheckValgrind                 PASS      239.27 seconds
CheckSmatch                   PASS      317.40 seconds
bluezmakeextell               PASS      95.57 seconds
IncrementalBuild              PASS      602.44 seconds
ScanBuild                     PASS      944.47 seconds



---
Regards,
Linux Bluetooth


--===============3135700686673134799==--
