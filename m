Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AE33ACF1E;
	Wed, 25 Feb 2026 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022255; cv=none; b=EOGlZngMznJI1oLORfXcLJ5Jjii7VNJlOZLCAJPb155liaJd93QSmqQbC4GPdYV2S/3fbvIXwUhKfBFarMeoVNRGZjIeFVVf6Uea0or7pJ23F6AroohCz4fjLILF2VH4NYfPWA08LUKX97LdqF0L8u4oQ8HPov0OtW3stk7UKrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022255; c=relaxed/simple;
	bh=khv/3KTZp7yoQupMiIaSBILxr8XlNk+QQm7Vr3yvBfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pydwTVCCVY7J5ZpZcZPIB5GmZqYx0kzYN3JNJqRpQi5BRA8e/saEW/S37btMO9FJjDZ78ca8Ag+ZLu22G3X+rncAkx0eHpO8ac+3RkpT6IqYVrdha/AJKEKFkc2cxASzI/2S3tzjJVQGsHPlDPaLbv9XN8EDA7lDHHv9yii5R1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wvpon5Co; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wvpon5Co"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B35DC19421;
	Wed, 25 Feb 2026 12:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772022255;
	bh=khv/3KTZp7yoQupMiIaSBILxr8XlNk+QQm7Vr3yvBfI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Wvpon5Co8PFWjOf0uX5/1042X4dupZF4/bhgueLN1JrS9NsujV141hoRqO7gURgGa
	 vyep4E5wPEO93V9oaKcPQ7caG9F0gQD1siSRAy55C9VEXkk/dnZ28t48u+LZqKp5/s
	 YmQ3CLSGji/xwfepzgob21Zy8N4uzxqL6If/4KVDUvkROmMFWhhhVcxpVUqjFFWURm
	 hxXfVKx0eEpogtlsYF2+U5o/7uwiwtIu2AJysl2xsjGZydSHcpmqBh/N80HthHoMC1
	 +haaQMgNJEu/62FS91LjBtSEHes9by1OFLBdeQHVbx4wY6PsknfT/tfG5y5NWfa6UJ
	 1EbnJZjGRdRQA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 25 Feb 2026 13:23:27 +0100
Subject: [PATCH v3 07/10] arm64: dts: qcom: sm8450-hdk: Fix BT RFA supply
 name
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-topic-wcn6855_pmu_dtbdings-v3-7-576ec5c4e631@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772022207; l=859;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=grl88B7UAj+3hdwDLNSXgXpL4EAxGRMdD+qEh4dcZl0=;
 b=3DSonLv0Ga7uAHIoPs9f2YcxUdPm9dNfqaNbYYOR1yPEbObNe5seZIXmOoET/Dsfu5jYUogc2
 VVee+QRCtpTCCvg88ut9oz+11CWDijfYwv1Vz4tH8Fy0tTKO7zglTkY
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Fix up the supply name to align with bindings.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index 268ae0cd642a..b37998cd9a2c 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -1172,7 +1172,7 @@ bluetooth {
 		vddbtcmx-supply = <&vreg_pmu_btcmx_0p8>;
 		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
 		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
-		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+		vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
 	};
 };
 

-- 
2.53.0

