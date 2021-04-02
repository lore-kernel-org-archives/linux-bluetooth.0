Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB20C433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Apr 2021 09:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB8A2610FC
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Apr 2021 09:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhDBJS5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Apr 2021 05:18:57 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60574 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbhDBJS5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Apr 2021 05:18:57 -0400
Received: from marcel-macbook.holtmann.net (p5b3d2269.dip0.t-ipconnect.de [91.61.34.105])
        by mail.holtmann.org (Postfix) with ESMTPSA id 62D61CED23;
        Fri,  2 Apr 2021 11:26:37 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [RFC PATCH v3] doc/mgmt-api - Return connection direction in
 Device Connected Event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210326094845.RFC.v3.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
Date:   Fri, 2 Apr 2021 11:18:55 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <BCF4A245-8B9B-4F62-BE31-1D88267C9CCF@holtmann.org>
References: <20210326094845.RFC.v3.1.I530e1c3e621abd34c342d657df119e12e576d8a7@changeid>
To:     Yu Liu <yudiliu@google.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yu,

> When an MGMT_EV_DEVICE_CONNECTED event is reported back to the user
> space we will set the flags to tell if the established connection is
> outbound or not. This is useful for the user space to log better metrics
> and error messages.
> 
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> Signed-off-by: Yu Liu <yudiliu@google.com>
> ---
> 
> Changes in v3:
> - Reserve it in Device Found event
> 
> Changes in v2:
> - Use next free bit
> 
> Changes in v1:
> - Initial change
> 
> doc/mgmt-api.txt | 2 ++
> 1 file changed, 2 insertions(+)

patch looks good and I am happy for Luiz to apply it and you send the kernel changes for it. However for userspace we don’t use Signed-off-by.

Regards

Marcel

