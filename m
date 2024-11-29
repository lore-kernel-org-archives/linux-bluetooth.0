Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A13155741
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Nov 2024 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732900430; cv=none; b=g84ZW1Fl26jxiVoiDD3V21DB2YDncMTLXPvFXEj+KcnRhFX7muR7qdFnnqsvOoy3WZGBspJcdzo46uYn+H3CLOotHwDIuYixxOV7xkPGwzgb+yofJJvUJ/a63LfmeMOahrVVIyY66cRU0XoQ8m/RyWkmKkhwP3LcMh3p7iI5zYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732900430; c=relaxed/simple;
	bh=OVULNuLdiuiJSgGYUUiF7CpOzfMeTbxpEJR3jCkSq5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D22k8hoU/8vs/yb5CuaqyueaktJYwTldirMasV9c2dS96RwsR88sbpNBO2+SvdKu+kBBw+Ki05dTkAbVO2tTkA7YvNftRA1uVdoMeMbAo1/ndZYo4Wel4RK6XMHLGlog6Q6ledaKWntrwIR/o4KJ7gLBkw+3kVVggIlPZ4rKcqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=atVTwDcY; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="atVTwDcY"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53df1d1b726so2576525e87.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Nov 2024 09:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732900427; x=1733505227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KaSmwlTmC5QYIHum9Bux7hahnfWaBrL/wcT59DsXIOQ=;
        b=atVTwDcY/QR2Y7gdAv2d0gLxsQ7kJIZxneeNNLq2tNMMlysu/1WUvVsjNqTndSKoZG
         pVqpcS8sah9ZT40brVhvcLo2280UtmJPgKiWbQ21bWCLisgTte24oTGfYT7vJtbPayNg
         b+1LFuWNok+lOqRZXW5gKHf8JeuCGpaBCk6CsoMSxEYSl15G1dLQ12w0Mkun8hbdKAPd
         QydguwF9HFlDyyEsAgjbcJGB9nGfAQKrm0nz3nmfbgPwggEFyJ1Pc6XzqdY0GzaMzNRL
         RhPvhCDPo2jLKZ9asWn02vC9JYFCvM6ct41JYvp0m+aW8LYt55HBbaCCymUtI5f18FYV
         SKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732900427; x=1733505227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaSmwlTmC5QYIHum9Bux7hahnfWaBrL/wcT59DsXIOQ=;
        b=PNxDb8qOxy6ap0oWMuyjg6eIKXgCni9Aj1luiJjYX1LFLrex4QWwT7dn8Ya5cdr/UK
         XCWqHLOZqs+TsUkP5XvNn4h8ow0ghSAmBXHxUTtiFbmL9IfbIAHOlRbEy05+02Sk/4oM
         qjthukxFAHKiiqp+bEUd7BqhhO82CI4V5wTarM+Kiwih78KMYea/FOZS3IyyTZEsqHZX
         dA9So1CS+5YjvYc5yL0R7T5CW6RJsCmGN5SMN2DHRFn6QSVDwcwy22jaE9LG4poo+Gmu
         edP/69tQL9WtewVkrhpsSmi7uOWUZHpRHz6fthaCtz+r01bX8WX3JxF3ofPy+Hfh/Y4m
         XwLw==
X-Forwarded-Encrypted: i=1; AJvYcCVr3G2Y3icsGhozG9ut97IB86gRGwxSGYNK9xO0A+qZw0ABaSdicKaqA5+ng8zTM0HkLMf7F+DkeOzdeHAC4Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/cwJDjFlWstQ0HeDe5v83gR8QTlVJiQ2t4drmchjoxD+i2sel
	cXee0X220G4QyKtrOSyIe6iOEh6GK6yUaQhcQBFHzs+TKnQF0gWtCutCzzNPvao=
X-Gm-Gg: ASbGncuKFgK6MVW9wdJqQHMr50MITlb/jMhGgtshotxbv3aWSNKdsHSEiEtINWzTb6w
	J3KApvkgusXcZNw4Dof/snzjxF/8i5ftntuoE1pBKazHGuxkyZg5w6SM/n4NOYOGfuY4iwLP3Pf
	vslYnD67+m31r2xTbW6kKuBItwThDSbBodLfn96i/j2hbubDePop4Adqjw9wr+Ko0MIR2yVlqhS
	6Fe8SKkITi2S85hNgIItiVfNPVdoH9gggvABpOR2I3LcFVuYd0ZB8y4jRJRWdni/Ah+YUYwPiPR
	WesShOwtYERUp3GaddvV4GGNBpZQkw==
X-Google-Smtp-Source: AGHT+IGJg1oqUzIF8Y1+ias4szk7baOW2OySOACIMvEDl848iG0nT+EhFaH2JwRDoUvzjYl+I6RWHw==
X-Received: by 2002:a05:6512:1195:b0:53d:ef6a:17f4 with SMTP id 2adb3069b0e04-53df00a9f95mr8246482e87.1.1732900426652;
        Fri, 29 Nov 2024 09:13:46 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6442a12sm534219e87.58.2024.11.29.09.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 09:13:46 -0800 (PST)
Date: Fri, 29 Nov 2024 19:13:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: "Cheng Jiang (IOE)" <quic_chejiang@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_mohamull@quicinc.com, quic_zijuhu@quicinc.com, 
	quic_jiaymao@quicinc.com
Subject: Re: [PATCH v1 2/3] dt-bindings: net: Add QCA6698 Bluetooth
Message-ID: <vlmdm5yfekmx5miv5twjpukwhudcpjoijk3jxoobhzvecpsb54@her62ghhpruy>
References: <20241128120922.3518582-1-quic_chejiang@quicinc.com>
 <20241128120922.3518582-3-quic_chejiang@quicinc.com>
 <jaq7tjdq4srboo7m4byfofdbigy5hyeeqwyrgh72t23xgwb65m@lz5yivskxbwd>
 <cd82ea16-7c37-41cf-bfb1-7cc6d743d8e9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd82ea16-7c37-41cf-bfb1-7cc6d743d8e9@quicinc.com>

On Fri, Nov 29, 2024 at 10:30:00AM +0800, Cheng Jiang (IOE) wrote:
> Hi Dmitry,
> 
> On 11/28/2024 8:58 PM, Dmitry Baryshkov wrote:
> > On Thu, Nov 28, 2024 at 08:09:21PM +0800, Cheng Jiang wrote:
> >> Add the compatible for the Bluetooth part of the Qualcomm QCA6698 chipset.
> > 
> > ... 
> > And you have misssed to explain why do you need to add it and how it is
> > different from WCN6855.
> > 
> Got it. I just explain in the dts/driver change, forget to explain here. 
> 
> If use the firmware-name solution, do we still need add the new compatible
> string for qcom,qca6698-bt here? The driver may not use this string.   

DT describes the hardware. If you want, you can still add new string
_and_ use old one as a fallback compatible: "qcom,qca6698-bt",
"qcom,wcn6855-bt".

> >>
> >> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
> >> ---
> >>  .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml   | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> >> index 7bb68311c..82105382a 100644
> >> --- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> >> +++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> >> @@ -18,6 +18,7 @@ properties:
> >>      enum:
> >>        - qcom,qca2066-bt
> >>        - qcom,qca6174-bt
> >> +      - qcom,qca6698-bt
> >>        - qcom,qca9377-bt
> >>        - qcom,wcn3988-bt
> >>        - qcom,wcn3990-bt
> >> @@ -170,6 +171,7 @@ allOf:
> >>            contains:
> >>              enum:
> >>                - qcom,wcn6855-bt
> >> +              - qcom,qca6698-bt
> >>      then:
> >>        required:
> >>          - vddrfacmn-supply
> >> -- 
> >> 2.25.1
> >>
> > 
> 

-- 
With best wishes
Dmitry
