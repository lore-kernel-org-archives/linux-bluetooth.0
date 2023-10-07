Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2780FE9413F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 Oct 2023 04:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343500AbjJGEYj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Oct 2023 00:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343491AbjJGEYi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Oct 2023 00:24:38 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133B2BD
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Oct 2023 21:24:37 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6c4e7951dddso1813954a34.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Oct 2023 21:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696652676; x=1697257476; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qK7Mv1xoIVFw72V7YHHXaWnS0b2ZcJ/vhSCR0Z1u9dU=;
        b=lzbtSm7k3hfBH6E76SZ6Yzx8iFu+OZVkVOxsyu/kI6XlfVpt3kxIn0gLusW+nqScJr
         lmJKItjVJjmekevtt4vX4os8xvONYZuPGorYI0D/wEd9KnkuEHlZnWy8X9cOJqIAJWNp
         bfd/SdPWDKhqqlcXrlGtMe15bWOcsL8LhWJA1IxlDEZOL/NO6sOvoj786sowA8ocPnis
         bqfKvwsLVrhxIpjs9/XPemUkR48OTM3VWAGSyoxVwNiBYrNgB4OHQp5rsLbwbcYDgSsF
         2yF0/Da5p4FgX4ikz2JapEiimX0zXhFoZ43dsdXbB/kT2BCAzPGWDoP+qhs5t+k+2HB/
         qyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696652676; x=1697257476;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qK7Mv1xoIVFw72V7YHHXaWnS0b2ZcJ/vhSCR0Z1u9dU=;
        b=iC1D2rlC88HWqnBm7qiIKBORAVXq8y1WEC1+gnqc5qpYfLegma8ufOrNBr2/ss18E4
         wQgHUURTqy0flcZbCEGJUgE3o4x2QbNiGkK5pDBdt3Qf9HORxzQ2apKVUq6YcpP2BJ8X
         u/8JAtSJLo+elEvuMbFhFt2eTx7tzJ4LTPVG/wkelxsNl1aAiCkba2C0QslytdZiF78X
         0HKk3CbpcaPOQS25XXcVP9msucCvmX4LFqRqdQ261uuXBGJBCsDIiyo0CdUK0TPzDjgA
         pZ5cBD8u1gu9vbylFHz/JFDiWPCxBpJhV/d+eVtwL90bjn07ubHzCFyQtYhwVql/wUeS
         0Qfw==
X-Gm-Message-State: AOJu0YznE8Bh9SICsInPO7B1Iu9bzmi42iWrg5ClGFeOR1BXJxDYC9ki
        /8faQPuGQX8WL+j264F0sQWJrk/jLNg=
X-Google-Smtp-Source: AGHT+IGEK2J8InHRyBvCsK3x/5xUxqGwbA9ZcFr1TcBj1OzR5LOsuzF3QY0fw/4CxMVQlKUj+mqJhg==
X-Received: by 2002:a05:6358:292a:b0:134:d45b:7dd1 with SMTP id y42-20020a056358292a00b00134d45b7dd1mr10990679rwb.21.1696652676019;
        Fri, 06 Oct 2023 21:24:36 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.162.49])
        by smtp.gmail.com with ESMTPSA id 7-20020a17090a030700b00260a5ecd273sm4651603pje.1.2023.10.06.21.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 21:24:35 -0700 (PDT)
Message-ID: <6520dd83.170a0220.16078.fe3d@mx.google.com>
Date:   Fri, 06 Oct 2023 21:24:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2869007357335908548=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/8] doc/adapter-api: Rename to org.bluez.Adapter.rst
In-Reply-To: <20231007010150.4103452-1-luiz.dentz@gmail.com>
References: <20231007010150.4103452-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2869007357335908548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=790826

---Test result---

Test Summary:
CheckPatch                    PASS      2.76 seconds
GitLint                       PASS      1.92 seconds
BuildEll                      PASS      32.37 seconds
BluezMake                     PASS      969.11 seconds
MakeCheck                     PASS      13.50 seconds
MakeDistcheck                 FAIL      12.19 seconds
CheckValgrind                 PASS      300.67 seconds
CheckSmatch                   PASS      398.19 seconds
bluezmakeextell               PASS      126.83 seconds
IncrementalBuild              PASS      6324.90 seconds
ScanBuild                     PASS      1225.83 seconds

Details
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

make[2]: *** No rule to make target 'doc/org.bluez.AagentManager.5', needed by 'distdir-am'.  Stop.
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:11890: distdir] Error 2
make: *** [Makefile:11966: dist] Error 2


---
Regards,
Linux Bluetooth


--===============2869007357335908548==--
