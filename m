Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85393603F8
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274799; cv=none; b=KL7uG0V+R35Jga332qgrfC0F3cST4+iufJcvZ5PzBWU/m2YI9VpMRAwc+6NJdmreJvdEN4WpCqbf0LpJahCgOya9GYxLxpLT3OVXPg93H/VFEju0H4rEJqzOiVKXg6hxAa7GCeuX+4VnZ9sa2Ytj1FQYtImcFecFbo01cMhy5zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274799; c=relaxed/simple;
	bh=tMuFqRJtSjW/BtSIGP7fEghEyWX1qeHJdf7t1D8fGrc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ag66B9Ea9RTjPm66SPAPbvv821TPtNGyzvrpBPJP3BKvC9RlTqefZ4yu8S593z/IV/NVGoRvzow0X83RRau+Oe1LUIOGg4XjrVzLL2eIgFtxha97BE/jUSNKKC96jozZb9lHLkxg4xHkSDWmhD4MyMkx6Xg+xTNAD2arffZoeRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=nD3x6+aw; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="nD3x6+aw"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bdb3fd39045so158144466b.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1781274795; x=1781879595; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTLM106efnje673B2OyrJhDO3JKyBJ//Wa8kKGBktzg=;
        b=nD3x6+awdWyy26Ksyt968dbDCZ8Qpn3bIemKFD9LS0X1++6tQ7bvece/nKWDtBtsuh
         hAt6hwlxDXWWafeDGCRENBNqbLHjOh/UNwv0iLHubDlDHbuq5QHbFLd0g3YOecbEEs5I
         K7WfYomB0W/2J/mgxj1vAVocYnyhyZVMWWhwhtT0c8FKb+T8jguBpLQaIapdJ5+o7LU+
         r1cfWuq1CBr16kFmSjod5ZToTQWKHsIQA6TdalfCugDvV5kqpRY+UjM9KJF0m63Pigrl
         D3QZhb+LfppCTRo+aeuXi4ulSWlnv0K5lEHr/TYiamrkbCpwsB9qihEdl7/XTxmeJhiu
         MyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781274795; x=1781879595;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTLM106efnje673B2OyrJhDO3JKyBJ//Wa8kKGBktzg=;
        b=mvj5opJSvc7LYiEi9m1X9uA3/HBPN1q3LJ2tzkiZXEw3p1e3R9YTNwFhW1MItlnYW9
         agGoB7FW05+dpyJTXrSvw3kPivknqKOQnPVIPaW6rw7GcHr0yFo/IHYbjBHrwVgcpt8+
         k477/FvPTMWC1/1em6H5Xvj0Ih9bh7k558u6i2ixpewjAPzTxA9/2GiHAPIM8RTR2dSc
         c4kf48PT6ONmIabtzpePbrlFPKBY7uz/paB71Kyg0gJApzOKPz4rYbgnmVn1m2U7eFc7
         pjNJ+I6kcAHMIsFWpCgSpaPoHUSReR/FZyyhMgQgfkvlhb4eDF/6Oz9WEpsHLigk78CC
         ykxQ==
X-Forwarded-Encrypted: i=1; AFNElJ8cQTsEmdExpB782+TXH1E073m7aAz8THvNUJBT3hGMZEs3B1lBXnXpHvLLBXSFWY9dJiHf2TqoylbIjKbij9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEFnbyldMV/nfWmBiQMldLFw2GwwaoCrbsBE4gffkbloa++0D7
	+fo08wmZRWH+fp3tAmMsmmHd8xAQDduAiRbO+EXm+ZYRiJfDmEg6ep1GkvQezjpkeAc=
X-Gm-Gg: Acq92OFf/LKFTWWAcMxqz870S4TyZZW+y7LNxxjAsC1Cqd8D8zRUXbtENKdRHy5Ssk/
	ldarnOZrXhcXltVCx/oL6B65/d0G4XHeCWnkgfcwFIdWFm3h+uiVr5k4nO10NavMw50e6FMwJkn
	xCvaIPXH8rYbkU2PYA1NW/m3bGtJn0gddvNWTl36BlcHnAMV2p6El5gdK0gtHfDuP5awKLhSmDv
	3Ad47/CkhVD9amIW9mMb46G1jjbmVNWJTQmeBnNiBiHZ7mwOOUbGoqe93YScA/6TRCuXrVnvth+
	wGzRylqO6jDdEL0g4i1RMV+1GgeU9IxlZNu+6DoRIab2djtN0VM2M/Cfc9ibDdYggPYNY2OCAmg
	yu6AkytQnZWDaxbYXpF7UE5haTrXShr0ir3e60Tm44apMXwDpmrxq0+Iea7MGV/GTFiNusT0Dpd
	D5xUV0AarVlJ673wXUaRcwXZEhOeS6OP7BvO24MWmUs0Fe8sDugUA+nkaPyI5pmjb4iTqrr5QEu
	tBD9rVM8cqsP/pD5GtaH0eBu+hRXPoDvrvlGw==
X-Received: by 2002:a17:907:9994:b0:beb:bf23:ac78 with SMTP id a640c23a62f3a-bfe2aefcebcmr149500366b.44.1781274795114;
        Fri, 12 Jun 2026 07:33:15 -0700 (PDT)
Received: from localhost (2001-1c00-3b89-c600-b4d0-bc9f-f60e-913a.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b89:c600:b4d0:bc9f:f60e:913a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb4b32308sm110137366b.19.2026.06.12.07.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 07:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 16:33:13 +0200
Message-Id: <DJ757RE8OYHO.2XEXNTLVIJ497@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Alexander Koskovich"
 <AKoskovich@pm.me>, "Liam Girdwood" <lgirdwood@gmail.com>, "Mark Brown"
 <broonie@kernel.org>, "Bartosz Golaszewski" <brgl@kernel.org>, "Marcel
 Holtmann" <marcel@holtmann.org>, "Luiz Augusto von Dentz"
 <luiz.dentz@gmail.com>, "Balakrishna Godavarthi"
 <quic_bgodavar@quicinc.com>, "Rocky Liao" <quic_rjliao@quicinc.com>,
 "Johannes Berg" <johannes@sipsolutions.net>, "Jeff Johnson"
 <jjohnson@kernel.org>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
 <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>
Subject: Re: [PATCH v2 2/7] dt-bindings: bluetooth: qcom,wcn6750-bt:
 Document WCN6755 Bluetooth
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
 <20260403-milos-fp6-bt-wifi-v2-2-393322b27c5f@fairphone.com>
In-Reply-To: <20260403-milos-fp6-bt-wifi-v2-2-393322b27c5f@fairphone.com>

Hi Luiz,

On Fri Apr 3, 2026 at 3:52 PM CEST, Luca Weiss wrote:
> Document the WCN6755 Bluetooth using a fallback to WCN6750 since the two
> chips seem to be completely pin and software compatible. In fact the
> original downstream kernel just pretends the WCN6755 is a WCN6750.

Could you please pick up this patch (or provide an Ack if you want Bjorn
to pick this up with the rest of the series).

Regards
Luca

>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  .../devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml     | 10 ++++=
++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750=
-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.=
yaml
> index 8606a45ac9b9..79522409d709 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yam=
l
> +++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yam=
l
> @@ -12,8 +12,14 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - qcom,wcn6750-bt
> +    oneOf:
> +      - items:
> +          - enum:
> +              - qcom,wcn6755-bt
> +          - const: qcom,wcn6750-bt
> +
> +      - enum:
> +          - qcom,wcn6750-bt
> =20
>    enable-gpios:
>      maxItems: 1

