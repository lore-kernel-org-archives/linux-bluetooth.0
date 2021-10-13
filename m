Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630D9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 12:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42C97610C8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 12:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhJMMdd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 08:33:33 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:34252 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhJMMdc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 08:33:32 -0400
Received: from smtpclient.apple (p4ff9f2d2.dip0.t-ipconnect.de [79.249.242.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id 70460CECF6;
        Wed, 13 Oct 2021 14:31:28 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2] Bluetooth: btintel: Fix bdaddress comparison with
 garbage value
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211013080511.23945-1-kiran.k@intel.com>
Date:   Wed, 13 Oct 2021 14:31:28 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "An, Tedd" <tedd.an@intel.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <21FB3BDC-FAA0-4CA5-A00E-D99167E3C9B3@holtmann.org>
References: <20211013080511.23945-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> Intel Read Verision(TLV) data is parsed into a local structure variable
> and it contains a field for bd address. Bd address is returned only in
> bootloader mode and hence bd address in TLV structure needs to be validated
> only if controller is present in boot loader mode.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Reviewed-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> 
> Notes:
>    changes in v2:
>    - Add comment for memsetting ver_tlv
> 
> drivers/bluetooth/btintel.c | 22 ++++++++++++++--------
> 1 file changed, 14 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

