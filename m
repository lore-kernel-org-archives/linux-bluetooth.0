Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D50F1F17E8;
	Wed, 25 Feb 2026 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022244; cv=none; b=slEYGJnMC/c1/E5sSASde7UQ0ByDRVaXFTTBfN08sCM5q0vZwtNeVSXv9iLRg7VnXXu4yx0xquDZjof9uQLLCxp60Y46L9l1NzpF3kiNlHI1Z8ptB9oJjoKJw76eWaHQaY2dX+FjQZow8nC/u7R0N7NWeqSA0Sr2UbMqIIRf8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022244; c=relaxed/simple;
	bh=5S8s9wBsu0POu0fhrPSWuEa4tcoSLqgVNor9jPqxTZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bea44Nxk90Vzn5DzGNw2Rdv+2Kn02YwSgeBGzZ1ne86x5G9GwBP9HYbl1Z8a61JJs/HLTedwMIHXJYp/EMAKMLH/KYF6hyd0z6saSb4LxU7SQ/qnDnuc3gMrDpFYTTGn+WiZyPzp/Fqm643iNEfZRb9C76SvuuJLW5Xbzp43OW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOIdrVJf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOIdrVJf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67684C19423;
	Wed, 25 Feb 2026 12:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772022244;
	bh=5S8s9wBsu0POu0fhrPSWuEa4tcoSLqgVNor9jPqxTZw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eOIdrVJfgOBPhcPw4wi9eV9a/MZi0LPHZuuJriATh8RRF9kkpobQmxEMFhs+x5+Bs
	 Z0IPd8ymr1AM4DP5xSkzJCSKrG/o4IiRR2GG/BcR/XLxqlajJa0BN4Cc6yFSw1JP9w
	 tNh9vw3TJu7gI26JVUZcktC4kN9v1wBG6XHgPNoKlSKSDvRU6UsS96FRRSaBypGNe/
	 wyE7rM948Kpclm0Duf6JpeaoVy1Jz2rUSiT71SaV9jLyypv0a5nQwDJKyKwjuV3Z+M
	 Fp+dqU9Gutp5CjLn/h4RxNl1wxjFC0rtLZjs4WGIy2mAqyHB98jugF7t2m/w58327F
	 +NWc7oSRKIxig==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 25 Feb 2026 13:23:25 +0100
Subject: [PATCH v3 05/10] arm64: dts: qcom: sc8280xp-x13s: Fix BT RFA
 supply name
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-topic-wcn6855_pmu_dtbdings-v3-5-576ec5c4e631@oss.qualcomm.com>
References: <20260225-topic-wcn6855_pmu_dtbdings-v3-0-576ec5c4e631@oss.qualcomm.com>
In-Reply-To: <20260225-topic-wcn6855_pmu_dtbdings-v3-0-576ec5c4e631@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772022207; l=976;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=5/4XzDPzB+/SfDFy+8ruZ9GavHTyq5ADjjYuopEUns8=;
 b=no6OcnFzGON0TFAyh6wOlW3bjlvNuTNMrvz7YYxYH1ylxiVv8PO6z0qq4Oi0u1HDNHVQPrc01
 Z7FiOe3aqlAB9NKLXQGvHfvnRm4kwhdd1FnqHp9EEtGyUqHlejeJqLX
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Fix up the supply name to align with bindings.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index d84ca010ab9d..abd9c5a67b9f 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -1331,7 +1331,7 @@ bluetooth {
 		vddbtcmx-supply = <&vreg_pmu_btcmx_0p8>;
 		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
 		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
-		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+		vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
 
 		max-speed = <3200000>;
 	};

-- 
2.53.0

