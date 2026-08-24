Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74163EC80B;
	Mon, 24 Aug 2026 07:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555611; cv=none; b=BwFyaZuIuXKqNV6tGDX3ltFDoCNJfZpJnbIYzrj6tZm4IDy5F27UViMV8l5Brxnncv+oGKw5mN2/8Fr8rCKQGnkaC2TmOGDC2c4kvd+A4TODgg6Dy6OMXOBDV/P/XqnAWM1hg+FcAmElv8QqsAu0Q/gEenY05GjU0aPQ6tNbvUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555611; c=relaxed/simple;
	bh=KgYGyKzfgqxtIgzivSptqZf2glC4PPt5W3T0cYfJAWo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z9I+W3qjgLeUyvIsTTgONc4Bq/h8MDo0BBxFvOR2sbfIAdvrpKwH+yfqWF1Q7ncYUgEDeePMLY8U4dQeFK515w/aOuMKog0XPdE11h0eUjSgJXCkFrAJYEF1yU7n2WfH36lJvUlnpSiXt7SDT6po7EUGZplTD17401JPS1aSrI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fR40m1fi; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fR40m1fi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/N
	4jKlEURceAiGz/EkfzfrY/RiKZUW+3+nM25WgHLjg=; b=fR40m1fiQycyrMh0ZZ
	y14eha/QEAT+mB/lheEh/lCHT7YmCANWGtuNMxWAXn6qRgi30QH91fsifQerADzc
	3Pp9M4Cwb+FYJbuTI9p+WBaqu5kzDGy4V6qtjTrM43NMtTZe+J3ld0aB0GgGYptq
	t5U0okEFJYrCOJJSg2KBpw/RY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wA31gL77otqUCtOQw--.27815S2;
	Mon, 24 Aug 2026 15:13:00 +0800 (CST)
From: Gongwei Li <13875017792@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gongwei Li <ligongwei@kylinos.cn>
Subject: [PATCH] Bluetooth: hci_mrvl: Fix wrong return value check of wait_on_bit_timeout()
Date: Mon, 24 Aug 2026 15:12:57 +0800
Message-Id: <20260824071257.2791009-1-13875017792@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA31gL77otqUCtOQw--.27815S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww1fCw1kWr4fXFy3ur4Durg_yoW8GrW7pF
	WYg3WqyFWDGrW3Xw1DAw4ruay5Zwn5XrWjkFn2k34fAr4YyFZ5Zry0yas8tFy3GrWrtw15
	ZF95Xr4fA3WUAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnZ23UUUUU=
X-CM-SenderInfo: rprtmlyvqrllizs6il2tof0z/xtbC4Rx4M2qL7vythgAA3u

From: Gongwei Li <ligongwei@kylinos.cn>

wait_on_bit_timeout() returns 0 if the bit was cleared, -EINTR if the
process received a signal and the mode permitted wake up on that signal,
or -EAGAIN if the timeout elapsed.  It never returns 1.

Hence the check "err == 1" in mrvl_load_firmware() is dead code: when
the waiting task is interrupted by a signal (-EINTR), the code falls
into the "else if (err)" branch and misreports it as "Firmware request
timeout" with -ETIMEDOUT instead of propagating -EINTR.

Fix this by testing for -EINTR so that an interrupted firmware load is
properly detected and reported.

Fixes: 162f812f23ba ("Bluetooth: hci_uart: Add Marvell support")
Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>
---
 drivers/bluetooth/hci_mrvl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_mrvl.c b/drivers/bluetooth/hci_mrvl.c
index 516b8f74c434..52badd1fe81a 100644
--- a/drivers/bluetooth/hci_mrvl.c
+++ b/drivers/bluetooth/hci_mrvl.c
@@ -307,7 +307,7 @@ static int mrvl_load_firmware(struct hci_dev *hdev, const char *name)
 		err = wait_on_bit_timeout(&mrvl->flags, STATE_FW_REQ_PENDING,
 					  TASK_INTERRUPTIBLE,
 					  msecs_to_jiffies(2000));
-		if (err == 1) {
+		if (err == -EINTR) {
 			bt_dev_err(hdev, "Firmware load interrupted");
 			err = -EINTR;
 			break;
-- 
2.25.1

