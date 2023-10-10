Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E02ECD98C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 21:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbjJJVPw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 17:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbjJJVPv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 17:15:51 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C9491
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 14:15:48 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-578b407045bso4933918a12.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 14:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696972548; x=1697577348; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aXk+Pcj/SbhO/SXfMjIyeOBGjps6EL+Fe8lE4nm7V8o=;
        b=JM2c6+dJDtKZaWtpkckx+ch+X3CHcmVdbg5QEaptapLkUoScK+DB9BHjnfV6CJJVEE
         qvkkaBF0PZcpl1tqS6nz5GmpHYDWgmmDG6qDUntQyHiXllDD7+w8NIy5YPTKiNaAOc0A
         9Q4rJa8hfy3F8sLSu6bAHaV1hVVkjOAKk96bNQEtYn2XiJfrNTbxKBItD87DyYhLJUZB
         R9bfEHJXK3AwF0IaQvDx1KPyM0iQcazUcz1pH/SjMy0Hwe8PDpTQS1oHON9qu75Ipkni
         GdV9eiSRg9uluBEz1LMRqJTPlUhwyNc+DCvg4jCniE46Hjfnc+sQMKHfSkb8nqxFCRH2
         YVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696972548; x=1697577348;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aXk+Pcj/SbhO/SXfMjIyeOBGjps6EL+Fe8lE4nm7V8o=;
        b=ctNrOt11q9IGQMPxvYt0eDFtFE6F/0LgJfsDbk40yyEEXTbJDNR8X8VYV3ysoS2lpP
         kSZVtWWIL9yP8PrMSkh+7J+6tKOV7TbtBxy2Tj4xHosB60BrFOxvtB0e9+65qNIDlCLJ
         RWJyTUEk4ii5QxozMj4EIX1cE/7fnUecJrBnIQLMd4K5Fp97JxoRN4cYy5P8sE2EbBjR
         zb/nRr9ql/Tk9e7zASrvuNStFMKZKKCBUY7yp8JkPctoPTvxfzzkweF2CdnIs5HWHsI+
         3hftrKezYAwjoHQyCH28UWfNlrilEnH73WVWlzPff3a+ai5Cl817QNPGtVZFxcos6/nd
         YXHw==
X-Gm-Message-State: AOJu0Yw9slQuq4HJlYS/2mYs9t+KmIQvVzlY4RoqWIxI7UOGjJcJi9Iu
        nU/RKO+96qms09X0VvqtoORRVnyTGT0=
X-Google-Smtp-Source: AGHT+IGVu7FK5Mfk/L5dXlgTb8MqrrMJFZp6HT5w1NDeNCoyB9mEUc2SSHXCmRRNYhJ2DPhcSJFgQA==
X-Received: by 2002:a05:6a20:2590:b0:151:577:32d1 with SMTP id k16-20020a056a20259000b00151057732d1mr23151382pzd.22.1696972547905;
        Tue, 10 Oct 2023 14:15:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.44.55])
        by smtp.gmail.com with ESMTPSA id z23-20020aa785d7000000b00690d64a0cb6sm8661169pfn.72.2023.10.10.14.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 14:15:47 -0700 (PDT)
Message-ID: <6525bf03.a70a0220.25ae2.6c85@mx.google.com>
Date:   Tue, 10 Oct 2023 14:15:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8336741093946168737=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] input: Fix .device_probe failing if SDP record is not found
In-Reply-To: <20231010194306.603745-1-luiz.dentz@gmail.com>
References: <20231010194306.603745-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8336741093946168737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=791911

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.25 seconds
BuildEll                      PASS      28.81 seconds
BluezMake                     PASS      913.67 seconds
MakeCheck                     PASS      12.12 seconds
MakeDistcheck                 PASS      170.71 seconds
CheckValgrind                 PASS      270.37 seconds
CheckSmatch                   WARNING   361.63 seconds
bluezmakeextell               PASS      111.37 seconds
IncrementalBuild              PASS      736.14 seconds
ScanBuild                     PASS      1116.30 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
profiles/input/device.c:165:26: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============8336741093946168737==--
