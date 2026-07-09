Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A274402429;
	Thu,  9 Jul 2026 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588717; cv=none; b=VpwwSGy2TZghm4x/+zPsYOzOw709gsJMUMVhl9+UVgHNVNay5j/Z5KgNB68zO+j5jiND33CsbJUshA5Mwum567WSbWkF91seqAzhKDMjEh+4N+UTsXqMQJchcgC5uZo6VbLTyWw/T8Jo9Wa33AensAkzRPw5WmMNdqifuuHLxkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588717; c=relaxed/simple;
	bh=2TcyOXsmylc9xai9nNc9EisV18MbNeNLG4uNJzVn8pI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MqVf1yH+SFEyUC0jh8NnP0bwkTdDtGU5nM7S5Shrh+pxAyjFpj4ZtAuwR/PsOlr/5wU8lvn9+1VTiuNsWSVakJtn3vTB3nRFljO1sgh8k8L+DB3EqLrciyaIG1XAOKk7exOok0pH1qhpAXRoai0FDNXp+Sq2NXfyOx46Hh7aM90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3hOQ4+3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3hOQ4+3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DD8CC2BCFD;
	Thu,  9 Jul 2026 09:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783588716;
	bh=2TcyOXsmylc9xai9nNc9EisV18MbNeNLG4uNJzVn8pI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=l3hOQ4+3+QE4KlKe8hUHyMJOb7VET8wGDmsqn8FxHcBM6nr3FWtEtqPwT1QQFdghk
	 Jir+jw8VzKBWLJu0ku7Q8mPnvkMPwlbicHCkrEuWk23HKJ9a4twskh6pbDoK7jhb37
	 LkS9OMFFx7XI57uHzHf6X0hwG31M+9Nu+3hT+wfROieOwaxxgmCRAEB+rbMmTfPkCw
	 x8meJvmMeUGCryhbHiN1g7E4fBuL+1HAls+1YqzzrmYsWulwk+fYBRnhHp56iph/e8
	 qZh62i82H4jILBGoCInP9/FxzdhQF8tJk5q02gaQs3ISV/5VfqAed1wz+NJarZDxav
	 UY2F8/HBTNDAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F07C44501;
	Thu,  9 Jul 2026 09:18:36 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Thu, 09 Jul 2026 13:18:32 +0400
Subject: [PATCH v5 6/6] MAINTAINERS: Add IPQ5018 driver to Qualcomm
 Bluetooth driver entry
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-ipq5018-bluetooth-v5-6-e476c41f03b8@outlook.com>
References: <20260709-ipq5018-bluetooth-v5-0-e476c41f03b8@outlook.com>
In-Reply-To: <20260709-ipq5018-bluetooth-v5-0-e476c41f03b8@outlook.com>
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783588713; l=702;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=2A14I/9djkbP7Q/3gMV0xrYoXvOWpPLiNZFRJ5IU8Qc=;
 b=E5AlHnX2v2ikivvWxaDyWRXrdlt6w6bqiiGkCWHWmGorm+1BvaoideNHaGiMCcdgSiOtl8BWq
 0/u/tBoJAIgC7Np7whNWHhHMrfMbsfGyVnRtN7mdb4vXTtINRJ8rf4Z
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

Add the Qualcomm IPQ5018 Bluetooth driver to the existing entry for
Qualcomm Bluetooth drivers.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb8cdcc76324..33dd0c70c277 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21876,6 +21876,7 @@ L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/bluetooth/qcom,*
 F:	drivers/bluetooth/btqca.[ch]
+F:	drivers/bluetooth/btqcomipc.c
 F:	drivers/bluetooth/btqcomsmd.c
 F:	drivers/bluetooth/hci_qca.c
 

-- 
2.53.0


