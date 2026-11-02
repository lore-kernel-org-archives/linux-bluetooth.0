Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613554;
	b=ST2EY2ZVaPvtuUYV8vTmWMooj12vZw4gmSSh16koQ+UmspkBE1KJgrREdLttEC0YzJvv
	 rvdpQ6D9LyFj3t881uXvtqJGR38aAOZz0YKxUCx8GtPR5CeKugdfQtoEIVRkGqNO8/0mx
	 55PE2ZM76mjGFog2xwkRYU8tu9IOpDBinUNbbu9mLujnjhKaQDfhOqVc7d31UzpFTFZXN
	 2E9JxECezvrGoqu1vwO83Olef4l+tbaoN3T++MEwrmalB7+G8/9rluQbMDepxZVjpX5k8
	 57ALGoIysxYHjMnm4NQuim5o2DeRavJyhKvhxyhkh/fZmoBH43x+CGmIWUnyCPV9EDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613554;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=DvLqP/tFCRw+lDS6WYFmF22WIsggD1RJMNZO7NQX0Jc=;
	b=bqB/pXd4jYlC2sjHhaQYVC+vzxLvoHYqjnUPh2d5/o+NVo15FJ6NcQZHH9zT6LmleBhe
	 oKUAOuPVqQHLxZdGJg+YpVLfx/Nvi6QMr8gcTwRcLlIEkQyHgWtSRmptLp1Qazp8yxJqp
	 LVSHq2LE+r0bc6u3gpV87dJZbUnAimvUKgMcQpUHqxjfKgw8gYOWFjaquZSdahctHKl6h
	 7aKVpI+SuPCSFq3ka+S6p43lh4OMDAGPdWxSkKhFMQ8lmUhXE60AbSyogp3yAPXEtJAxp
	 4JYQT8TqVijhzsbHYeAI0XNzgLc95JbkemDmJme5B+8JC/vd86QH/tf1B+T2W0Vqnhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ctdHG2pg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kHzd1pG2;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99324606A334
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 09:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99324606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ctdHG2pg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kHzd1pG2
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29B2dY4015097
	for <linux-bluetooth@vger.kernel.org>; Mon, 2 Nov 2026 09:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DvLqP/tFCRw+lDS6WYFmF22W
	IsggD1RJMNZO7NQX0Jc=; b=ctdHG2pgkaQCYWdXQm7JOTj2bSHBkT/Kdf70Gzfw
	vfeGb1ztNVIX+f+hBwpNXGc732fuW673AIMV72by+Z1LoNgJgIx1M3ZdiIbGv+zQ
	9y19vQJ+VpPpsw4/14hqmAMg1vyr6kcg1JarJZWCUVn6e3qUAcg027GTqosZ6889
	d1ew500EPfPPzuqftIbOjo770OdBMtD3Ql/r76k09+LlI7MReICFflm++aLQXPDp
	BUN/ksGQb3w0oVzm0BdunQF3DZzA5KHiL2WBqvtCllJ7xAGQ2h6qoBmjVjj5r/ks
	JWgJ1HV5HM0NyP8jKo53WpIKgv0xKcIMyc8SF3VObcBuaQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7b6pf6n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 09:59:12 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f13c143c8so516711685a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 01:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793613552; x=1794218352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DvLqP/tFCRw+lDS6WYFmF22WIsggD1RJMNZO7NQX0Jc=;
        b=kHzd1pG2eqtms50mvSIRtxABHbW6bbKsrPDc2Mbx5dlY/5dZNRjnn9p/pTbVju2Xjn
         vo13Ne/9kBdNKi1i+6Gq+NvC7suqZoNR2FCbCkK7c1kxM+jkj0MKfzHEhIG/m6YP4iKi
         oD9mdavN0bUf7nmQHSla+W/KIc6GeJrLrs6l4Z1zUOgR8Z/9oDzHN4ZHJz3UgIbQ2c2k
         pfI6hPcKpZvtnta4XZuvp6fu2HUxf8s+Zu3JXmsmQcgSjrbACDBkGDx1l73vqlvwOpv2
         wUTs5edpeVMamCt0qXZnVDv1a/Qw4aPX8mrrj5RzJ88M0AnkBQjGEh4tOb0mZ6hpaGXI
         xklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793613552; x=1794218352;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DvLqP/tFCRw+lDS6WYFmF22WIsggD1RJMNZO7NQX0Jc=;
        b=dyNX/6lojgzhUdxv/z4uVtjzcDSzUqAl7r9leuF9uxqP/8laKgO0vsUbGivB6LrwBs
         gJLpNTIzqB8yWeAMXqNaJIM6pedozA74D+BJSyb0IPgj0/USMcgNgKIEZIx/zHSkdi/Q
         UoEpIGEEZnwpyRuMoSzFnPXSk8xvTYTxKWC3r60vzl4MyMzYuG0bXAt78JQ0ny7G+tvu
         BYO4XzKWLg7lP/8HDP+Lk/61PlENYJBYyqFeM5jnQ9123OJUN+GOgsHtIpqWNc7LXoI6
         nFEwAVAlEq6f7ZytGtlOJHrbY3w1y+LO4ciqS6abkmKh361EiUVvDwT9nbbmwGpSyYyT
         +gcw==
X-Forwarded-Encrypted: i=1; AKwUvBy7Q/t7q5brR2b0Aryo5g8Apr5ik5wSJensuZVRm83fjfpbQfBvCN31RqFzzAuxzbRr87kyiWKbP73FZrCcSeQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3txTFyBZxoQ682IIpUmzgOIRClpuRnn+YbJnn2ZcMmjEwHf+G
	/q8ckTFEKSm0N2Xefm3B2X9aB1A+q50XU3qc5TKPtd0a3ZYYibzXSfhfVrl6aMDktazUIou/Y19
	OlwpGD5MNs7GrFlex8nIvTPIlc+OKUgkRUWdVrlX+2tIhSRNATC9sWdhcustJSwBfo3qZ+lo=
X-Gm-Gg: AYBFou2mhgC76vfwtFfqswoHdsh8GWB+cI1lRueX9dR7U/COvz+YIXM+j8cw1OGp34q
	JI4XZOMOk6hq5CAq3HZ62V3vRdm2hQ0aC1N+Ln/p7zInHI1QT3zhEibhQFYO9vfbAg7DrBzIqLe
	0iPEx6mSNkFmyDDj+hPEXIWRiUZ75QoPjFTnLBqusMKtlRXRJJIyiWcQmbU8x9OeobXTPCnYbs2
	JPhgyzSHKFSu9LgJSPjV6D3Z+BcpZ5csbWSsIRbo8Z1r/ygnS0nsyQway3cTbr6A0gZcEhlKFJf
	/ZTmKnObR9VKQJXneLS5noLLfHo4zY5PIDLe/jipDCQ9vpXJGGrjKKCfuD8sOEnEmJay7HbrpQ8
	yR1oNdrg98sGVUmYMOY7bUG0n+EWOuaOW7F8Ili++DaFpBtwm27k6uDQMI3Y7WQ58aSY0MZbpkA
	apLctTjIhUsMAXeK4HlyB5oGaF+VPigARFMmV0hAaFRYls1VoJEAQWo/qiZ91k
X-Received: by 2002:a05:620a:4594:b0:93e:c12c:4409 with SMTP id af79cd13be357-944217cece5mr1518817085a.69.1793613551922;
        Mon, 02 Nov 2026 01:59:11 -0800 (PST)
X-Received: by 2002:a05:620a:4594:b0:93e:c12c:4409 with SMTP id af79cd13be357-944217cece5mr1518813585a.69.1793613551287;
        Mon, 02 Nov 2026 01:59:11 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe07551e2sm1516515e87.84.2026.11.02.01.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 01:59:09 -0800 (PST)
Date: Mon, 2 Nov 2026 11:59:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, chejiang@qti.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        stable@vger.kernel.org, Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: Re: [PATCH v1] power: sequencing: qcom-wcn: increase WCN7850
 power-up delay
Message-ID: <6n7g6tamgj4q6k4sslwllqnidobapv7groh3tqc73lmzj2xw6y@e6ya2ozqa3pc>
References: <20261102094800.3225454-1-shuai.zhang@oss.qualcomm.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102094800.3225454-1-shuai.zhang@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: Hn0ojbw4FrhUsTJ5shSATTj5UF4veVaF
X-Authority-Analysis: v=2.4 cv=QuvLTlyd c=1 sm=1 tr=0 ts=6ae85ef0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=H8z_xw01dn0BF6GSKEAA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: Hn0ojbw4FrhUsTJ5shSATTj5UF4veVaF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzOSBTYWx0ZWRfX6mmWtmspwxE6
 8KOTBcK06rSdSE4xrKTHI5pWtyvj0p0vmXcozknWrRrRm3cmFocTLHE7jlxCAZ5JDRmxFaktLdC
 j0GI7nutwUX6s51p99abJVEBdPJo66s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzOSBTYWx0ZWRfX8QhE8NMbnTwA
 9scgFfca/QMEDB/J/QTpvU3tE/yt1Jqxfd15tKa8xK95JSZjP74KW308c1h+8qaF8s6rac6fuKQ
 xDv3/owNtTZf7mTovyPsOsqRyapisBnJ8lLDVMXd9XH6nlgUcgPmyQdI7Yi0FSL0VIZw7XxKMmj
 6Ahv0eN8P5ZW0vblkaAQPqs2iGpNdpsU7cZ7QyL9I2a7feLCXKumvnPac1jdWEzamteWzfP9XWI
 2v6wQcrgeFlDtg8IGt630NizdxRygp34ZYZXK6LeWIu0AHZAEb3RUqV6LYzhinCeQ4SOQ6ozbzB
 eqC+yESkZfkLiBJaIAEocf/uN7j+f4EdHt8yufaDw8BSUPcCGBX23LHqFC6WsPYBLV/JOq+2MNB
 c5rV269iu6PHzUw0OKlo7G2MEdotyd9Z++DPzaqhdQ6/tpql1E22SmQQrULYfu/IKW+B/4NOJxI
 wf4Wc8qLpCx4+NR0zzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020039

On Mon, Nov 02, 2026 at 05:48:00PM +0800, Shuai Zhang wrote:
> When the WCN7850 is powered up from the Bluetooth side first, i.e.
> BT_EN is asserted while WLAN_EN is still low, the chip starts from a
> cold state and is not ready to accept the first HCI command 50 ms after
> BT_EN goes high. The first command (0xfc00, read QCA version) is lost,
> hci_qca does not resend it and fails after the 2 s command timeout:
> 
>   Bluetooth: hci0: Reading QCA version information failed (-110)
> 
> When WLAN is powered first, 50 ms is sufficient, so the failure only
> shows up in the BT-first ordering. Measured on the affected board by
> which enable pin rose first:
> 
>   pwup_delay_ms   BT-first boots   with -110
>   50              9                9
>   75              23               0
>   100             21               0
>   300             20               0
> 
> Raise the power-up delay of WCN7850 to 100 ms. The delay is shared by
> the Bluetooth and WLAN targets, so WLAN power-up also waits 50 ms
> longer.
> 
> Fixes: 2f1630f437df ("power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets")
> Signed-off-by: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>  drivers/power/sequencing/pwrseq-qcom-wcn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 

-- 
With best wishes
Dmitry
