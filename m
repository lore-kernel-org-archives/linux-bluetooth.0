Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC26C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 14:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D68C61BF5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 14:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbhKPOG3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Nov 2021 09:06:29 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:36004 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbhKPOGI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Nov 2021 09:06:08 -0500
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id DA4D0CECD7;
        Tue, 16 Nov 2021 15:03:10 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [Bluez PATCH v2 1/3] Listen and process remote name resolving
 failure
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211115170538.Bluez.v2.1.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
Date:   Tue, 16 Nov 2021 15:03:10 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <59CFC634-45D8-40EF-A8AF-29FD7E6DE975@holtmann.org>
References: <20211115170538.Bluez.v2.1.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
To:     Archie Pusaka <apusaka@google.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

> When Remote Name Resolve ends with failure, record this occurrence and
> prevent remote name resolving for the same device for some time.
> Increase the time duration for subsequent failures.
> ---
> Hi maintainers,
> 
> This is the patch series for remote name request as was discussed here.
> https://patchwork.kernel.org/project/bluetooth/patch/20211028191805.1.I35b7f3a496f834de6b43a32f94b6160cb1467c94@changeid/
> Please also review the corresponding kernel space change.
> 
> Changes in v2:
> * Stay silent instead of sending MGMT_OP_CONFIRM_NAME with DONT_CARE flag.
> 
> lib/mgmt.h    |  1 +
> src/adapter.c | 15 +++++++++++++--
> src/device.c  | 23 +++++++++++++++++++++++
> src/device.h  |  2 ++
> 4 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/mgmt.h b/lib/mgmt.h
> index 0d1678f01d..468d31cafb 100644
> --- a/lib/mgmt.h
> +++ b/lib/mgmt.h
> @@ -856,6 +856,7 @@ struct mgmt_ev_auth_failed {
> #define MGMT_DEV_FOUND_CONFIRM_NAME	0x01
> #define MGMT_DEV_FOUND_LEGACY_PAIRING	0x02
> #define MGMT_DEV_FOUND_NOT_CONNECTABLE	0x04
> +#define MGMT_DEV_FOUND_NAME_RESOLVE_FAILED 0x10

NAME_REQUEST_FAILED please.

And you might want to indent the rest of the variables and provide this as an independent patch.

Regards

Marcel

