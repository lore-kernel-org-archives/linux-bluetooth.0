Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795489048;
	b=pKo8NinxmDnJFUl7MwUf5WWRPL44QVHgqdsJlLaImS5gnWonIObfkb/w7x+Id4SGcRPA
	 yNZq9XDt+J+YVluGaU1fthJoUrBLMesH+lwuGVcgL+ca7PmOOt4wh9+tbsJTX+3i9JUP0
	 HbgThxAD4iWJeTpE6Prh3l+83bhotnlinAOqEfqcrCk+PBPN5dt6jEpOIJ2qZQ7V9p98V
	 A9ofdO5ARh19DgOUQtrtHopHBJpKkZ4nX1xeY4BSarHEdZyqRru7Mo7p95wDkRO9dHdnP
	 m4Ccu1DAFasMDP5O4Palwp5QAm4Nz3LtMw5anF9NS2Zg+L1WYMLApGRsr07ix/Nz1rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795489048;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Z2346qPlbqE+w6NK/kbd+5STGHT/xmU/Nmfs8PzX6I4=;
	b=O4+hCqIwo+ObjRJORa9cKisONpk+MVj/9OAGeMfwsGAb3GgjSF9nJAF950J3zZkYg03E
	 tKJo+IHtKO3AGTCJ05K++81I/O8Un75dnSICBc2JEZ1SpWQ1+LW3aal03N+6eiaGJ0RjK
	 bMZCw5fRTJOEKrWzMLELRcydwTGQ/KF0VCIwwyfcreSRuXVPQDrvYn/VTz4iBtSJ/NReZ
	 uR2Hbhgj8K5nAKZjepl9Vuc4SC8HKcZWtln+4TxpYd0gpqpTDGQezFbxwDP53gah5cngl
	 wIGa6G3H96pyVW/oZKE3ClRdcW1pvbK9WT1I757VzXgEriE9gyCCmGuJMmmRYt9ZPaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BcRaiItI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="cs/Xyd/X";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B125E606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 02:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B125E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BcRaiItI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cs/Xyd/X
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2k1fE3701099
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 02:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z2346qPlbqE+w6NK/kbd+5STGHT/xmU/Nmfs8PzX6I4=; b=BcRaiItI0yZRC4oi
	T2KXQ9lC5+m+M92JiEDTaOx0KAZXCJjs6tnSYuizq0275WZfU4FK8X5xCX+k7MWW
	qk9beO4vunUKq0uWu9/DmoLJ7TZ1ANV1v4dHxQxk68D85t4oBkUKvD0AmMoSywky
	BORpZyLxrWPbAaakTsKFq7Mfw0h5jQG0jRb+HtNtCZDwia5i/1fsAYk4J+B16+fT
	xkR/U4AdzVFwWwoHJwFf++/Asu+GqzEgKoWXzWIS79VuW57KEBUYMeznPeU52GyL
	8xpf77OlPCyXsUoG5NgUfHC1GxoMsevU+bBKVW2jbA39W59tc18VDgOwgPcZrked
	bJj3XA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j50ky0apk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 02:57:26 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2f021f3a9ebso8177355ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 18:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795489046; x=1796093846; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z2346qPlbqE+w6NK/kbd+5STGHT/xmU/Nmfs8PzX6I4=;
        b=cs/Xyd/Xz83/srYM0qk2XczY+NQwDqCymddH+LhkNn4lOfzUZIH+WE375mZZB1bMr8
         +uV+hRsyFh6xEmjB0J5lrXskfJsDDsedIdPy6shlTabFadVmrDlpYqDRJSE5hg3VWbat
         Ytvm7lXzwIXKRpBtTylDN5nwiVIFZx5Y9XcISmgEi0/Kd43aFwfYJjiqdLBnOJeNgyPA
         7FTk3u2UYffMLqk/Rth0GCwvMzyHt4xfdvL3NaZOXnXSdXyTz7MwBNp+vLe7hj9KxYwe
         VF6lIh8UDvhO8p5lCK2yPjwFw11oikDPCaKInD0WlQBuU2wu8BEe47qg68Sh54reaC4M
         tciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795489046; x=1796093846;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z2346qPlbqE+w6NK/kbd+5STGHT/xmU/Nmfs8PzX6I4=;
        b=PN+Lgs8itY2b3wfO7raO0dkaPTpJw+fTQGOjatDpUlrNoFdsZ7n4/QfzRx8OLyA4dt
         ja3N1vLNT0Owa6dOXDrYopwHtZafHJkxoMg7KGs/WrzT0WpI/z7XPEPHV0uprVl5U8xg
         /oRRezbFnNC9BKEdeERX5l0OcoZxWPmID93Wnw1WvrSKzuU0sVgHYXWaBah1ZkzOHgBZ
         nAagXjMISZDyWypIkAhM6TkM1SKEaGA7u7ry6ls1knOCKeswly0jeYrS5DPiY7FkCd3a
         snFhVn6FT0z785DKx1VHau6DooM7FqNQgVfvBR48QP+EEetvBk57sdrChfpoxnek9ixm
         KZ3A==
X-Gm-Message-State: APuU4Z/0fq3+GhcKcnJ4SoUi4p+ERrgG9hHyegaRduyMmaYFzDjG86G3
	Uf+ukYT1b7toV4e39Zwk23/vs9IjebdgXySs11iWP9VixkY8HO6hLT3Ms1kFXsG5mQP4Wvqf/vN
	q/XsSpoRVQ//cCu2PKUwu1BWaRJ8eldhQrN6tSIAj3mDZ0XLNxYZFhVf5l5cFcRnHRTI697DV1J
	ijDn4=
X-Gm-Gg: AZFdTZfO917VQ2lm1FKMjXES8IEsNVMTuLaqjC+4vdZaSdzM6JqFO18Hy6YbqcPH9xM
	9TJ5pIVbpZPAznf+YA+MYgbEwqqn0PAw31qeoLktBV+86r2PneGG92YJH2FAaX2xV37fTKDSPDY
	aukgS9f50bKQoZkkgmWR7g+3oldp3AtjfaKuderqm9eOayVjay0Rxtf8caW0fltHn2yO5SVDNRP
	48WYP9nHUba0gsP2GPQXyq3vrx5kAjWNLYjRj3CAjy7C2VnQho5jNhj2WBuBqfLOsUg0AU4t+xE
	n2zsDYEfNLBFO6XiF0RC8CM64o0A9k1ePb9WhOq6POe6cz0gHIiM7zMwNvjp0mCtp7n2DqexASy
	R3564IXPGFVzxSB69b4c12H41NMYuTc7Fftfb+unPTKt7pahGcBIimXemlgArXCQPHGG6EbAvXf
	PthI48GLgb3V2WfsT5A+P6G20q81PNj/MgTjN8hE4=
X-Received: by 2002:a17:902:d547:b0:2f0:33d8:f88d with SMTP id d9443c01a7336-2f03ee6fa4fmr213866905ad.0.1795489046040;
        Mon, 23 Nov 2026 18:57:26 -0800 (PST)
X-Received: by 2002:a17:902:d547:b0:2f0:33d8:f88d with SMTP id d9443c01a7336-2f03ee6fa4fmr213866605ad.0.1795489045545;
        Mon, 23 Nov 2026 18:57:25 -0800 (PST)
Received: from [10.249.21.191] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f1276c5sm65412885ad.67.2026.11.23.18.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 18:57:24 -0800 (PST)
Message-ID: <eb42aa05-3065-446e-b257-b08477e04c6f@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 10:57:22 +0800
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bluez 2/3] tools/test-runner: Support running on arm64
 hosts
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Pauli Virtanen <pav@iki.fi>
References: <20261122-tr_arm64-v1-0-4eccf35daeca@oss.qualcomm.com>
 <20261122-tr_arm64-v1-2-4eccf35daeca@oss.qualcomm.com>
 <edb6288e11cf9eab058cada5151c0c071587eb3e.camel@iki.fi>
 <249d8212-f68a-4eee-b92c-efb339dd9de4@oss.qualcomm.com>
 <CABBYNZ+-8kb2wA4fd5oYq=_hi9BSfFwie-RSpsZdVbCM57qCUQ@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CABBYNZ+-8kb2wA4fd5oYq=_hi9BSfFwie-RSpsZdVbCM57qCUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Y+ptIReN c=1 sm=1 tr=0 ts=6b04fd16 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=J5rNfPaM_tw-T4xYV3oA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: a6cY7S1YcWcpismh8A1l-kXq1H2XNu1h
X-Proofpoint-ORIG-GUID: a6cY7S1YcWcpismh8A1l-kXq1H2XNu1h
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAxMSBTYWx0ZWRfX5Av4BQN+wExS
 poEUW8ughkZfqyx9QuDib+zsC/oaWW2pvutfLxZQeJI8KKQweDtsxP3ZbJTeTGdFyoF4iBv/Fo3
 rbI1o75qUUNK/kMU3DjdmQXLx1aVVrk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAxMSBTYWx0ZWRfXzj55cjaGxnmZ
 4ve+SKFG5V5pkk1r9ox9HTjRXvrwboDpB7kqblynaWhGtdJDWsIX5GzQrNh5qRFco6uyc05sXkp
 15ZXTZsYePMoOkikWINQlsk3PwxGuUvzh3HnEEqEpKduH6Uvzh5qm8AfMLk3cTHbemnpQbI7Feb
 2p07T+89Q2D/wn3vGLLzx5qb+99AgLJLEQfTWOjfThbLOKfov42oic0CSpLDKWI9xZVWkaSrhJJ
 T+duqq6LwmefXd7iHA+ij7j3aHtXCmTe7QHlSHAlTWqjdzxEYqjaaIlj1mTTMt7oRg45HxQbGB9
 ZsIa9DmjFfTvkN78D5qasxOPC/5Vg/amJ/pGWdaKNHPHn3AF8izFMKNaTCKlLCKuAxU3rRz6M3s
 O750dFrdsWmen2+EIBOJLDvoN4xVjEax1Yv7b721M1ZstpYcz0tqZSDRbfD+/IwnX8xancWtLXc
 3LSO3ToqFlWg/Wle8vQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240011

On 11/23/2026 10:45 PM, Luiz Augusto von Dentz wrote:
>>> Should it actually determine whether to run qemu x86 vs aarch based on
>>> what the kernel image is, and not the host system this is compiled for?
>> I don't think so. Choosing at build time is correct and simpler than
>> at runtime:
>>
>> 1) The guest shares the host rootfs and runs the host binaries, with
>>  test-runner itself as init, so guest arch == host arch == the arch
>>  test-runner is built for, namely, the build arch decides both the
>>  host and guest arch.
>>
>> 2) Kernel images come in many formats (bzImage, vmlinux, Image,
>>  Image.gz, ...), so detecting the arch at runtime would add more
>>  logic than it is worth, while QEMU for a given arch already parses
>>  its formats with -kernel.
> I guess that is a fair point: the tools binaries would have to be
> built for the same arch of the kernel image. However, that doesn't
> rule out running test-runner on an x86 host while mounting the rootfs
> with a cross compiled tools. I guess we shouldn't recommend that setup

That doesn't work, e.g. on an x86 host:
test-runner(x86) -q qemu-system-aarch64 -k arch/arm64/boot/Image -- /bin/bash(arm64)
since test-runner(x86) can't run in the arm64 guest as the init

> since it's counterproductive and considerably slower to compile and

Agreed. Actually, test-runner requires:
arch test-runner is built for == host arch == guest kernel arch
and failing when this rule is violated is expected.
 
> run. That said we could perhaps print an error if the user attempts to
> pass a kernel image of a different arch; test-runner should probably
> fail with a clear message stating that this is not supported.

So, is it acceptable to illustrate this rule in the ARCHITECTURE
section of doc/test-runner.rst instead of parsing the various guest
kernel image formats to detect the arch and print an error?



