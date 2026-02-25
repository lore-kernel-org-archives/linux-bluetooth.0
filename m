Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F763AEF2F;
	Wed, 25 Feb 2026 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022261; cv=none; b=uCX1kS28mrxba/53xMh76xIYOV8sqK7R/qiDBh+kHFbw1zZxkMQDf+xVxHkYOsVe/3qZlhrOmmMOXNaJ6HcSRJgvPQ6kK1mdNm8SWylVyiNdHk7wr3GrchjKevr4VwP1mQkBTszfDYcLp9UUNauUGmUl2cUwn2BTFjVyHnL5kHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022261; c=relaxed/simple;
	bh=m5uJNCarcR6AQ5pUGakjpaUQRDejG3ItIoWIxp7sf8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m4oQ4SO1iuwEUJsIoouRoabl8AoS5GNgnkVj8dCJE2d6CwJwBluJdTlHXb6X1Iz0ahNdU/V6ZJfqRNprh0ckp4PktjmmdRynJ/udZJneb08bHt3b+wOXYadW57yey2aZ3Ecq1OWXQDrkKzFXSGD2XuxYv/N1y9lSpfZkUc7M7LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKHfyHLD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKHfyHLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC21C116D0;
	Wed, 25 Feb 2026 12:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772022261;
	bh=m5uJNCarcR6AQ5pUGakjpaUQRDejG3ItIoWIxp7sf8I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nKHfyHLDg8NAIUhnvyygSV/VOFglAQZs3Sj4sgXbAsa45zLHTSXDJqkgszKlmlqs4
	 DwXYDFYilcjPNKCQ0hbRa9ZgiZF7HbuFu7SWROnZWnjlR19DrzEsykMdFwQ089zRWw
	 a8WL0o5vMo9IQFJuI+vNO7kOwdUFsURUBPMwDbqN+htw7uPOBXpoLMGuQ7BrFW9J2g
	 rywwvnd8SgR+YMJc+jvBQX/69qWAhRMWFMa8Kd9gVK5w7CrTWcAmaa0Ng5yZlSftSP
	 X+gY0rv8DlDxMLJJZHW3BljpcLBeE00lfidc1VN6X1eqFhYiH8yK34jmX3zMlrMymv
	 yCKFjHYkMkOPw==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 25 Feb 2026 13:23:28 +0100
Subject: [PATCH v3 08/10] arm64: dts: qcom: x1-omnibook-x14: Fix BT RFA
 supply name
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-topic-wcn6855_pmu_dtbdings-v3-8-576ec5c4e631@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772022207; l=904;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=t57WPNA0INoLuqbjX7x3uLsVeNpnywWIe5VraJnDu2o=;
 b=NxzsRFV0jFjXouiW/7Ou4Tb/X8VJ6xVuLUa0YyfNH1MCdln9XAOaZZFH+W9eYo8QEBtDqAgnR
 mEuDqSdPhLyARUPJD3027h7/tugj8tfhjLvQdMWaZ7kVB/lvjXaA58k
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Fix up the supply name to align with bindings.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi b/arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi
index a4075434162a..30f18c8cbcbc 100644
--- a/arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-hp-omnibook-x14.dtsi
@@ -1450,7 +1450,7 @@ bluetooth {
 		vddbtcmx-supply = <&vreg_pmu_btcmx_0p8>;
 		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
 		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
-		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+		vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
 	};
 };
 

-- 
2.53.0

