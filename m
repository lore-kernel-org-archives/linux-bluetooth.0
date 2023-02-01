Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E2AC636D4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Feb 2023 20:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBAUFw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Feb 2023 15:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAUFv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Feb 2023 15:05:51 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0AD62789
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Feb 2023 12:05:50 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z1so12069083plg.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Feb 2023 12:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E84ojlJ1mq+sL2ce+ef4CC8vT394XIiifBVItGoEwZo=;
        b=GIhqg0CbSUx5CobPhnkWujzmj+1eGgVwdlsMu2g683WBI5YE4Zknhs6DJ2V3dR+LsU
         RlQcI5mHg/GgeX6jDjxCrRvKjoovK9hHl0nSRxGqR7yl7hsZiVzm2UwhsfsrY6weZJ5a
         cbjfXAFRbuGA6iyufuosDYx+mJUE/70MPQSWVOHDP7SQZm30cSzDYakiNrmsbozUrdHB
         O1MugdR5h5J+9gOL3D9dZxD4MirOA+y1a2rcjENYi0ubo3wh4Cl/7wGbFaYptFIDAVp0
         MiO0csdlsUef3v04lmO61p0m59DwgeY3MHfDvJ7L9BD7SoXermHLf1t07FXwKLvydqMF
         Y0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E84ojlJ1mq+sL2ce+ef4CC8vT394XIiifBVItGoEwZo=;
        b=vyDISXXkHTW2Z1AZ6EYfRCVb/IrW66TOc5XFPXfTJKu8xDYeHdZ81xhHYduZWJ6hTg
         V0MP3zQOX/3rhYtb1hwCDnLliBm58RwrGa+LQG7jZ02Me7YJ9bGE4Y9Q05VYSYv/8T5q
         4dVcUcTlDcRP3PFWdVCm71pWaBhjxRLp5BdVFjzmwCcBM170WZ46DdAhJoXaa0l9Dtge
         g8EaTqkIQKyYu5ySz4yPrt8iHRLFMInHyAyCxKFOpe+k1ZOW1dtOIBm4M4RJ/iNwiuxf
         3f3Jsf4XvceaeTfu2hgFp/UZFmBvp6Aojlvi1tI3RS6fqnBj5Pl9MTkkAqf17oQ1kGti
         yJZg==
X-Gm-Message-State: AO0yUKVDsfFmK7aHmQm/gWw/ggsGsX7s1l88lMrrMCoE7KGYdwV4ex80
        tufiJUCT/RSUj/OQoroAwvWEefjDx5MRSg==
X-Google-Smtp-Source: AK7set9wtBF+IdSwFdIdzIEq44kKYJXxvtgrcrZDnZZc33e2DrRVR8iedRzRsX9vuTodJaHXZcS8FQ==
X-Received: by 2002:a17:90b:33cf:b0:22b:eec7:dea5 with SMTP id lk15-20020a17090b33cf00b0022beec7dea5mr3482185pjb.30.1675281950154;
        Wed, 01 Feb 2023 12:05:50 -0800 (PST)
Received: from [172.17.0.2] ([20.172.10.65])
        by smtp.gmail.com with ESMTPSA id n1-20020a17090a670100b00228c8aa7916sm1684515pjj.38.2023.02.01.12.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 12:05:49 -0800 (PST)
Message-ID: <63dac61d.170a0220.cf82c.30c9@mx.google.com>
Date:   Wed, 01 Feb 2023 12:05:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9060611481132411813=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] media: set default value for BAP endpoint Vendor field
In-Reply-To: <d23190507e9c7131481648848d0afd62448226d3.1675276185.git.pav@iki.fi>
References: <d23190507e9c7131481648848d0afd62448226d3.1675276185.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9060611481132411813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=717858

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.25 seconds
BuildEll                      PASS      26.98 seconds
BluezMake                     PASS      749.00 seconds
MakeCheck                     PASS      11.59 seconds
MakeDistcheck                 PASS      147.49 seconds
CheckValgrind                 PASS      238.95 seconds
CheckSmatch                   PASS      317.56 seconds
bluezmakeextell               PASS      95.51 seconds
IncrementalBuild              PASS      610.03 seconds
ScanBuild                     PASS      966.48 seconds



---
Regards,
Linux Bluetooth


--===============9060611481132411813==--
