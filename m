Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792797412;
	b=Rhf6ggL/Yr0Zial3Uc3Ihp/d768B8ysAgF/OD692Hr+PnbAuDMGHiHXdhobQy13d3kqS
	 4batWbMzPPpVqG2vXhFW9k6vcb1x+6clwVSsAkk4Q9plpSsLDWS6udEU9cWKKDFwDBx2A
	 C/vlCsEbi0Q2nVuCe3mvxF5Pd4Wfo1eD5xk3CIyAtKqKZVoVt00ySY9YML7cmGgTpu47V
	 PaGhBt8Nv12/KSrV/C6fnE4PeV7Z+F2P7Z/vk3hvipYfiMlZ6iyWBd0jqfVF4J/5Uz9X9
	 Pnvpd3gw1XeAEEbjM8gGJDiON+/xjHEECkOd9fxf2xFwJW3ID3uadTFIKclfyWNJYDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792797412;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Uf/HLf+gvCGbaUy1xNBEudLWqzzIfdykWFA/o6PVAmI=;
	b=dMYSkOh7gN/1gX7iWrvPLkiBFBlurbJkdYCWuYLhYNhQPutwK3NmPZEZBNrOWwU+Mg2V
	 HIdwgQDJcOe3tE3Fmon/vdc7YPFa67jiu8wqfj46S12xd3TVOB4nMHe+VNr3h2Ozz0Py9
	 Eh66q9Uki187FZgSBzPwVhM5wMD0vU0rCfRzjc87GDP0oPp5TNjPFOFCxiYCOQAIWRuiW
	 UjrMU13SujnvSJmxOJcSLalxTUE87HyE4kUfz4GQuoZA+XmPtHtGJbfc8ypxx+0GGkrxU
	 G1GungL0Pby40QZgAW+9x0p0i9Vtj1wo9167qy1tGq4v0SRhitFQlBUoHXkE+Bsofxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SjqKlVSn;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BXNj7W+X;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD94606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 23:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABD94606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SjqKlVSn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BXNj7W+X
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLv0I1877252
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 23:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Uf/HLf+gvCGbaUy1xNBEudLW
	qzzIfdykWFA/o6PVAmI=; b=SjqKlVSnNWlW0GeO05ZZwUu5Gn64FEJ/PwAiY9yj
	/Uj932ookfMP0o82G/ocYnwE9TORuDtPZl9rEP2LsXaVA3pL3ctdny2fqtCW7H6x
	mB3N3cIwLZYVK+lPJMGyzo29avK8B5FBzJ5AUVQ2L9cjA6c0Oa/qc0gAJEXv529a
	5++WWU+Rf3WgOnlP1KavgKZ5vAEMhUGDaxnVWutbdGRqrHRj2Jd8V0rJ4txQvS4K
	Fh19n+dfrwy/QH1R5GTayplUsueHNY7D1n254xzAdw6ihq/32OlkBbvPiKAIiCyB
	LNq3+e2DStPLjpoc7N5UAGjEhfK7bnGF3cu6eaoQk5vN9w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcr68umd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 23:16:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f13c143c8so251055985a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 16:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792797410; x=1793402210; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uf/HLf+gvCGbaUy1xNBEudLWqzzIfdykWFA/o6PVAmI=;
        b=BXNj7W+X8YoP4Ot9Y/kKHsLsZgkqoZ9el6UAb2t7MsLGEQLtJ/I1x+3OEnAAa1zdEt
         brcqNrVz9UKhFwBkQBWwcRBJVlpC+l6slHh7ap/asFyfvSzyGY9M6gLr+XHxTc5tw+ix
         tUL+ObsfkItj5K6G63PgBJ9TaL6YcIIK1q7Ccoh80AmxJ+q/R1sbGnSgswKVkbPl9M4f
         b+DEDD+LGhy5j4o/pioLh/a2q5MC3EzRq0YPhAK1orvUQYrS8IvS0Nb02j5d/jNX08ek
         8A8J3deJegcTnBYniDP74bOBn/x4O1H1mFABXVZK6o91J9bd7Dj0LoCIN3mQCZ6gXdZc
         Ub3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792797410; x=1793402210;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uf/HLf+gvCGbaUy1xNBEudLWqzzIfdykWFA/o6PVAmI=;
        b=H6S12BEPUOZgdpkAQCKH2FMI816JwCpiu5gKswHQAqADPO+MybgECZx+laR10eym19
         8Js1c/HCMBjUAPpfJGiavYEfZNvPBJfILpDcOIAVhodJtxVwEd1+wdcNWhMheq0QUl6q
         3I+NKBI7aFg8sILFJBpDHNMixAScfl81n0U6+qA65xiVoy+zEL++OPNI+O+f7FxdLWMa
         Pm1M8UsPK9tShaZxbMXWOCol/7TmgC+LxFQlzionjkFMXQlPOJk68eGZMJF2KHVgkFXx
         cvflzq+0Ux5M0WAeZGJr5UocCYXChfuvg2tZ/2Yd59ZALrNUxp5S6HtQPubmTcW2UORA
         lanQ==
X-Gm-Message-State: AFq9FYJFKe7z8svUvZBDlhz1Bgx2BPObTW47YUIXSs6aSog2IaQ5YbQz
	2HcdnjHLdOyd6XLdZC76la9q1O8HkGJ9FAcVLaVGyx41BH3BcWzuyOYfMgxQRxhQuKRhDc1MmlR
	/XqvH7u+bTleaAPUScsAnmZK1GtEESXz0T9z2tUiXzxr65JJEjlSw1Qw9kzpUI9zPUR9sS87C9G
	iG4Ng=
X-Gm-Gg: AYBFou1iemQ63QE50pbJ+7JAnNpYVqY0yCVTGtr1MEcoXxswq8iy15gydbT4cOWc4cz
	p7mY19L2XWZnlmWNqatHt5/AqZsXE67c8CNlmF7rvjcLS6U63tt6enlpwbu+zUBrSybao7S6m3j
	i5EGq4pmV+5RlduTP9qYoCxc7LhQsYhgEmk7UaG92TGuWq+wocl5T78/Ef5FGXAlDNek3/KRr13
	+FsO0bIlMUQ/Tzf4igjG5Lh9qPsPM4259zK6vX3sSrWQ/OENl3pDslY7KsUoiV1ES5ad8+5emXz
	tiZoTIbgsvynP96GsAEH69/j+7xvP+DrFryJxi9lUslccWXp+Djz8wRp/RbEYOmuMrRXV+ukH3V
	TgaII5gTk54l+eyhb2Yd4ObfwVruvfaZGQbImda1BJ/K5o8jCEwhdimXwn1BY6JFfLClPvexYFV
	ZmqshXavXw2HWR
X-Received: by 2002:a05:620a:6f05:b0:93c:c162:125b with SMTP id af79cd13be357-940ef931614mr82906285a.39.1792797409771;
        Fri, 23 Oct 2026 16:16:49 -0700 (PDT)
X-Received: by 2002:a05:620a:6f05:b0:93c:c162:125b with SMTP id af79cd13be357-940ef931614mr82904085a.39.1792797409401;
        Fri, 23 Oct 2026 16:16:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ac70a493b6sm955911fa.37.2026.10.23.16.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 16:16:47 -0700 (PDT)
Date: Sat, 24 Oct 2026 02:16:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Michael McAllister <me@michaelmcallister.org>
Cc: linux-bluetooth@vger.kernel.org, brgl@kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, lumag@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bluetooth] Bluetooth: qca: Fix the WCN3950 NVM baud rate
 offset
Message-ID: <phkghjerfiho5a2tqzuckaraacy5mnsgnfwfqfqonogcl7ctkk@pekseqogr6eb>
References: <20261021195112.41138-1-me@michaelmcallister.org>
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
In-Reply-To: <20261021195112.41138-1-me@michaelmcallister.org>
X-Authority-Analysis: v=2.4 cv=HMRWhYtv c=1 sm=1 tr=0 ts=6adbeae2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=JwJ85b4fAAAA:8 a=EUspDBNiAAAA:8 a=RX1V4Qf_SthgjYcjEs8A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=qg2vb7sgHZQYDKbllo_a:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MSBTYWx0ZWRfX9yA4xa1vASfa
 3aIX5fOYGMhhNEPKyeTkpXBSpsKb1Xo+Azf76qgFMQj6q/TLi6wbvjCOAN4cML+oFYkR2N64SgY
 TjtuehjDAT/ydAHU5+TMdSHuatXxgkoal1Jfq7BQo8gkDZPuA0lUHEbmiUa4+9iz9zx+a8k6u4P
 tZm+pQV2AeyUipdCyZw3vBwRyoA/WGLMmBdOA/JVsZtl1WNXChMPLtcgNfVHdRrgmSU7luHqUBz
 gsQGQVl114/NZJjgAM/sCmL1k/SiuhKKVuLMDZ6EPw2TXIaLNWxzcA+IMtdRqpTC0nwqtwDLnXc
 7XFe+jrmBF5VaT1zLYxa7Aw9QvJO4Ss5N6eTTSNRuKFpCP2yRSRYvXFiikEdKiamAN81Amxcn3Z
 zZPN5cf4AgdqdlPZYLblQwtxVL84wPNVGAxwnonb7NK0iLrM59sMIEk05AuTy+TcujjWQTNdagO
 Xh0F+rBW7beQkPRbbIg==
X-Proofpoint-ORIG-GUID: L3A59RmkfYHRFjBtopoxXet3DJvMpT6S
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MSBTYWx0ZWRfX0sf21X6SFQoS
 I5nF7gwoBMeRySdJk8OwkMPC1RjMrFUqI5cmITaGbM+7RPB5uXoGJCBDKmJ/MClFZf0E1DlEAkL
 Ik1YvHwM/RcYxRFypBUs/QKhJdgT9Xk=
X-Proofpoint-GUID: L3A59RmkfYHRFjBtopoxXet3DJvMpT6S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230091

On Wed, Oct 21, 2026 at 08:51:12PM +0100, Michael McAllister wrote:
> WCN3950 uses the HCI transport tag layout that stores the UART baud rate
> at byte 1, like WCN3991. However, QCA_WCN3950 precedes QCA_WCN3991 in
> qca_btsoc_type, so qca_tlv_check_data() writes the baud rate to byte 2
> instead.
> 
> On a Motorola Moto G10 with WCN3950 and cmnv12.bin, configuring a 3 Mbps
> UART therefore leaves the NVM baud rate at its default 3.2 Mbps and
> overwrites the following byte. Firmware download completes, but the
> subsequent HCI_RESET times out and Bluetooth initialization fails.
> 
> Include WCN3950 in the byte-1 case so the NVM baud rate matches the host
> UART without altering the following transport parameter.
> 
> Fixes: d5712c511cb3 ("Bluetooth: qca: add WCN3950 support")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Michael McAllister <me@michaelmcallister.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
