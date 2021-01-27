Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFC6C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 05:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A06572070A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 05:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhA0Fm7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 00:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239596AbhA0Es2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jan 2021 23:48:28 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCC5C061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jan 2021 20:47:42 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id l27so654536qki.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jan 2021 20:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=vosjF/0RryToz4grUPt5O3y0VwVxqWulocN+7eccFis=;
        b=KHvUVDEscQyXnNL2yuw76S4nhNiCelIOsAEoxVTTm7Y7DzjuDcNP1kXovkaqJ7IEli
         xgr4XjwAi4yiilQI0lyiZ/uBuqyocfR2FiZGi1K08/ceupOgOscfAw9a7yifyFyaLRWZ
         mfiCvwuu6S87bBz0M8qlKi0vTFKVtQ/c6sZMjWhPwaAzPNWgAPRObVONeAhWGeqavXIk
         vuN7EiYs+5HQvRxaVwLUI3v3VvDDKVnpZWOr3EWeTfk4QX+OBt8Un0qV6zK7jesMlYrd
         ezzjANw2/eC1eVUfvHc1Chlrjk338VDIPSBdhvvd2BmYhyE+Xtq8lg1BBl7G0NZTyWqA
         iHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=vosjF/0RryToz4grUPt5O3y0VwVxqWulocN+7eccFis=;
        b=Rwu+iIdrBis2yHs+Q13USMsTz4QwulnnAgPhujDYBPOvqZmzO6vTG7ptpbQDdT4sGy
         MyZaLZXqxAHbBSAv1GnC/EKRKhGdVaNbYLYYwgnuCUaIWXjEmuLxmNrJZ6t497vGrGQu
         xHMMNy2SfSRJhqjF6DJrGfDujrN5GRqReg4ntI/TvUrGWJgOzGjgfMs/I3R7t+b1SB9l
         U0kvHtga8Zh58OFqm4XhVFmMqYBsNwf9UlupEALeihhgMVYwNrPJVe3sbGiFFYxU8SPM
         y+cx9YtSGZnxt2HHhH7Sqsg3us6Fhf34g8uVtlbkyZQDIH/5DyNZNXmbgVwBeHy2HCe8
         TqQg==
X-Gm-Message-State: AOAM533naVCpuXo8AtuWcOsjoxVca7goz/m0ZaytdbPXnHQiSyNG+juU
        0dmRzK+dlDOj4NIrg7jlJOWckgZp3+07nA==
X-Google-Smtp-Source: ABdhPJwx0ZnT2iyOFo8kW5C5wtQa7ZMIDDXUjoEyDgBKDCDmnQpFgbaJkG/kvkDaks9FyZsl+T1aTg==
X-Received: by 2002:a37:6545:: with SMTP id z66mr9093910qkb.31.1611722861519;
        Tue, 26 Jan 2021 20:47:41 -0800 (PST)
Received: from [172.17.0.2] ([40.70.20.129])
        by smtp.gmail.com with ESMTPSA id k5sm647700qtb.49.2021.01.26.20.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 20:47:41 -0800 (PST)
Message-ID: <6010f06d.1c69fb81.ce890.4279@mx.google.com>
Date:   Tue, 26 Jan 2021 20:47:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2709737646350111627=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tedd.an@linux.intel.com
Subject: RE: [BlueZ] tools/bluemoon: Display FW version of firmware file
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <f6d640062281fea6381cc33c7460785e04307b22.camel@linux.intel.com>
References: <f6d640062281fea6381cc33c7460785e04307b22.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2709737646350111627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=422497

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============2709737646350111627==--
