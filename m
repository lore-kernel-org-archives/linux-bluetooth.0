Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB70C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 09:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiKVJcw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Nov 2022 04:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbiKVJcu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Nov 2022 04:32:50 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F66EF12
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 01:32:49 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-14279410bf4so14843898fac.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 01:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XI+MWaXZ2KKgddnpv1U5j919ElL5C8ysR3ABeL9wfPA=;
        b=MC7Cr1QQ0szNwEeWxSKEJqZjJadz9V25dA/FpHnchR3WpE++Rt6DsjRT99DcuqFloo
         mZov7+Fp5c4CiXnwyKBi6rSAdeLhK4NFR62jhMGGXvfwOf1qUuF6zrovWzhyGcYqPuio
         wc4ECYMq7ptV1YyPKMKZbTZ9ct98EaeemUmiifwNfcSYFH3vYFlNFfhY8dLSTY61LdBc
         5xO+QPo3bgWKJTbfPlLBsbJAr5QzAaV9IfGAnI1RPisa+3rUMArpLeCZfDh/0Wm7EpKd
         TFEMumfkxK+8/fivAPmCwrYjQjj2gJ7PDnrQREPVj7gN5JW2IdBlI0f1raZesz7BGvv/
         GLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XI+MWaXZ2KKgddnpv1U5j919ElL5C8ysR3ABeL9wfPA=;
        b=krTj4zi4/1c/XiMXGR8iniDMdMoUOE5JTH/njsP0Piv1yXoNP7rBoRydt6uWKTQdfT
         UrooIbfi3hqW9kfsNsq8jQulEbQvPZMprlaT3ew41YBxuKLm7RzoL13h5YuEREs1BPRG
         KDG9Nr3DlejyW+72eCoBkN+bUgp5eHfumgOyVbLhedd2i5qIabIXJw+6zUmU2mAbCbMH
         zyTSrArT6azm11XbTOJQEPo8CYA/Go96AqtTGZ9tSY+WfCy1zF3tUUoCZIderily/zxV
         pTw+vk/7gSYrH94Gc4lJQE4HRTldNAFRriivOR+FLW33+DjwkZ0bXJq6hFzYIND1jFOT
         8e3Q==
X-Gm-Message-State: ANoB5pk9PbJpblyXJDE3ywHKvnHgjhkHduLamyFOOkATrRwmat6ubJ87
        3zDNY+UFENBq64OIbcqW/JmmR06puDU=
X-Google-Smtp-Source: AA0mqf7gJRPLCo0QfkP8yKPpLhTNXNL/BFZ+mkM6KkGB7vQFTNRI+ZCgQBqVNnfWJmQqELiEvlzVig==
X-Received: by 2002:a05:6870:eaaa:b0:142:8a73:958b with SMTP id s42-20020a056870eaaa00b001428a73958bmr9780776oap.75.1669109568490;
        Tue, 22 Nov 2022 01:32:48 -0800 (PST)
Received: from [172.17.0.2] ([20.225.215.46])
        by smtp.gmail.com with ESMTPSA id 123-20020aca0781000000b00349a06c581fsm5194392oih.3.2022.11.22.01.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 01:32:48 -0800 (PST)
Message-ID: <637c9740.ca0a0220.5e447.39aa@mx.google.com>
Date:   Tue, 22 Nov 2022 01:32:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1779281326438329356=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v3,1/2] Bluetooth: Remove codec id field in vendor codec definition
In-Reply-To: <20221122090257.26564-1-kiran.k@intel.com>
References: <20221122090257.26564-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1779281326438329356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=697980

---Test result---

Test Summary:
CheckPatch                    PASS      1.36 seconds
GitLint                       PASS      0.57 seconds
SubjectPrefix                 PASS      0.19 seconds
BuildKernel                   PASS      36.61 seconds
BuildKernel32                 PASS      32.50 seconds
TestRunnerSetup               PASS      457.29 seconds
TestRunner_l2cap-tester       PASS      17.07 seconds
TestRunner_iso-tester         PASS      16.82 seconds
TestRunner_bnep-tester        PASS      5.68 seconds
TestRunner_mgmt-tester        PASS      115.63 seconds
TestRunner_rfcomm-tester      PASS      10.54 seconds
TestRunner_sco-tester         PASS      9.60 seconds
TestRunner_ioctl-tester       PASS      11.14 seconds
TestRunner_mesh-tester        PASS      7.59 seconds
TestRunner_smp-tester         PASS      9.83 seconds
TestRunner_userchan-tester    PASS      6.64 seconds
IncrementalBuild              PASS      44.26 seconds



---
Regards,
Linux Bluetooth


--===============1779281326438329356==--
