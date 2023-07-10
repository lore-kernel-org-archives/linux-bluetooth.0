Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4309FEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jul 2023 07:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGJHhK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jul 2023 03:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjGJHhI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jul 2023 03:37:08 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5211095
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 00:37:07 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b75637076eso3734105a34.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 00:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688974626; x=1691566626;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j8Azk9dB7aq6KGQAyd4j7yp9q3hkNm4Hd/u1jThupJQ=;
        b=AAREEyBe+rQ2A3O0VUyroalc2Jl4c9bWpOpYjl0fEqqTUKaytGE25KMSbqENBy8lxy
         lhHcDma6KD5Ov/AHAycLcAJM/5IQaG6S99La2jUYK8AhKoWV8X+hwIvhgaMQ1nfsgZO8
         MDwycUxk0U71OW9QWqIe8pm9pRLUdzD737Gn2ROhk4xJ20m4PgzyiN4wyPlXjufTzYZj
         kjoxoyzfNYqsAt3F3wNWN6ksv9SdJLo6odKQMN9EgDJLYBJXg1VZbST4VgJt6NJWij6L
         OE/llwTMKiagREWo+vg37f16JYWoglQcfyrD9NdEyxO+chauN6+kyqEYq62MOYUsSjpU
         QZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688974626; x=1691566626;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8Azk9dB7aq6KGQAyd4j7yp9q3hkNm4Hd/u1jThupJQ=;
        b=dR16cHtNCOn2R8OVdM5s8q+c4Ir2Tl/EEHbW2DhkzLSwWU5fWOomIQHZ19Xq6GE4G6
         hTbaoqqmicRA9MiebD8TZz1oqvipO9DJdydOv/ncOKYFkHXC7Ru/MepbEaFdb35wDn0t
         e7sBzSdGthFgv0N+PS+U+PggchYb3Hd3V9/K6VOpAUZfQPukb5HpnDsDRrhEC0HY1wd0
         o0cL6lNVH1l23WKid6uCHL6bTG/f1fCJ/NfrAdPMc1cd8IH0IOFWE17nTXhPEGz9Oc7Q
         6S01mkXbyHLL4TkBN8GI2tz7QiIFKS8CilxhP/8u/l5xdhD/PjqW4XFmp06kAAxlLaqv
         Jt6g==
X-Gm-Message-State: ABy/qLYHtqlqiBJ/qWtBfUAt1FQSeaSVRtwPDj1C9HTD8ucsBStyoTij
        C7Ya0+EQUO2pyz6UjA9sKVLNhyZEon4=
X-Google-Smtp-Source: APBJJlHvYL3xW1g0HgMvfzl4vU/XKNgBfHh/g8GIoQNIDrOVjuU+y4jrnaCVgbA54EXrTgFkrBG0gg==
X-Received: by 2002:a05:6358:98a2:b0:134:de8b:17f0 with SMTP id q34-20020a05635898a200b00134de8b17f0mr13519306rwa.19.1688974626262;
        Mon, 10 Jul 2023 00:37:06 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.0.224])
        by smtp.gmail.com with ESMTPSA id q24-20020a62e118000000b0067db7c32419sm6755182pfh.15.2023.07.10.00.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 00:37:06 -0700 (PDT)
Message-ID: <64abb522.620a0220.98d7c.c86a@mx.google.com>
Date:   Mon, 10 Jul 2023 00:37:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7934488583138796807=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, joeyli.kernel@gmail.com
Subject: RE: Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in HCIUARTGETPROTO
In-Reply-To: <20230710070745.5505-1-jlee@suse.com>
References: <20230710070745.5505-1-jlee@suse.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7934488583138796807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=763894

---Test result---

Test Summary:
CheckPatch                    FAIL      0.82 seconds
GitLint                       FAIL      0.52 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      32.42 seconds
CheckAllWarning               PASS      35.37 seconds
CheckSparse                   PASS      39.97 seconds
CheckSmatch                   PASS      111.21 seconds
BuildKernel32                 PASS      30.96 seconds
TestRunnerSetup               PASS      472.90 seconds
TestRunner_l2cap-tester       PASS      22.50 seconds
TestRunner_iso-tester         PASS      40.91 seconds
TestRunner_bnep-tester        PASS      10.39 seconds
TestRunner_mgmt-tester        PASS      211.46 seconds
TestRunner_rfcomm-tester      PASS      15.46 seconds
TestRunner_sco-tester         PASS      16.31 seconds
TestRunner_ioctl-tester       PASS      17.21 seconds
TestRunner_mesh-tester        PASS      12.78 seconds
TestRunner_smp-tester         PASS      13.88 seconds
TestRunner_userchan-tester    PASS      10.72 seconds
IncrementalBuild              PASS      29.83 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in HCIUARTGETPROTO
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#88: 
https://lore.kernel.org/lkml/CA+UBctDPEvHdkHMwD340=n02rh+jNRJNNQ5LBZNA+Wm4Keh2ow@mail.gmail.com/T/

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#90: 
Reported-by: Weiteng Chen <wchen130@ucr.edu>
Reported-by: Yu Hao <yhao016@ucr.edu>

WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#91: 
Reported-by: Yu Hao <yhao016@ucr.edu>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>

WARNING: From:/Signed-off-by: email address mismatch: 'From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>' != 'Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>'

total: 0 errors, 4 warnings, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13306348.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in HCIUARTGETPROTO

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
9: B1 Line exceeds max length (95>80): "https://lore.kernel.org/all/CA+UBctC3p49aTgzbVgkSZ2+TQcqq4fPDO7yZitFT5uBPDeCO2g@mail.gmail.com/"
12: B1 Line exceeds max length (98>80): "https://lore.kernel.org/lkml/CA+UBctDPEvHdkHMwD340=n02rh+jNRJNNQ5LBZNA+Wm4Keh2ow@mail.gmail.com/T/"


---
Regards,
Linux Bluetooth


--===============7934488583138796807==--
