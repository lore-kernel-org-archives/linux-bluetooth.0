Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40CDC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 07:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70AE964FE6
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 07:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCEHew (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Mar 2021 02:34:52 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:55217 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCEHew (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Mar 2021 02:34:52 -0500
X-Originating-IP: 78.199.60.242
Received: from [192.168.1.150] (unknown [78.199.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id E6D45240007;
        Fri,  5 Mar 2021 07:34:50 +0000 (UTC)
Message-ID: <eeb0cffb975efea34b4db00dcf92dd08c635dc8d.camel@hadess.net>
Subject: Re: [PATCH BlueZ 1/2] adapter: Fix not using the correct setting
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Fri, 05 Mar 2021 08:34:50 +0100
In-Reply-To: <20210304222448.3769100-1-luiz.dentz@gmail.com>
References: <20210304222448.3769100-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 2021-03-04 at 14:24 -0800, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> set_mode shall use opcode to identify what setting are being changed
> rather then the mode.

What was the symptom of this bug?

> ---
>  src/adapter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 051c32753..f483cc827 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -631,7 +631,7 @@ static bool set_mode(struct btd_adapter *adapter,
> uint16_t opcode,
>         memset(&cp, 0, sizeof(cp));
>         cp.val = mode;
>  
> -       switch (mode) {
> +       switch (opcode) {
>         case MGMT_OP_SET_POWERED:
>                 setting = MGMT_SETTING_POWERED;
>                 break;


