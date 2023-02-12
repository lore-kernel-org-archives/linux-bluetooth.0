Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB856C05027
	for <linux-bluetooth@archiver.kernel.org>; Sun, 12 Feb 2023 18:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBLSvF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 12 Feb 2023 13:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBLSvE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 12 Feb 2023 13:51:04 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBFF10AB3
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Feb 2023 10:51:03 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id e17so2598224plg.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Feb 2023 10:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nxmIMmbsfaONNqnQag0nwWMHfiurC56d2g2uOikvnAs=;
        b=Ce3J3PPfjgagMq+AfJ2A0mgXXSBrb+z6lNGNsP+POQ3ZCyS+Zy+FCFKLezB25QAFJi
         Q/2yJozZHJ+MbP+Wn1OMnjDBWJZmVmzUUc6+yZvI/hNgoTnQRbgSPyCwi8Qv6lWwS8L6
         sm0MF/QC7ql3ShdTHiakZkrFxbiAbzgdixMtmvqmpJzgybG5YCF/Oi86tXUeLqEo4TD2
         SzYiY9s1SeXmRJ5EiNhw68JzJnlY30ub16nA9JsCnWl5N3UgnSDYdaWmdml+DyCEAWax
         h+noDJsv8Hm/+hTNOvvgqYKhkvC8+D1lm1ztxEKJAzBi6F/yin3QMbyFj3ELL8jaweeC
         46rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nxmIMmbsfaONNqnQag0nwWMHfiurC56d2g2uOikvnAs=;
        b=6Zp5bEZEyB8jtcf0T4B59N3NjsmaNd/58lfgbQxNA5jrzXRVTMuLL1p/kMdltrYomI
         /CB4b5AT8VdTaLD3MF4edYdP9FimoZwwFaXEerhk6ropdiE7yuHank3A1KScDTHijGiD
         M2yJYg8TKgWzcT6Ff1J5TO9UfOpNlPMot9yhQBKDGk6afmTM4sdE0pq0PxyYoEL17ZWY
         JUHAvF4VE3crneb1xBxmu1Ws8gN23bfOGpYVJTuLUSDAUugNr62ohH4EIj9WzB2Z1Fmj
         S4lNoIjW6tNEYvjiUnqLxVT1OPN7xpM+9ctF4wBs4+klZYMJoeoZK6im+s98IEh+mxi4
         5Osg==
X-Gm-Message-State: AO0yUKWO1yfe2C8pDlMzUgyAuZzbymXqVTyzl0acubqZZwTRw4qtsAMo
        fGSq4+JrEcTk3cc40Qyuh7IIIflrLGlG7w==
X-Google-Smtp-Source: AK7set9D6rH08k3QeSVofnrxg2MmH82aFr7KxUskeIUCU7LW/2XeU9+yzBNtusL5UyFHLdpV53rR4w==
X-Received: by 2002:a17:903:2407:b0:198:adc4:229d with SMTP id e7-20020a170903240700b00198adc4229dmr13881046plo.24.1676227863178;
        Sun, 12 Feb 2023 10:51:03 -0800 (PST)
Received: from [172.17.0.2] ([13.91.160.241])
        by smtp.gmail.com with ESMTPSA id jd21-20020a170903261500b0019896d29197sm2671232plb.46.2023.02.12.10.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 10:51:02 -0800 (PST)
Message-ID: <63e93516.170a0220.bcde2.39b2@mx.google.com>
Date:   Sun, 12 Feb 2023 10:51:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2740464379613493747=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, david.nicolson@gmail.com
Subject: RE: [BlueZ] gatttool: Use consistent spacing before brackets
In-Reply-To: <20230212172402.19018-1-david.nicolson@gmail.com>
References: <20230212172402.19018-1-david.nicolson@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2740464379613493747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=721094

---Test result---

Test Summary:
CheckPatch                    PASS      0.35 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      33.20 seconds
BluezMake                     PASS      1090.59 seconds
MakeCheck                     PASS      12.80 seconds
MakeDistcheck                 PASS      183.29 seconds
CheckValgrind                 PASS      301.39 seconds
CheckSmatch                   WARNING   411.94 seconds
bluezmakeextell               PASS      122.16 seconds
IncrementalBuild              PASS      922.53 seconds
ScanBuild                     PASS      1317.16 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
attrib/gatttool.c:235:23: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============2740464379613493747==--
