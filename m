Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F71C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 04:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbiKREjD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240483AbiKREjB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 23:39:01 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818C1490BE
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:39:00 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-13bd2aea61bso4762643fac.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WsX4H9ezqETapzBvNGlRUyfmfBP+60YZnLzszyd6eF0=;
        b=QkkItUuuekRwTOeLJa2a0qTzvxabRq24dMyI/Zy54FmbbLSa8Pt9EZPaNlrRJ888T8
         w5WyayvriUzo58rMpSLaJ89Q7FJYNIHk9gmha0luVFSx0wUP1TaQu/015XnMVNev86Cu
         oXiY9vbsraPnODGoTgiNoifaBQQ//vpLgzVYYt35a0CBKglL08xNFMTcLbF2wyLbGeGj
         rg8D/+Kqf72/IMCqvrpK53NXUIKvSJEw2jZzpHhRXGonwiQQ+nOvzFjMLvgO1zd4GyMO
         o175Kjn8m9jgldh01uKd6g7GTgQXuU9JYOf02TUlVoC76j4iQCOj7s/DAENtpblGIdc3
         hO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsX4H9ezqETapzBvNGlRUyfmfBP+60YZnLzszyd6eF0=;
        b=x+iTPfS/H4jpvdpBi+u6oYTk1ljbyWlNjS87XAt7RsoIpDp+o1Qb9TJmOnDcTXwM2s
         ixXumWZmoZixVXodzVPRglGr/Fn+fBp+eiVG+ZgWeSyf9tH4egxAzjKNBOIJ3W76qXqR
         9z1LnepSClfx3qf1fTPQ2jHuWS+6tNyb7zf0Skxxm1dEu+6V7E5+AoTReB4lB9W73xkw
         s/glkZadIEkOsIUjgF90yWZx2jl0freFUvw9Ya3AHk0f7Vm7mLVDMiaPyBq7qV0N0kub
         VTbvC1zrsj/GhdrW4Ns7xb0yMpXYrFdGPv84vJ8CoKV6EECU6gc5WqpVxBkGRrGEBqdG
         uS4w==
X-Gm-Message-State: ANoB5pknajRrGkv//5ZsGBd3UrUr1j6m8WCDOXY2on4bNzqOE5w15OTB
        pmLyZF10ZI0wjIkf19au07MpOvBPjlE=
X-Google-Smtp-Source: AA0mqf4hU7uN3ZcBMIj1fxbLlLXAwOvQR2Kz/oKKdo7UecQCQSTQszqtRa8mt5tPaZrPB4plZjpxTA==
X-Received: by 2002:a05:6870:6707:b0:141:aba2:f9c4 with SMTP id gb7-20020a056870670700b00141aba2f9c4mr6182634oab.273.1668746339474;
        Thu, 17 Nov 2022 20:38:59 -0800 (PST)
Received: from [172.17.0.2] ([40.84.141.204])
        by smtp.gmail.com with ESMTPSA id a7-20020a056870a18700b0013626c1a5f6sm1424739oaf.10.2022.11.17.20.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 20:38:59 -0800 (PST)
Message-ID: <63770c63.050a0220.21f29.6977@mx.google.com>
Date:   Thu, 17 Nov 2022 20:38:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7775334009368614562=="
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

--===============7775334009368614562==
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
CheckPatch                    FAIL      2.01 seconds
GitLint                       PASS      0.65 seconds
SubjectPrefix                 FAIL      0.53 seconds
BuildKernel                   PASS      46.06 seconds
BuildKernel32                 PASS      39.72 seconds
TestRunnerSetup               PASS      568.54 seconds
TestRunner_l2cap-tester       PASS      19.32 seconds
TestRunner_iso-tester         PASS      20.15 seconds
TestRunner_bnep-tester        PASS      7.02 seconds
TestRunner_mgmt-tester        PASS      134.74 seconds
TestRunner_rfcomm-tester      PASS      12.36 seconds
TestRunner_sco-tester         PASS      11.21 seconds
TestRunner_ioctl-tester       PASS      13.41 seconds
TestRunner_mesh-tester        PASS      9.47 seconds
TestRunner_smp-tester         PASS      11.28 seconds
TestRunner_userchan-tester    PASS      7.83 seconds
IncrementalBuild              PASS      49.56 seconds

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


--===============7775334009368614562==--
