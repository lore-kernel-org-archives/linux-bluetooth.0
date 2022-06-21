Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC04C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 04:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343662AbiFUEbs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 00:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbiFUEbr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 00:31:47 -0400
X-Greylist: delayed 56280 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Jun 2022 21:31:45 PDT
Received: from smtpproxy21.qq.com (smtpbg703.qq.com [203.205.195.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FADB7FD
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jun 2022 21:31:45 -0700 (PDT)
X-QQ-mid: bizesmtp75t1655785900tfvdiqrr
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 12:31:35 +0800 (CST)
X-QQ-SSF: 01400000000000D0G000000A0000000
X-QQ-FEAT: cwL8yz+KJ/asnA4U/E8IQY6//P/cJ80d/z8df4hMixvK77ac/bU2UNcSaOeqt
        FM6DthTZIlhF+4DRFkDSqiM2tP5mN/TSA3V9W8OExYf6aq085HwcBw6pLrdJ6F7ZNrWVzAc
        CXMJeouwSByi6OtKo9FITugf4vVLqdfiA9vm7SXQVGvC9ndPis56mj/nkU2CSqPvw6zxdbX
        81qzDuPR08Ma3GHH8HwR23yrDnZI3jYpbmIdiLrKpqfqo4l6ZcdSGvQC/+t6AUhbtdf2fEp
        ezQ7a/3mk9aYM9mtOEFxIMdqF+iCIAQpkr3q5ztlJk8etZJN/ZmvHUtVFWtmlvxvbAXA==
X-QQ-GoodBg: 1
From:   Chengyi Zhao <zhaochengyi@uniontech.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Chengyi Zhao <zhaochengyi@uniontech.com>
Subject: [PATCH BlueZ 0/1] avdtp: Free discover when send_request returns error
Date:   Tue, 21 Jun 2022 12:31:32 +0800
Message-Id: <20220621043133.7720-1-zhaochengyi@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign8
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When send_request returns an error, session->discover should
be released here, so that the next time the program enters
avdtp_discover, the -EBUSY error will not be returned.

Chengyi (1):
  avdtp: Free discover when send_request returns error

 profiles/audio/avdtp.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.20.1



