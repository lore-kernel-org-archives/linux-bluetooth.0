Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777FB37CD45;
	Sat, 23 May 2026 02:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779502840; cv=none; b=uLszBUxDSFY8WQUzmW1xNXdKd1FVJ5JOleqYznxTxfW48ZZ0NBu4hPapa/YXUSMvEvJP8AViejpukBCBHsRUJ5THKghzdV8aEhulmObaP/41CYvmWHnuKileW3iBKtzSxjGtBBKb8QOIiXelLntozBWLstUD47z8U7AXeoD9PeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779502840; c=relaxed/simple;
	bh=ceWs36/8WSaDZVvAOsJro8HzN7NSbHK5EaszDcNyEBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpgb4YclG5TZ+D04ZGujpZVYDKLrNWnXl7uq8dSdz1/xUwmQcNHaC9Xxp5wFJDJWDdJ/Smu1VEYHcaXKhTZ4dnHOdz9agNfkOFOjfzckm5wrWdCKsbp0Q4yqrLuhEAtXYWEv5kK8tDSMcs3k6LuQ9WSJEH93ZYta0/RlLivJfpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiIRFfWt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiIRFfWt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F751F00A3A;
	Sat, 23 May 2026 02:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779502839;
	bh=8mOs61VY2PSI0Zj3KHKUjR9zo9Cws2XJRNoSO/W8Hrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HiIRFfWtFKSOeZFjVGdO2o2lK8PPqZYw75ktxAsx16+W2zYeRZNdpREQW5ELd1t53
	 0+nexIG2MeetfMvIC5TKm6hpBF5/SdnSCkbvT8fBqDZWbjVurn2hivNvZcgPbsO26Y
	 4STojGK4XKE8i2+yuAmelhvl2QVj8Gi1lFYouxRWCdDdGiG7t+Y20Znz7Qza8eyLIr
	 d5kJnhRpOYXB7xK4eWzrUEGO4YxL3oKqJ4EkCt+X5XhWlnUj9YlMnQOm7qTW9IFPua
	 LLCu91kDVL+N5SKCsFPUwSOh+25DFPM2d6i+15ByovPHZMOCZBjNaYwL08mlFe+EYd
	 2ODMpKS4CKT+Q==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	cheng.jiang@oss.qualcomm.com,
	quic_chezhou@quicinc.com,
	wei.deng@oss.qualcomm.com,
	jinwang.li@oss.qualcomm.com,
	mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH v2] arm64: dts: monaco-arduino-monza: Add Bluetooth UART node
Date: Fri, 22 May 2026 21:20:04 -0500
Message-ID: <177950280359.1097700.2541767933662489538.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429103537.1282497-1-shuai.zhang@oss.qualcomm.com>
References: <20260429103537.1282497-1-shuai.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 29 Apr 2026 18:35:37 +0800, Shuai Zhang wrote:
> The QCA2066 Bluetooth chip is powered by a board-level 3.3 V supply
> provided by the hardware. This change connects the Bluetooth
> controller via UART10, and the corresponding GPIO is used to enable
> the Bluetooth chip.
> 
> basic function test step:
>  - bluetoothctl power on/off
>  - bluetoothctl scan bredr/le
>  - bluetoothctl pair <remote device address>
>  - bluetoothctl connect <remote device address>
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: monaco-arduino-monza: Add Bluetooth UART node
      commit: 0299c007e6f34a2a5b724c332b86be77409ea729

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
