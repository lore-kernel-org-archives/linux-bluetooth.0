Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EFBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jan 2022 10:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbiAEK0k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jan 2022 05:26:40 -0500
Received: from giacobini.uberspace.de ([185.26.156.129]:58400 "EHLO
        giacobini.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbiAEK0k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jan 2022 05:26:40 -0500
Received: (qmail 15430 invoked by uid 990); 5 Jan 2022 10:26:38 -0000
Authentication-Results: giacobini.uberspace.de;
        auth=pass (plain)
Message-ID: <a6a50dc6-d8f5-cf56-5218-6115bb0f136f@eknoes.de>
Date:   Wed, 5 Jan 2022 11:26:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC] Bluetooth: hci_event: Rework
 hci_inquiry_result_with_rssi_evt
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20220104210051.2982871-1-luiz.dentz@gmail.com>
From:   =?UTF-8?Q?S=c3=b6nke_Huster?= <soenke.huster@eknoes.de>
In-Reply-To: <20220104210051.2982871-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Bar: /
X-Rspamd-Report: BAYES_SPAM(0.013763) MIME_GOOD(-0.1) R_MIXED_CHARSET(0.625)
X-Rspamd-Score: 0.538763
Received: from unknown (HELO unkown) (::1)
        by giacobini.uberspace.de (Haraka/2.8.28) with ESMTPSA; Wed, 05 Jan 2022 11:26:38 +0100
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 04.01.22 22:00, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This rework the handling of hci_inquiry_result_with_rssi_evt to not use
> a union to represent the different inquiry responses.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/hci.h |  6 +-----
>  net/bluetooth/hci_event.c   | 19 +++++++++----------
>  2 files changed, 10 insertions(+), 15 deletions(-)

Tested-by: Soenke Huster <soenke.huster@eknoes.de>

