Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9FDC63777
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 22:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2217221F8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 22:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxeEgKOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgKSWbF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Nov 2020 17:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgKSWbF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Nov 2020 17:31:05 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70BCC0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2020 14:31:04 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id z3so5702364qtw.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2020 14:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=OgfgMV90FrfcNlmq7PMhIrjYz/cECRvnO8+rOQSqNTU=;
        b=BxeEgKOS+GoZWA9poiD0muTIMWI1tB+34hfypqnCw6GDVoKs7fPbeIRZDq+No324/h
         k9KM2Lye1FjSXzLwX1/0tHTcx1Ou4HhKJp9ZDg+HRuKqH7WiYxO7T0W94zBmKZe6d+oP
         ST03GsYMwWonrlnTydwSZwW/VB1DoJBP7CoQZhat3Z5CQNFjZPYX/4Bntn0TH/MunVgc
         SN0f+9s6C5v1gCaDnkqfgoIm+m6iQGMlk2W/5rRfDw4Pr0zo69wDNr1h1YMuziT4bH21
         zXgdaOAO7TY4GwRULt28u5nGOmheit+d0Cl+Ed47KGQw7QleX/dmzrbw+gcEA3BEnA+8
         /PeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=OgfgMV90FrfcNlmq7PMhIrjYz/cECRvnO8+rOQSqNTU=;
        b=XPuCt/exmbAo9+W2IILm3W0dDiLdbefbcoETU3jHrmwj7aEhEqKl5p1xRg625pnlPF
         ThU6WgBMZsKZRdC5/+UyHTBZit3TXT9wcXVpwmaLKu2QvqcYMekXqP6Vj83hmJ57og8E
         95QDiysz3O/RdkkEog4O/DJ/BAoWceROeOi+wNzjjlzf0UHnPYK+QnmhUNysWYtUysku
         jJUVSbuY9WCPf8Rs5Lct6nyOWowsxsHnza3k4jQpyzNOKR4u3nPXuabzYdNjBNpZA8t6
         JgPmja18qxFB3VOTACydncBOfQzXKfn3GhcV8UvyO+GhHWQ7SzLOFacjNmXms+zVRIsG
         6pkA==
X-Gm-Message-State: AOAM533UD8qinsxnL4NpWecQx3PWcszYbyKlP1vSJeCKhKIq7FGw6cWU
        bbDQ3yo7rx37sbHAf7GmdyJiN/z2oZUWXA==
X-Google-Smtp-Source: ABdhPJxQsYK4kD0aimMLbkFQ67Y71mx0kaXLmDGt7XmePZr2XdLdyISPSKN0TvCpKRivxTzQ5obbJg==
X-Received: by 2002:aed:22c5:: with SMTP id q5mr13168227qtc.234.1605825063743;
        Thu, 19 Nov 2020 14:31:03 -0800 (PST)
Received: from [172.17.0.2] ([40.84.31.250])
        by smtp.gmail.com with ESMTPSA id g8sm849227qkk.131.2020.11.19.14.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 14:31:03 -0800 (PST)
Message-ID: <5fb6f227.1c69fb81.e0c3d.64e1@mx.google.com>
Date:   Thu, 19 Nov 2020 14:31:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9010907479655645353=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pavelm@google.com
Subject: RE: Fix duplicate free for GATT service includes
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201119214337.3886160-1-pavelm@google.com>
References: <20201119214337.3886160-1-pavelm@google.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9010907479655645353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=387933

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
Fix duplicate free for GATT service includes
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#14: 
bluetoothd: src/gatt-database.c:gatt_db_service_removed() Local GATT service removed

- total: 0 errors, 1 warnings, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] Fix duplicate free for GATT service includes" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - FAIL
Output:
Fix duplicate free for GATT service includes
11: B1 Line exceeds max length (84>80): "bluetoothd: src/gatt-database.c:gatt_db_service_removed() Local GATT service removed"
14: B1 Line exceeds max length (94>80): "bluetoothd: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10006"
15: B1 Line exceeds max length (94>80): "bluetoothd: src/gatt-database.c:proxy_removed_cb() Proxy removed - removing service: /service1"


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============9010907479655645353==--
