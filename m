Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E88F4E3784
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003340; cv=none; b=TIHvDjBS5EcDz6FAzbJH9wbSYgH+0TokUl9uJ795ZazqLJv7f8K4KhRcnitxhkCU/8RFjNBVIGAQzYr1wbXhwCWgjyW8fLKBTqInX5N4H7Ol4f5ELkgeM8KImUdn2lO+eHR4s0I4CXdMPtSreL8tqYNw4ieFsWqqf+xyhAyihd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003340; c=relaxed/simple;
	bh=VxFKVtox8xsppBVyhlslMwiSu0XXvRSjUt1HUa15Zew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sj1ICVqKrBYjBE/aRljFtFXQ8k5VDfB7uoeo1IjExOB14eY9xTmpyg0TIrZro4ZSJ2gFQwx93o31swUZC70lDTEq6bNNZvNrWSwX+IrQWWl7WFMbJt0UkgoS2x8sLg7ajlVD0ihuGL9jaKudYZoFE/DRE3W56ltW6xoTFTP6Kjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlN6P/Rn; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlN6P/Rn"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e533aacf2so98528585a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 07:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783003338; x=1783608138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oK8EJbyVF51Eyz5/SArRDnf9pZh/+PNn1rq0K2zPYs=;
        b=qlN6P/RnYsxJAfAd/LHhFf9Ilqf7Gf0dMtu3yxxNlRVjLyjiai/0lBR7tAGHhj7p/m
         FqOK3fsU5fun9LTo2xfppTEffgbMYUopiL/54tWfQDXebGX4fL24FQ/onoKDtWvPnbIo
         m9lEFGZZ0x0xpHeZMYJmsaezvBduEf7oNbcdqmnAeJt73gF8dAk411eJVkl48Q1Hk4Oj
         LGd7i0FaCJfUFDFw2C2tGDNX5R5mqSnGtvZAN4hDRgp6WLKNElHfm4QgSJZcIApZFoSb
         0N8cKO9LfrSFD9YSgvbI+MkQCpc0H9ppQinIiiwP5oP78H2fJku4EUpFeQ4422DRwAPP
         jkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783003338; x=1783608138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/oK8EJbyVF51Eyz5/SArRDnf9pZh/+PNn1rq0K2zPYs=;
        b=U7YcLUJKqtyaU923VzSLO3d/ndbabS8D76ABAjopkXTY18irzlOKAVBnSPaGmPzNxN
         672PngGyuxemo0EXrU5iWXEqDoKwLXbRQpH7MF0p80OxYhWx3j6LPlv7Lcjh0jDu2kEX
         W4O2nZyVMVV/5AINv2KlQIwfsAcNW9ZIBELE6dsnvo899MiEHnNT0BFFRCt8Dt2wD1uv
         Z62H1W593HcAf3pY1R5UgJwamtPdpFu5zKRUgX/bhrtlSTSueFHNqBMQFaf1R+1L7q7n
         R2xE5GgdWCeqsC/tv1Vk5jgA8F9kgO1R3lNjBQx/hLIsgztHlR539Rh5c8EbY//hU6yg
         zggQ==
X-Forwarded-Encrypted: i=1; AFNElJ+4MdNHnT2ozoTA6zsnpROfwFj6RG4EgJimGkBywrF4upfRSijCWhiY7myn4z2O8IsrVZYsv0I+wBF0VZh1h4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/a8u2wHQrM8FtgLegWdumKACggLL56Rt6JZYSe2A5LJTRV0f7
	QZbAk5k+k55SSEedJO4kYQKXshxrKxBLwzZzpwjRNo8ADapEQMbe9j0l
X-Gm-Gg: AfdE7ckA/cdh14nloifT1kU96NxCWshRNIAwfXyKu9+0Grko8AUTlh6VMzfSqEoIlX0
	PDjM2fkp49R/9LVRmJOCyp4IVkdbeltDDxcKIO91cqDvJzgx59W6ldPuIPzJC2SbqszchaCBOcl
	IGNrRuJH/Xt85UqlKKg36fbAWT+h1oiQDY7GanTHOPZGmVtl5bONYwwxBjErsX09xsJIoF3feAV
	CHa1GOHVmO+TvqOOCOCLeFeKqGw31FWuJRLXS6Ui5t65hoE3sPqNvBy2eIV/GWgZM+ZksBie5ol
	GuMbaO5iYo7YWvs+I/Hldq+p+jRxe5FM6DyOcaxAYHlGFc4M6wTOI/57CUvL3JYzWBGLGKHWBOi
	EjQVsoP5ad21swrnrEBDeEPyqArcPe9lsjqpGsoVnqJ/Vo7hLrjZfzcqry55lYdTZFgpVzg80CB
	RDVbFAn6idKnFWyzMVi1NToeRC1q+Mfzp7mqYYjU3j9ybiebEhak50JI0nj7QKzkOATAGglqVKX
	yRxW6bOCVSFjEESVQ46JgGTC1Y5dYgk1Uht
X-Received: by 2002:a05:620a:45aa:b0:915:8502:f7f9 with SMTP id af79cd13be357-92e7b0579d3mr729021785a.31.1783003338151;
        Thu, 02 Jul 2026 07:42:18 -0700 (PDT)
Received: from jeremy.kali (srv1619992.hstgr.cloud. [2a02:4780:75:55a3::1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e800146acsm236934785a.13.2026.07.02.07.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 07:42:17 -0700 (PDT)
From: Jeremy Erazo <mendozayt13@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Claudia Draghicescu <claudia.rosu@nxp.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Erazo <mendozayt13@gmail.com>
Subject: [PATCH 2/2 6.1.y] Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID
Date: Thu,  2 Jul 2026 14:42:07 +0000
Message-ID: <20260702144207.320421-3-mendozayt13@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702144207.320421-1-mendozayt13@gmail.com>
References: <20260702144207.320421-1-mendozayt13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit f4da3ee15de99efa0a68eae1c4d09b4bcc6d9dcd upstream.

Copy the content of a Periodic Advertisement Report to BASE only if
the service UUID is Basic Audio Announcement Service UUID.

[Stable backport rationale]

This fix landed in mainline v6.7 without a Fixes: tag, so the stable
autoselect bot never picked it up.  linux-6.1.y HEAD (v6.1.176) still
carries the pre-fix code at net/bluetooth/iso.c:1613:

	if (sk) {
		memcpy(iso_pi(sk)->base, ev3->data, ev3->length);
		iso_pi(sk)->base_len = ev3->length;
	}

ev3->length is __u8 and iso_pi(sk)->base is __u8[BASE_MAX_LENGTH] where
BASE_MAX_LENGTH is HCI_MAX_PER_AD_LENGTH(252) - EIR_SERVICE_DATA_LENGTH(4)
= 248.  When an attacker within BLE radio range sends an HCI_EV_LE_PER_ADV_REPORT
with ev3->length in [249, 255], the memcpy writes 1 to 7 bytes past the
buffer into the trailing fields of struct iso_pinfo, including the low
bytes of the iso_pi(sk)->conn pointer.  FORTIFY_SOURCE flags the write
with "memcpy: detected field-spanning write" but does not block it.

The upstream refactor addresses this by:
  1. Filtering via eir_get_service_data() so only the BASE portion of
     the PA payload is copied.
  2. Bounding the copy with base_len <= sizeof(iso_pi(sk)->base).

Backport notes for 6.1.y:
  * eir_get_service_data() is already declared in net/bluetooth/eir.h.
  * The header include for eir.h and the EIR_BAA_SERVICE_UUID define
    are added here, matching the upstream commit.
  * The put_user() addition in iso_sock_getsockopt() that was part of
    the same upstream commit is not included; that hunk is a separate
    getsockopt correctness fix and is not required for the OOB write
    fix (getsockopt(BT_ISO_BASE) is a controlled path that already
    validates optlen against sizeof(iso_pi(sk)->base)).  Applying the
    getsockopt hunk here would risk a user-visible ABI change on a
    stable branch.

Reachability: any host with an ISO listening socket bound as a
broadcast sink (LE Audio / Auracast).  No pairing required.

Fixes: 9c0826310bfb ("Bluetooth: ISO: Add support for periodic adv reports processing")
Cc: stable@vger.kernel.org # 6.1.y
Signed-off-by: Claudia Draghicescu <claudia.rosu@nxp.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[jerazo: backport to 6.1.y; add #include "eir.h" and EIR_BAA_SERVICE_UUID define; drop unrelated getsockopt hunk]
Signed-off-by: Jeremy Erazo <mendozayt13@gmail.com>
---
 net/bluetooth/iso.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 7ea3e6335..6b8622bec 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -14,6 +14,8 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/iso.h>
 
+#include "eir.h"
+
 static const struct proto_ops iso_sock_ops;
 
 static struct bt_sock_list iso_sk_list = {
@@ -46,6 +48,7 @@ static void iso_sock_kill(struct sock *sk);
 
 #define EIR_SERVICE_DATA_LENGTH 4
 #define BASE_MAX_LENGTH (HCI_MAX_PER_AD_LENGTH - EIR_SERVICE_DATA_LENGTH)
+#define EIR_BAA_SERVICE_UUID	0x1851
 
 struct iso_pinfo {
 	struct bt_sock		bt;
@@ -1606,12 +1609,16 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 	ev3 = hci_recv_event_data(hdev, HCI_EV_LE_PER_ADV_REPORT);
 	if (ev3) {
+		size_t base_len = ev3->length;
+		u8 *base;
+
 		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
 					 iso_match_sync_handle_pa_report, ev3);
-
-		if (sk) {
-			memcpy(iso_pi(sk)->base, ev3->data, ev3->length);
-			iso_pi(sk)->base_len = ev3->length;
+		base = eir_get_service_data(ev3->data, ev3->length,
+					    EIR_BAA_SERVICE_UUID, &base_len);
+		if (base && sk && base_len <= sizeof(iso_pi(sk)->base)) {
+			memcpy(iso_pi(sk)->base, base, base_len);
+			iso_pi(sk)->base_len = base_len;
 		}
 	} else {
 		sk = iso_get_sock_listen(&hdev->bdaddr, BDADDR_ANY, NULL, NULL);
-- 
2.53.0

