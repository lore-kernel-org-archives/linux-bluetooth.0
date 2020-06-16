Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1D5C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 17:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97E7A21475
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 17:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyVwV0U+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbgFPRh1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbgFPRh0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jun 2020 13:37:26 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB96C061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 10:37:26 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id r16so9896712qvm.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 10:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=vjymJMdriNlShquUhc0kje+yFrxQEwjTvz+VOTDvTAs=;
        b=VyVwV0U+ttMea+DEDmW29JeUlpSAuhI2cNL5DOsH6PXqyTlm0eLZ7GowIM094osucp
         D0cpxI8RT/g7qJTd9HnGKrmizRl09T3qdzkttHdvMCrgXI6E8iParb3fFrXe7Qr0O9aM
         g4vO0Y7ZcH9ETNdqbjwnyNnCiGLRyvqxgqoSmwWONaf+1/NdfldnjLjKGZDXgT+gP/Jg
         pSC+b/5R9s+a7IRPwwJWB1rZLQZ847qbsE54T6+cCW5Uhd8K2EW4Uj0akTtxtTtjUGi7
         OfoqY7g4htTP0z0EaO+xaAG17ecsmaa5WefelJpPhaxulN4f8DaisZAvTaPZvzE1Ym/F
         h4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=vjymJMdriNlShquUhc0kje+yFrxQEwjTvz+VOTDvTAs=;
        b=B5rUQnZIx66Jc6wyDsbM9cFh9NONJQrXbqpNY/5XWNuwHcBwN73yMmiUMrJ5m8ma7Q
         UrFeU6VkU+9peQjkawm9eAK863EgT3wLU4wGYbmAXzTVd0n2Oti005zlC9VJcUqZRkpy
         tKFOoExQh+dmALvxrkmB3eXFGNNXI2+JOmtwpcQ9g9aVJpjcV4u0BIOJBYbm1Y8HDYKt
         qFzwQQTktgthN8Flfyeb5hOlzSL5HdxL2NUr6pAYM1Ou+Mmi8JA2E6FWqKPN8A6ROiHa
         T+A2IrqdEMzsV+83AKCxv3uYRuDAp5nIokHXgUcXX6BV+HuE98jeR3Y7AXtSHbU0cJvk
         Sxuw==
X-Gm-Message-State: AOAM532IqIt0QES9sMqkpeDAKXSXBXp+Y3G4rKcH2XrbFcJjvSNaMMDZ
        2SdwAOzp2eF+YkNeNcQT1O/YH+DsOUA=
X-Google-Smtp-Source: ABdhPJxri0b4DnO1lmhaIQv3zoogMXlPHtVYgDmM+eSfhYez/TvAb7KDq1jLJ8f723bNjBLocjn4zw==
X-Received: by 2002:a0c:c303:: with SMTP id f3mr3514042qvi.240.1592329044792;
        Tue, 16 Jun 2020 10:37:24 -0700 (PDT)
Received: from [172.17.0.2] ([104.208.162.113])
        by smtp.gmail.com with ESMTPSA id n13sm17429832qtb.20.2020.06.16.10.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 10:37:24 -0700 (PDT)
Message-ID: <5ee90354.1c69fb81.282ce.1098@mx.google.com>
Date:   Tue, 16 Jun 2020 10:37:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5962184303030250577=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ] mesh: Add deferal of Attach() and Leave() if busy
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200616170510.27378-1-brian.gix@intel.com>
References: <20200616170510.27378-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5962184303030250577==
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
WARNING:TYPO_SPELLING: 'deferal' may be misspelled - perhaps 'deferral'?
#4: 
Subject: [PATCH] mesh: Add deferal of Attach() and Leave() if busy

WARNING:TYPO_SPELLING: 'deferal' may be misspelled - perhaps 'deferral'?
#12: 
If the node is still not ready after the deferal, Attach and/or Leave

- total: 0 errors, 2 warnings, 90 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============5962184303030250577==--
