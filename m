Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE17C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Feb 2022 21:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbiBRVoa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Feb 2022 16:44:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbiBRVoa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Feb 2022 16:44:30 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC06F53723
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 13:44:12 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id v10so17344124qvk.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 13:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=LCMvkZGaEXQqijpmJ/6cT2520mLJ3Xi99r8CnydxNQ8=;
        b=L9cCL7dbvNsNozA9Gk1dXEJ/2LHv47l6ZXks+aRxdZx1GDSO5zCprrHJZSQ2ZVCd0d
         MlD7teNU4yJSFoefLH84oBkIFNaBpZicnp/mstPpVbKacfTCfQ+M/xvUtOxduIYmfr6H
         aO00cXUaMLSjEejoR/jyjY12txSvbl4UABfNTrqgSti/ST2BTDcn14Xhorkrj7RsqLmt
         oPFeAmfFmgSCml21BtdPeJAht996uZPz1ziugI2AScAcZntSOWBOxQFpk3xBot5aII1Q
         UlpzQpCPENxRZHvVVLAec2cWX65Sx/vROl9RidJ9fzcQN2BufXtHrj/LwZ2TSBLDj+Le
         k0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=LCMvkZGaEXQqijpmJ/6cT2520mLJ3Xi99r8CnydxNQ8=;
        b=oMpdG7VsBiDxIsVj8ShakEeRCgakCGYQVXV+MGh+O+9T0ssFigUX/26MdhEsxAnNcE
         miJYmeot1P4v6bNxf2egZ0ovzSkrX6Ptz5Fvim6GTSY2KY36u/P487TSb+ije5otxVf3
         jUXHeyVr7cTcrlN1hZSsZ5eywcrwlp0MhacvAOj4mK2XDTxLXHpW1FeBjbkevQ58vBQw
         sXfwiyR21xMM5USoLLO4yrBk7Z0r6Z2RNZLKqTYf5/c9CRv53XTYjm3cIGShw+qGbue4
         sSJTNpj03Xa8OJlI7WGdH3hWb5Jkhnkr/BRKeiRR7Wxb8W7jgHbsYbhvrlFeMMdIymCc
         +e9w==
X-Gm-Message-State: AOAM5311HwF9yphDCRsICoO5Id2in5lh+ioDI0LsGnXCBPP/tNfsC+Qz
        cOwmdc6fs+YTeEuJ0AEVESijdcnXvwg=
X-Google-Smtp-Source: ABdhPJysdwuGnavnHevgqfV4hyGbBxvutYQDyfZPD9TDq19pBw4XaSwC6k3zPDHbSb5MAh2mQdshRA==
X-Received: by 2002:ad4:5749:0:b0:423:583e:2fa9 with SMTP id q9-20020ad45749000000b00423583e2fa9mr7321091qvx.61.1645220651921;
        Fri, 18 Feb 2022 13:44:11 -0800 (PST)
Received: from [172.17.0.2] ([13.82.6.19])
        by smtp.gmail.com with ESMTPSA id y20sm25877153qtw.28.2022.02.18.13.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 13:44:11 -0800 (PST)
Message-ID: <6210132b.1c69fb81.be402.6d51@mx.google.com>
Date:   Fri, 18 Feb 2022 13:44:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0509231710380164025=="
MIME-Version: 1.0
Subject: RE: [Bug,215576] HSP/HFP mSBC profile broken with QCA6174
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bugzilla-daemon@kernel.org
In-Reply-To: <bug-215576-62941-2nprEl3omz@https.bugzilla.kernel.org/>
References: <bug-215576-62941-2nprEl3omz@https.bugzilla.kernel.org/>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0509231710380164025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: corrupt patch at line 41
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0509231710380164025==--
