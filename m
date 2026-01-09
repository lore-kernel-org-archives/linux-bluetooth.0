Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F8421D00A;
	Fri,  9 Jan 2026 01:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767923929; cv=none; b=MT76xhM2E0SVKuLaFrIUe//x8qld0iKmkxL5eXdwgrZiW7HfYppvGIuYhUKBX9L7FXHVSqdxZEwJsHvx8GUXp4Sph1ZEuHpfwzsan3eW4ZV+8GZhmPmRh8+vVRo0qiXngXrrSYPxlacKZ67x/hbP89Nk+PrQDtRiVzT0TcI007A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767923929; c=relaxed/simple;
	bh=sh04KFXiGBF0F4O65VrTjth/gScegt7TGOCGgeAbjVo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=WygsM/yKA7RBH9v0+Ca7XRVOmGT/XFFQW1lHd8epnvWn097gIZtn5TLESW7KA131W1tXqGdkSof+T+QMBW70dXuIhDTHizdPLLdSmOUPy1a/uCz4BS8kYmmg4Npp/789y3u4eMmiydVlFFkLvrZQCyivc7GWv4TyJtc8RgG9EFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=FdWo2Co2; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="FdWo2Co2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1767923918;
	bh=MkGOptT6n9lgaECJhQqt8LxNvssRq3HY2avAzKHe5HY=;
	h=From:To:Cc:Subject:Date;
	b=FdWo2Co2/d0U17IO5SJXLQhdHMN/7VIY6KBMlIKcwOae/curiPo9uainLJ8uHSUko
	 G23314f5fUDbt/gQ8on2qSmP1eYfPqWMUYPCFC6XHl30fkTyrY40kV2G6tvhKZd9sc
	 ALvNHXEmelkA+EkDoXcvsSd+OQM978JRg55pwTAk=
Received: from 7erry.customer.ask4.lan ([31.205.230.119])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id E5939275; Fri, 09 Jan 2026 09:57:25 +0800
X-QQ-mid: xmsmtpt1767923845t54o9e7ab
Message-ID: <tencent_2FAB909645504A5E0FDC88F125E139242C05@qq.com>
X-QQ-XMAILINFO: Od++Svt5p/ChRmnKU+pQFNZ/OUsRx5rVKW4kVm91aWFuc5bFQdoHchLIjXueBR
	 a0DC79VTj+l0wM8Zqz4jp83vCTtfIIfG3A7CXXlVDw0VZ1YQ7Mjz9i5Lz39gisZ4SJEmqgHc5beU
	 JloIylZNFnlcRx2Ls42Otq8Fvv3w+BeX3VMKMtVGz68tdcLw3rrLId2ccHq1/Sn2YvZ7XQSFQKHi
	 ObkYj3vDxHf3QF5Dilt80XPtr73yNcg6ovvDT9JlpQw7k8gAew7gyJzQjTdu+1CrtQitbIzs1++z
	 epdExbrg7i7K7DD7GTfsHJVzadpVz0RrmuizGJZKNCmnNYT3DzmmPxH1vQHaZoRpewWp2GL9Z9zO
	 KyNi+7eb7I8hjXOVRMtbgPY2QUNCY+jjsbJNtUiEdxXGBvgV/9bROHG6vEuXsdDTNNl+m6EXgJxj
	 gqZFF1CtnV069oEiGaUDaB6yvVyvlW/Ib1UGvMVGY/ki7cRi32c8FaykSXWcVysEdRVuw3shGA5N
	 BE++Y0O5xf/7PcHHtM8Psswz42TAaX41MpdISKfJ8kmr/cvFgPxMX8HS2mgVhOXRHcPNZ06u7q4+
	 VOS4Ie4A40qRrwUtdLewQDDX9cFen15FVqSCDBX4kCMrpt/+rmNC07Y/nE6c14HE+3uF/JISnbx8
	 tPCLj24o6suWuvZFI+BUvtKez9PvM6OVXhPmA3Y/Pdc1Iu5u6qKBHjtZI++iXyV6KNSZfpJ/EPDr
	 /W+cMXO7pYxAveXkZYkdATWuf04K1DxqCPM3D8f3rlZQUeBPau8ekQvySmMYQeFUGrL1iGlvp0xP
	 ijRBDRkLhVON7++AxUqLQrJ6fdQJi+hEJt7hyQECJL87v3gjLaTaiIwDRNnAWHyxWLtej8ejRaA/
	 uS8OdcT3YRMxEmPylNSnEx23RgyhkLgeBQi5RK0bssHUpdAXk9OX30Y2MJ5vQdwT3DIylHwuyWSh
	 1NSqgdMIGT6LXSE8bCYeVKiqd25DTFazR6X7nwkXbl5hIJhUloHneuLXLwXwYGISdcZtjNl9jeta
	 UPwUurcYirCQGkzZBZyBnnRzVN3BpByEyW1g+6tQhbcaNJZzAjpbmTHmy7dCk=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Jerry Wu <w.7erry@foxmail.com>
To: marcel@holtmann.org
Cc: johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	w.7erry@foxmail.com
Subject: [PATCH] Bluetooth: Perform careful capability checks in hci_sock_bind()
Date: Fri,  9 Jan 2026 01:57:18 +0000
X-OQ-MSGID: <20260109015718.44203-1-w.7erry@foxmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, the HCI_SOCK_TRUSTED flag was set in hci_sock_bind() by
checking capable(CAP_NET_ADMIN). This function verifies that the
current caller of the bind system call has the required capability.

However, this approach is vulnerable to a "confused deputy" attack. A
malicious unprivileged program can open an HCI socket and deliberately
share it with a privileged task (e.g., via file descriptor passing).
If the privileged task is tricked into calling bind() on that socket,
the capable() check will pass, and the socket will be marked as
trusted. The original unprivileged program then retains access to this
now-trusted socket, allowing it to perform privileged operations.

This issue mirrors the vulnerability previously identified and fixed
in hci_sock_ioctl().

Fix this by using sk_capable() instead of capable(). This ensures that
both the task performing the bind and the socket opener must have the
CAP_NET_ADMIN capability before the socket is granted the
HCI_SOCK_TRUSTED status.

Fixes: f4cdbb3f25c1 ("Bluetooth: Handle HCI raw socket transition from unbound to bound")
Signed-off-by: Jerry Wu <w.7erry@foxmail.com>
---
Commit 25c150ac103a ("bluetooth: Perform careful capability checks in hci_sock_ioctl()")
fixed CVE-2023-2002. hci_sock_bind contains a similar logic. Would it make sense to
fix it in the same way?

Thank you for spending time reading this. Apologies if I missed anything.

 net/bluetooth/hci_sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 4e7bf63af9c5..2bab2532dd9a 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1259,7 +1259,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr_unsized *addr,
 			}
 		}
 
-		if (capable(CAP_NET_ADMIN))
+		if (sk_capable(CAP_NET_ADMIN))
 			hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
 
 		hci_pi(sk)->hdev = hdev;
@@ -1427,7 +1427,7 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr_unsized *addr,
 		 * untrusted users the interface is restricted and
 		 * also only untrusted events are sent.
 		 */
-		if (capable(CAP_NET_ADMIN))
+		if (sk_capable(CAP_NET_ADMIN))
 			hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
 
 		hci_pi(sk)->channel = haddr.hci_channel;
-- 
2.52.0

