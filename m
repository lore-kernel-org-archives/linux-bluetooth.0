Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06B42C0F91
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780345298; cv=none; b=QnR4cO/o068Dq2UZUHruJZKdD8Z3/kQezZClJSRgswKouD9snRzjZLpjRzX4IrrXlbujgB5eDhFwksJP2lIj/wuV4EYQ8L+1H4QsykpZdYAuc6kHVRTicB4g2Wp/dWuxbgh0LaQLWX4UBfWXznWzK/ob11j9UZVOsJaNn/sO3Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780345298; c=relaxed/simple;
	bh=SoGx2tdRAIU43n3AzbiYXWzU5ajML/+4Fbwa1DcEiqU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ZEdMwC3PVkC00wiH9xz4qNdzgizCoTa5nNsfJ/GOTWnfHSoEMWG06IgRfwerbS7TLztj2v1128+n4gn3//2y/fY6Lhw9lzavCbhAQGSZA1gd0thi5n6+FckRMejUiDS7HepgCgkXxMTsvE5fNbjk+k/YDWxwjQ9cuShxViWS/KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.78.2.227) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 1 Jun 2026
 23:21:31 +0300
Message-ID: <4f997f21-786e-4745-80c1-0d6da94c0d48@auroraos.dev>
Date: Mon, 1 Jun 2026 23:21:30 +0300
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Subject: [PATCH] Bluetooth: hci_h5: reset hci_uart::priv in the close() method
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

Unlike the other HCI UART drivers, the 3-wire UART driver doesn't reset
hci_uart::priv in its close() method -- this shouldn't pose a problem as
all the methods in *struct* hci_uart_proto should only be called after the
open() method that sets up hci_uart::priv properly. However, it seems wise
to be more consistent and provide for the *struct* hci_uart_proto methods
the same state that exists before the first open() method call (so that
they rather crash than dereference a stale hci_uart::priv pointer)...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

---
The patch is against the master branch of the bluetooth-next.git repo.

 drivers/bluetooth/hci_h5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index d35383718212..c6d9f70ad3bb 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -273,6 +273,7 @@ static int h5_close(struct hci_uart *hu)
 	if (!hu->serdev)
 		kfree(h5);
 
+	hu->priv = NULL;
 	return 0;
 }
 
-- 
2.54.0
