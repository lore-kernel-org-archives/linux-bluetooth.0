Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58495C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 06:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3392A2098B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 06:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDxB+3HU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgFQGha (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgFQGha (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 02:37:30 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1239DC061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 23:37:30 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id u17so730343qtq.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 23:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Mx+FRKLDzN4YI90LdMKYe1BxLfgYlMWj3Du5hoYgOp0=;
        b=NDxB+3HUTRfXQoSUyoTDPN4NE5SJ7VW6isqa8nkwOqebbx6nHEo6RDTkWPMZUg2aVq
         vVD6Wr2fE2KmaeC8ENdG4SbbA4oi6pVz93S+wfWpuxmevdBVD4+sgMz+MLmFtd7kcdEl
         OylNoqK5EGbFFQyLoeJl36ezoQBa0OcngZz4ttdPvqtalR6Rmj57YFokArf9P3H96kGh
         opRwXFf1bARMYhhLrvrRizPdwFrsOfXibPmZG6Req45L6jgAwWawiwHqWd6DBHnUP95Q
         lWKPxCXO/oAGlCvIZ1C0z0BPVc9Nf944uUm53T+Pr8p53gJo3Se5OYeq+W/gAhrHpJwv
         L/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Mx+FRKLDzN4YI90LdMKYe1BxLfgYlMWj3Du5hoYgOp0=;
        b=ZgztRSiW6pt7BvAYpxM+tOJxeWgUG93wiIRIIELfZtNMK5vXlBTzX3LTppc44v9NAi
         EW9Cj6ZdmFoVHXO984V/DkogAwCZbnQWaPC5Elsz90NuD6SBGW8+T8elKVIPh8eNxN/w
         2hyyigJs9NgTfm3fwV8NL1iHl515SJUQsVVz+VouOHzrlcrfaGEdQ2eOiHSCDWKgWVjZ
         bIo4+trQrlQZ3wVGKOtfbR2LqXODO14Rg/Y7GUz5Y0+fjO09Fzic/S1DL+wHZzT2Ewnx
         tXvIYmR9RGsFWyPjZygxYtyuAB+MCURI1VnWJEkzn3s6TD2t7v4T2O2ADcsiW9bM/Djo
         MkJA==
X-Gm-Message-State: AOAM533fL8tF/Nxi68v8NSyothY1u+Kx9D2++Kczz0LmA3Ec20jM/jON
        N45tR4cpjxPuCK8xD/ZiE691ziFolaw=
X-Google-Smtp-Source: ABdhPJz39ptiCkZuKirwmDmBT8VL9L3Z3+3Llm5yqy16Q7f0bOJHFOZf83dkMW79KJnH4xK1jaLiRA==
X-Received: by 2002:ac8:3a06:: with SMTP id w6mr24894659qte.199.1592375848916;
        Tue, 16 Jun 2020 23:37:28 -0700 (PDT)
Received: from [172.17.0.2] ([13.68.98.178])
        by smtp.gmail.com with ESMTPSA id l2sm19482560qtc.80.2020.06.16.23.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 23:37:28 -0700 (PDT)
Message-ID: <5ee9ba28.1c69fb81.d10b0.a845@mx.google.com>
Date:   Tue, 16 Jun 2020 23:37:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5027362676469036389=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michaelfsun@google.com
Subject: RE: [bluez,v2,2/3] btmgmt: Add command "remove" into "monitor" btmgmt submenu
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200616232642.bluez.v2.2.I6847f3a5339713811d88b3a234e6454e11f0f042@changeid>
References: <20200616232642.bluez.v2.2.I6847f3a5339713811d88b3a234e6454e11f0f042@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5027362676469036389==
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
WARNING:SSCANF_TO_KSTRTO: Prefer kstrto<type> to single variable sscanf
#72: FILE: tools/btmgmt.c:4685:
+	if (sscanf(argv[1], "%hx", &monitor_handle) != 1) {
+		error("Wrong formatted handle argument");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}

- total: 0 errors, 1 warnings, 79 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============5027362676469036389==--
