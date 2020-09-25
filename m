Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E26C4363D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 16:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CEF82371F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 16:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgIYQLc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Sep 2020 12:11:32 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51661 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgIYQLc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Sep 2020 12:11:32 -0400
Received: from [172.20.10.2] (dynamic-046-114-136-219.46.114.pool.telefonica.de [46.114.136.219])
        by mail.holtmann.org (Postfix) with ESMTPSA id E7DC4CECDE;
        Fri, 25 Sep 2020 18:18:27 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v1] Bluetooth: send proper config param to unknown config
 request
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200924234422.v1.1.Id1d24a896cd1d20f9ce7a4eb74523fe7896af89d@changeid>
Date:   Fri, 25 Sep 2020 18:11:27 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <83EE8429-0454-4348-9FDA-AC275C3D5B8E@holtmann.org>
References: <20200924234422.v1.1.Id1d24a896cd1d20f9ce7a4eb74523fe7896af89d@changeid>
To:     Archie Pusaka <apusaka@google.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

> When receiving an L2CAP_CONFIGURATION_REQ with an unknown config
> type, currently we will reply with L2CAP_CONFIGURATION_RSP with
> a list of unknown types as the config param. However, this is not
> a correct format of config param.
> 
> As described in the bluetooth spec v5.2, Vol 3, Part A, Sec 5,
> the config param should consists of type, length, and optionally
> data.
> 
> This patch copies the length and data from the received
> L2CAP_CONFIGURATION_REQ and also appends them to the config param
> of the corresponding L2CAP_CONFIGURATION_RSP to match the format
> of the config param according to the spec.

any chance you could add btmon traces to the commit message to show the wrong behavior?

Regards

Marcel

