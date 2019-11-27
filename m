Return-Path: <SRS0=/G8r=ZT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3A0C432C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 06:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A4620684
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 06:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfK0GAK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Nov 2019 01:00:10 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:39068 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfK0GAK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Nov 2019 01:00:10 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id E4F55CED07;
        Wed, 27 Nov 2019 07:09:16 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] Blocked key mgmt Api definition
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191126191452.23603-1-alainm@chromium.org>
Date:   Wed, 27 Nov 2019 07:00:08 +0100
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <7223C834-7E4C-4521-9C1E-CA7C2F26EC63@holtmann.org>
References: <20191126191452.23603-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> ---
> doc/mgmt-api.txt | 33 +++++++++++++++++++++++++++++++++
> 1 file changed, 33 insertions(+)

patch has been applied.

> +
> +	This command can be used at anypoint to add to the list of blocked keys.  Any connections that
> +	are attempting to use the keys will be terminated. If a device tries to distribute the keys during
> +	pairing, pairing will fail.
> +

However, I ended up rewording this part since it doesn’t sounded right to me. We can adjust this once we have the implementation to match against, but for now I kept it simple. Oh, and we need to stay within the rule that it has to readable in 80 character wide terminal. So no long lines.

Regards

Marcel

