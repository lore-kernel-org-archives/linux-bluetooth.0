Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CF0C433E3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 16:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 638CC619A6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 16:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhCVQrV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Mar 2021 12:47:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229703AbhCVQql (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Mar 2021 12:46:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D5436157F;
        Mon, 22 Mar 2021 16:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616431601;
        bh=aaRmjBEwVOgZ5jrusxYFiRwZAqfg3gWemKkKVk2egp8=;
        h=From:To:Cc:Subject:Date:From;
        b=cnr/pAqvMDO2kAK5qrCLy3aHTrBnZ4UOLCqwoYRq8acPF470NUUYZ/rG+Rzag7X8x
         ouzwomg3hzaDDRKBh+WGYXfSGBrGT/S+pwQ/JzFX4kOHkz8vizdOLDBPLa+dUHOVUy
         QUhqZcu6VqgzfK45Z3GYoTQPmLf5zkmbaO3Cv+/QeiIF7m4Q2ZfDCSG11+5e5F0nbG
         +IMtiD6NIJAI3eILwQK7bwD5vFp7PZqObyjiCl8etbflAm+m0LaAYtY1DDx5BUpFG9
         tdwqnirNOKAXDntPqDhVaqNRIxc+Io6ztHfpexHjNpsxjD4UljhE2Nh3sD+VMWaTFl
         RDv2h0VHBfyHQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth: fix set_ecdh_privkey() prototype
Date:   Mon, 22 Mar 2021 17:46:30 +0100
Message-Id: <20210322164637.941598-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc-11 points out that the declaration does not match the definition:

net/bluetooth/ecdh_helper.c:122:55: error: argument 2 of type ‘const u8[32]’ {aka ‘const unsigned char[32]’} with mismatched bound [-Werror=array-parameter=]
  122 | int set_ecdh_privkey(struct crypto_kpp *tfm, const u8 private_key[32])
      |                                              ~~~~~~~~~^~~~~~~~~~~~~~~
In file included from net/bluetooth/ecdh_helper.c:23:
net/bluetooth/ecdh_helper.h:28:56: note: previously declared as ‘const u8 *’ {aka ‘const unsigned char *’}
   28 | int set_ecdh_privkey(struct crypto_kpp *tfm, const u8 *private_key);
      |                                              ~~~~~~~~~~^~~~~~~~~~~

Change the declaration to contain the size of the array, rather than
just a pointer.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/bluetooth/ecdh_helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/ecdh_helper.h b/net/bluetooth/ecdh_helper.h
index a6f8d03d4aaf..830723971cf8 100644
--- a/net/bluetooth/ecdh_helper.h
+++ b/net/bluetooth/ecdh_helper.h
@@ -25,6 +25,6 @@
 
 int compute_ecdh_secret(struct crypto_kpp *tfm, const u8 pair_public_key[64],
 			u8 secret[32]);
-int set_ecdh_privkey(struct crypto_kpp *tfm, const u8 *private_key);
+int set_ecdh_privkey(struct crypto_kpp *tfm, const u8 private_key[32]);
 int generate_ecdh_public_key(struct crypto_kpp *tfm, u8 public_key[64]);
 int generate_ecdh_keys(struct crypto_kpp *tfm, u8 public_key[64]);
-- 
2.29.2

