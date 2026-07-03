Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4D933D6C0
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783067641; cv=none; b=ofC/27qOajbTQ4cXkM9iqUEbcpzVkHGlyAHo3+haMp3L3u3Y47J+4u6M20xctaYfBPpAxbbLaoAfwQCepicwBv9bUZHWJ2VR5ImbQwCT7SPXIyGYZH8Rr6cp36yZa6k2dyMWZVisnfUkEjy0RoOWkO9vul9vm/lVUg8WY48apK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783067641; c=relaxed/simple;
	bh=heeEk6kNSz7DzysTsEXaatXI6Em4Av7gIo4guvkev4U=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhLICU8F9keXsThSQP5LDXUQMCd75FiKX4FhzzPUPbXK/aFwhj8mgjiHhXD3R2thh70KAVuP+9zQ2HLc7EhZ9AyqEK1Tje88iWGB4+MMKCiw4hPs0cM75YAi/6O7+e4v3bptOaxYAcWCIvgra8SEGR0vw+sZzRIFPROuBAsDnNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNI4cDAR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNI4cDAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7356B1F00A3E
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 08:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783067640;
	bh=heeEk6kNSz7DzysTsEXaatXI6Em4Av7gIo4guvkev4U=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=ZNI4cDARmPKCAFSxaqmVeYbF1p+9XBDeOMLYf7TkvYjOExUn8xowCPtgD4eFPh+kt
	 23NTOVV54lUwRiu0wWB7p41kMvJoQ/lWD16fvnWqq/nB7SesLbJz5jQR1CIItQZeO7
	 KukYx+xYXGKjw2C6B5yw2B/1pLXBLqy71GGEffRXErw6Yx7MwpAX/49kQZj/vGUxUL
	 V1kk0bz7p20Un5HlHLa6q6gvsCTraBrkYXiWyWdI4O91YgoCHDWz3BG9i48d9Jm9xL
	 ee4ApOECi/knTK/Vs5MtfGiYx2eOicFp73N/CTuhDzVFGJxRfB/lUtaoLpG6Ssmpmg
	 Q/rd4Itzme0Sg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aebf120839so322225e87.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 01:34:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqykg5VldTTNxrPEN6hvWGOIsWnD7NDzVaiwC4af0x5K0CIPJL7qlT/TdNM3WGn5V9QWqou6q5sKpUvAl0x8n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ5HMjub5qcr+kEVdrCVGyZ47b8Z5zvRpsQkk160dOgqkn7Cjm
	tl/D1ni58dAVSq7QPi0Am5tD5ocjdCiuvRVmGP72QhmSqc8fOOzKvz15W1mwUwrQ7R3IVbKlT3K
	Ti9N63PMekqVfbp9Yq+jqNFVDEE+11Hi4iaIE1mfhnw==
X-Received: by 2002:ac2:5bde:0:b0:5ae:badc:47d3 with SMTP id
 2adb3069b0e04-5aecf512627mr466540e87.28.1783067639185; Fri, 03 Jul 2026
 01:33:59 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Jul 2026 03:33:57 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 Jul 2026 03:33:57 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260703-ipq5018-bluetooth-v3-5-62da72818ab3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-ipq5018-bluetooth-v3-0-62da72818ab3@outlook.com> <20260703-ipq5018-bluetooth-v3-5-62da72818ab3@outlook.com>
Date: Fri, 3 Jul 2026 03:33:57 -0500
X-Gmail-Original-Message-ID: <CAMRc=McfS2Kk=+-oC17YdBP1j8Hyi9VAMV=KivrP9aijgie2Vw@mail.gmail.com>
X-Gm-Features: AVVi8CfE_G3EXsiF4ujXPs5b52ftHHbsubqnhWEG3C4K2k50vOw-6hQv3NStrxg
Message-ID: <CAMRc=McfS2Kk=+-oC17YdBP1j8Hyi9VAMV=KivrP9aijgie2Vw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] arm64: dts: qcom: ipq5018: add nodes required for
 Bluetooth support
To: george.moussalem@outlook.com
Cc: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Jul 2026 07:01:53 +0200, George Moussalem via B4 Relay
<devnull+george.moussalem.outlook.com@kernel.org> said:
> From: George Moussalem <george.moussalem@outlook.com>
>
> Add nodes for the reserved memory carveout and Bluetooth.
>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
