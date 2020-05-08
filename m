Return-Path: <SRS0=6WQ0=6W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC089C38A2A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 May 2020 08:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B653120731
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 May 2020 08:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJhuvVh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgEHI7b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 May 2020 04:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgEHI7b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 May 2020 04:59:31 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC6DC05BD43
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2020 01:59:30 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 207so585192pgc.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 May 2020 01:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Xk8y/AJ3/8gnCPsTQkgW4RnJXrH/qbL8MduwYz1/YjI=;
        b=AJhuvVh3jErzZCtRUXEn5epUTCpR493HY9pTw7t1J6DIQXGK17ju3so3ydng83CTxG
         R6s37+dGuunCeKR2Wcvu0a9iw1pU7AMe20v1qNuZGGSN0oF87BtVz8s0xqsWPbKTLv6P
         uaYr9sJ2QERHayG5Bsmjh+37mkmyEN/+NjXaHYxEBaNXMrjyJBpEQ04HG5ozZq5bp74Q
         MwQUCxSnO4NwhkZO9/Ov0l+laIXxZMfxNrHW55C0wI7XGO26IvM/yAWuMf42JAMQW/+z
         g4HkREBbaFHIhpXLn8Rg8bRcwQdGOLvkhdr4kHLKPRCFQHiys8tP9hzb0WHhbGnfzsB0
         CY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Xk8y/AJ3/8gnCPsTQkgW4RnJXrH/qbL8MduwYz1/YjI=;
        b=ZQm7OfFnUOM6T+D6l3/s14Sj6BVcfKpKDH5oEGU2R4farenddfzvpJE2Ur8qOL5iqW
         ql4PKBjZc8/6uoY9y/K5UqdCZ6p35I1uC0N2xG6fPAoGZNwQtp8vXRCagJG++Ji/dhBt
         9Eo/X+I4GFfjjr5mR1VBERBBEkinjG30fh35X9ablf4oI3Y26ZlhCl3vNEMeJLOW6ila
         PazoDPLyVSz+K09sVhMjuo0LMvOzhWvxonLW3dz8ASsHZFY+o8+Sf8sJlE2RxQaYgxMG
         njmF5rXvWa/YI0ey/AMuqaorWWZckTcA4wJ13mRfHmhsUo9dskQQ/qgxLlrg6KUukVr6
         PavA==
X-Gm-Message-State: AGi0Pua76Gz7Z8oyG5YsemdCIOnMp14/sRcFI6KEHE7fhB2MtzwuwuUP
        lgdNmgG5sKtRF9x8n6cavhiC22AGKHqv/g==
X-Google-Smtp-Source: APiQypJGY76ioTCcrSpx/VIhrqA7rBunRQzPzlSq+GVU2VyA0YE3qHYY/cusnSx4bCJBBZiSyi9JAw==
X-Received: by 2002:a62:6385:: with SMTP id x127mr1858639pfb.276.1588928370341;
        Fri, 08 May 2020 01:59:30 -0700 (PDT)
Received: from rsegal-mobl.ger.corp.intel.com (jfdmzpr03-ext.jf.intel.com. [134.134.139.72])
        by smtp.gmail.com with ESMTPSA id c1sm1138992pfo.152.2020.05.08.01.59.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 01:59:29 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3 0/7] Patches introducing experimental feature support
From:   Johan Hedberg <johan.hedberg@gmail.com>
In-Reply-To: <cover.1588751831.git.marcel@holtmann.org>
Date:   Fri, 8 May 2020 11:59:26 +0300
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <1978B405-610A-4A7C-8E0A-1128B471A707@gmail.com>
References: <cover.1588751831.git.marcel@holtmann.org>
To:     Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On 6. May 2020, at 10.57, Marcel Holtmann <marcel@holtmann.org> wrote:
> Marcel Holtmann (7):
>  Bluetooth: Add MGMT_EV_PHY_CONFIGURATION_CHANGED to supported list
>  Bluetooth: Replace BT_DBG with bt_dev_dbg for management support
>  Bluetooth: replace zero-length array with flexible-array member
>  Bluetooth: Introduce HCI_MGMT_HDEV_OPTIONAL option
>  Bluetooth: Replace BT_DBG with bt_dev_dbg for security manager 
>    support
>  Bluetooth: Add support for experimental features configuration
>  Bluetooth: Introduce debug feature when dynamic debug is disabled
> 
> include/net/bluetooth/bluetooth.h |  11 +
> include/net/bluetooth/hci.h       |   1 +
> include/net/bluetooth/hci_core.h  |   1 +
> include/net/bluetooth/mgmt.h      |  69 ++++--
> net/bluetooth/Kconfig             |   7 +
> net/bluetooth/hci_sock.c          |  12 +-
> net/bluetooth/lib.c               |  33 +++
> net/bluetooth/mgmt.c              | 364 +++++++++++++++++++++---------
> net/bluetooth/smp.c               |   8 +-
> 9 files changed, 365 insertions(+), 141 deletions(-)

All patches in this set have been applied to bluetooth-next. Thanks.

Johan
