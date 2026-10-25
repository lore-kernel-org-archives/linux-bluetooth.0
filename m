Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=138.232.1.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792956242;
	b=Mx9PkKHYnTfhtYck2FgvEKxQzxmiQAgiFQrjWRC2rlwMLUi49XUg5VIpU6jWKIeUi8at
	 QcCsD8ANBOp4X0jhud1eMkIXlVv4zCwR+8vHw25asuDc9c49hcCqo/u+q2qncZrOE0N0J
	 2RBC8uraHARir4IWafrLBlT3OtDmTM2QtMlV0XuLHxv159YQuqP3SMzKAL/XNMVmPtyPL
	 M12QYqyRZlUldH9/ebMEHlC+CT1eKuVTZMgHqxnx+glnx2mwFLG02Aj9v804tDJxvvS+9
	 YfjQf1boYw0EVOflnYeWQgPwpzs+hJwSyczpY2x02tPzDPaak1sLWjfgqgnLgGI9d1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956242;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Score:X-Scanned-By;
	bh=BtI2A4HiRG20kcrzMXe1otZW6Wmjo2thyrIwBe1WYI8=;
	b=dH2OLbdeqRXuTax2MsSKBhokCWJ1E7Xmx1n+Qsd9Xgca9q5BxmOnsk+ksphtOva5hezc
	 wSN1QlmQf0fG6FQzigyXNAZImeRvDhx++I8s5zrwNnwdeeJx0srM6x6NmxIRdLt/cjiZ/
	 fur7lYetm9NyqWUHO8PKbnMlcwSQgJw2IYuI17OnPOqhD+ymOMCVxycurVkesTPiktmeN
	 QQ+S57fx6BRY2bOExKWHRGma6/E49i7kQbNQ+BhGm3gfQqiKgieVmmYK3gTt8T7Tow7Pp
	 79oACbWVmWkGV8z2WnNehDfkHqrmUuvMPb5wkIdCGvm5lJYvGb9WIHFzZDYVFWMK+Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.uibk.ac.at;
	spf=pass smtp.mailfrom=student.uibk.ac.at;
	dkim=pass header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=j1klM9Q7;
	arc=none smtp.remote-ip=138.232.1.140
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145E060A2633;
	Sun, 25 Oct 2026 19:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 145E060A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=j1klM9Q7
Received: from surface-pro-5 (178.115.151.51.wireless.dyn.drei.com [178.115.151.51])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 69PJNdP1518064
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 25 Oct 2026 20:23:51 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 69PJNdP1518064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1792956231;
	bh=BtI2A4HiRG20kcrzMXe1otZW6Wmjo2thyrIwBe1WYI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j1klM9Q7SGNBCnpkBXUpwT5fRvk1pnOVfdjh9Ghdg+fwtGQIVm0QwdwiUTpWKOanL
	 6Rlo2bRhpSLO9Cjjmw210xAll+89YLPV7jBo0vdZ2bfSOtMZSjqUeUEpQ/2zDiBKzn
	 BM5pPm4UOxYX0Be92EIgDhzLbap5K8l74h8rSBrA=
From: christian.koever-draxl@student.uibk.ac.at
To: yang.li@amlogic.com, marcel@holtmann.org, luiz.dentz@gmail.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
Subject: [PATCH 6/7] dt-bindings: net: bluetooth: amlogic,w155s2-bt: add amlogic,shared-antenna
Date: Sun, 25 Oct 2026 20:23:37 +0100
Message-ID: <20261025192338.209574-7-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025192338.209574-1-christian.koever-draxl@student.uibk.ac.at>
References: <20261025192338.209574-1-christian.koever-draxl@student.uibk.ac.at>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: () -14.0 ALL_TRUSTED,RCV_SMTP_AUTH,RCV_SMTP_UIBK,U_RCPTS_11_PLUS
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

Some boards wire Bluetooth and Wi-Fi of the combo chip to a single
antenna. The Bluetooth RF has to be configured for that, which the
driver currently only does for the W265S2-class coexistence parts.
Add a property for boards to describe it.

Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 .../bindings/net/bluetooth/amlogic,w155s2-bt.yaml           | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
index 50291a438ce2..aff8c2a54cf8 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
@@ -46,6 +46,12 @@ properties:
 
   local-bd-address: true
 
+  amlogic,shared-antenna:
+    type: boolean
+    description:
+      Bluetooth and Wi-Fi share a single antenna. The controller has to be
+      configured for it, otherwise its receive path is severely attenuated.
+
 required:
   - compatible
   - clocks
-- 
2.56.0

