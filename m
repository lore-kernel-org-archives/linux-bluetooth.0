Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA009C00A8F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Oct 2023 12:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjJXM0d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Oct 2023 08:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjJXM0c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Oct 2023 08:26:32 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4894A2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Oct 2023 05:26:30 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-58410fd30aeso2212073eaf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Oct 2023 05:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698150390; x=1698755190; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=94sHlHOeJz9EZG4rj6o10kLO8y4ZgaCcikJkJ9T78L8=;
        b=PAWdhNA+yZvJSC0sq3hRxzZP4bcCm8AjED2dZe1jTdT3PkDRgE3A7NKnKklMbGUcW6
         aMw703LWzKxWTmDNc5/rA+JlmUgCP5plpIaMxK9DhlYvdXhtw5wb2SvqI00wsx3a0OAZ
         hqDOJLXkdftU12WhF1cG4msIBzayzaRNWtf2AY0k3xsKjuPAJel8chuncwAJ4P595yvM
         mK4nVSgp2zWrWEz886r2ANVFTSXzWF3KytVIYo0qMUvZsKr4pNQ/hqVL0uG+Ht27KpdH
         WsWzsBhhymAmLFil5zO14/jF4bZ/IGR4LcIQmNcaCyreA5YvTKGFVKv3uQqOHifOu9Eh
         IWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698150390; x=1698755190;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94sHlHOeJz9EZG4rj6o10kLO8y4ZgaCcikJkJ9T78L8=;
        b=I3eTjFBeQB3dSoIf2N5llpzjehlL0GqGmjgLrWybX46P9S+AMcP9POAcQ3RdFo80ez
         a8kjGTEHhoX+S/0thuWZQ5SKXLoMAZlHwmp/dH+dKNP+yzPVCUH042RI49LPF+73Lp9y
         RSVbd5NJKEQM9mAXRhJERd7X8qjkd+a6aoE1ZX0mJnJ6dMAo8AnQM4mMGD5tibE4TBdZ
         FC10kllbLWNhosfp6JwR6IBCfdDb8OaMkEh/8co6iMI7vh+CNSmxcy6Q6d2AM/+TyDLe
         q7i63hUQVm3mrKi0hxCfBF2CjGwR1PyIDJcNxPzBJ6Yx5d2d13SksCnSI2sT5jqjmgwV
         1uZg==
X-Gm-Message-State: AOJu0Yy3usyLYq/YnNIepprMwZPixNXRkQQgxFbvvd5mjtpIm7+lIlTw
        ENXqFf2D5ir6kcWkY1tjopE4z2fpdNs=
X-Google-Smtp-Source: AGHT+IFYLeHmZmH9JuLygOIJsNN4hR+SSUFxtYG3YmaP+g/iAq/z/K1TtXlecPvBaSbY4NSpUJWpQg==
X-Received: by 2002:a05:6870:e30f:b0:1e9:d481:52e9 with SMTP id z15-20020a056870e30f00b001e9d48152e9mr7486650oad.28.1698150389855;
        Tue, 24 Oct 2023 05:26:29 -0700 (PDT)
Received: from [172.17.0.2] ([70.37.167.34])
        by smtp.gmail.com with ESMTPSA id tp23-20020a0568718b9700b001eb684b9347sm906180oab.44.2023.10.24.05.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 05:26:29 -0700 (PDT)
Message-ID: <6537b7f5.050a0220.8e171.4209@mx.google.com>
Date:   Tue, 24 Oct 2023 05:26:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6373264971598738399=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: iso-tester: Add test for bcast receiver PA bind
In-Reply-To: <20231024110345.3292-2-iulia.tanasescu@nxp.com>
References: <20231024110345.3292-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6373264971598738399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=795982

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      34.73 seconds
BluezMake                     PASS      1039.19 seconds
MakeCheck                     PASS      14.24 seconds
MakeDistcheck                 PASS      218.70 seconds
CheckValgrind                 PASS      331.71 seconds
CheckSmatch                   PASS      436.15 seconds
bluezmakeextell               PASS      143.71 seconds
IncrementalBuild              PASS      880.74 seconds
ScanBuild                     PASS      1347.36 seconds



---
Regards,
Linux Bluetooth


--===============6373264971598738399==--
