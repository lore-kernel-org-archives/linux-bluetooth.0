Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7314BC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 00:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54C9C2074D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 00:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vWmzfO4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgFPAMd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 20:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgFPAM2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 20:12:28 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC587C08C5C2
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 17:12:27 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id q14so14165295qtr.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 17:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=XNzpy1tbF2yZ11DauzGLMmY8ZVyuOFn4GSoZ4F3xiIs=;
        b=vWmzfO4JgXp6/kH10UiDT2cS82Ps2kyfPEtefCwc9MUjJz6fWtY5n1DZV7gSiJwoJk
         j5rXVY7XVBB7/FzwkjNTE6NU7hAVm2Q1B5/H3dYx9Lds8PcMWwWbjjbtkTBHwTs+QkND
         QTp+w9Rp0Coq9MownWnqtq7/kVgAuLktLk+PohFon8q67bPlw7arwsoZCAD8pB4F5J7P
         OjNWAchMIHrBPekXC6hD5CushnkuXKQAxDqdiJnX924Oi7oMsVlr9Fr9ln89WtBafnzf
         Gmn5xXCtTtqDUOIvKPfkJodCvWsdwpB/OZ5wGsXZfRzt+uXEV+Fa4q646zJ1q4/mEEe3
         2RkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=XNzpy1tbF2yZ11DauzGLMmY8ZVyuOFn4GSoZ4F3xiIs=;
        b=NScs5zywthlrb0w7JG8pjhPDGNftqL22bGoj+HIXoRH4IruU5uT6jfsF1Rzj+HRusi
         IPxurpU51z0MQFLbW0YELwBmUWul74BgKOhtItpnp4cck9AqIEsH7N425mQENCso78Zg
         0alrioZXJ5hDcfRY0PXpCworMnHaOxgvItcxJiP99otrXGtYQyN1FyoOCjF2oSCkWu2R
         ORCvc+H0lLBQitwFGofyZeo279ZlHFQG4CSoGMJOV07AwYc5B9T6k3tWAnzqgQ1e2xvr
         /eSlEc3iv/LDDmzP4KtsKsj3os9ydUz/V4p5uizf+J5ITo8N+gMzc0qPsW/qktONcGmy
         xyag==
X-Gm-Message-State: AOAM533ubCc0lXeac4j4xSkXuoHGpmHscZJgAzPsSIaTrk5WtyA5Um1x
        TZ4j39NIk7XUkOJF3oLPfn2gjITa
X-Google-Smtp-Source: ABdhPJzGwaYMELdAnYeypQcvLf3u3PcXT7fQYWV3vOZ5POXUhPVMWmHTc9/ivS0UkClF2VOzo8/4dg==
X-Received: by 2002:ac8:342b:: with SMTP id u40mr18031072qtb.59.1592266346814;
        Mon, 15 Jun 2020 17:12:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.36.191.240])
        by smtp.gmail.com with ESMTPSA id r138sm12534294qka.56.2020.06.15.17.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 17:12:26 -0700 (PDT)
Message-ID: <5ee80e6a.1c69fb81.7796.7fac@mx.google.com>
Date:   Mon, 15 Jun 2020 17:12:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7612047573608803163=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michaelfsun@google.com
Subject: RE: [bluez,v1,2/3] btmgmt: Add btmgmt command advmon-remove
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200616000318.42664-3-michaelfsun@google.com>
References: <20200616000318.42664-3-michaelfsun@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7612047573608803163==
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
WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'advmon_removed', this function's name, in a string
#32: FILE: tools/btmgmt.c:1022:
+		error("Too small (%u bytes) advmon_removed event", len);

WARNING:EMBEDDED_FUNCTION_NAME: Prefer using '"%s...", __func__' to using 'advmon_removed', this function's name, in a string
#36: FILE: tools/btmgmt.c:1026:
+	print("hci%u advmon_removed: handle %u", index, ev->monitor_handle);

WARNING:SSCANF_TO_KSTRTO: Prefer kstrto<type> to single variable sscanf
#71: FILE: tools/btmgmt.c:4686:
+	if (sscanf(argv[1], "%hx", &monitor_handle) != 1) {
+		error("Wrong formatted handle argument");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}

- total: 0 errors, 3 warnings, 79 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============7612047573608803163==--
