Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C45E158A09
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978197; cv=none; b=Uq3rss2++eH6l1d4zYQDT0D6pDI0d9I2wBoGBrYpUEO6iiZNpH0/+qjPT6wHH4pdfm6chhd4UI8VHIGtXdZRTh/BItnfFHwCvRUOEpssFSxeAikyCVuBwNbkBFd0UrXQerPf0YrTL86XwlQxSrzvokMVmMD6W/il84DvqYhFPKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978197; c=relaxed/simple;
	bh=wgkgu9uxJGXnH8Azt31hb2LGhFzDBhgWYxHF/CDQvc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JG86Z5gvWdpOYjztG7H+ihJSdQ28pguS+q7QsLKCAaXtFFzCH92faw0X5xXYk5TmUcgmvBv7bZ7VUtH0tlndHJE0zFA2+0P/hu9y3SNAdN71jpKgxJs6HYVNUp5VDBGcCiUIxRe99BBy6TejzArcPm665q0ffWBT53OxRRlsVYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFzmkFtO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFzmkFtO"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43690d4605dso46013295e9.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 01:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742978194; x=1743582994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wgkgu9uxJGXnH8Azt31hb2LGhFzDBhgWYxHF/CDQvc8=;
        b=QFzmkFtOmU1FePOBtA1h74lZlV18bE7BIsiKh7cWr/M0iywEqjcQnnWQb/LCbL77+p
         WAJsJnZUw89qGkzmVwBNziYQaNiw8sI0z8/h8z1mhLdf0saOpcGC+Ds421T6ouleqFkK
         dzaFCpW4E77sD+U5DA4UVQ8Z27+PV0yAwUFC8/2LtQXNWfiXYcIW94nvFNRP4ER6en5C
         Tst/jSwmwGzzdxoZ0s+bmQL5hmKX8mxM2kWbtSzG9OTFYyHQq2F54hdtR4D0q+LOsD5k
         +oigMStBYo5fZA4pxJ/yufFO/2diknhMNH+comvO2UEy2B4DVe6aNFPXZOCtUyGOlTNO
         g9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742978194; x=1743582994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgkgu9uxJGXnH8Azt31hb2LGhFzDBhgWYxHF/CDQvc8=;
        b=j5DCmQlsz1PoRMinxA2cyABDNrRo/pHTMydNs08qdMMZhH4AViEX3utjf9Idgrp0JX
         7rDmJ+SQhvDiKHj5iBGRF0/b2PMGtn5PElNjwNMIdH7vaV7dXqktqpR2G0PdQ+yZZb0d
         XMC0+nGt2fL6Dl0+40G3JJwXlnEHjNrbY1y6r6W0iLRQOV4t0WdF2JY6V43mva3ATI6X
         Y2wFhnCyJCIU42gIfDG8+baMztgo+pqMuH70jCO5WO54WjUX60MgQU/veL2tMoEsa83a
         WVjAqjBdWrjVjygpxUdygGzZuJ9Qu7JYX6+9at9G8wIcMYcWdyFh0rFGFOIiufcx/eOS
         cXog==
X-Forwarded-Encrypted: i=1; AJvYcCVKV7ktjkt2qz8+mBdMNGhVZQln+DNzZtF4L32U+s9bHuOrcsL7keHGEwCA7p5LV9vpCvkzXDVpt9pfjRU7eP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ2/W3ooNGjmR/A1yzv+ne+4VqRmMykoITcM9sISQLbTueMRel
	bqCRIfNuiosPW7+Oakwu4kG9ueok1akk3e3sc0A4HxjN507SbZytzwoHfFD5V2Qj4Q==
X-Gm-Gg: ASbGncsij7gL/z4l27s7WSZJ1KWiFVcKyfNfH1jR0J/0MJN4raecyOF2hR0H07ngntG
	RxcrO6PL0XxIwaT1diMdPWmQESLmGRwciJrWwn1IFO4oCvwyXXtbT2u44WclCwvK678HFUT02XX
	Zx4CWojNUupEzZThkVLrlaL76/W/aqueLUu+lW1EGUxSj+cNb3y0tQS+Mb0hluXi6d8MqvogJEn
	5SQD+TJNT2R2ec+tbBxbfe0Js29A7pSqxT45LNIBPf7e4zFyrJcGDz6xtcmS1Jy97ej+XXSLFlD
	5JD+oHv7WgpU7lNNS3CjOtmcZm8fJFV3FqwxvZuB/F+6F8Sxvz6wOTlw+l0ylihV0ctOwHIjVuC
	JjXPgsOmCQ5aNjrBBJJUDYSogPIx4qpOdragdgwrG72WckMIIoxK7HXEzH6c7kvRPkHWSWGr4/d
	DZr2hoDbMj5nK8+dtFZvbo
X-Google-Smtp-Source: AGHT+IHEh5Ky6qeQw6GLi2KWZSl/Q/ya8PtPdVtbtu/bTMC+DeSNCF7+dgZ/HXV+f60Au2C5LHrM1g==
X-Received: by 2002:a05:600c:3110:b0:43a:b8eb:9e5f with SMTP id 5b1f17b1804b1-43d509e38e3mr189151585e9.3.1742978193625;
        Wed, 26 Mar 2025 01:36:33 -0700 (PDT)
Received: from ?IPV6:2a02:8428:af44:1001:4d02:f29:39f2:741? (2a02-8428-af44-1001-4d02-0f29-39f2-0741.rev.sfr.net. [2a02:8428:af44:1001:4d02:f29:39f2:741])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd26cecsm174670955e9.17.2025.03.26.01.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 01:36:32 -0700 (PDT)
Message-ID: <1c571e8e-c6e6-41b5-8b5c-1ea20cff89d8@gmail.com>
Date: Wed, 26 Mar 2025 09:36:31 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] obex: Add supported-features tag in MAP Client Connect
 Request
To: Amisha Jain <quic_amisjain@quicinc.com>, linux-bluetooth@vger.kernel.org
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
 quic_anubhavg@quicinc.com
References: <20250320123126.216903-1-quic_amisjain@quicinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>
In-Reply-To: <20250320123126.216903-1-quic_amisjain@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 20/03/2025 13:31, Amisha Jain wrote:
> This change is required for below PTS testcase -
>
> 1. MAP/MCE/MFB/BV-06-C
> Verify that the MCE sends its MapSupportedFeatures in the OBEX Connect
> request if the MSE declares support for the feature MapSupportedFeatures
> in Connect Request in its SDP record.
>
> If Server's SDP record contains the field 'MapSupportedFeatures in Connect
> Request' as supported then include the supported features
> apparam in obex connect request.
>
> ---
Tested-by: Frédéric Danis <frederic.danis@collabora.com>
