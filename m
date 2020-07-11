Return-Path: <SRS0=nBj1=AW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259ACC433DF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jul 2020 12:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB358206D9
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jul 2020 12:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaeznO0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgGKMXu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Jul 2020 08:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgGKMXt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Jul 2020 08:23:49 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1627C08C5DD
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jul 2020 05:23:49 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id k18so7932492qke.4
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jul 2020 05:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=bguH9NPoTSMPiIqfLlGSETGclFvqXfQPOxujoD6NWbU=;
        b=TaeznO0CjK5CZNxRn9T5aPMow1gcxfGxHHHjhuwOfoRUb01wCYuhgJKdtIv1W0cz/0
         AjjieH6+2rZuoEx31vH8fSyqE/UxFOM8w+XxBPhSKJWsvldreirrmwR6w7ZhMIQLp7cK
         o6JXRJjWh1oPe2bve9o1OVlJr3An59BonlFH+7n3JI9JNFhtXZIxAZ/DE/HCgHc5zU/Q
         AhlC7QAuQt1O1Cn7ii4QwWnPEvZOIvqv2+YxLqDZ+sdlF0pLScQRPmiZhYhL5pdf+GCd
         3ANMY8613wbi7JBuV9x+NenDJ41P3haUjyIH12zZgvD6kI/gG2kQsue/dfiBgDCJXnjV
         YMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=bguH9NPoTSMPiIqfLlGSETGclFvqXfQPOxujoD6NWbU=;
        b=FGIUuokHprcIZyVfl3/KmeiaQqdFWFB2sYrMFDj8hD8kgjPbYZzBJ4EIyjTRpLpE8s
         BE47FeDysdkdOX58tb77npOX0JqS9fFz847Vc3lM1EzbEsavjVWypnEwPFIQb3acWkig
         dxfobr+3Xevlu24ofrGhUhcTAOv5kf8KRThSunSMv0q30gDPzxgSIcIrKzq+yWZTTdzu
         bf/m/SiJd06ghE8MdWCnXGokvpxyLT6fLD6EX9c2LXEo6eMzdvef13r7lr9bBgcVeOsA
         LLvlxaAszzjV+WpijDDl+cibqZ32f9rCN9b5e9bJnXG2KuKO3oDs7YjbCHp6gJ/eNhrJ
         Ewdw==
X-Gm-Message-State: AOAM530bOTEEeL42Tmb0adJzn8q9aCE6xertQuWq06zwUd0V7m9xrbK0
        OkeYKMSrUqk1zlpuVEfv4b4gPC5bP0o=
X-Google-Smtp-Source: ABdhPJyeAjsWTcPL0GgJper1nQ9zyq8qZrPvy+dSXvDXwi0sbF3IjzQQ7bupovQvF51VCuqdkr49ug==
X-Received: by 2002:a37:46d1:: with SMTP id t200mr50427313qka.17.1594470228645;
        Sat, 11 Jul 2020 05:23:48 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.31.62])
        by smtp.gmail.com with ESMTPSA id x23sm10742252qki.6.2020.07.11.05.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 05:23:48 -0700 (PDT)
Message-ID: <5f09af54.1c69fb81.6ddf5.a1e1@mx.google.com>
Date:   Sat, 11 Jul 2020 05:23:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5842721584137256734=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marijns95@gmail.com
Subject: RE: [BlueZ] audio/avrcp: Always update transport volume regardless of player
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200711115031.123793-1-marijns95@gmail.com>
References: <20200711115031.123793-1-marijns95@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5842721584137256734==
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
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#43: 
[2]: https://specifications.freedesktop.org/mpris-spec/2.2/Player_Interface.html#Property:Volume

WARNING:LONG_LINE_COMMENT: line over 80 characters
#59: FILE: profiles/audio/avrcp.c:3630:
+	/* Always update the transport volume, which is separate from the player */

WARNING:LONG_LINE_COMMENT: line over 80 characters
#71: FILE: profiles/audio/avrcp.c:4382:
+	/* Always update the transport volume, which is separate from the player */

- total: 0 errors, 3 warnings, 53 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============5842721584137256734==--
