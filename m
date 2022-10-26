Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76F6C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Oct 2022 13:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiJZNcW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Oct 2022 09:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbiJZNcU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Oct 2022 09:32:20 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615C9E4C13
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Oct 2022 06:32:19 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id l127so13296642iof.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Oct 2022 06:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FN0MgVXKfBWkhKk9V+q4pI20SX5erzjwChZkDiWfFe8=;
        b=cwiJilJqaMj0A7XKxamHeeFZbBLCYzAwkow2v/zrOtxUkajGiC/5Me6Ha+bKwlXzzB
         nVLPEuvh7OycqnnQXKj1cfrracWbCjixMjUYL0VE3NSSlXcKNsuaJHb79HlhXXFFVHQk
         flKuoo9enQWkJODlH5mHZ5tF3SAnartblIMn8JrgLeey0osToBB6Ed3pkqiDHzr3ecAA
         xM0ebXIGXB/nnSGCABQ3sdqS3HyM4S3OknmwNlfn5APOvOAX62uEUQpDkMV4JakariEr
         x42YGUGSUzB4ZKdCBGQRDqdBGMMNidbdNSUwi8N0ItP+ZTyhRVrrZHNqH4s9+oek95ZL
         JelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FN0MgVXKfBWkhKk9V+q4pI20SX5erzjwChZkDiWfFe8=;
        b=UA2X8oRDeXR5GtV2iJoOd7UJGQqRLydlzEAcGy4hYOsKr1ku0eNIz/YUBGjjSYhdg1
         g8OW6YnDGW/z5FDzPgQw9YzVyr2yrXvNQcCmS59mP67oqe4E3DqaidXqIlCCk3IwwQnj
         7CE+mu/bsWQkoIiwBSHfNaUFzpeTB1fdAWgf+rUI+fLzAUIHmS+2KN2oVYVEZzIBtfwp
         4lvoeIG1q6XqzWPKzTLiOGjO704K42UHUbJLGsM8J36w9vfrFbOKv7P/0oJhITyQ9amJ
         InQHRAM0xwSgmVk9HV+rMU+XJcq0KIL2eqtuzEuDMxmAA4Pq4GOB7T/6DkjbgZYjPukE
         +1ZA==
X-Gm-Message-State: ACrzQf1HxP6bVfxwoPRvfZU4ehr/GNptcI8lySnj7kqYEbIHoooXF2xy
        wv9CjIBEtOPxQy9XOgypqj46Ednm8c4=
X-Google-Smtp-Source: AMsMyM5P+/ffb2OrkKPeUwiS0NZZjKGFNe+eWvAX3F82e/M5Oy2ZA76Nr5bmWdaZWE7LX+7LJHQ5zA==
X-Received: by 2002:a05:6638:3285:b0:356:4df5:5d10 with SMTP id f5-20020a056638328500b003564df55d10mr28525911jav.19.1666791138495;
        Wed, 26 Oct 2022 06:32:18 -0700 (PDT)
Received: from [172.17.0.2] ([13.89.36.92])
        by smtp.gmail.com with ESMTPSA id a95-20020a029468000000b00363bd76184esm1991661jai.162.2022.10.26.06.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:32:18 -0700 (PDT)
Message-ID: <635936e2.020a0220.12fc5.357d@mx.google.com>
Date:   Wed, 26 Oct 2022 06:32:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1894829104405483821=="
MIME-Version: 1.0
Subject: RE: "notify-device" for cross-driver readiness notification
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, matthias.schiffer@ew.tq-group.com
In-Reply-To: <db30127ab4741d4e71b768881197f4791174f545.1666786471.git.matthias.schiffer@ew.tq-group.com>
References: <db30127ab4741d4e71b768881197f4791174f545.1666786471.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1894829104405483821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: drivers/misc/Makefile:62
error: drivers/misc/Makefile: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1894829104405483821==--
