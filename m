Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9CDC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Dec 2022 05:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiLIFbV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Dec 2022 00:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLIFbU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Dec 2022 00:31:20 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1461D7126A
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Dec 2022 21:31:20 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id d123so1515849iof.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Dec 2022 21:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlLxxSkXrtLCuuJSuRC0JzNhMkU5pTxj87mznQN+4uY=;
        b=Twg7QOiWCtMK71Bm5sada4PHFp26CtJE4cdE8hAn45OxyEVahRxVgNLqSwvUK+KUww
         vFfvjpd8vNcvWtiUP9XaNN0E/v7Ko+aTAQmbz5s7klNx32hq8v/dUzaTyWuEEb0aKbkh
         vEA+qx95olFWjn9gYdI0LGOf5aNUkFi4xDLw7J8FLim1C/hYWOl/A7gs1RmWKVMku7gF
         v9PjfY8CuQKra8LWNu7VwWihrSHRYY9WGycMtuttuV7a3hVKeWaJ2+AJL7CLUR8XmJoh
         HNmVJQBOYgKr2YwW2bKpxsHmAAilFkY3uAtBaVtvhnfj9EFvHEu6/5orAGEndl97yYRW
         aUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlLxxSkXrtLCuuJSuRC0JzNhMkU5pTxj87mznQN+4uY=;
        b=Nhx7nOo2SbLAFtzlK9rVlg6FBBBGSeG8O/D5WoLjJW70CIU7RLWX1wHxKVpmtEDsGA
         AisFXA07h+4qbCiyqYP8L1wqlOmJEOZqkB1NOy4ZfsVRzt5oZQMSpH4J47b3yHwLizqV
         rtdDCx0Fba8uoem30gJojxA5nU/OthA5ZZJQSuk8FrwqlTC6Moa1CeIzT7EgKvDIw2qp
         TXR/A0CQ5QZ8CmkkGCV+y5pAy0XEgpHkwSjKZX4lZLf8wWahQDA30I61Hxu+kp3qxDHn
         GWgK/FaiqIFqANWkp7eqlIJ+4jgbwqYhCl3ykknqpG4PC9cYdHlkxlX5WBwB05FC7Tis
         B4wg==
X-Gm-Message-State: ANoB5pnlKhe9T7M5xNmZq/+S9fbswumk5rxrgZBTwogmC/7GOAhwSPVs
        4TGFl9O8byRadqXMrcjGWlBlOvkIHLI=
X-Google-Smtp-Source: AA0mqf7NHUTMYo4vChDZGvG4C/GewGtrnaeo7upVkistSXgevb4QhZOIHJ5qrYx21xRdUV9Z5XrSjQ==
X-Received: by 2002:a5d:9550:0:b0:6bc:d712:c314 with SMTP id a16-20020a5d9550000000b006bcd712c314mr2609649ios.11.1670563879343;
        Thu, 08 Dec 2022 21:31:19 -0800 (PST)
Received: from [172.17.0.2] ([40.122.214.64])
        by smtp.gmail.com with ESMTPSA id h11-20020a05660208cb00b006bba42f7822sm273866ioz.52.2022.12.08.21.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 21:31:19 -0800 (PST)
Message-ID: <6392c827.050a0220.9f59.052f@mx.google.com>
Date:   Thu, 08 Dec 2022 21:31:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5440884751749173650=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [DNM,v4] Bluetooth: doc: test patch - DO NOT MERGE
In-Reply-To: <20221209045449.953699-1-hj.tedd.an@gmail.com>
References: <20221209045449.953699-1-hj.tedd.an@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5440884751749173650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=703183

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      32.23 seconds
CheckAllWarning               PASS      35.97 seconds
CheckSparse                   PASS      39.79 seconds
BuildKernel32                 PASS      31.12 seconds
TestRunnerSetup               PASS      438.10 seconds
TestRunner_l2cap-tester       PASS      16.10 seconds
TestRunner_iso-tester         PASS      16.47 seconds
TestRunner_bnep-tester        PASS      5.60 seconds
TestRunner_mgmt-tester        PASS      107.39 seconds
TestRunner_rfcomm-tester      PASS      9.55 seconds
TestRunner_sco-tester         PASS      9.00 seconds
TestRunner_ioctl-tester       PASS      10.33 seconds
TestRunner_mesh-tester        PASS      7.05 seconds
TestRunner_smp-tester         PASS      8.77 seconds
TestRunner_userchan-tester    PASS      5.93 seconds
IncrementalBuild              PASS      29.22 seconds



---
Regards,
Linux Bluetooth


--===============5440884751749173650==--
