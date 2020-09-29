Return-Path: <SRS0=RRj3=DG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB33C4741F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 14:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C95120757
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 14:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601390816;
	bh=yvr2LgsHeBUwSehSCkpozDO4/RLdGtxAV4HSyubV94U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RVwDGY3usDo7nz/hxhvDWAiyChi2Ebl8fnwP2gOtzdNOWzjkiIbyGHzBTErTY930t
	 Nak9ZNVcQkFmN9+4yiuZ+oGlYzUPTvNgj9r0qsV4JHwGno5ss5T8w00dOGa2L+MJ7w
	 2Gey6eGn2w5nxL9jfvipXenP9DKAt5aMF1/I8nKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbgI2Oqw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Sep 2020 10:46:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbgI2Oqw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Sep 2020 10:46:52 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA86A20757;
        Tue, 29 Sep 2020 14:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601390811;
        bh=yvr2LgsHeBUwSehSCkpozDO4/RLdGtxAV4HSyubV94U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qEfNVEM9+Z4Mb9+EzqtVs2JmMYvIn4nCCpbfrAlZc6t1qPalo0cdGRzDm3C3qxwdY
         WJvdfyN9VJzu44y09ood3U6VgMcIJZ/s4SZ56x2goRSRQ4lhpXHh3stBLn0vhzMMd5
         g58JNfhMWV51krwc+8JjocdONxkrpLjXR2cZMnfE=
Date:   Tue, 29 Sep 2020 07:46:49 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Howard Chung <howardchung@google.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, mmandlik@chromium.org, alainm@chromium.org,
        mcchou@chromium.org, "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7 4/4] Bluetooth: Add toggle to switch off interleave
 scan
Message-ID: <20200929074649.20dfda35@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200929192508.v7.4.I756c1fecc03bcc0cd94400b4992cd7e743f4b3e2@changeid>
References: <20200929192508.v7.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
        <20200929192508.v7.4.I756c1fecc03bcc0cd94400b4992cd7e743f4b3e2@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 29 Sep 2020 19:25:26 +0800 Howard Chung wrote:
> This patch add a configurable parameter to switch off the interleave
> scan feature.
> 
> Signed-off-by: Howard Chung <howardchung@google.com>
> Reviewed-by: Alain Michaud <alainm@chromium.org>

One more:

net/bluetooth/mgmt_config.c:79:17: warning: incorrect type in initializer (different base types)
net/bluetooth/mgmt_config.c:79:17:    expected restricted __le16 [usertype] type
net/bluetooth/mgmt_config.c:79:17:    got int
