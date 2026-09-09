Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055B63A9DA2
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954395; cv=none; b=P6zdZTDPrKfW++K+Bu7E0/5djbqJDR1SiFSWxwk2Scfv1FFxA3kd33YSWJ7+Pd3AqOwzINWtXEmyeV3tPDFTZx+lcByVCHURWSTAfDfh9kkIf0/RIoTM6bqe02mXlEPWPyNR3hoAUaM1SLhPR2f62pO1jQ/qblgBL3PY32kmN/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954395; c=relaxed/simple;
	bh=VHvyJm3N6VqiiCiBo4vnjF++MTywRTJ/wZXQ39ocGZk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OxgkjpC5QRH9muT0i6ZuCYeXIlMEoO+Dgbx/DKIiYUlcUUiK9GHIBUFCmX4YsET4vPHHKYn2m2N/qxOlZMaBvdn8MWvSBNioexunSpcNxQmga1gth7bjDV3azPXE40eLq9ils6qXTk+XJS6Y3YSqXxvrvIWwOzF96usaQmk+PkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9xn922R; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9xn922R"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca12086c06eso4442783a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 04:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788954393; x=1789559193; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VHvyJm3N6VqiiCiBo4vnjF++MTywRTJ/wZXQ39ocGZk=;
        b=F9xn922RtZX0EywP7xVpGOHT1x+5oIljX4VyxPV+ovSMZZn9wd1JJWbQmjDFUIhqQs
         b2pO4EkbqrZpdqipAzCcseLqi1UGzmT0K8EvkmVFOlXsKI8iexFu7mkvj3momeMPo0QB
         ibPys54kHgfAaZF72JWLCTGuoJOlkYDsz7ocLedHHI721JsRA7X4HJAO1ae8Be09s/dN
         GVBL+s8L8THtW1yFnPFZIxveb44pf0Rx1V1SnzgOgzSbbKQVwJy0eI7S4Lq9nJ9xWqDl
         XtrGF0FF/CaYXbPkDjPEvpV92FYh9yzidrmAA3ukyI3XEO8cp2wLoTBlXbjEPNgck+Zd
         gNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788954393; x=1789559193;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VHvyJm3N6VqiiCiBo4vnjF++MTywRTJ/wZXQ39ocGZk=;
        b=kR/CVsmREEW2hTp6J+DUCMQFE9jr7lZRqLqqHUEiKeCCb4UmE0BYzPvNgcEvFFw/mO
         CUU2wUQowtSmH5mv4hPVDoX0ISKV0/B6f8gIhVxylOVuWkdJxsApHaLCyNC5XTsVm0aO
         k6sHd83bIUvu81uTxWc+1hrLNVOB5zjEG7ppzp5PaOjXMpkwT+kslHPkBWcaQbCPWNb1
         O+AGPvP8W6b1+y1mgQl0387/lLQWf8QYsUCliQONeIhjvGtpES3qXcGUoo+QUtxKjNOE
         on3Bqlor2pf6cYLXAUhw8q8AlpeYYE+p5+rBoKPJNxM9naXyUTs4c+sitkL0CpY4EcRr
         D+jg==
X-Gm-Message-State: AFuF++lS/iB7gmftScwAQlktNHDKo27HfsFRQmX50emtTs5pqfDhGJxE
	fUKHFQgmrAeXSBKawTGlpu0YTo0JSNQKOW9ck/x54O/Y5ujbutLREAMfCDaT3g==
X-Gm-Gg: AYBFou146vQod/O0DwCQ7cgZhavyHTlebvcuDAc0HVq83tPFDXnwYyErW/ksNxcp980
	Rl88+qrezyxNisRVDdbWaO/frha1RA6mJbTkC00lMaT9qj0m75EvjJM/WABnDSnmGAqCnyAFHIE
	0hJJ/mTxSSCvH6vSOmQuekhpFVH18BkADDqyaQcFs9BLMofMA/P0i+teOCONQ9KJDTg40c2KK94
	FK6HcKOJC7d3bKJ58+Z2DSlD4ytjHYaXyiIBJG/w20JAJEsofzbLgDdwF3xV+7d3Oh+VJWFKrmQ
	NesdBNb9sB4eZ/xcocS8i3jCEs+/4WRwo5UqS7ZxLbrhJyvQjzUEiClvDUAev8ZyFnSaLXNDr4U
	wqyjTMf0BYcpW6WQI4SQ2pERCMJ64OEHhG813SuXuF7WsCWd6ufyzHd/y9VuErAR1RF+k85VqgL
	5ylXUHQRNgj/y1bgol24eYbQvX2ktJiK4Gow7syYz3O8JZgDUwvtfzln3nqaUz8XzkKljzPnzQp
	6whDg==
X-Received: by 2002:a05:6a21:138c:b0:3d3:afd9:6040 with SMTP id adf61e73a8af0-3da3a1f77f2mr57269859637.27.1788954393079;
        Wed, 09 Sep 2026 04:46:33 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.55.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3342af0bc08sm44047716eec.17.2026.09.09.04.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 04:46:32 -0700 (PDT)
Message-ID: <6aa14718.17b2f02a.39821c.35ad@mx.google.com>
Date: Wed, 09 Sep 2026 04:46:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3264309468913642233=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lee@kernel.org
Subject: RE: [v2,1/1] Bluetooth: mgmt: Dequeue pending mesh_send_sync entries on cancel
In-Reply-To: <20260909111021.2322753-1-lee@kernel.org>
References: <20260909111021.2322753-1-lee@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3264309468913642233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/mgmt.c:2399
error: net/bluetooth/mgmt.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3264309468913642233==--
