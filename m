Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17488C47096
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 14:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02D06613D6
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 14:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhFCOcm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jun 2021 10:32:42 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:41156 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbhFCOcl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jun 2021 10:32:41 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id C2C3CCED1F;
        Thu,  3 Jun 2021 16:38:53 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v8 6/9] Bluetooth: btintel: Add a callback function to
 configure data path
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210518104232.5431-6-kiran.k@intel.com>
Date:   Thu, 3 Jun 2021 16:30:55 +0200
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <2F035DD5-C840-48B2-892D-4D866BDA4995@holtmann.org>
References: <20210518104232.5431-1-kiran.k@intel.com>
 <20210518104232.5431-6-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> In HFP offload usecase, Intel controllers require offload use
> case id (NBS or WBS) to be set before opening SCO connection. Define
> a new callback which gets called on setsockopt SCO socket. User space
> audio module is expected to set codec via setsockopt(sk, BT_CODEC, ....)
> before opening SCO connection.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> 
> This callback gets called when audio module does setsockopt(sk, BT_CODEC,...)
> on SCO socket and data_path is 1 (non-HCI transport). For non-HCI transport,
> Intel controller expects presets to be set before opening SCO connection.
> Presets are pre-defined, 0 - NBS, 1 - WBS. Likewise additional presets will
> be defined for A2DP, LE Audio offload use cases.
> 
> drivers/bluetooth/btintel.c      | 50 ++++++++++++++++++++++++++++++++
> drivers/bluetooth/btintel.h      |  8 +++++
> drivers/bluetooth/btusb.c        |  1 +
> include/net/bluetooth/hci.h      |  8 +++++
> include/net/bluetooth/hci_core.h |  2 ++
> 5 files changed, 69 insertions(+)

same thing here. Please introduce the callbacks as one patch and then in a separate patch, you start using them in a driver.

Regards

Marcel

