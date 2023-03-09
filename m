Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6356EC64EC4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Mar 2023 18:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjCISNS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Mar 2023 13:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCISNR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Mar 2023 13:13:17 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA233754F;
        Thu,  9 Mar 2023 10:13:15 -0800 (PST)
Received: from fpc.intra.ispras.ru (unknown [10.10.165.5])
        by mail.ispras.ru (Postfix) with ESMTPSA id 3811A4077AED;
        Thu,  9 Mar 2023 18:13:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3811A4077AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678385591;
        bh=HVqvyl8y47GICEAeU8bzjA7y0Iyh69I9Q3lDJZgwxmA=;
        h=From:To:Cc:Subject:Date:From;
        b=g5uwSfk5qihf/jFzSjxxwfl03meMsZsdP7N7N98BTWWAShGy8SSF74+9UbDemzkfX
         MJndm6mgi/IHatEZTUQrPLQs2eqI+gnhbq8X/PRPRMMP5AUvqHQsaQ/+LSmUcwHXxs
         1/BvWBfEPErC+mKOkSMnXj8Ui9T6ciCbi9UCd4Sw=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Marcel Holtmann <marcel@holtmann.org>,
        Nguyen Dinh Phi <phind.uet@gmail.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: [PATCH 4.14/4.19/5.4/5.10/5.15 0/1] Bluetooth: hci_sock: purge socket queues in the destruct() callback
Date:   Thu,  9 Mar 2023 21:12:50 +0300
Message-Id: <20230309181251.479447-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Syzkaller reports a memory leak in mgmt_cmd_complete(). The issue can be
triggered on 4.14/4.19/5.4/5.10/5.15 stable branches. The following fixing
patch can be cleanly applied to them.
