Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435CCC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Feb 2022 07:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiBGHU1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Feb 2022 02:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349367AbiBGHGk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Feb 2022 02:06:40 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54181C043181
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Feb 2022 23:06:40 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id o12so10212650qke.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Feb 2022 23:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=PuZqCuIwhQ4Xr7i64kV0pbUfrOJeQOy6DbzjfLmvfOo=;
        b=HN7ppt2h6ZDb6tLlM26dXKP4fHkZ2b7CZCL6SEbprUQcMCT4W/ZK/ZkEE9sNuLQCjC
         NQxZwRk/OlCSrf4m5W64RFkJ7LrwmHixwj0O2kqSkJJYdNGPslp3qI5fTfNy/QQPud2q
         92BZxfXz8TILZk4ViETtKc+WgbN6rAY75aa91hldPi+Ts7mYas4IWwoDTCI8RuEur60Y
         1ICxD0dCX5p7GNTIdg9LTCoNCTBxbX0xZ+ZAfeEYNzSrLhgAkhnfMqHXNrs/venHCW7p
         Iph84Ny3RsgJedo2XdW/nl0hMqtFKe9BAxIdKPfyAx23+meCgcoMg9cZTbdZwSoxkw/R
         Rtbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=PuZqCuIwhQ4Xr7i64kV0pbUfrOJeQOy6DbzjfLmvfOo=;
        b=jdjvDPcu/mfc/Ruxqw9+6ulx7gPH2eWs/FrN/Zp5p/bvMJlWN6sFHjTv4B4NnrLjKQ
         wQSXFlA4Ic8AfpJuA5zpRUQiN6m8d3umG4V4SHr4BKR2IdTREPvqSCIYr/nFJ06M43bP
         FjoFjwNc6GvsSTFWbUEOp8d6igDZXzoUXgeW3BwUGT1Xr/C0YJd4WLyn16sgESQEZUrD
         OvyedGpaFw72QT8Rla5fG6/iBk8FM3/URKh3wXYtfpAIqRzQH+xECsF3t1H5nzHgwMb7
         1k12wUwE96Oa5ldWONSJ1NMX4L859/FIlUMiCjQ266s9RCkBTh5lLz7rGYcHcPP3z4zZ
         p9bQ==
X-Gm-Message-State: AOAM533j+PqrnSk76ba9WKrmCeoK0Bv24IccYHEtEF/WHINT8spJdEZ/
        VAUbCyH1SInh+36wvRpm4V+fAY8tols=
X-Google-Smtp-Source: ABdhPJz+5DFowqVGRECGj8qdjwkoS5M5E7gt4N8WJXyuSUIsccnL7CZO1NqlX87StTK1+tszfYxhAw==
X-Received: by 2002:a05:620a:28cf:: with SMTP id l15mr5515289qkp.23.1644217599357;
        Sun, 06 Feb 2022 23:06:39 -0800 (PST)
Received: from [172.17.0.2] ([20.110.61.6])
        by smtp.gmail.com with ESMTPSA id c78sm4906555qkg.42.2022.02.06.23.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 23:06:39 -0800 (PST)
Message-ID: <6200c4ff.1c69fb81.674e1.7a25@mx.google.com>
Date:   Sun, 06 Feb 2022 23:06:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7146605284057734091=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_saluvala@quicinc.com
Subject: RE: [v1] arm64: dts: qcom: sc7280: Add bluetooth node on SC7280 crd board
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1644207878-19839-1-git-send-email-quic_saluvala@quicinc.com>
References: <1644207878-19839-1-git-send-email-quic_saluvala@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7146605284057734091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=611723

---Test result---

Test Summary:
CheckPatch                    PASS      1.68 seconds
GitLint                       PASS      1.02 seconds
SubjectPrefix                 FAIL      0.90 seconds
BuildKernel                   PASS      33.70 seconds
BuildKernel32                 PASS      29.33 seconds
Incremental Build with patchesPASS      40.42 seconds
TestRunner: Setup             PASS      539.08 seconds
TestRunner: l2cap-tester      PASS      14.95 seconds
TestRunner: bnep-tester       PASS      7.10 seconds
TestRunner: mgmt-tester       PASS      122.04 seconds
TestRunner: rfcomm-tester     PASS      8.38 seconds
TestRunner: sco-tester        PASS      8.60 seconds
TestRunner: smp-tester        PASS      8.68 seconds
TestRunner: userchan-tester   PASS      7.49 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.90 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============7146605284057734091==--
