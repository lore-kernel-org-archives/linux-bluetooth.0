Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE07423EAB;
	Fri, 14 Aug 2026 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694506; cv=pass; b=EN5LIKqAMTnvpcXxG3P8R7fIjH1kZRVF6Lsk2rb6PBuApK+dTiNexAFUcKGUwGcU+Sk+bo7/Kskto9L/M18+nSo8o3BOjczdIE4JMNsIuNPJbJtNkYPDBrVJQyaD5yH1Uv7na7oAUKMVUoKQHfG4cSkT3FAq9ylHn+qTYAF7s8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694506; c=relaxed/simple;
	bh=W5dxJDOzAM3tcsXA/iPjhcNyAow+F3SHRhAYj+3Uk+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BEzjtI3NYvRbV0qIiT78ELAgsOH3qSiTMZdyw/iw2bBJRPGnl3LytjjuPKtjsHtEtTqEh6SxlLaAGTpUaiNGxf9jWFK7WcWCDd6Zuch3jQ3M6Cb48Gf4oT2l2jiIsXCQAsxrHtaRIGdLDBjoR8wYAhxNmt6I9ZqbwmaaBgZd5MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=PtEGniIn; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="PtEGniIn"
ARC-Seal: i=1; a=rsa-sha256; t=1786694495; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=K9lW1x9mNwZaPCCx09lU2ckg+Dv/ONoHDyJaIlFTMv16Tv+urI0ZyTYdZY6sLLB6TK2uMnYGb7juj1L5T+/Tw+kIBl8v0iKADfu2l6vfUib84EYDVQRjlRh7Y09cnk1qisHfbJqerRrIYez4FN4AybBDCnZv4tP7t7soCE+P+BA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786694495; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TvNsJVo2hEgo72fT3oFcUPVj8fF+ifdaKQ8hp0UHgHs=; 
	b=dsiM5bOIh5ohXUc9ERXfTqUosei4Ts2C6/rt1JkPk/DPGD59T/eQhLWM9bJrEGzcQW7n5mlKg0Z/Xn0ooQWXcWI5WDbCRBmI8UWkuDE8bj4CLDgp/30Ids601kpzptFEYCqJZQm3Ez0O8dX+xHnKEizeUpJ9Y7cMjPa+pnZeyLQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786694495;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=TvNsJVo2hEgo72fT3oFcUPVj8fF+ifdaKQ8hp0UHgHs=;
	b=PtEGniIn/SUp3nDzgDHtQ0z2SGmhbY++AEkPDwKXWRexkgWeSo7lZHb8s3eJBXtu
	MxJxclBacA6sDm/7hoqvHssA5RRE7qfiMozqSWumEqNiboUV20ok6kY1svvAEI6v/k6
	VbqXBbNu1UJds3EuyCi6gQkJVgtI6UCWWn2oyS6k=
Received: by mx.zoho.eu with SMTPS id 1786694493210587.942943335904;
	Fri, 14 Aug 2026 10:01:33 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: johan.hedberg@intel.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel: Bound exception info print to the received length
Date: Fri, 14 Aug 2026 08:01:22 +0000
Message-ID: <20260814080123.902388-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

btintel_hw_error() validates that the Intel exception info response is
exactly 13 bytes, and then prints the 12 bytes following the status byte
with a plain "%s". Nothing validates that those 12 bytes contain a NUL,
so the conversion can run past the end of the received response and into
whatever follows it in the skb.

Bound the conversion to the length that was actually received.

Fixes: 973bb97e5aee ("Bluetooth: btintel: Add generic function for handling hardware errors")
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 drivers/bluetooth/btintel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index bf567b7c5f00..4112f39f251f 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -288,7 +288,9 @@ void btintel_hw_error(struct hci_dev *hdev, u8 code)
 		goto unlock;
 	}
 
-	bt_dev_err(hdev, "Exception info %s", (char *)(skb->data + 1));
+	/* The exception info field is not guaranteed to be NUL terminated */
+	bt_dev_err(hdev, "Exception info %.*s", (int)(skb->len - 1),
+		   (char *)(skb->data + 1));
 
 	kfree_skb(skb);
 
-- 
2.55.0

