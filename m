Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8362BC64E7A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 22:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EA942225E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 22:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URNVyvSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgKSWFh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Nov 2020 17:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgKSWFh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Nov 2020 17:05:37 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0253C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2020 14:05:36 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id 23so8003632wrc.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2020 14:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=AgftX2/yu/R3iHNc+sTHzRatVUvqA77cZnTgup76lYs=;
        b=URNVyvSg4CFbpHk+LEscgYCs2OpkDTdeqlsYUetOo9K1u4waq9ifbalaSXM9pquwFz
         VFJOHVeFX1Ekn9vohYp0xzMxughlUYiYrFzPso6CRo6qr0Yfumdx3vtF9YI1xvPQUMdF
         PiW4k0VGwGH1SLMCUe10liaV3EkqvFfQywaHH5UavbLLS6eC8edm3ZXpGfpR6ba4jpwO
         aNd7Mxf4q4S0qRKcD5Hgrxhxw0za5AZ2yt8RYIi5FdwHuuHEkzhygafkI9veY5LDAyzx
         TgEMm4GstW0mhesSW/KYgqtKuOVrWb2LgoMbpUe3kOhTbYiWbyEQ1f3Y0/Qi6fNglWFR
         6KCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=AgftX2/yu/R3iHNc+sTHzRatVUvqA77cZnTgup76lYs=;
        b=gYm5s8G4559E39DUkOUtYamr6sMQEChFPE7KMKnsof1XqxEaIFNjHqJJBC7RDRHBi5
         mJyUv8FOGU5r3bV6Zik0g7x9Ycu14gzCX6usFzvWTWbi+r/R4w3SPxPahINY9jV18rUo
         TBqUjDjHPyxq4AW+5BYuyPfsYR0OStm71UIGRERqdxdULBqf0f6cWUq6yxXKZM2DZxuG
         hSZ1BKHE02bcfAPheg0ksqigbGtJLIRcsckJ3f6GUGneiYX4P8ey/y+3lCBVayzSYz7P
         4mdadkgucxeX6dSazNa5udUDmVERXj9E1iWHfjqDL6vhhy20Ypnh3RGuarS8w91w74mZ
         AhFg==
X-Gm-Message-State: AOAM531A5V4XuJtJkoSc4WSETC5LV55PG9IjxmdtiQMp3p+b4DCBK2zt
        1suEcXOk5ow5LiQuF+t7fghF65Nb+g/oBQ==
X-Google-Smtp-Source: ABdhPJz+qj1DwawkNtd8GCG1V87OYxCCiBRlkaJe4KnfjOX+z0apqx/l02KKZVFVmPd8fF7a2r5C4g==
X-Received: by 2002:adf:f24a:: with SMTP id b10mr12663298wrp.352.1605823535422;
        Thu, 19 Nov 2020 14:05:35 -0800 (PST)
Received: from ?IPv6:2003:ea:8f23:2800:6d7c:9ea3:dfaa:d617? (p200300ea8f2328006d7c9ea3dfaad617.dip0.t-ipconnect.de. [2003:ea:8f23:2800:6d7c:9ea3:dfaa:d617])
        by smtp.googlemail.com with ESMTPSA id u6sm1771886wmj.40.2020.11.19.14.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 14:05:35 -0800 (PST)
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     BlueZ development <linux-bluetooth@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Updated fw versions ignored for Intel devices?
Message-ID: <0011e099-4ab0-4705-de1e-cb03953f11ef@gmail.com>
Date:   Thu, 19 Nov 2020 23:05:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In btusb.c we have the following code. I interpret this in a way
that once firmware was loaded the driver will never check for
updated firmware.
Shouldn't the driver always read the firmware file available on
the system and check its version against the firmware version
the device has (and apply it if it's newer)?
But maybe I miss something ..

bt_dev_info(hdev, "read Intel version: %02x%02x%02x%02x%02x%02x%02x%02x%02x",
	    ver.hw_platform, ver.hw_variant, ver.hw_revision,
	    ver.fw_variant,  ver.fw_revision, ver.fw_build_num,
	    ver.fw_build_ww, ver.fw_build_yy, ver.fw_patch_num);

/* fw_patch_num indicates the version of patch the device currently
 * have. If there is no patch data in the device, it is always 0x00.
 * So, if it is other than 0x00, no need to patch the device again.
 */
if (ver.fw_patch_num) {
	bt_dev_info(hdev, "Intel device is already patched. "
		    "patch num: %02x", ver.fw_patch_num);
	goto complete;
}
