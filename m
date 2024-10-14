Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121B614B08E
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896838; cv=none; b=PlfyEMhs25QFY2+5Mgn8K5jFZYWAajpgNAGANAzfjck7wC2p3Ko1MlElFwe8hLsdQVwBtjN6WbPH/9OnsZTii0PWiR4NaUto7dU2GnYJljcQY0pjFtDjXoR8sJvbzHeCpnMlG/BwnTNS5KrOAUDNBa6rZm3Y/wX97gEfrdnZsZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896838; c=relaxed/simple;
	bh=YGEjbL3d6Li6hEcrP0HmPpWI1kxi5EGLcTX44xzU4c8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WAURYGxM5rpMd2VfWNRr7siSWbx2bMlP6ygZ6xu/vRPsXL2T3PYVh/EJURko9AMtjTEXxuCoSICr3TbvlAjJq9atmb7CfMmipFIlQah6E09MZmFdjXadn96HOTQXjyTmQ+cFFFniimMM7WibqSIBl2YhdrQkI8i2I77jmxSKBEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XRrvc3hKCz4f3lDq
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 17:06:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 54D631A06D7
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 17:07:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
	by APP4 (Coremail) with SMTP id gCh0CgDH+8c83wxnB+M8EA--.48175S4;
	Mon, 14 Oct 2024 17:07:10 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	ricardo@marliere.net,
	linux-bluetooth@vger.kernel.org,
	viro@zeniv.linux.org.uk
Cc: yebin10@huawei.com,
	zhangxiaoxu5@huawei.com
Subject: [PATCH] Bluetooth: bnep: fix wild-memory-access in proto_unregister
Date: Mon, 14 Oct 2024 17:07:08 +0800
Message-Id: <20241014090708.3818916-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+8c83wxnB+M8EA--.48175S4
X-Coremail-Antispam: 1UD129KBjvJXoW7XFW3AF1kZry5KFyrAw17GFg_yoW8Jry3pr
	W5GF43ArZ5urs2kF4kJas7JF95G39FgrWj93Z5uF95AFnxC3yqgw18KrWYvFn8CrWvkFW5
	CFyxtrsxAas8C3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

There's issue as follows:
  KASAN: maybe wild-memory-access in range [0xdead...108-0xdead...10f]
  CPU: 3 UID: 0 PID: 2805 Comm: rmmod Tainted: G        W
  RIP: 0010:proto_unregister+0xee/0x400
  Call Trace:
   <TASK>
   __do_sys_delete_module+0x318/0x580
   do_syscall_64+0xc1/0x1d0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

As bnep_init() ignore bnep_sock_init()'s return value, and bnep_sock_init()
will cleanup all resource. Then when remove bnep module will call
bnep_sock_cleanup() to cleanup sock's resource.
To solve above issue just return bnep_sock_init()'s return value in
bnep_exit().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 net/bluetooth/bnep/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index a3bc0934cc13..d44987d4515c 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -745,8 +745,7 @@ static int __init bnep_init(void)
 	if (flt[0])
 		BT_INFO("BNEP filters: %s", flt);
 
-	bnep_sock_init();
-	return 0;
+	return bnep_sock_init();
 }
 
 static void __exit bnep_exit(void)
-- 
2.34.1

