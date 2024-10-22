Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10951E515;
	Tue, 22 Oct 2024 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623182; cv=none; b=ALeOWof7QHPatVIPPiFY807jmaLw69nHRFhJUMmK65FV30kJgpU6gNqSpsgWpy8kNZUS0+uPnMx/lw7tURL6eFwujPSsop8vV8RaZ6PfHwjTUdZty5cYdKsQIKozQ1nfUnf5zHZSKwCvCyoEJv5aLca6+Ca0A8VgThIKGGRP41w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623182; c=relaxed/simple;
	bh=ZRajgVrhJySL80fRpZUOov5be1ZeZ5/Urojgatl320E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q010USIRL6hCumdg5CxMhXpwNonN2V2EWz54NkIaOHUQY49hr+LU5Ef4aKfdkxH1HZdQ4g4q05/V4o15TsTDIbrW9wlO69qq0xp8EN3t8VBjO/Wd95e6uGIpTnzJFu6FE2nJ9d3ojkCJjNBpNROuzyYYw7tIBN7v+Lqhdzl16iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=G5UxsCEq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="G5UxsCEq"
Received: from eahariha-devbox.5bhznamrcrmeznzvghz2s0u2eh.xx.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 40EB7210FBBD;
	Tue, 22 Oct 2024 11:53:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 40EB7210FBBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729623180;
	bh=CnXC+PCkG//lbC/zwe39ZMC1UuIDogzzgL1iMHAP9fs=;
	h=From:To:Cc:Subject:Date:From;
	b=G5UxsCEqY+ofsFa6AOzndZiXo+vLoQp/3s6k+sxJ7eDVaZu/OUWTa+S+aQT7m+7lD
	 sC7ksmMmt+VBw0qWesQxwYPgW9lJp7kv64ZaX2GW9IrREZ0OvzDtabAGB2P8y5qxeO
	 GDcMeX0kwcVtMct+M/O5OPAN8AKBQYzFYEMjG0gg=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: lkp@intel.com,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-bluetooth@vger.kernel.org (open list:BLUETOOTH SUBSYSTEM)
Cc: Naman Jain <namjain@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH 1/2] jiffies: Define secs_to_jiffies()
Date: Tue, 22 Oct 2024 18:52:30 +0000
Message-Id: <20241022185233.2079261-1-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are ~500 usages of msecs_to_jiffies() that either use a multiplier
value of 1000 or equivalently MSEC_PER_SEC. Define secs_to_jiffies() to
allow such code to be less clunky.

Suggested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 include/linux/jiffies.h   | 2 ++
 net/bluetooth/hci_event.c | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 1220f0fbe5bf..50dba516fd2f 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -526,6 +526,8 @@ static __always_inline unsigned long msecs_to_jiffies(const unsigned int m)
 	}
 }
 
+#define secs_to_jiffies(_secs) msecs_to_jiffies((_secs) * MSEC_PER_SEC)
+
 extern unsigned long __usecs_to_jiffies(const unsigned int u);
 #if !(USEC_PER_SEC % HZ)
 static inline unsigned long _usecs_to_jiffies(const unsigned int u)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0bbad90ddd6f..7b35c58bbbeb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -42,8 +42,6 @@
 #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
 		 "\x00\x00\x00\x00\x00\x00\x00\x00"
 
-#define secs_to_jiffies(_secs) msecs_to_jiffies((_secs) * 1000)
-
 /* Handle HCI Event packets */
 
 static void *hci_ev_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,
-- 
2.34.1

