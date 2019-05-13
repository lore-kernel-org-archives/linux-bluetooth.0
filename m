Return-Path: <SRS0=zNJH=TN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1F8C04AA7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 May 2019 18:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E60D206BF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 May 2019 18:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfEMSNw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 May 2019 14:13:52 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:38661 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfEMSNv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 May 2019 14:13:51 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 0D7291BF207;
        Mon, 13 May 2019 18:13:48 +0000 (UTC)
Message-ID: <d5bbd6d48b45d252c6cb1b40598458f13459706e.camel@hadess.net>
Subject: Re: [PATCH 1/8] build: Add a few default configure options
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Mon, 13 May 2019 20:13:48 +0200
In-Reply-To: <CABBYNZK=U6xCfdKV6LHCZEmJTz+tfwq97MGCAxoXrO_o2DjTyw@mail.gmail.com>
References: <20190509123746.8396-1-hadess@hadess.net>
         <CABBYNZK=U6xCfdKV6LHCZEmJTz+tfwq97MGCAxoXrO_o2DjTyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, 2019-05-13 at 20:38 +0300, Luiz Augusto von Dentz wrote:
> Applied, thanks. I skipped patches 2 and 5 since I want to check what
> can be done regarding of usage of pragma.

Thanks for applying those.

Cheers

