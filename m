Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBF837E301;
	Tue, 24 Mar 2026 02:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774317906; cv=none; b=EBJhEHOMGG8E/hNHBdXpFukbaQ5AgsKI8445Uv1m49fGvnaGZlKd/wtYxiiWLiwf90JLnsex6oqr1YxSuXF8xzvJzzyRTkM+EBsZ6CfZZN/H4wxiZ31rOhBUcYP9Mmdx0UJURes1O9dcFjrbB87yHWQMspB7pKqs3ARfCCF+tMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774317906; c=relaxed/simple;
	bh=D+uv1H3IolAu3p1D0s7Jq8lemZJQ8aMMCO3az0GtEto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D767THYCPoOaOvoMHav2yi/6OjWbNUAPGvz40V4FCdU4Ml6wTtUF2WHD6o0ozBDpTUo0Fb6JlxsB2f8phhf/Gg8QNk92C3iOxwwIo0zBXr5o9KDmAqVU2XspfLFNnkzZexh/XCmoe7610ZbQoSlqKxmAoraQIe8KT5+NST4tqSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-05 (Coremail) with SMTP id zQCowADXbBAr8cFpRhFKCw--.57736S2;
	Tue, 24 Mar 2026 10:04:54 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] Bluetooth: btusb: clamp SCO altsetting table indices
Date: Tue, 24 Mar 2026 10:04:27 +0800
Message-ID: <20260324020427.60125-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADXbBAr8cFpRhFKCw--.57736S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AryDGrW3tw1UCr1xArWrZrb_yoW8GF17pF
	W8Ka4Yyrs5JFs0ya1UXr4UuayFga1rXrW7Gry5C345uwn0q34xAF48KrWjyr97CrWSgw4j
	9F4Y9rW5Ga1DCr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUehL0UU
	UUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

btusb_work() maps the number of active SCO links to USB alternate
settings through a three-entry lookup table when CVSD traffic uses
transparent voice settings. The lookup currently indexes alts[] with
data->sco_num - 1 without first constraining sco_num to the number of
available table entries.

While the table only defines alternate settings for up to three SCO
links, data->sco_num comes from hci_conn_num() and is used directly.
Cap the lookup to the last table entry before indexing it so the
driver keeps selecting the highest supported alternate setting without
reading past alts[].

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/bluetooth/btusb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a1c5eb993e47..870a6aa92216 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2376,8 +2376,11 @@ static void btusb_work(struct work_struct *work)
 		if (data->air_mode == HCI_NOTIFY_ENABLE_SCO_CVSD) {
 			if (hdev->voice_setting & 0x0020) {
 				static const int alts[3] = { 2, 4, 5 };
+				unsigned int sco_idx;
 
-				new_alts = alts[data->sco_num - 1];
+				sco_idx = min_t(unsigned int, data->sco_num,
+						ARRAY_SIZE(alts)) - 1;
+				new_alts = alts[sco_idx];
 			} else {
 				new_alts = data->sco_num;
 			}
-- 
2.50.1 (Apple Git-155)

