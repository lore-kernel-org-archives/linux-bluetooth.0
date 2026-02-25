Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8E8392C27;
	Wed, 25 Feb 2026 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022232; cv=none; b=HEyjXw+R+FWtHctdD0g/aFoku+34Ie0AoiAhx+BBUXxGhPjtSliYr3936zvg79dtp4Ap6J0B6I5rHfnoeipNnmfpshLDl8PjQFNkV+sSG2HPkTr5AqgtmuToye+xHcywlse8N00CBnjf56zDXVtk20jpGNgHoD/LXW/OIg2Ax5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022232; c=relaxed/simple;
	bh=HHOWGRSmytRFmry19YXbHc2Au8MnLwhDNWHv7U1MwRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FTh51TIfCf/6qv7tdLzIew3xsO8RzbrGuEALLToNgxahSwUeZR+F4Z+Seib75hbkzTRbrmysWx8bIBff0gvDcQAwCbAB/TN0ZDjsKLdmQB1DU3qdXnomY/jm0CS/t1w9oUKufsYksz/rOcZkmCxn733V6M8whp1lleEhIeqB15A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3AKZrkB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3AKZrkB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A97C116D0;
	Wed, 25 Feb 2026 12:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772022232;
	bh=HHOWGRSmytRFmry19YXbHc2Au8MnLwhDNWHv7U1MwRM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u3AKZrkBIVYDhCW24qnSLACHW/ENHe5bMix+81AgA8wDx64a+gHjsQIrqpLkfupo4
	 r3TuiWF2scyxd0uO7DaPneLeb7TGVx41aDRVrmI+ISyTx1gX62hgrtiw4/gQ1L2FXu
	 THytPTp47LNedTzTx/Z8UJr7nztEtgb7HiEiugs60jaiyNBrbLP1+WTxhjdBTjWWik
	 u+pXTDHZay8VFGB4lCcKDPQKkeYBt/INpLn8e1p/0V5hAvGhYOh0mopr4K7hWtWwuN
	 74oRD5monaJUEM1AididolxsZ3Xr7OOE8M/ZXf5+FMVV/JkY2ZCWhh8lZ7KZDotnyu
	 +EgYsAEqPEfKw==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 25 Feb 2026 13:23:23 +0100
Subject: [PATCH v3 03/10] arm64: dts: qcom: sc8280xp-crd: Fix BT RFA supply
 name
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-topic-wcn6855_pmu_dtbdings-v3-3-576ec5c4e631@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772022207; l=867;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=+4kimOp6B9BI8ettxCFyhdN3fmpE75eAYFrsso+pWng=;
 b=3nFOfKklLIPE62VXMTLJNfXB82m0jgvmuexQ15JQ3n+kkLqnQyvLKXFMqt9a0hJADBF7walsj
 jgVhocji1yZA15JI/nhYZbXnpyEPGDkgnRSzKa4Fhzm3Fw5yPvjVtuX
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Fix up the supply name to align with bindings.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index c53e00cae465..dcdeefd28728 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -787,7 +787,7 @@ bluetooth {
 		vddbtcmx-supply = <&vreg_pmu_btcmx_0p8>;
 		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
 		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
-		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+		vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
 	};
 };
 

-- 
2.53.0

