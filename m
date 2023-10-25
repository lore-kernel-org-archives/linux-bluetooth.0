Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EB6C0032E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Oct 2023 11:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjJYLAN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Oct 2023 07:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbjJYLAM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Oct 2023 07:00:12 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F95C116
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Oct 2023 04:00:09 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6ce37d0f13fso3338503a34.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Oct 2023 04:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698231608; x=1698836408; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/DODjhlnGh/Vlh1h/OJLgDcEmsybwWa6QRh8CMBjwgQ=;
        b=HnT5wOy+fQFcoDrrOFRfrCoyE7bda1fGDyt2wZqDh/1AhMl13750+EPv2SQvPjmwgw
         uKOoXPVUTJ4JMNzZ4AQ6W4LO977jK/kDOxh6JaeKQlopS5dnMgmPegpQBXZB6uLne/6R
         bzSNs8bxIu7b/9FjTetIZEDpLwQgJ5KCip0sMqZymsblY8muaY1h/pSNKLMNkgou30h0
         umqeEIlAWyz9O32XdNXGIJrGVlCaNufPJe+zOzjDlO4ofSbre3xQxtMUVqVI4KrvUfrH
         iawEZhR1GM/kJ+9C1iSnEmnFtrg2uqXbTJga+L92YZign1NxyGOQ/LznphkCQxS05Z0x
         e3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698231608; x=1698836408;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DODjhlnGh/Vlh1h/OJLgDcEmsybwWa6QRh8CMBjwgQ=;
        b=e+s/IhO7gX63ZX8Vw/iQnP5UKUWJS4ZhC6VMeq9W1wUwg9B5S02Qjh/nyjaFOEVd2w
         n+255cOk9L8Kk86T6hc0jLT6hueE3c8R6e/jPFNNYjgANw9hnCs7VYjKU20A2DrU89SM
         EFoVAue8j126MN+OyNzBps42fQaJQs0wZAWieh2t3DwJ1beGheHUA8Hiq9qcZL3qKZ3Z
         YU7xSubk1syFdB6VtYG1ARTizC15al2hq5AIzCt82BngFl7smjozuquT5ip8u88OgiRH
         6VvyOcYc1v9I04Anro1rcPB5tTwpTJI3E6b5irN00vD/s6ajalOW6nyjDnLP4ss3Ysmj
         nfWw==
X-Gm-Message-State: AOJu0YyAWFKWEJaO5UiLc2YpInTDQtLE28lNeE32612UGvxM0TzKAVkL
        8lIyHFoqVHn0rnNbaBUGLAsSxUef3Tg=
X-Google-Smtp-Source: AGHT+IGmXgr9JHZUDJWB3QF/dAFo82MnHSJBeJQeCd2cr1AfmC6iTqUErYNzOYtiqq+9z+mLqCUgNw==
X-Received: by 2002:a05:6830:16c9:b0:6bb:1049:6919 with SMTP id l9-20020a05683016c900b006bb10496919mr17070605otr.12.1698231608400;
        Wed, 25 Oct 2023 04:00:08 -0700 (PDT)
Received: from [172.17.0.2] ([157.55.189.34])
        by smtp.gmail.com with ESMTPSA id w23-20020a9d70d7000000b006ba864f5b37sm2184539otj.12.2023.10.25.04.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 04:00:08 -0700 (PDT)
Message-ID: <6538f538.9d0a0220.23110.cbd7@mx.google.com>
Date:   Wed, 25 Oct 2023 04:00:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6980744532957295269=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: Fix source+sink endpoint registration
In-Reply-To: <20231025091853.18647-2-claudia.rosu@nxp.com>
References: <20231025091853.18647-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6980744532957295269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=796328

---Test result---

Test Summary:
CheckPatch                    PASS      0.91 seconds
GitLint                       PASS      0.58 seconds
BuildEll                      PASS      28.99 seconds
BluezMake                     PASS      1029.55 seconds
MakeCheck                     PASS      12.15 seconds
MakeDistcheck                 PASS      179.83 seconds
CheckValgrind                 PASS      279.69 seconds
CheckSmatch                   PASS      373.18 seconds
bluezmakeextell               PASS      121.27 seconds
IncrementalBuild              PASS      1774.25 seconds
ScanBuild                     PASS      1137.70 seconds



---
Regards,
Linux Bluetooth


--===============6980744532957295269==--
