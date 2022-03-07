Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0097AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Mar 2022 18:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244887AbiCGS6K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Mar 2022 13:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244902AbiCGS6I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Mar 2022 13:58:08 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EB293196
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Mar 2022 10:57:13 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id u61so32910836ybi.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Mar 2022 10:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=S4gJ5WSgOm6UPb/Jf/ZU25tmWFHW5ov82wrvElSdaTo=;
        b=KThcTFXsJ+AU0ZRn03LuNejg6+aoPqcsoaoF4yq8m42UT8tWF/sA3JCs1m1/cIW8eB
         yHa+PMUvYAADsVOavcandn6ddDRnIPq34rGWzJPMsszKzfAjURd+zLWQmMr+ee7Yk6ta
         H+VZkYDownNLc48SuDrnnY+U0eJ5Znrk1wuPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=S4gJ5WSgOm6UPb/Jf/ZU25tmWFHW5ov82wrvElSdaTo=;
        b=Cp3C4ZnLtQOUxmeRd9FLQEK3S+a3rOQ5t9maEkWtG+YVPhp1WURQXg9EVA2vPLhVM9
         EAHgF6MD4IoA3QmSIKI4Wq38xLW3yMZ7iLITDX2wGBI3jxNo+HvOWn1hlQmwEsHT4JpS
         ugy75X/zzDT7p6rRz7y4p2u8TFL27RLsAVNh9z6l+G0pwA1ba8doDlxWk3HgbaXR6FBT
         /4QCs2okLiyq6Q0LP7pIu8gSQRe71fCvCjAGMRR7HwgAMgr90aO1PPbs9M7EK8Y9gMYT
         Zam6LFol2/OCAzMHs01FBqlrE1xFQ/SiJtNYAYq2WTjLYROMWOx3pcXgv5jBAoK3eOqG
         sf+Q==
X-Gm-Message-State: AOAM530pyu7FVRtItb19gs5tFNYbnMD+X9LrYc1c5HS06glBNrF9r9vJ
        IgFsqV087ahOrbh9H6MecuGGQMXmlW3bBzIAQOzUWGZNuQxuig==
X-Google-Smtp-Source: ABdhPJzNufD+y8EXjtPbsaqNxTgIvNBzykinmYwXJKHzIPeFRBmIHW30ZbI4L0xWfsS9N9Q5G2JQJQh3cQ0rOBtSjEc=
X-Received: by 2002:a25:7804:0:b0:628:ec4c:989b with SMTP id
 t4-20020a257804000000b00628ec4c989bmr8794539ybc.428.1646679433000; Mon, 07
 Mar 2022 10:57:13 -0800 (PST)
MIME-Version: 1.0
From:   Katherine Lai <laikatherine@chromium.org>
Date:   Mon, 7 Mar 2022 10:57:02 -0800
Message-ID: <CAPBVwTQrcYYauoCXBWdOsPa_vmN=cajYzVFcep_GLC-2OwOwYQ@mail.gmail.com>
Subject: [RFC] Bluetooth: Adding support for /etc/bluetooth/main.conf.d
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Background

It was found that a change to the default settings for
MinConnectionInterval and MaxConnectionInterval in main.conf broke
some of ChromeOS=E2=80=99s keyboard HID tests for only certain Bluetooth
controllers. These keyboards aren=E2=80=99t able to connect to the device.
Since those connection parameters improve the connection interval for
most other chipsets, we want to leave the default values but have a
way to have an optional override to address problematic models.


Proposed Solution

Adding support to bluetoothd for an additional config directory
/etc/bluetooth/main.conf.d containing multiple files which will
override common params. Override order will be lexically sorted
filename order. This pattern is already used by Linux distros, for
example there is /etc/sudoers.d which files will override common
params in /etc/sudoers.

Users can add override config files to /etc/bluetooth/main.conf.d
rather than directly editing /etc/bluetooth/main.conf. This is more
friendly to package managers since BlueZ package updates won't cause
conflict to /etc/bluetooth/main.conf.

In bluez=E2=80=99s main.c, merge the params for each *.conf file from
/etc/bluetooth/main.conf.d with the existing /etc/bluetooth/main.conf
in lexical filename order

/etc/bluetooth/main.conf.d will be configurable at build time, e.g.
with ./configure --main-conf-dir
