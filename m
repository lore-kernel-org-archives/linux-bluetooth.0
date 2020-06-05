Return-Path: <SRS0=pjei=7S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE82FC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 11:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA3A22070B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Jun 2020 11:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eekYXS/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgFELgI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Jun 2020 07:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgFELgI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Jun 2020 07:36:08 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59110C08C5C2
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2020 04:36:07 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id w90so8099150qtd.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2020 04:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=cf+zzgj5fZF8rtOhi4gZ2sliPbRqdIRp+ljNZjF7vac=;
        b=eekYXS/rLXvAKQvZWuFxz0qoXPKBccaQcEUwpN9T29FEKN34fCMP0tldU2ug60HVup
         SYdKAFHJi939/VSY7B3PCSSIcFoyLkIxxoTvE25bD2zIJOqA72x0oJmQPuZJdZcS26aN
         kspN4hadFfkOIB4x29Jlmx6kdS9BvArxbxJ5subrEg/QCS8fZqfTCIK5RIidptIhgKl8
         TaKCAKmmncKImFdP+Hp8Y1d4ZrXcdT4ECkVFsYZDxVrvIZua0POQkyNAS0GBneE7CTIc
         awH1oOEeHVyJamCIcGNDL8/9yGAaj7/AQj3tjoNxNAeZfK7/KCun5aQ4ID3/SReN2T36
         Eujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=cf+zzgj5fZF8rtOhi4gZ2sliPbRqdIRp+ljNZjF7vac=;
        b=eXC13uabK3eykJFMZ+MBjFHv3YuDTA9v2L48eJDrgusNIpf1433zR9Z0KwsSaqOwga
         D7HOkGO8C5MCBjTLkC5ofLwDRvwoPxaPJ8a74c7TtbIg8KHCklpA1GGfQRokEtzkyeEu
         fKzd1QqCAHMwqMihq4Qbp1u8IGPBMW/oLfpvTSWQYeGhdF7itMb46SxjANy3ORDyHtup
         pmYf77cvVAOVE8xEd52Sa27j32MSkaSVms6qBU7Yr2j00Yhw4nJD4hMYPfpFF106uZYM
         g5nmfhQygP1uVR/ZbE7AKHBI5mnuS22TM4UEAKSwy2yOHoK5pJHW57Fu728e8VXHWzXY
         XUiA==
X-Gm-Message-State: AOAM530FVIjhr+knZ86UDzwlB7c9U2idCfG5pUi+2HG0LvWZjA3kAGyJ
        Pw6RaiBwbDFXLqFWNBQQCkLBa6WjOZM=
X-Google-Smtp-Source: ABdhPJzMMMBx0vYiaGlW4LctMEkHZ97vrX7t/coQqZNKFi9RmPMbuHjvn/w8GOlpDosvK/TXq490XQ==
X-Received: by 2002:ac8:7a77:: with SMTP id w23mr9638625qtt.111.1591356966360;
        Fri, 05 Jun 2020 04:36:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.68.85])
        by smtp.gmail.com with ESMTPSA id q13sm6429053qkc.72.2020.06.05.04.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 04:36:06 -0700 (PDT)
Message-ID: <5eda2e26.1c69fb81.ee1f1.367f@mx.google.com>
Date:   Fri, 05 Jun 2020 04:36:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6411660726205705000=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, d.grigorev@omprussia.ru
Subject: RE: [BlueZ,v2] gobex: Fix segfault caused by interrupted transfer
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200605111859.7742-1-d.grigorev@omprussia.ru>
References: <20200605111859.7742-1-d.grigorev@omprussia.ru>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6411660726205705000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
11: B1 Line exceeds max length (82>80): "0xecc6eeda in dbus_connection_get_object_path_data () from /usr/lib/libdbus-1.so.3"
35: B1 Line exceeds max length (81>80): "commit 04ba72e6b24f ("Bluetooth: Reorganize mutex lock in l2cap_sock_shutdown()")"
36: B1 Line exceeds max length (81>80): "commit 9f7378a9d6ce ("Bluetooth: l2cap_disconnection_req priority over shutdown")"



---
Regards,
Linux Bluetooth

--===============6411660726205705000==--
