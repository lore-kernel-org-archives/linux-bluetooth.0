Received: from mx4.sberdevices.ru (mx4.sberdevices.ru [176.109.96.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEC82D7390
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.109.96.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506418; cv=none; b=nqjdf2NNNLfSg2QjZFWn7kIdyQCCtTdSjAslACme7waHYwn2q9XVUnSKp5Ft1D+l7aC2SJziauOXUxgoTR/Vi3KpykOcGay8wbFfoXd3oR9AmEs+l6q8HyzrTW2sHwm5/EMBITIN4IVjacyhb7xMEbwixOAPDBqldkpGxcGXpCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506418; c=relaxed/simple;
	bh=Q0OdNFVPmN72aYzegfSjyp8p6grD1IQPj1wGach7ROo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ovXQKqMc0FVX7AVrx46imDEvod7obksmfv7tFvW4TBICzBJCzI1Nvk4hFxgdMumGLsyz674MiRL0y2RR7I1XG/pffb2RBjdRuU8kR2YIgE7oIK+BYFKlc8EbYrMv1m/wfAC6Ffesed+fcTGHjVsqczRPdCHzP7evoncdsYrO3Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=YjYDffEe; arc=none smtp.client-ip=176.109.96.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="YjYDffEe"
Received: from p-antispam-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx4.sberdevices.ru (Postfix) with ESMTP id 7735240060
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 12:00:56 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx4.sberdevices.ru 7735240060
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1762506056;
	bh=xFuIWZiOLb9YNMz5W7utXn4fSKvvK1+F/+oPORpkH1c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=YjYDffEeGF7d2FROFfzq0hRHHjrnSGlYwHIyhwTeLbwbJKt4PHYkdGXtFs+AxGHkC
	 K3727f4EwOL/G29x9ief9lxBamMLL/5xZ8PU+uKvaws5PbNX4LAAZ/OJlXyr2yvRpw
	 J5BpeUK6iJM6sPEW6+DPMAWnbGKDCt9nm27MTOZtMcHiZta8oadZg0UJGiHw8pfpNT
	 3ri8sZsqc3CPKDWmfUYKz0lcOCWzCCdBE2ibtqtbtoL1PsPMzPzLoJ+6fF18DSy7Tp
	 0hHvyHDQXEPR8uAR3BF3koWoBTaF6NpuhXufR67Um2o8FfqZznjo2xDOibDxkUZHV0
	 7xGyWo/VlLfEw==
Received: from smtp.sberdevices.ru (p-exch-cas-s-m1.sberdevices.ru [172.16.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R13" (verified OK))
	by mx4.sberdevices.ru (Postfix) with ESMTPS
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 12:00:56 +0300 (MSK)
From: Pavel Bozhko <pvbozhko@salutedevices.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Pavel Bozhko <pvbozhko@salutedevices.com>
Subject: [PATCH BlueZ] avrcp: fix AVRCP_STATUS_INVALID_PARAM
Date: Fri, 7 Nov 2025 12:00:16 +0300
Message-ID: <20251107090016.89520-1-pvbozhko@salutedevices.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-exch-cas-a-m2.sberdevices.ru (172.24.201.210) To
 p-exch-cas-s-m1.sberdevices.ru (172.16.210.2)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: pvbozhko@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 75 0.3.75 aab2175a55dcbd410b25b8694e49bbee3c09cdde, {Tracking_uf_ne_domains}, {Tracking_black_eng_exceptions}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 197867 [Nov 07 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/11/07 07:41:00 #27891535
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

The first AVRCP_EVENT_VOLUME_CHANGED event triggers
an AVRCP_STATUS_INVALID_PARAM response.

When pairing, the org.bluez.MediaTransport1 instance
may not have time to be created, but the org.bluez.Device1
instance has already been created.
avrcp_handle_register_notification receives an
AVRCP_EVENT_VOLUME_CHANGED event and
media_transport_get_device_volume will return a Volume
of -1 from the org.bluez.Device1 object, resulting in
an AVRCP_STATUS_INVALID_PARAM being sent to the audio source.
After receiving the first AVRCP_STATUS_INVALID_PARAM,
the Audio-Source will consider volume changes
from the Audio-Sink unsupported.
Relevant for all iPhone models as Audio Source.
---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 91b6cc0c6..352323167 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4818,7 +4818,7 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 		return NULL;
 
 	device->tx_power = 127;
-	device->volume = -1;
+	device->volume = 0;
 	device->wake_id = -1U;
 
 	device->db = gatt_db_new();
-- 
2.43.0

