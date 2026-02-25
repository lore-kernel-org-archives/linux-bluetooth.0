Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE563ACF1E;
	Wed, 25 Feb 2026 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022250; cv=none; b=M9xETetHzx4jCDIopcKkUdiV9FCmLbRpTJqLG65Mf/Xnw/QHm/5j9ikSsX7sfhDV2ahOKWi0dUISohzFmU6etYc4pq+eu5b/yoHIqD58X/sVYY7HDwR1avnC40TU5ov1IWtKeAYQl3YNyaxComBbvO97bGlPJXJ9li9NbYPpDeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022250; c=relaxed/simple;
	bh=u1b3bu03v2Abs/kmiHx7MWgNFzJZCV7yQm4TlCgPFtQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QVLqFJDpnMGMlnK3sFhLMexsGl3iAbAR8GvKOpFOC4Qvv7MOyj63EsJq4DesPtp/F98QdTObwreHuFoqfKfNa1G1mcHdTSQVTLAWZ7QcIK/UoINf81uxiOlN6z+z8ZZN6uMP2d2Vc2dE3eN/RI1ala5GVBvGEcNqqtymZrkdCPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1c2ytAe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1c2ytAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A697C116D0;
	Wed, 25 Feb 2026 12:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772022249;
	bh=u1b3bu03v2Abs/kmiHx7MWgNFzJZCV7yQm4TlCgPFtQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N1c2ytAeJVkyiFZOcWemvbARoT9Zl/smwPKD8eOO7bLT+hEplYSS90Cd+HS7ih70N
	 roRu4jeUTHlfTtZOhipUNCInJ8ZbwdeUKofhmM+oFpqmwiJp2J9umL19cZKr7hnDGe
	 7pfscD+91BgTrho3jksrd7qNpceNHKb8w372PdBkh1xrDaPKw6ghybcoGxlIf9krnB
	 cRxO06jiBQc8NcFWhVlwFdj//uzbh5LTR9g7EWDEJo+Bs4ERPsQcWs6VNVeXFgWvlp
	 DICbwuZvC5qpnDTOmhd7gpqQbcOVK+WL/hV8P3rGuyo60p3fBSPHtdjOkH9m8WaMc0
	 J7okv54J9AeMg==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 25 Feb 2026 13:23:26 +0100
Subject: [PATCH v3 06/10] arm64: dts: qcom: sc8280xp-blackrock: Fix BT RFA
 supply name
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-topic-wcn6855_pmu_dtbdings-v3-6-576ec5c4e631@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772022207; l=969;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=WW6OSOcSc/uvisTpRKcCveeZbqF0YKsShpN/AKjthWU=;
 b=bM4zeQ+5quFnLWll7vCJbpfTJHSRkN9Bbi4ZaZrzhFnkQYjlRBZ4BTOG7xa4pSwEatQnzxOeR
 8/jUqyYb3icAZdyKPoZgV5Cm6ozaj/QRCVW9d9PLmraiPDg5vF2teK6
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Fix up the supply name to align with bindings.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
index 00bbeeef6f14..125af356e24b 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
@@ -976,7 +976,7 @@ bluetooth {
 		vddbtcmx-supply = <&vreg_pmu_btcmx_0p8>;
 		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
 		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
-		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+		vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
 
 		max-speed = <3200000>;
 	};

-- 
2.53.0

