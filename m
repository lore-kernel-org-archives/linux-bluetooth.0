Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C808D37E2FC
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775224528; cv=none; b=RlabFOeCzZqLBolx6yY0ZSfgGIjBCaq5LJucD+W/12imgWq6H35W86sdUKPLkKrPEAiIbgPu6htlmzD7lvgsv2tQwP8dqj8jAWMeU2OKHcLFK2gmUa+HWnoPFfirgoLYDshFCuE1Veh94rNp96Ks09KelAbrFqUjVYdsvGHMwdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775224528; c=relaxed/simple;
	bh=Laagl1WvmKQiKODwRM094nhY7LnQG8oBc9UyZ9+RHgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WWdH/d7W4baNkkKa42dHEYrEWRTA/0gPOP7WjXy15JrGsMuEoDgQsCI6uOlm6kNbY+etv+/Sp07H5K0OSLVnuYo4UUHSItscwLURa37fr+o27o19ceVBY25F4ykuB+DvHqUUUXHq2Vrx5Io9CBwtMRG/dGVjWbEJWVoV1ifvZXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=uiiEeTs5; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="uiiEeTs5"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b93698bb57aso386404166b.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2026 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1775224521; x=1775829321; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1YCa6QIo9PeY+05m/sjhH3PUg81ljbhDyFPKMlTXyw=;
        b=uiiEeTs5YPL1xzsMNn93RhdNKRlOdfSlZ0vc6opd3J2dqbPonRHAIR5CM9UlaE0Coy
         sPlG7rRiH5D+2dTFKSMo47XZskYHG3xa1EGWBv9rA2bE6+jwzwWcxOZOtSJgAuR36ROC
         ta0RejydEDLcpusmRSgJjATdWM88lKfEvdh/z0ilj+RZ/oRMM1dSyGs/u/Ev9RezXjou
         6SPG+BStWNAhW1zE/ulOoRiLXnIKTq0PdSuUtIOFBnWlg/qybwwkP5qgphoCpquKCv7q
         fKaWoww1GxHA37HyDknA6E6A5iQ/BfipLpgfuR++bf7lJ9TviLDAo740pNtewoIDbvBu
         sCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775224521; x=1775829321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q1YCa6QIo9PeY+05m/sjhH3PUg81ljbhDyFPKMlTXyw=;
        b=Y8VYMlOm9YYSByLYlRK/IuKSdy8QBI9/EFYVof4BhFNhpMSSrlLSu/nKIDu77dGXSj
         3PDU+r0mnitlrQDx22vUt+eXHQQW+/Gp0VdNk6LkdTKZ4ytgw14Io8cy1VQRj+2LG+Eu
         qyNkON0d40NrC8Vsp3OYRQsUx60C34hxAEGWoMDH/mOGk0K5vMRKJWvz48tl+bMr7rP+
         mpihYtcULmliUPzziTg0qVHBOHCKsqxqtMbA/OvOuKDKTCpIXulvihrmGqQ3L6afi1H1
         glO+Wv7SxV561C+noPeJRRv+Oeg3iuI3+GWk33PYjHG+yX+D4JKuL1+MkLiR53PJ5Ilx
         s+AQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+xZ/3jdQoRU+iMR20QydQlkHRABcJbtdWdmnHggvIPp3p7QqGwFtj7FcnYTmJLgGeljH5VzS68b8uAo7y2LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjU8tgcu3IjjnRK9swMgR7ogTgIr0XLNRMzNVNh9neNbwdN9vW
	PeEbdRVNvNQBVPbgPklK+SG55Uyk7QaWyRELbwVfg2QtKdnNbDl6802FBhBa7jTtSc8=
X-Gm-Gg: AeBDieuGAvf3IuSGBx/fa60VysHu6BPwh42cMWS5dOfKuAao6hmSzgXx7mAKMW01MK3
	psCBX5Dj1DVdFYm7bYDTlat0uxsWs/vx+lkQmuPNk2fVQwLwJInVfCpan5DqCHAg+WOyMVnh8LE
	y3X9UHtzZjrz5an+l60eK5h2JkJCv0KS+J/93MCmuWx1U4LuXd1q+ByklkDpxS8tBNFL9EQ5lsx
	3T2RHF67Qyp0slF2n4D511gJcN1FCnRxbWA2zX9j8gE9WN0tnol+mdA0eQQtwHl+7PJAs0Jz/xI
	Y7FO2x3B4rlnoRdPqpkBTUenMcytuwCfg0ODWoKlGa3uz97Ok+prxUEA1PEyXDGVVaNiwnX+qcI
	JIv9KoZJLbDm7Lx09uspdueW/DRDjqxteoRzH0WRL24G9xRFWUbYGDEVQ4gxYtbHKNYcVAbUBQF
	G0tiS8KM8MPleDpd2+aExj0XgVZ6V60cVP3ThFsNJMmPEYm8cQmZVTyGjvAtkoxsh8XRaoEa8Ua
	cUrxf/BbYVo4P2tzOXQ0pobjOE7Y0T4VAwK31QGxPa6pUKm
X-Received: by 2002:a17:906:ee83:b0:b99:86b6:85fd with SMTP id a640c23a62f3a-b9c65596fdbmr158557066b.9.1775224521403;
        Fri, 03 Apr 2026 06:55:21 -0700 (PDT)
Received: from otso.local (2001-1c00-3b89-c600-71a4-084f-6409-1447.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b89:c600:71a4:84f:6409:1447])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c972e28sm198057266b.1.2026.04.03.06.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 06:55:20 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 03 Apr 2026 15:52:51 +0200
Subject: [PATCH v2 5/7] arm64: dts: qcom: milos: Add WCN6755 WiFi node
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-milos-fp6-bt-wifi-v2-5-393322b27c5f@fairphone.com>
References: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
In-Reply-To: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alexander Koskovich <AKoskovich@pm.me>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Jeff Johnson <jjohnson@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775224512; l=2562;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=Laagl1WvmKQiKODwRM094nhY7LnQG8oBc9UyZ9+RHgI=;
 b=5dJnjoMOmNyoMHrWYuV+T1fDHL+fKjWcd2iksZsGpFY5KgrcxW85fMrGe1suXpl/g2g53QTu/
 2BtMLr3WqRnAYp8oduhNM5XgqDpI+uMmoQqYThDMSgKypx2bIP832X6
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add a node for the WCN6755 WiFi found with the Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/milos.dtsi | 46 +++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/milos.dtsi b/arch/arm64/boot/dts/qcom/milos.dtsi
index 71292dfd6e08..3a3d7f2134e8 100644
--- a/arch/arm64/boot/dts/qcom/milos.dtsi
+++ b/arch/arm64/boot/dts/qcom/milos.dtsi
@@ -2438,6 +2438,52 @@ gic_its: msi-controller@17140000 {
 			};
 		};
 
+		wifi: wifi@17110040 {
+			compatible = "qcom,wcn6755-wifi", "qcom,wcn6750-wifi";
+			reg = <0x0 0x17110040 0x0 0x0>;
+
+			iommus = <&apps_smmu 0x1400 0x1>;
+
+			interrupts = <GIC_SPI 768 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 769 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 770 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 771 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 772 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 773 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 774 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 775 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 776 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 777 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 778 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 779 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 780 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 781 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 782 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 783 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 784 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 785 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 786 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 787 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 788 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 789 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 790 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 791 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 792 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 793 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 794 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 795 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 796 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 797 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 798 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 799 IRQ_TYPE_EDGE_RISING 0>;
+
+			qcom,rproc = <&remoteproc_wpss>;
+			qcom,smem-states = <&smp2p_wlan_out 0>;
+			qcom,smem-state-names = "wlan-smp2p-out";
+
+			status = "disabled";
+		};
+
 		timer@17420000 {
 			compatible = "arm,armv7-timer-mem";
 			reg = <0x0 0x17420000 0x0 0x1000>;

-- 
2.53.0

