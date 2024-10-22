Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D271C460E;
	Tue, 22 Oct 2024 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623241; cv=none; b=CSmzQtC1VzgqxCamZnLhdR5AKxxHsI9BL9XDELKqwPNDz13xSBc66cWY+lSvbJchwVlIv/JqKmve8/LRiS2h4aWu21hMRnUgpB9fFk46IXIYlttYgssmm6h0QVJxli44DWV5rDgwh9GbLmH1ekCMXgdzXQwmz2J+h4EtQ/53PDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623241; c=relaxed/simple;
	bh=ZRajgVrhJySL80fRpZUOov5be1ZeZ5/Urojgatl320E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N1nQ/OQUPt/ZMMlDBFQKHzDano5zpTf/yY4WXLtqIxO+f2A8R44oYTIzh4qq9ZaIo/jg1GsobKL4YRtnybTRqHS3EhC4tOQbqf9fDGnYtk7ijFPS4yVQ/iDB11Gdp6SeEWJvxV6s+8rIldgBl9nyaWViHWji9ZSIxUvRgl8kZRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Gcx/WplC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Gcx/WplC"
Received: from eahariha-devbox.5bhznamrcrmeznzvghz2s0u2eh.xx.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1A482210FBBD;
	Tue, 22 Oct 2024 11:54:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A482210FBBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729623240;
	bh=CnXC+PCkG//lbC/zwe39ZMC1UuIDogzzgL1iMHAP9fs=;
	h=From:To:Cc:Subject:Date:From;
	b=Gcx/WplCGorSonlJyKO4jekXbMEJ47wHVNj8MomUFZV2KXS78RGEZJ+3Sp9olOrnO
	 RU2r9Az6+X2fQ5EfQw+NeOIhJctbp65MVUJlEAO2Y6/tKzEBPmzmkmV0pkagcbVMR6
	 swwM/YN+V++9ZJeALxsuxyNdhOtT3ex7kfw+qJVA=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: lkp@intel.com,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-bluetooth@vger.kernel.org (open list:BLUETOOTH SUBSYSTEM)
Cc: Naman Jain <namjain@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH 1/2] jiffies: Define secs_to_jiffies()
Date: Tue, 22 Oct 2024 18:53:49 +0000
Message-Id: <20241022185353.2080021-1-eahariha@linux.microsoft.com>
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

