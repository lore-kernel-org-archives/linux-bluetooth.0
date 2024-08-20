Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB717BB7
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724163447; cv=fail; b=MtDGHxaN+SKc+rZaN2I+eMC3UbZ8OaTAwe+OsriF7h4I6sq471nGTkE4u4QxO8Km1JSISketQcZP9n8H/5J6NnE73qppCucoCfE2g13U2rFFR5UQy0fN8TghZApdMmYyf1GkUff/chcfQTzmfYP/JUc7ItPROCpYYa9fp5hTEVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724163447; c=relaxed/simple;
	bh=UuQPTYW+bybpujRHxJxn5OmBJd55josY0QzIq9BYSOw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Type; b=BH3bzpUjw4YhPyNuVmvtHm1np3WYJX3AbALhkQdLgQlus4HQHmR4yp3XoPkYcN1FC9PTj8gWfP7/mN6WZxNZj9yROSeTomXbAw4gQR1Yf0bY+5nWn5tbcc2PKcKACRUhbGHIKXjcPnhh/nMydtje6gVdR1fh6djF1Cd0LjWfXZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=fail (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=kRBeHukq reason="signature verification failed"; arc=fail smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="kRBeHukq"
ARC-Seal: i=1; a=rsa-sha256; t=1724163440; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NSxmas7GdptCTTY//fFWB1iecTpumZJA3f7cAW46gXS+QKoqzvosJzqMMMwtQLvvQ4KymsG39QK27Rf3Xk8fVOFhpHIBMDJMqhn+97qUcVf/n1uE7PBB8j+dnUx+Tm5ViuM9kiW2z/tcwZOMuQDDaAXtjA2MPpyMbTQB6iGonH8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724163440; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=oIdrJ/ZYp4Q1TpVorZDXWeXTpGpIHF1IQsvqx2cJsiU=; 
	b=m/0vtlxGtSNe2YAd9GvaiFPYKg6AMXRe5kMlXlDPQmqyGHRJwMptdvEcx+LpeZo16dbLt1O9UWbjDKI3GoK1vFihnV8Kjzrfnj3MJlidw/h2eqKwqMwqo74UOTMyFvJoywvdu3YyrmBxvMv5CpLYjcJEDoIWax5XlHU0e1+Rix4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724163440;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Reply-To:Cc;
	bh=oIdrJ/ZYp4Q1TpVorZDXWeXTpGpIHF1IQsvqx2cJsiU=;
	b=kRBeHukqPuVecj4JZs/OF+woJfrbGFGU7iXxV7SjakHTk6HwciUHgUwXOZFwCTnR
	7yPbHxaEVnm1+dG0nMwkdoQl3Qud2n/OCH1JiPPzJ0CYnyjLnwinL0+kQwss/kbLJb8
	yCh3olg00GTl+hbkP1k6gfhLw70lULl6PIS21eU0=
Received: by mx.zohomail.com with SMTPS id 172416343894254.2758926450573;
	Tue, 20 Aug 2024 07:17:18 -0700 (PDT)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_ldisc: Use speed set by btattach as oper_speed
Date: Tue, 20 Aug 2024 16:17:16 +0200
Message-Id: <20240820141716.288862-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Starting a BCM UART controller not defined as a platform device or
a serdev with "btattach -B /dev/ttyS1 -P bcm -S 3000000" works fine
but the serial port remains at the init_speed, i.e. 115200.

The oper_speed is only set if a device is declared in ACPI, device
tree or as a platform device.

This commit copies the serial port speed fixed by hciattach to the
oper_speed on line discipline opening.

Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
---
This has been tested with 5.4 kernel only.
Afaict there's no change in this driver which should be impacted by
this commit in latest kernel.

v1 -> v2: Move speed copy from hci_bcm driver to hci_ldisc to be
          more generic

 drivers/bluetooth/hci_ldisc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index d307c41a5470..395d66e32a2e 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -507,6 +507,9 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 	hu->alignment = 1;
 	hu->padding = 0;
 
+	/* Use serial port speed as oper_speed */
+	hu->oper_speed = tty->termios.c_ospeed;
+
 	INIT_WORK(&hu->init_ready, hci_uart_init_work);
 	INIT_WORK(&hu->write_work, hci_uart_write_work);
 
-- 
2.34.1

