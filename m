Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D3C4CF49B
	for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 21:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792272285; cv=none; b=gyvS5wmDxQJqrJgZmuc7q9abZHXoQT6rirp+cUbb6F4suizKbmGcSCjfp9Cdg8fx+ziuBmtnyukNQioiqNrDoNdjkSBaxAdvkDBFb8wnmI5gjKnj2VaFvKYCUgXcWeKNDyY/37PXvh0BFyZJxG4xsRlufJRUa3GKBEwzfSuQE94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792272285; c=relaxed/simple;
	bh=hrrWDiy/kbLp5k/Qv2kPUZiRlAw0Rqi8oEIC+VmD/dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lcxib/CWyDX+ThN1WQH1fMMOCH7lRycS+OCJqgXqwAY7fRTrUo0iyqCHnAsw6yGMDI+o6mdOe58bEnAbrOqmsUfRTUHrIjsP3XSVXS4aEJtSwMqUABcs/RLy7x3D3C0PTGX74LcsZ8kgKTzINh+F8LDfS++dxeuSkdJixEOcoX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=oloDkRbl; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="oloDkRbl"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-354ba08cfd1so1486911eec.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 14:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1792272283; x=1792877083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hrrWDiy/kbLp5k/Qv2kPUZiRlAw0Rqi8oEIC+VmD/dg=;
        b=oloDkRbltzL0V5rQA3kDeFKaW+6V47CV8m5uiPrJaIDR8G1Vo+VwWuPp+gTOH160BO
         G6A3zqNQeHSwbVajxBu5loyICLw+X1dW+qMinJ0rrZCPcZovm6ql69jE5BJHwjD1xqje
         N8D0/tj+qG6Ktxxa7TpGPPtNiZXUUCZq+9N7bg2IMnMzmwr5u1n98UZ9B3E2ZaxFHRmX
         fvpOJ8thQkAnT+MkVRrKsuoZoN99YdZbdaEDXTwbIsPje36OxEBhElK2/kww9qAaIGID
         zswWTkTjHXuXAwTb4/hepgQUFPcC/s2o1dWYX4fWJTt5Z38uvFoNL2KrHq5d18wHxHqr
         KxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792272283; x=1792877083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hrrWDiy/kbLp5k/Qv2kPUZiRlAw0Rqi8oEIC+VmD/dg=;
        b=t2O9/6bzHJQh5NbsNfsqDxOcA3J2ujYaLKSoIob4YYd/CNF+sM++6oa9en8sQwIKAm
         s1q2JQ2Eqq99BHjVF8xBNmyAOiIwMMC99vk6uFqPeafm1s+y2C9skJK6BUuGnDzF+G4p
         anjBNDf8D5vOqQBQDPDLefp//XCfN4qtz19BZtmQeRv1UjRIwPSrsg3ciPCho484g+Pd
         G0i23Wp+7tj8qBBAefTcXWX+XkFo3lOQ2uv3WpDptfqd773wXd3iY75YFcvyQLsxW+dJ
         FP3k7TFYZ2Wot7Xe4k/8h4IX8jZrn83/g51rSJw7BOwHm9zoStoovOQIOkSW/CCru8tH
         4ZHg==
X-Gm-Message-State: AFq9FYKQkviaS8kWImjtDXUH+4ep/r8faAPpCRMsy4aaPtydEX/bPj1z
	l9xW6SgQ27fxpcjRTAGARqqRhiCzJXBqfFOWmMMz0N/vT63efh+wz/FxHp+ZyECylftefJ/9L8z
	Ln2FNBG0=
X-Gm-Gg: AYBFou0yWws8Z+1Uq0aD4KfSUVqtfdfLjVPNgInoj3SVBufyujyCaBkv6h7736Y9ACy
	XeqCm4djkpqkFUQ0/Kj9qwJshK5D5DXNj75pQtDsG0E5BDDD2GGU1pUUS0e/OyjgfGezQDKOwS/
	BEPMMv3QoYWTuMf8kIZVAEcvMSpFj3kMgZvGKJstEGaSp7PGzovDjzE617n1Y9JcXbA0vp6wk42
	tiW56+KmcLUPfK/6jd8uFj8dDCwZrt01dCOugIs6CqIa3bB+UcnWElYu3vfaK6r3r8Q/uCo5U4G
	6SvUv5VMzmLoJqn4qA4dcxVcyr5xurI11aJSbXwnuod50HrSb3sA/tjA07YGNAQIiwrTgXtE79Q
	hAycsanfHvk+jb5Io/CTwLdzeihVYFkRM4cEyu2iWh3430qI4QsEI3sjzS/ZbTsX5Ogc82DmSFB
	LNoqfdYq32hVQcvb12YrKQSSecoyV1z/CahPH2Ql8i45fqMfgslnEaqlQYIKnjqWX95qSADEG0c
	7LCiQXm8+EiNTCAmyxeUT0y4mdYm0ziR9yGsmOnF4MeK6JLuKEsGpmMznRKPI0pPxOv2/zc/+yP
	JWRExi7uU76zK1UxbYGDANfl2H2Nxxl2cujvALGz
X-Received: by 2002:a05:7300:10d:b0:351:1e89:66ab with SMTP id 5a478bee46e88-361a0e85fc5mr5265300eec.7.1792272282401;
        Sat, 17 Oct 2026 14:24:42 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082e81a06sm17563565eec.26.2026.10.17.14.24.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 14:24:42 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-kernel@vger.kernel.org,
	Kevin Dewald <kevin@simpleble.org>
Subject: Re: [PATCH] Bluetooth: hci_event: Clear explicit connect state on LE connection
Date: Sat, 17 Oct 2026 14:24:32 -0700
Message-ID: <20261017212432.8372-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261014224145.10801-1-kevin@simpleble.org>
References: <20261014224145.10801-1-kevin@simpleble.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luiz,

Sashiko flagged two things on this patch, so here is what I found.

The medium one: if Load Connection Subrate arrives while an explicit
connect to a device without params is still pending, the subrate values
go into the temporary EXPLICIT params. This patch now deletes those on
connection, so the Connection Rate Request is not sent. That is
correct, but bluetoothd only loads subrates at startup, from stored
devices, and those params are DISABLED, so they are kept. A failed
connect already deletes the same values through
hci_connect_le_scan_cleanup(). Moving the cleanup after the subrate
check would not help either, since hci_le_conn_rate_request_sync()
looks the params up again when it runs. If you want that case covered,
load_conn_subrate() could keep such params as DISABLED, which would
also cover a failed connect. I can send that as a separate patch.

The low one: the comment in hci_explicit_conn_params_set() still says
the new params are deleted in hci_connect_le_scan_cleanup(). I can send
a v2 that updates it if you like.

Kevin
