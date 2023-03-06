Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B3FC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Mar 2023 02:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCFChp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Mar 2023 21:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCFCho (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Mar 2023 21:37:44 -0500
X-Greylist: delayed 4139 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Mar 2023 18:37:43 PST
Received: from server139-1.web-hosting.com (server139-1.web-hosting.com [104.219.248.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA461EF8E
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Mar 2023 18:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gentil.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x1kviJplXpdMBSf6VtRiJNwchP2OXNavqOyQUVVXDvA=; b=nJTBsA18F7aPrKuQERQcfwfcMD
        WFMnhepDMk3ZGXbSwAe7QQtmLPLJq92GOvD7NcAsoQzWh6uxk9J/xY5+5uWxZldPuBmLVUZloEX0g
        1lr0QCa9/+H7bY4G/5f871F98SM0r8qtWSQVGqVxRrmfMcMubCAOb6T6b8MUuMu+64Q1Pj2VkpRmP
        IM2g0IG1Jfrq0irA7sZUaOfjcwLaw0HEJEP3eEePj9jVejWbH9aEkXACi1sZsW2Y+TEN//s55ScFN
        sMYamAH3Tra75JTybm9g2p7kKOOHbTzHnNrGNhC4yr+65aaMY3XkL49DA9OJnAk72CdfGiOkiDuex
        l4MWeGuw==;
Received: from c-73-162-57-209.hsd1.ca.comcast.net ([73.162.57.209]:55902 helo=[192.168.10.21])
        by server139.web-hosting.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gregoire@gentil.com>)
        id 1pYzeY-002Bbh-Jt
        for linux-bluetooth@vger.kernel.org;
        Sun, 05 Mar 2023 20:28:43 -0500
Message-ID: <bc5ba838-ecf6-f5c8-e6bf-312ce7077911@gentil.com>
Date:   Sun, 5 Mar 2023 17:28:38 -0800
MIME-Version: 1.0
Content-Language: en-US
To:     linux-bluetooth@vger.kernel.org
From:   Gregoire Gentil <gregoire@gentil.com>
Subject: How can I change the supervision timeout of BLE peripheral?
Organization: Gregoire Gentil
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server139.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gentil.com
X-Get-Message-Sender-Via: server139.web-hosting.com: authenticated_id: gregoire@gentil.com
X-Authenticated-Sender: server139.web-hosting.com: gregoire@gentil.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I have a pure C application running on a BLE peripheral and it uses 
bluez code especially the code base of hcitool.

In le_set_advertising_parameters_cp, I see min_interval and max_interval 
but I don't see any supervision timeout field. Is there another 
advertising parameters (extended???) that features supervision timeout?

I'm aware of the following code in hcitool:

hci_write_link_supervision_timeout(device_handle, 
htobs(cr->conn_info->handle), timeout, 1000);

But in my own code, I don't manage to get the handle of the central 
device once the connection has been established - I'm also wondering 
whether if it's not too late to change supevision timeout after the 
connection. "ioctl(device_handle, HCIGETCONNINFO, (unsigned long) cr);" 
fails with a "no such file or directory" error though I'm sure that the 
central device is connected.


How can I change from user-space the supervision timeout?

Thank you in advance,

Grégoire
