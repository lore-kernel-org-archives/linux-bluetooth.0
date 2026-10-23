Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792732190;
	b=RN7zfrr7ZCYh+i30P9d3UUlTAkFBpNgqMgf4cl9uQrMDJj7h71aOHmlLr79s59HgC+/D
	 QPdWClO35aZJebgUBpT/Qt6WNBtYQtJ6nZHhJz5oj5ivDNldxn9gxmh3OGH4JULsK5pjH
	 Exzruzinx79Fa1Ley3waH4Ywr+SYBOLe/wVtBB69kkobfcI2U2b+QrveL/9eRuw5KNjCM
	 Z9iHH01n/JqWMxwkdAK7yFNBEkinY9gOoRL+28xDcri349kuCMB3Kl6xnsztB4REGN5cn
	 ZicI14NsXRKNNc+Qp829zJSHjSWCCHIQM5IloHcxrqR7N2RIec0r1LrrqRldHYDXY8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792732190;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=LALDteG/UZkflF4BJzSKAZvIyXFZw8pks8R9WPb8HHc=;
	b=ZW/1FJmjnPvWpAZLETanm8eHMDluJKLqKFd/f/eOCwyFRGbolwXBUmyCAAaHWj30mG/K
	 gSVYF9qdAtzeH1/wdyFEdc4FEd6RkM2GVD/TuBa5bhFhxqhKvA9/dafqBZyB41zW9O1W7
	 7jtUkMixNIWm7+vVZQJAuQXT4h7XRM9WwALoqns1IY068sTUh64gwaAqPxc8rVVo674TH
	 XQ1MnDGACC4UtFOFJgqcfLUDbrJ0oLAmAJtK/Flr8cEobofOJj5r+Hy+5woPvC6ZPUPap
	 UWHlLYkERM308EmIrRV9mI4r3q6QUqQwagqKLk00noarKtS/6N9h4Wu5Wz9djSYUIXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RJeS5+Eo;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JPUkT2RF;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A5606A319
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 05:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 529A5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RJeS5+Eo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JPUkT2RF
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N1F3Ux1869056
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 05:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LALDteG/UZkflF4BJzSKAZvIyXFZw8pks8R9WPb8HHc=; b=RJeS5+EoDeJi1vMg
	Eiz3d3BfH+lSlytnorw2SryWcFbynI/dVqxcy0fjgIC57r2LwsLH1vdfRQqWpc/3
	XtT33eqAUXP0og0TFQfwbjN/I5yOCqv0q+EWg2TN50oH4Os+BXyp6EvmxddK3TkO
	DAfkD4foA3KcF8+IYejIyfJo7QBe+Yicvz+gWU+BFXSAw0eU+3c4SWH8Y5O4dKLc
	EV7QxeumnzfGLH91sexZ+ZTcQiHRxPitRxUmPFWcu2LKxG/I32amDVqdyzXsXFgm
	tNo02jRB0B1ojUjcs0+3zXAkPHcRyU4I2M0s+ATF6DBH8y4wYmnWaAMGTIXRXGWc
	of3Qhw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmja1n8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 05:09:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ad94b96698so145530a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 22:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792732188; x=1793336988; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LALDteG/UZkflF4BJzSKAZvIyXFZw8pks8R9WPb8HHc=;
        b=JPUkT2RFfnDkEYnsIe1uPVXZwSbW8bVDshmIMFoxfTg+nPg4wq1FDZg8bBQKhXh+pA
         fsqBSZEiSAqg5jxMjL/FCBff9W0NjYbTt6IyIi1uND/sjVZZrcg/W5Xs3634sbc+I0iO
         PT5CvIHB4aVvMeSxCl8HFZ8YHI9r8XMtCbeykptY4+W8cgRAwcWreTlBkKH56WQNHb66
         FmMNkaZJxTuud32eI79jY2lvjdmrpn09Xf2NjZN9hQG/sIpx/MaXi3+weRsDfUQsiebj
         lsJI6mLNO51RpFstTiFlUjl3dvgoei2jDeoSo+5LMcYfRRIEpdgve06tPMeoQjMXKyxe
         N/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792732188; x=1793336988;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LALDteG/UZkflF4BJzSKAZvIyXFZw8pks8R9WPb8HHc=;
        b=ryXurAxwQ3MhG7nP82fL+lR0BWMN9pIveTAVwV+fNPp2l8ErYTiKPxDM3A+WvNSz2X
         M+BqLstaFfDZUeL8KaNM51WtLnBHxeJXLH4NaICuJnKL7zgl/TyEKjKbNEaONek37ec2
         177aG1yNNgBPkI73by01LHejC3XLaPbSuoB6fnONOwojcSG6syU/5/4G8IGf3il1Upgg
         zjIJoZeyPwClAM23whvjVsj7JdprOYSuaLxt0a4LcFv/QEhaia2s0/hqfT4G7pFBCkrn
         Hbl+ilYec6fzEdnBa8z7xVtkxRI3Mvui4Jvm01jD7ThyzjTLKw+lufaORP7les41i0d1
         vPTA==
X-Forwarded-Encrypted: i=1; AKwUvBzgK+eZPSZeOrvVbE0K96jdtTwgbY4PUWohZJoZTLaWE6m8mN9wKLMgtAvVJg4jpCZbr0Bhn5iEmEY0klTKXdo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdV5+NG2p5EFr8e0YQymUYKye5e3nZX56yZ3pSPZzKSuuDv6zO
	M0bqsKJJqAq5QdzildD97plyx5iR5iNMONeTro/+ans+hRev9XiIwFh9FI44ftrIgCtELQmt+ai
	L7daWkYJNo5Pu35wGac4F5XkzJCydPiB/j0o4ZQ2X28iGkAbKrCDxdskiDMKBLuaUpVnrNvQ=
X-Gm-Gg: AYBFou2ttF3e4aEnfDYT6svIs9T5DNKKqKEvzEfinL1yMX7N91aEFMP2AhFW1dnykGS
	5JlJcw+uDiX2WFmVimHvEnq4lENroCP0Md3Sh2ICfwzEp2AiUnYmgtSl4brVlsrD8TD7MKyqVAd
	bLZvVu7OU0bhzUaKPeBnNtmA0AdJD8A5y4ANFM0L0i5cX4qURhogB6MK1CxfdEtwG38t6ziIuXp
	n3jRwDoPWfO7AKeB+aBMzUOK1PB02D0VTVPqF1ou+l1YcRfrR6PxSYU9YEf6wActQIyu+0HVmfu
	TVtQytKP6Rbdu0aDJOMfGeaduwVoNIRDMDXJiMGwSWja7nNzBlUgi6Y1AnrL9cD/wRG7PRiRvJI
	wLmKttdv/ESvr+Qrl8EGGgWxFcoL4tF3ZJY3pXVJ1VOFz0qgOaBF3/hfsHERFU+Py
X-Received: by 2002:a17:90b:4407:b0:3ad:50ef:f5ef with SMTP id 98e67ed59e1d1-3adce08123cmr1517876a91.3.1792732188178;
        Thu, 22 Oct 2026 22:09:48 -0700 (PDT)
X-Received: by 2002:a17:90b:4407:b0:3ad:50ef:f5ef with SMTP id 98e67ed59e1d1-3adce08123cmr1517840a91.3.1792732187636;
        Thu, 22 Oct 2026 22:09:47 -0700 (PDT)
Received: from [10.249.18.99] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adcb1f93e0sm1803501a91.15.2026.10.22.22.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 22:09:47 -0700 (PDT)
Message-ID: <8c868c2a-d5f5-442b-b7cf-997f377ac90c@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 13:09:44 +0800
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
Subject: Re: [PATCH net-next] Bluetooth: btusb: disable by default Qualcomm
 multi-subsystem
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org
References: <50f92fe870de717fca6368e750e0a6cbc8f46597.1792683340.git.pabeni@redhat.com>
 <CABBYNZL_EV5LHaXO4rUGu1jg7domF_h1xfmg1m9odHBfgFPA4Q@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CABBYNZL_EV5LHaXO4rUGu1jg7domF_h1xfmg1m9odHBfgFPA4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QCfJKZRvQsJvQnUj7Lmp6qW15S_Ym11M
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6adaec1d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=MPfgTQqCwHivTDeqJUUA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAyMCBTYWx0ZWRfX+D8rF6YL3mRr
 xrO6PXnqErsvunc1dpXcv/WygrGoSpOHhHUY17SzVljbp2vphcRziTD6x01MZ9o8sjPUoGlLwYB
 zP//vcGn7qlm7sVEGkwp/VpqAXflGNU=
X-Proofpoint-ORIG-GUID: QCfJKZRvQsJvQnUj7Lmp6qW15S_Ym11M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAyMCBTYWx0ZWRfX45oq9HsqgeEY
 A1XdfVnmd7HoLpYdmxg8hfrK/yL9e5vLAhzar6ZlnsU3Wo1kueFhI4RCAN/jHvbOUNrFqZcBSK/
 Vqqv1UEfemsU+Fbefo7JppDvnbecQ0IM95Qi2Vurs2nrNvjdbF5Xxg5xkQqQy44aqWX2qMwI2X2
 oO0jjWWmZS8rzjjymvt9vmq4DbUgaA3yB9CSHm95opCK2YrEH8SRJ+ASkmTLyKdo+5N8VUFHjPH
 3FXblubeZ54tCLOE9EMlXmj09Om/Zt4KdJUWToo9dr3o2b/0QHE4zF6MAJ2YRY7WxBvR2LVgtvL
 T6JNYvNycIl4R9F1Za34fuJGOIe4MQTSy7x8z8rRkViJHlQNhWz3uZcnWsLAerz2CM9TELd/Ybq
 cXPDpwzB4fABmSof3HtLZ1ah5xec8kjmXY+V0Jja2uZ9KvNFaEqCnKUJrcjqvH9vsfXJyeqTYZO
 VyPmdUN6cbkVNsWB9cA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230020

On 10/22/2026 11:44 PM, Luiz Augusto von Dentz wrote:
> @Zijun Hu lets us know if you have any problem with it being default
> n, perhaps it can be default y for a specific Qualcomm platform but
> not in general.
Hi Luiz,Paolo,Jakub

Default to y for the following reasons:
1) Avoid regressions when moving support for many existing Qualcomm controllers from btusb_main.c to btusb_qcom.c
2) Align with BT_HCIBTUSB_BCM and BT_HCIBTUSB_RTL, which also default to y.
3) USB devices are hotpluggable
