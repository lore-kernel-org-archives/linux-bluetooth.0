Return-Path: <SRS0=Tswr=DN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FF2C41604
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 14:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32D5D2083B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 14:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6nhieaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgJFOsV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Oct 2020 10:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgJFOsV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Oct 2020 10:48:21 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52780C061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2020 07:48:21 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id v123so16900389qkd.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2020 07:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=aCAl3rSF8g/CMAntbgsY4Mzh+WjUS5MDHg7sTezlhGA=;
        b=h6nhieaJPwHhZSVuzwpLbqPwVuS8gO3XrQNj54R41jN8GNJhFdWx54w9oBdvRSzyOu
         MuPfXUeE1JFBiHRN1gNsdvQOmvd3YLiGKckfq5L1/w0B/fL2bfBK+njtnt0FOuCZh6Hb
         jVt0VMTqzAZNDt2DQBsNExm/hjAiIt1+U06tQfg3D/tHntqoaMNOrL07EXWOCJL7u7Ds
         NpiFh99zXwYETKlZMeZ8VG3+U6Ux89hdfC4zG9tNxloq/fi+pEgOM4/lK1UQhrty0gSv
         fuTPSAkuC92SnSaT4FRaZAjnBdB5Criv8PA6P6lXwgrLTqflAwpO2dq7+VLXuHC/jbg/
         /jKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=aCAl3rSF8g/CMAntbgsY4Mzh+WjUS5MDHg7sTezlhGA=;
        b=XFZf6I6BTjlJyDM85WDpRbJSPlgIlm6NXfR69a7iUzeXAFll704KxyE1X4tx7ExSjz
         TWGmk3XbMNyu9tr9SgmcY5kERtpl3zvzSM7jx4t60WWfCQltGXePCCI33lmsdjZMwTTc
         9SjVXZGWAvaQkTqVTFRWoEIK6p/mVtmg8j/ZmpF6Qu5Rl9Uw/dC2UyywZyIi0Z6Pi9Id
         Zx2n6FUUIgZmHXEU/ovwxlDfv7t/9F233wmklm3NwyfnQF7xv9QXM8JabGWywSLAmEcX
         bh2f8w4vSifi+0wGZI0blXMl9YMHAepQ3Tk59myRReFe1gSucJsk1QnFnXNejaxdhumY
         mXlw==
X-Gm-Message-State: AOAM530W2Uj5jTUnZXMigeCkX+vvQklXFjzumcsp3rKAISVHS7tjeHSV
        dyRzyOyZ4EpzQui9b22CUmJTfLHlQ3G70g==
X-Google-Smtp-Source: ABdhPJxLe2eUiY0bsWFLFcmyYJqQY3FbOt4xNYyWcPiUInwdNsRYvP4VV0fZE3vKCg7B38uaJ2GNrA==
X-Received: by 2002:ae9:ec14:: with SMTP id h20mr5381802qkg.180.1601995700430;
        Tue, 06 Oct 2020 07:48:20 -0700 (PDT)
Received: from [172.17.0.2] ([52.152.231.71])
        by smtp.gmail.com with ESMTPSA id m3sm2652343qkh.10.2020.10.06.07.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 07:48:18 -0700 (PDT)
Message-ID: <5f7c83b2.1c69fb81.9561d.57f5@mx.google.com>
Date:   Tue, 06 Oct 2020 07:48:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3141479068511050448=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, henrik@grimler.se
Subject: RE: [BlueZ,1/1] tools: fix forgotten index->mgmt_index renaming in btmgmt.c
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201006142836.123490-1-henrik@grimler.se>
References: <20201006142836.123490-1-henrik@grimler.se>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3141479068511050448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=360317

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
tools: fix forgotten index->mgmt_index renaming in btmgmt.c
ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'Commit 6523d168a7c1 ("tools/btmgmt: Port to use bt_shell")'
#6: 
Commit 6523d168a7c1bdb886fbf42e8a810ed15e5ec0e2 renamed the variable

WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#11: 
/data/data/com.termux/files/home/.termux-build/libbluetooth/src/tools/btmgmt.c:1229:34: warning: implicitly declaring library function 'index' with type 'char *(const char *, int)' [-Wimplicit-function-declaration]

WARNING:LONG_LINE: line over 80 characters
#33: FILE: tools/btmgmt.c:1216:
+				config_info_rsp, UINT_TO_PTR(mgmt_index), NULL)) {

- total: 1 errors, 2 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - FAIL
Output:
tools: fix forgotten index->mgmt_index renaming in btmgmt.c
8: B1 Line exceeds max length (214>80): "/data/data/com.termux/files/home/.termux-build/libbluetooth/src/tools/btmgmt.c:1229:34: warning: implicitly declaring library function 'index' with type 'char *(const char *, int)' [-Wimplicit-function-declaration]"
11: B1 Line exceeds max length (172>80): "/data/data/com.termux/files/home/.termux-build/libbluetooth/src/tools/btmgmt.c:1229:34: note: include the header <strings.h> or explicitly provide a declaration for 'index'"
13: B1 Line exceeds max length (103>80): "/data/data/com.termux/files/usr/bin/aarch64-linux-android-ld: tools/btmgmt.o: in function `cmd_config':"
15: B1 Line exceeds max length (116>80): "/data/data/com.termux/files/usr/bin/aarch64-linux-android-ld: btmgmt.c:(.text+0x548): undefined reference to `index'"


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============3141479068511050448==--
