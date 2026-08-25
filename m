Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FACB1A704B;
	Tue, 25 Aug 2026 02:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787623358; cv=none; b=apJKv4Cjrd/od2LujHumJwrIhvivORtNaZf7MCzUbh6h1Ch4ZmWrG0duvXt4QOVYBzVjaHFO5fE7U7xnypGE7ztpLMmvsnEhsWWopsRuWFnv+H4no7cPDPgtZUrAVEtqWDms+NcdR2G5PnH30ckQw8DSVpmHa+ABqO1LHg1c62k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787623358; c=relaxed/simple;
	bh=1/yC8wPiWesaC8r1KY6givAwWlXH952mP+AN3lwcPzM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hfLDp+tIH3XRAg77mm2tGM8BVkj2HmAPoxm+Ch9iVaeipvqgAA45adr7Ec+eef1sucRfjCWHTD9pWACsgIvy9dkqcIkks/QigAPy7N76+xb2m2qcSsYCDV/lvz+aEULyDUkBdD34l/G57aPuBimqGAHtxqcik8VvgS/MY76gr/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MUM67TJz; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MUM67TJz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=e2
	jOiAtwW9prw6yKvsEap7HF2CMOGrNQ+0rvNFenW98=; b=MUM67TJzCF3xlR5YIh
	IX3jw9AnlQ5HVRuMnWEAJjZb1aETjuE96LLpe6JWGvQrTGuyOZu7H/3nhCZL/Vai
	748Qudg9nS4t/kdUCzIcVK9ad5USQ174CdHZdX4i8R25fzuaNZZZGzzJWk81/DJ8
	WSmYbk2gMmwcFQG+iSU5mI4zM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAXbyql94xqmQNmOA--.55402S2;
	Tue, 25 Aug 2026 10:02:14 +0800 (CST)
From: Gongwei Li <13875017792@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gongwei Li <ligongwei@kylinos.cn>
Subject: [PATCH v2] Bluetooth: hci_mrvl: Fix wrong return value check of wait_on_bit_timeout()
Date: Tue, 25 Aug 2026 10:01:45 +0800
Message-Id: <20260825020145.2840983-1-13875017792@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAXbyql94xqmQNmOA--.55402S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww1fCw1kWr4fXFy3ur4Durg_yoW8Wr1xpF
	W5W3WqyFWDGrWaqw1kAws5Zay5Zw1rXrWYka92y34fAr4YyrZ5AFyFyas8XFy3GrWrtw1Y
	vF95Jr43Z3WUAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnhL8UUUUU=
X-CM-SenderInfo: rprtmlyvqrllizs6il2tof0z/xtbC4gbkn2qM96bI0gAA3y

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
Changes in v2:
- Drop the redundant "err = -EINTR;" assignment inside the err == -EINTR
  branch since err already holds -EINTR there.
---
 drivers/bluetooth/hci_mrvl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_mrvl.c b/drivers/bluetooth/hci_mrvl.c
index 516b8f74c434..5798a8db016e 100644
--- a/drivers/bluetooth/hci_mrvl.c
+++ b/drivers/bluetooth/hci_mrvl.c
@@ -307,9 +307,8 @@ static int mrvl_load_firmware(struct hci_dev *hdev, const char *name)
 		err = wait_on_bit_timeout(&mrvl->flags, STATE_FW_REQ_PENDING,
 					  TASK_INTERRUPTIBLE,
 					  msecs_to_jiffies(2000));
-		if (err == 1) {
+		if (err == -EINTR) {
 			bt_dev_err(hdev, "Firmware load interrupted");
-			err = -EINTR;
 			break;
 		} else if (err) {
 			bt_dev_err(hdev, "Firmware request timeout");
-- 
2.25.1

