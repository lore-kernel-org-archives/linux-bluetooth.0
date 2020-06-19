Return-Path: <SRS0=y5DB=AA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9A9C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 23:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3708208B8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jun 2020 23:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Whf+JbuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbgFSXF3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Jun 2020 19:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729923AbgFSXF2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Jun 2020 19:05:28 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE3DC06174E
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2020 16:05:28 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id l17so10539014qki.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2020 16:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Skp7ka6G4daxKIPlabjWQ/X/5qMdH6n+Nu79aelw88w=;
        b=Whf+JbuOqVcd62W6Neizjl+ygrKM4F17tluSuzsW0rnAvuSTw06OJrylaL1Ch92WqO
         scOQALiOEn4bVcyibBIeYF+veT7ZINboe98+3nWekt+/90pfrcTWdPltNo97hEUB0w04
         50mNJNHg+ruuVH3xdwjyE4Hw0etnUlQnsoojkaB8xgc1DVi36G4kUwZd6d6rL7iwUESC
         Hv22dVTSAkxi1cFOSGFHqiXacxPMnwJsDktn2/fEbCBnHV7tYbJ51RDLqMVM3AIuXnID
         ZBSGD5DOzqqMVzHSp9eLM+9azEAfJgymZNdWhF9C3H00hlY2rycfQ0yw5MkgRRcNrbKs
         hL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Skp7ka6G4daxKIPlabjWQ/X/5qMdH6n+Nu79aelw88w=;
        b=P1yznqm4kxoUh294VvdcmoZW/QWG1RaSyOAU0scPZexmj8Y+u+sg39uzgXAsQyg5mA
         mZWW/mexV4r6fg1pv6PvI1LK/82iE05PLirp2gLMFjMl0FNbN/dG/BRoo8+rzWv260pe
         8Z0Y5db7N5vACf9E/g7IwlQyO/pKwIJHO64IvumUDIdQ63Jkr1rZwOdLKppLXoYSZq8l
         LlJjJ+DPKK+SHy4EI9LKVfXch67778cAscByifWe3UHVueNCN6Xty6JdSTJeBxuZnk/E
         18Dfy8w15obiyDAL6/B8OONsu/M3ELYt7P4S07BVp3qJ8MgbNSeu3kcx1m+hwSWt/DlU
         NTbg==
X-Gm-Message-State: AOAM533ZKsYhEH6DQwwCKYAZQEqvaAwK/tjE+oHHGVMaOK6s/EejdTDx
        xGt3uhgq8P6Hx7vC5NEPbpWgfbthkf8=
X-Google-Smtp-Source: ABdhPJwJOXQ2GA+jQ4nBrFq26TecumVw+0H76abgta21I3DPJj1UgrnAGoNj+YEbk6rXfr5T5IV4hA==
X-Received: by 2002:a37:6744:: with SMTP id b65mr5222159qkc.324.1592607927092;
        Fri, 19 Jun 2020 16:05:27 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.172.175])
        by smtp.gmail.com with ESMTPSA id h19sm7964902qkj.109.2020.06.19.16.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 16:05:26 -0700 (PDT)
Message-ID: <5eed44b6.1c69fb81.44ef1.7e06@mx.google.com>
Date:   Fri, 19 Jun 2020 16:05:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1276049013917436348=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michaelfsun@google.com
Subject: RE: [bluez,v4,2/3] btmgmt: Add command "remove" into "monitor" btmgmt submenu
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200619155612.bluez.v4.2.Ib8ae2d78936aa9f16a318aca14cf8c7198449bac@changeid>
References: <20200619155612.bluez.v4.2.Ib8ae2d78936aa9f16a318aca14cf8c7198449bac@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1276049013917436348==
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
#78: FILE: tools/btmgmt.c:4686:
+	if (sscanf(argv[1], "%hx", &monitor_handle) != 1) {
+		error("Wrong formatted handle argument");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}

- total: 0 errors, 1 warnings, 80 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============1276049013917436348==--
