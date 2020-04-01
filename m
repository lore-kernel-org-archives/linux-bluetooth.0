Return-Path: <SRS0=i/J9=5R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285D2C43331
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 12:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2722078E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 12:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="VSHK2xpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbgDAMi7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:38:59 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:62113 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726901AbgDAMi7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 08:38:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585744738; h=Message-ID: Subject: Cc: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=Lm4XeXJvFGgsWmywVyVrVKjBBrWMAGA3u6lSj/QKmog=; b=VSHK2xpkyxTBRGlI4Zc7xi55h6f9NCBJ5MvuloTeckRVAH541CNXddutMkkmF3NYMi/Qgz8A
 3RuixGT76z+k2g1/iTR3RbUh87aHCrtYYmQFqfmRywgiJybsoNpbAOBH71andFjjkiPDvcky
 mefooDvwYFk9ch3mHvBfL9vaATY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI2MTA3ZSIsICJsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e848b51.7f40aaac2ce0-smtp-out-n04;
 Wed, 01 Apr 2020 12:38:41 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3562DC43636; Wed,  1 Apr 2020 12:38:40 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 96CAFC433BA;
        Wed,  1 Apr 2020 12:38:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 01 Apr 2020 20:38:38 +0800
From:   Rocky Liao <rjliao@codeaurora.org>
List-Id: <linux-firmware.lore.kernel.org>
To:     linux-firmware@kernel.org
Cc:     linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PULL] btqca firmware 20200401
Message-ID: <1fce439e32d6b77970e01a797cdb70ca@codeaurora.org>
X-Sender: rjliao@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi linux-firmware maintainers,

Here's a pull request for btqca bluetooth driver. Please let me know if 
you have any problems.

The following changes since commit
edf390c23a4e185ff36daded36575f669f5059f7:

    Merge branch 'v12573.77' of https://github.com/erinlo/linux_fw_scp 
(2020-03-20 07:39:19 -0400)

are available in the Git repository at:

    https://github.com/rjliao-qca/qca-btfw.git

for you to fetch changes up to 4921f73bc8fdd81cf54200f67bf44a071df50e78:
----------------------------------------------------------------
Rocky Liao (1):
        QCA: Add Bluetooth firmware for QCA6390 (2020-04-01 18:12:51 
+0800)
