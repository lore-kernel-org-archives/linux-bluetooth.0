Return-Path: <SRS0=p+wm=66=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D0AC433DF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 May 2020 00:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E912C2076A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 May 2020 00:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtTpIOog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgEPAJ3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 May 2020 20:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726198AbgEPAJ3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 May 2020 20:09:29 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5488CC061A0C
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2020 17:09:27 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id i14so4470300qka.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2020 17:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=DmZueznRhiaGNzTjYX9riR2dwizqGT/wj8CfQvoYQkk=;
        b=UtTpIOog54k6LBx2Y/OeB4Reabe7R0E1LFlbHsWLbBiHVNjfK5HHd+H9qmJtLu+r39
         H7LIwXPi4DXEaBW1pCedynzEC3rBoy9ajT6tZM8BnNPFJoSSFDfgkDv0U7SHIHj3DneT
         vEceQP1dL7yQpoTVi91MACFZZ1s/TtvzJ8qL7vc53df8XOrlKiabElTyplASr9tDvO0f
         HQweBBHGLdIOoRFF7GHH4G01Et3D+6LysR/IuASG4/3P9q5p3liuyJNrfyodsQ76JLoY
         RNuabQIGse/dNNpQfPqeHX+xXzy7z1JVUGTLbThDTLHTvsxC6AF0WcfNvAPszQA1C3f5
         s61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=DmZueznRhiaGNzTjYX9riR2dwizqGT/wj8CfQvoYQkk=;
        b=L70p2H4flNcNwjhrhjoBsW3COeHuxR56UeK2YmuIxKyETQDTLNR6RGxWDDqmnh/LvS
         8rydwfdK68VDiNMN8Dn6HxPjdaYkz/vycjqWpkEkDVwHIi6r+tHK9ONK0gJSTdnISa2N
         mgfu1RyHiWHR6wrb8rlqjOzv2CANamWqcMMV+Z2qlGYxkC/A8EtMJURBMtd51stMNtf6
         8f4hk9YlzuaLyjdoxLEJJXybO7NMrDHZ/9VzSeO8RXiSLFjT+oUSrsC9qsakWpDJ2K82
         uqnxdp6DKGPWzsuEi/6yDMYu/wjgkIODtaqRDcKIX0Cfvg8NhPNdzceyqyij8FUj7FTJ
         m24g==
X-Gm-Message-State: AOAM532KO/SQN+V4T6DosLtwpoBH6tunb7VejaQt/Q8ZXic3iToXfWMS
        UwTpSbDQf6uoblT2FJbcEJKwHJRrFh8=
X-Google-Smtp-Source: ABdhPJxfgbMatib3olgvAgoRJE4Ds0KWxl24dt2JNFPJ1wpJfG9DnXCnlUNRq0ecLIifMTbjs1zDAQ==
X-Received: by 2002:a37:8844:: with SMTP id k65mr6138295qkd.309.1589587765993;
        Fri, 15 May 2020 17:09:25 -0700 (PDT)
Received: from [172.17.0.2] ([52.247.62.227])
        by smtp.gmail.com with ESMTPSA id u56sm3380145qtb.91.2020.05.15.17.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 17:09:25 -0700 (PDT)
Message-ID: <5ebf2f35.1c69fb81.9259a.4d6c@mx.google.com>
Date:   Fri, 15 May 2020 17:09:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1020173334636916025=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ,2/2] mesh: Fix valgrind memory leak warnings
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200515235912.565846-3-brian.gix@intel.com>
References: <20200515235912.565846-3-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1020173334636916025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkpatch Failed

Outputs:
ERROR:FUNCTION_WITHOUT_ARGS: Bad function definition - void net_key_cleanup() should probably be void net_key_cleanup(void)
#54: FILE: mesh/net-keys.c:527:
+void net_key_cleanup()

ERROR:FUNCTION_WITHOUT_ARGS: Bad function definition - void mesh_net_cleanup() should probably be void mesh_net_cleanup(void)
#91: FILE: mesh/net.c:706:
+void mesh_net_cleanup()

- total: 2 errors, 0 warnings, 75 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============1020173334636916025==--
