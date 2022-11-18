Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C101DC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 06:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241121AbiKRGev (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 01:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241136AbiKRGee (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 01:34:34 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928C09A260
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 22:34:33 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id h206so3160095iof.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 22:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sL9nKK2CncVJLIuGQ9Rmk/U1qbZ9QS30DDqMy3PA/7M=;
        b=aAxmBnUNTFr4ku5TW8xlAxLN/rqeKY1pkTAJvduepplRWLRdMIkXNU+W97Wp1eGG3T
         yA1i2DBuEZYqJjFRQ7HNrjNKcYsJJDKwaHEQZchi1WCydA+2KMFSc0o7PopddBJwyTTj
         KAWkmmH5qKWQOb65g3QyaKnuCfiI+gdBVZI9JvtnBKKhrAdBC/yVw7rjOBVkY7DrsFEN
         dSSs53IpXzByYt06YRcASzHJDBPkx9ZH7aQANDx2H8XkdF+REDscdjk7NiGcvBrfE9Ke
         Js8E9EY543jjyrfttbMbl8HanEvyVZyu6PUDJkORSyy9IdaVkTToRjIGklHCf/W3XlsU
         0nxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sL9nKK2CncVJLIuGQ9Rmk/U1qbZ9QS30DDqMy3PA/7M=;
        b=f5bII05F6vr3TgDeiPBaHtBCL46nvx02XPjJyE+5sFIPIq/7syZ3K7mnAffPSM8TSS
         fTERX+uya6djIgnP7rktKqWl3Lt9eCDDz86SeBKUqxRWr9RyaX99OlgffoRQYgtwm/3o
         RqmdFV66GZl8o9Fiv2uB6W4oDhOvD2ocpApD9LAN6ckWMTMXXoEsow9gNwOtySewcsBW
         jXQFEBbgO/DlFPlQizITEPDhWhhDeagjCNiqp6k8MKH5h6eIhe5hZZG55GHcctqaYjIt
         lSQiK4r5+okOGO2mNUCoVrk5eWkjanhBt41du9UzsP1NrUfZulmC4N68HHlhz6cYTG5S
         TybA==
X-Gm-Message-State: ANoB5pnA0P9udcHr+GeKwZ4y9CeGdik2sRXFkqAK44CVqY8g/ep7FoIB
        NVG5FTVZRPXyKlRAMu0B7N1BldjVex4=
X-Google-Smtp-Source: AA0mqf7knvq9Dgpm7hz6XPqOkBIn20svTh0N4C1PT0CQjq0chT/J/T+1G8e5E3WNettk1R56sQxBvA==
X-Received: by 2002:a5d:8356:0:b0:6a0:d590:f5d with SMTP id q22-20020a5d8356000000b006a0d5900f5dmr2887410ior.179.1668753272690;
        Thu, 17 Nov 2022 22:34:32 -0800 (PST)
Received: from [172.17.0.2] ([23.101.125.217])
        by smtp.gmail.com with ESMTPSA id a22-20020a027a16000000b00375664a365esm975158jac.1.2022.11.17.22.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:34:32 -0800 (PST)
Message-ID: <63772778.020a0220.62548.227f@mx.google.com>
Date:   Thu, 17 Nov 2022 22:34:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8794386460569434459=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org,
        dominique.martinet@atmark-techno.com
Subject: RE: Add serdev support for hci h4
In-Reply-To: <20221108055531.2176793-2-dominique.martinet@atmark-techno.com>
References: <20221108055531.2176793-2-dominique.martinet@atmark-techno.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8794386460569434459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=693092

---Test result---

Test Summary:
CheckPatch                    FAIL      1.68 seconds
GitLint                       PASS      0.54 seconds
SubjectPrefix                 FAIL      0.48 seconds
BuildKernel                   PASS      35.18 seconds
BuildKernel32                 PASS      31.18 seconds
TestRunnerSetup               PASS      422.79 seconds
TestRunner_l2cap-tester       PASS      15.68 seconds
TestRunner_iso-tester         PASS      15.23 seconds
TestRunner_bnep-tester        PASS      5.28 seconds
TestRunner_mgmt-tester        PASS      103.68 seconds
TestRunner_rfcomm-tester      PASS      9.17 seconds
TestRunner_sco-tester         PASS      8.67 seconds
TestRunner_ioctl-tester       PASS      9.94 seconds
TestRunner_mesh-tester        PASS      6.74 seconds
TestRunner_smp-tester         PASS      8.41 seconds
TestRunner_userchan-tester    PASS      5.51 seconds
IncrementalBuild              PASS      36.83 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,1/2] dt-bindings: net: h4-bluetooth: add new bindings for hci_h4
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#114: 
new file mode 100644

total: 0 errors, 1 warnings, 49 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13035921.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============8794386460569434459==--
