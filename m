Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEDDCD37AF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 Sep 2023 00:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjIPABR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Sep 2023 20:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbjIPABH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Sep 2023 20:01:07 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281602102
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 17:01:03 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-656340e666eso7258956d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Sep 2023 17:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694822462; x=1695427262; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5qxmQegELzhKO7T/vXo/Enp4txJ6rriZmITApKWmkJk=;
        b=IMCUHlfNmgc7HysfDnnzoGZeucOofI1GRinWKWthxBK8BpOk23Ad+pTB+0IuznYhd9
         8nrY/+cz2x1ZzaBPvr7XQwhoHCTqDz9ZVV47apcUUiThtrPAgImF6BuFi4dtrof5/yE9
         ij//jM0IzX8nXydmVNkgZudBtoPDVXY1H8qSUC8X2+3zh+nhqKnc9YeD9OCrq2sm+kov
         XqQDm5o/Cafpi/4qODvusuYIPKDHXK+qbjjb9aAOC9c8k3mSeqA9BRJ9vV/PjB7D5EDP
         4bpJJaxQvOvT90G63w9383FNKYiMXmOYyeuFGGnCRG1h6r002ZuIqbG/kA5/oOsqPFEa
         BAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694822462; x=1695427262;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qxmQegELzhKO7T/vXo/Enp4txJ6rriZmITApKWmkJk=;
        b=qAq/I/ouJ9Y+QoTS6CKpdZ+vhbekVbekv9KN0Lgt7a42JArBqg7nMg3k7yyYVoFJX8
         yL6nUo3301JoZFDII72enjQ6CHC6UV9xTBP47AGjygJu3qt7uWe7rFLTYC6Ythk/1d9U
         HZLhYBFD1EK5r4Yotjy69hftMeTygMTuvS9gSf2iAGxOOwQ7Ropv6Ho4TP32trLxIIfX
         WpjvoUvUjxlDqUS8MMEca7oh/EuHjmEDV5hgcewrPCYBNHhGdAxG5/F4na2OEPXYzSaQ
         Wulv4eyhfy1Imie/Cen4OTAlebe+vwEUNoC5FryH7HaZDayObw6ECd8KVbEA4v0j1a02
         FDrg==
X-Gm-Message-State: AOJu0YxYFQetDlpKhEmipCWpqX5NHx9fS3fyizXn9jVmCZyhLDnt3RjD
        1iWjH0+YEH+0Pc04UV+fNqNZNTynxEE=
X-Google-Smtp-Source: AGHT+IFT2U97GEOEVF1uuotpogQz+W1Cltcc2OgaMkhfvleqjZ1UW6TK95XHfr+M+X48+LpJjjKgTA==
X-Received: by 2002:a0c:df14:0:b0:64f:430b:cab3 with SMTP id g20-20020a0cdf14000000b0064f430bcab3mr3531338qvl.9.1694822462054;
        Fri, 15 Sep 2023 17:01:02 -0700 (PDT)
Received: from [172.17.0.2] ([52.226.28.161])
        by smtp.gmail.com with ESMTPSA id z1-20020a0cf241000000b0064f77d37798sm1629558qvl.5.2023.09.15.17.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 17:01:01 -0700 (PDT)
Message-ID: <6504f03d.0c0a0220.de0d6.7a99@mx.google.com>
Date:   Fri, 15 Sep 2023 17:01:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3182491871590874022=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] Bluetooth: hci_core: Fix build warnings
In-Reply-To: <20230915232139.3661778-1-luiz.dentz@gmail.com>
References: <20230915232139.3661778-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3182491871590874022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=784857

---Test result---

Test Summary:
CheckPatch                    PASS      1.72 seconds
GitLint                       PASS      0.68 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      33.24 seconds
CheckAllWarning               PASS      36.14 seconds
CheckSparse                   WARNING   41.19 seconds
CheckSmatch                   WARNING   115.05 seconds
BuildKernel32                 PASS      31.70 seconds
TestRunnerSetup               PASS      488.47 seconds
TestRunner_l2cap-tester       PASS      29.48 seconds
TestRunner_iso-tester         PASS      58.00 seconds
TestRunner_bnep-tester        PASS      9.85 seconds
TestRunner_mgmt-tester        PASS      211.98 seconds
TestRunner_rfcomm-tester      PASS      15.07 seconds
TestRunner_sco-tester         PASS      18.45 seconds
TestRunner_ioctl-tester       PASS      16.89 seconds
TestRunner_mesh-tester        PASS      12.43 seconds
TestRunner_smp-tester         PASS      13.60 seconds
TestRunner_userchan-tester    PASS      10.41 seconds
IncrementalBuild              PASS      37.71 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============3182491871590874022==--
