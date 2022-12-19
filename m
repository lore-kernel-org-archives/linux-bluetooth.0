Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54EAC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Dec 2022 21:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiLSVOA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Dec 2022 16:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiLSVOA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Dec 2022 16:14:00 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EE5EE16
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 13:13:59 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so14408864pje.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 13:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c9e8y4t56x7b6AmK/lyWNMYJ7TsVo1FqadbWP2nJVRo=;
        b=Pti0fZivwtM0PcSPZstoyibBbzolr7UwldMLKFPeC4jxfR+hc88VbMA2lCvaZ/BiQ8
         bScpP1pDlDh0gVsLPTzA6ZJlTV5Jsd9GtZmj/hSCL5vKfEf0NL2KNoiJ3000WrttARNW
         FYclp1RYti8d3CL5b87G1xWqJKIL3B6mWCno4+Wu8+BSnbUqaWGeTAa0NgDDRPwJT6BL
         ZyryiiQN1rLXtNnb/3BOI+nB+n1T0tLCKPjBXUWpuEZxBh+M9C55fHMvHu4Hv/CsUELY
         2B8l/THN+zFkf6M4X3aY0evacpIDQJHSrjspqi+KvPawFk40iQCLCzuwAEXCW12ZOCnF
         6/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9e8y4t56x7b6AmK/lyWNMYJ7TsVo1FqadbWP2nJVRo=;
        b=cG7H/U69bngRcZeUaDyIJjLKUGn0xidC5wvmqa6x+HxqeIuRK7Y3Hg5SWUJpJVW9hK
         9BcFriqLliZECq6lQpUvTZAZOZJqCVoNarbRaGUSt2i+wWUdSonYbqW2WtaKB8QS+DLT
         chr8nI1F2ByA/fJ1/JLHIBVjJ6A5lmxm5bioHzJtdkOZ7juJpX2jz0Xr/3h01JIV7n7G
         IYNgSsJVI+jvOAevQiRYzL0gVG6AvU3IkZhn2ez4u2OizPAXD7e9JNUT+bittraYAasf
         WnntSxHQZt2d7za1f+8s3wzHtLtDrMKH8LC64iz+OaoeHkTG1bKbIk0r7TtvgF3+O6uD
         Pgdg==
X-Gm-Message-State: ANoB5pl35htplBO0oHvHdlC+YTMyIopCJLgaD913OeIWGwwhuF9xlkr2
        FRrF5BMnYpe4/Qjp9D1Qirhv5YFZMX6WWg==
X-Google-Smtp-Source: AA0mqf6498NY5t0CvsjdUh5S493GcQhL/WtwVh6CD5MN0UYQg3yDDKx7aP1PC4FFVUbjb6X9oL/9VQ==
X-Received: by 2002:a17:902:f548:b0:18e:c6b0:b2f6 with SMTP id h8-20020a170902f54800b0018ec6b0b2f6mr51118325plf.14.1671484438592;
        Mon, 19 Dec 2022 13:13:58 -0800 (PST)
Received: from [172.17.0.2] ([20.253.144.192])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902ec8100b001895b2c4cf6sm7623644plg.297.2022.12.19.13.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 13:13:57 -0800 (PST)
Message-ID: <63a0d415.170a0220.4f57c.cb7a@mx.google.com>
Date:   Mon, 19 Dec 2022 13:13:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7157426389866104771=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bugzilla-daemon@kernel.org
Subject: RE: [Bug,216817] btusb device with ID 0489:e0d0 no longer working after v6.0
In-Reply-To: <bug-216817-62941-DWPzypSwyv@https.bugzilla.kernel.org/>
References: <bug-216817-62941-DWPzypSwyv@https.bugzilla.kernel.org/>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7157426389866104771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sync.c:3572
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7157426389866104771==--
