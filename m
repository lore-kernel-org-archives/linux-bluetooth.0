Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D79C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 18:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ED8C61360
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 18:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhJSSHs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Oct 2021 14:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234643AbhJSSHr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Oct 2021 14:07:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CB7E6136A;
        Tue, 19 Oct 2021 18:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634666734;
        bh=S+WNU1Dy2S8T+sWsM+dATLpcrrK28GSXkl2CCEZ7MWE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MXTI6BXzU1jyW3W8n4AiD3BVBAPI+l/fXNsvKdah9aCeE8MkoEPV7Ml7agY3OKcZ+
         znZpbOEkDdykKJSkH2S/5xRQdZMIJTfvFUuNpxTXiLA8T+j9U6dRqXZgzy29FRMd0L
         yhoFedxRiYpCFiaFTLhdiw3MzV+pQT7oWntvbVhnLq4SNcYMBc+5aDrcBskRsbHUen
         rOmtlKidDXNZiyZ6dL2VEA7+vHgNikH7vkTltOP/b0bCztBIjLDWhtQZ4uNsEXJbAO
         fZFv5Yjld+Wm41lyjpsHpZ5QtZXHzYaOHlVP5w0AQTbRYNgkcm9BcXweYIn8SAlQ47
         tVt9DcNPnED+Q==
Date:   Tue, 19 Oct 2021 11:05:33 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     bluez.test.bot@gmail.com
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [1/2] bluetooth: use eth_hw_addr_set()
Message-ID: <20211019110533.5665cc90@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <616f0064.1c69fb81.3a2d8.9416@mx.google.com>
References: <20211019163346.1384785-1-kuba@kernel.org>
        <616f0064.1c69fb81.3a2d8.9416@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, 19 Oct 2021 10:29:08 -0700 (PDT) bluez.test.bot@gmail.com wrote:
> This is automated email and please do not reply to this email!
> 
> Dear submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=566505

Eish, sorry, you need 40af35fdf79c ("netdevice: demote the type of some
dev_addr_set() helpers") from net-next for this change to build cleanly.

What are your plans on sending a PR for net-next? Probably easiest if I
resend this after such PR? Or apply directly to net-next.
