Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB184C388F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 03:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B4622168B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 03:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3DetgO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgKKDJN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 22:09:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:56320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgKKDJN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 22:09:13 -0500
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4398206E3;
        Wed, 11 Nov 2020 03:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605064152;
        bh=msnVHGgbxFQfHjRxheY9IogzUpKNpRnskL9wdsSTp/w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D3DetgO8JKQNRpCVNsMPuWa1VRw2200w695bKY9+B3RLSbQVOK5ujCQuTLY4aJOcA
         EQrhIIHHeJoShSZ8YWMIuglNlnwlfg3XSojKoCP/1bYX49jQUck3DadJRemaiICzWF
         tAm8fMNDvBBxLapqIpj+aXZgxkCoHD7n6A/z0+Sc=
Date:   Tue, 10 Nov 2020 19:09:10 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Howard Chung <howardchung@google.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, mmandlik@chromium.org, mcchou@chromium.org,
        alainm@chromium.org, "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v8 6/6] Bluetooth: Add toggle to switch off interleave
 scan
Message-ID: <20201110190910.22215e96@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201110181740.v8.6.I756c1fecc03bcc0cd94400b4992cd7e743f4b3e2@changeid>
References: <20201110181740.v8.1.I55fa38874edc240d726c1de6e82b2ce57b64f5eb@changeid>
        <20201110181740.v8.6.I756c1fecc03bcc0cd94400b4992cd7e743f4b3e2@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 10 Nov 2020 18:17:55 +0800 Howard Chung wrote:
> This patch add a configurable parameter to switch off the interleave
> scan feature.
> 
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> Signed-off-by: Howard Chung <howardchung@google.com>

Please don't add new sparse warnings:

net/bluetooth/mgmt_config.c:315:63: warning: cast to restricted __le16
