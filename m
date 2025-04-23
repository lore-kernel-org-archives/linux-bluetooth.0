Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA5B1F3B83;
	Wed, 23 Apr 2025 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745407244; cv=none; b=Pa3MgOl2b2TByHI0XqX7R9afrAFe/BsoVcW5FwjaHBpOWhHn2ApnBecMeeKFQSMBNUpGYm9BgmGUOSJSZQOXqfMYjaC/kJgk8s4wdcMyCR78oLmsOCY9Yi2nTOx5XUz0MIEVHGc7FDsk5G/xgOwu0SpblpTaZnmIyMQZER/Myxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745407244; c=relaxed/simple;
	bh=wZMn6aYHO6bxSszB5o+LjAjxWqasCK3x54vLi7nS+oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saxONJzoNoOJE4jaFma43SdXISoHCHRjYFIjInMJiaXYxycjxFp8sh7vINO63NXiSxpZppLh4tCGMvXycbr3nHnEiCn083l9nrQ4VAEPaU28DjgEflntvsBjV4UfXgO54NWqPL0IhpPE1ayKNki0ZoblIaQ6SgdiSiNzg+ucRqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a01:e0a:3e8:c0d0:d851:318b:70da:57a7])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id D221B33E03C;
	Wed, 23 Apr 2025 11:20:38 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a01:e0a:3e8:c0d0:d851:318b:70da:57a7) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=arnaudlcm-X570-UD..
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
Cc: johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	syzkaller-bugs@googlegroups.com
Subject: syz test
Date: Wed, 23 Apr 2025 13:20:29 +0200
Message-ID: <20250423112029.189032-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <67ee633c.050a0220.9040b.0187.GAE@google.com>
References: <67ee633c.050a0220.9040b.0187.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <174540723926.13106.4896757570339174931@Plesk>
X-PPP-Vhost: arnaud-lcm.com

#syz test

--- a/net/bluetooth/coredump.c
+++ b/net/bluetooth/coredump.c
@@ -249,6 +249,11 @@ static void hci_devcd_dump(struct hci_dev *hdev)
 
        size = hdev->dump.tail - hdev->dump.head;
 
+       if (size >SKB_MAX_ALLOC) {
+               bt_dev_err(hdev, "Dump too large (%u bytes)", size);
+               return;
+       }
+
        /* Emit a devcoredump with the available data */
        dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);

--
