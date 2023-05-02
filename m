Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8421AC77B7E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 14:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjEBO6H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 10:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbjEBO6B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 10:58:01 -0400
Received: from pku.edu.cn (mx18.pku.edu.cn [162.105.129.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDD1A273A
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 07:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=SLvP7Rm0p5
        mMK0mIr4FQLnN1i0z9DL3Tp3K+tqe/eIA=; b=h8e+Y7xfH0Bih7X/qKBRVcpnhw
        iXeAQFBCKI++TF6ME64yAPLRPbwyxNJzCWG9AsvCLCILupIdcVTOH/PlODzy8O5Q
        a6RaF5CzTZETWUy6u6UfrvwwMQ9w6pPk0EfFhX+IDwPe46Pq20uH2jNp6/gDaYis
        nbRv/mu898gkv/Crs=
Received: from localhost.localdomain (unknown [10.7.101.92])
        by front01 (Coremail) with SMTP id 5oFpogBXX5fjJFFk6i5LAQ--.10226S2;
        Tue, 02 May 2023 22:57:46 +0800 (CST)
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ruihan Li <lrh2000@pku.edu.cn>
Subject: [PATCH v3 0/6] Bluetooth: Fix potential double free caused by hci_conn_unlink
Date:   Tue,  2 May 2023 22:57:31 +0800
Message-Id: <20230502145737.140856-1-lrh2000@pku.edu.cn>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 5oFpogBXX5fjJFFk6i5LAQ--.10226S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1kZw1DCr1DZry8tF4ktFb_yoW8Xw18pa
        y3uas8Xa1kJrySqr43Awn7WrWFqws5Zryakrn2q34rJ3yYva18AwsY9Fyj9rWDurZ7GF10
        yF1ktrnrKF1DArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6c
        xK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svP
        MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Kr1UJr1l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjfUFYFADUUUU
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEPBVPy77wh+AAWs0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch series contains six fixes related to hci_conn_unlink. The
purpose is to prevent merge conflicts between each other. I'm not
intentially linking them together. So if any patch is not suitable,
please just let me know (I'll be grateful if you can explain the
reason).

The first three patches are the most important, each fixing a
triggerable use-after-free bug (see the report URL for details). And the
fourth through sixth patches are a bit more minor, containing mostly
tweaks and refactorings.

Changes since v2:
  * Put all fixes, adjustments, and refactorings about hci_conn_unlink
    in one patch series.
Link to v2:
  * https://lore.kernel.org/linux-bluetooth/20230430180535.168270-1-lrh2000@pku.edu.cn/
See also:
  * https://lore.kernel.org/linux-bluetooth/20230430171847.156825-1-lrh2000@pku.edu.cn/

Changes since v1:
  * Resolve merge conflicts.
Link to v1:
  * https://lore.kernel.org/linux-bluetooth/20230430172937.157999-1-lrh2000@pku.edu.cn/

Ruihan Li (6):
  Bluetooth: Fix potential double free caused by hci_conn_unlink
  Bluetooth: Refcnt drop must be placed last in hci_conn_unlink
  Bluetooth: Fix UAF in hci_conn_hash_flush again
  Bluetooth: Perform hci_conn_drop in hci_conn_unlink
  Bluetooth: Unlink CISes when LE disconnects in hci_conn_del
  Bluetooth: Avoid recursion in hci_conn_unlink

 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_conn.c         | 96 ++++++++++++++++++--------------
 2 files changed, 54 insertions(+), 44 deletions(-)

-- 
2.40.0

