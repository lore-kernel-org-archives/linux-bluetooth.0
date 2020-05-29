Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453F3C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 16:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20DDA20814
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 16:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiG2Z6Br"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgE2QKF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 12:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2QKF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 12:10:05 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043E2C03E969
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 09:10:05 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id b27so2677097qka.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 09:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=imlQ1gWwT9mHLSPx8I61RS3WBxXLDFEtZNkeOxifRXQ=;
        b=OiG2Z6BrfdxMX0kEig4YjA9ynPD4EJ9VZ4d1HtoD4kNME7TghpmLUSi2zeW/avvijQ
         iBQYIAwy15vVQq37zEJU73bmfpxh+Mprg5b4jFqmwPSfyUnloHSbkWybSzGRPhshNxN1
         iq8V8fYf8RCkm/cF8z+6GCeASdW+dqRccaWdDJ2GHwXwmOzn6PBJH1ZQy5WbeLSALtQt
         QzSkT0J4Z1BjgkLF9+9Flw0KW+DmSexs1NdeX1NEfnOqKlPWpLpCMP7wx773Hvfo2mn3
         htCCQlwx1CAFvQVzAOmLmUPjNNWlbmsTx56logdLKfi0KU9Q3v8KIpQ6qjqbeLc/wuRB
         YO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=imlQ1gWwT9mHLSPx8I61RS3WBxXLDFEtZNkeOxifRXQ=;
        b=VQOT9D9pqeZNYdTWGqXo6p5+d5rCZSyvJ4t/YSy2jy6Adm0IfT1VjVfnFx8cFIsIUa
         S1uGNJEMCW6eREJw24jEzjtxH3YSF7DU087e+yVBGE6aZH0muc27kMW2BVG0WmU+Ke14
         jm+sGg2D7KMnSu7wAh4BDIGDOVS0sBunzQAPHzt3eKAhEC+J1XLeIv5AhLpBQtg1lEYh
         LJB8D/PbIwfAErFbSH2qnKKarARzMi4uyZCMGX+q3DMyZZUhKG2isWib8Uf+hzCYF9zo
         bKPwRmpWAJXWggOG69rDz80XITv8k2F5OD/7B9UG4nx4TjnWIku7XeG/vpl6Z8tJngm2
         J9og==
X-Gm-Message-State: AOAM532ICAAvW3IX8krQhD7nsf6KXy/WAqYyVJ2eLZNkSbw052E4Zxql
        heFh50zIxM4WtJiYi/oqI/NyqRYGdVw=
X-Google-Smtp-Source: ABdhPJx+AvyyPaCxtM78swTIE3qaeqRQGCEfNwDT5x7b+5i4Pi25VNMcQlQU0wXqeaSVvut3ObrRCg==
X-Received: by 2002:a37:a9cd:: with SMTP id s196mr8448993qke.315.1590768604108;
        Fri, 29 May 2020 09:10:04 -0700 (PDT)
Received: from [172.17.0.2] ([104.46.108.37])
        by smtp.gmail.com with ESMTPSA id g13sm7069092qki.95.2020.05.29.09.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 09:10:03 -0700 (PDT)
Message-ID: <5ed133db.1c69fb81.c4fd7.95d8@mx.google.com>
Date:   Fri, 29 May 2020 09:10:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2193247698100572256=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, alainm@chromium.org
Subject: RE: [BlueZ,v3,2/4] adapter:set default system configuration if available
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200529153814.213125-3-alainm@chromium.org>
References: <20200529153814.213125-3-alainm@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2193247698100572256==
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
ERROR:INITIALISED_STATIC: do not initialise statics to false
#17: FILE: src/adapter.c:123:
+static bool kernel_set_system_params = false;

- total: 1 errors, 0 warnings, 320 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============2193247698100572256==--
