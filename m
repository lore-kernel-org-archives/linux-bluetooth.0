Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C16336AB7C
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812418; cv=none; b=eolg07g+DhPOb3kDCCJt4PhDek2AraXOf0s6KkbfxRf5HhKUHMEeG6YyGCuTrzKOWr0HH3QFL6dvriqdQoZQQshAyA1nK9IDIRMiS/PJX4gNxxaE0PrM/ytvi/M+zQ0tLLmbx/cPEry24G0m+Tptv9vj7kTkHOb0aonwMH2XI10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812418; c=relaxed/simple;
	bh=ObO1NlYssZkMqOHfmoyw5rb1Sdfdt+FEN9EgsBLC570=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEkFcUdr1k9/RVXBiGcE907XGA10dB9QkGYyIl/kiWDm4rQ/+4sBPvNpJDFraOhF24U5YL6LzpdIv6gSMjY4MLPl2hIVj0TqXy8S6d5d1/lccsGxFUQ2TBgGFTYbWYB5mVAcEOT9pbgmzI4bvZ/uRJ1rMkwjcx8AQ1piY5Ug0I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XDzdEbe1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S5M+6Ytn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XDzdEbe1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S5M+6Ytn"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC0Djp1686432
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 13:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AhDDNYFPcv+zyLGx07rJHLV856ZktTY7eHtr9ZO4JBI=; b=XDzdEbe1RzaUGOkp
	3Ybm0gfuP0/DsEbGrk+ys6EaYFMBhVWl/N7WU6I1jDJliqJ8nvjzVnySd5iiM7X/
	qcjNJGEdUMJlNadkD4YvWU6cWJCRKTz7jBmH+e5OMST1mgOoddYosaaqp4tWHV2l
	vmaPkF2kP7SA+tfNtvWtiWew6NhMc6TDPO8YX2WCIf7Aq/1sQom1xxtEGzXU6DPa
	jxChgX+WfFoApQcJL+SJ1ugmrRMK7Hdblmes4Q4Taz95lzuc1nZQbbg/mzbUxurU
	gFdKbicGlAxPbwnEcEwYo4c6elv45XfM0Mp04pLdTEJoWsLVUTZ/g0RsiJgS38BQ
	/0rxMQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wbc10dx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 13:40:16 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35a04491c56so1132699eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 06:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791812416; x=1792417216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AhDDNYFPcv+zyLGx07rJHLV856ZktTY7eHtr9ZO4JBI=;
        b=S5M+6Ytn0yAK6Xj/XlN1AGk/7Ufhy9Us9XEiM/Nn00+AxnN4i3WA/94YXs7z5nCp4N
         df5Kj7sxHK24ieGlGpVceKURu1DLm8/gy02R9iabz4EHPMOkZGOu8/CepirK4DOXaFM+
         phZJvw/C9CbCRKhg6fB4xSs3Y3k2LG1/lo+YaP8KkaJ2w8KJw/2IfPUn17N13MNqGACI
         ixFiDLibh+o/kQNgabpt/2FrL6KGG7h923hUyl1wTEVDsdWSSkzIB7kNFjxOCT6fMX7j
         8ECRoWgEWFt79VD9Ywzof6JLsxNSJF9CIKuyjd+ZAzRiK427lTwgbXyV1y3oxzRmnNBF
         fDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812416; x=1792417216;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AhDDNYFPcv+zyLGx07rJHLV856ZktTY7eHtr9ZO4JBI=;
        b=GpyRE0kMgFTNlKe9xM5mZhvMH14kaVqh7z2vNMiNgAmkzZG0Av60RaTnf1Rvd3Xcn3
         n2bdid0lTxbT0eQ4kZRWvWISBej0dHZPnXE+senlKN2hjW+pg/tNcyk+6169NqDQlXm3
         F62KKKaRHCtuopPPlbhkVvKXA/hxz/UWrxW0Ekidptufj6g67tVXGnLp95PbgrDFiafB
         osiL+KYCYOxSdI12n1F27/w6DN5Z3AiAqXZgpAN4JIJ/wGvsu4B2ujRpr4uhpFW3RBYE
         Py1m2sSIxJf0vGGnh+m84JIwgOg01UBG4ST7kwhZ7KscTd/a/H7HHbcT94AdAEjQBA10
         xUqw==
X-Gm-Message-State: AFq9FYLmn01ozHN6hPc+5WG9thTCYVBzG88NwYrAXXYkGUVqL7t0XCLx
	TndFYgrUxLUK/2FhrSkkASiZuwI/Qc7ymD/G5T0u8OyS3R/AwT5QyxXVFQ1NEXG3GJsoWiyBJch
	K0MhUN3XyVCLpPvQT45Z+zCaxAOwh0EG/YDsJNfC+J/GPgG0D2yduBJuy2NvGhDFtjtvy2yt2Z/
	7B1dQ=
X-Gm-Gg: AYBFou3Sby54VcSiH+P06m9Awsed2xoIAfaHqg8SB1tXtNWcQtzyIRLZVPHgbCjvq6R
	ViN6NiD84mMvemJZq38Bx/J+eDusBW3A60A/itLWBIvv2fUxeVblvy6GL77bzUwDLA6n6U8Tf53
	10F9d3Mt8UNyKpFUL7cINcpy3vg1tIsAQoLM3ZJfReKZWR5/oU0U6NeCrjFCNbd6FPr3yLn58/i
	srlgcp4+/peNxvLdX6MFpUxT9BvOJwnOfJe6nrpHJqD06HqRDlC//K3cIcnMtJd+Aq+sFgV+Ht4
	gFdpMHf0Iq4pliaYjaX92XjRRGJuvkMqreBPJHoI990tE+6hU5li9Dcp5nmalsg5UO0Hlhunyt6
	4+j7VerZQLyXJY1Ob4SqczvbsZgA=
X-Received: by 2002:a05:7022:5f1b:b0:16e:a290:12bc with SMTP id a92af1059eb24-16ea2b0303emr7013562c88.12.1791812415730;
        Mon, 12 Oct 2026 06:40:15 -0700 (PDT)
X-Received: by 2002:a05:7022:5f1b:b0:16e:a290:12bc with SMTP id a92af1059eb24-16ea2b0303emr7013541c88.12.1791812415156;
        Mon, 12 Oct 2026 06:40:15 -0700 (PDT)
Received: from [192.168.31.121] ([58.247.180.211])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1becefdsm30195695c88.7.2026.10.12.06.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 06:40:14 -0700 (PDT)
Message-ID: <dc6dc673-af60-4b59-89b7-7722fe355907@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 21:40:08 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] avdtp: Fix use-after-free in connection_lost
To: linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com
References: <20260807095809.2584501-1-jinwang.li@oss.qualcomm.com>
Content-Language: en-US
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
In-Reply-To: <20260807095809.2584501-1-jinwang.li@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfX9uMpMhNi4W0b
 yhWKqVi9AXGqGrJ9jph+lrdGn9aeuHoZK39gXW6PVJysHEQO13iEyoaj7WK5y+J9e8Khq0lZxnM
 +CplInysRfQddW6FWGHZ765PI3JIKBA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfX/N5zKU3QFupP
 lZKupwtzKMCamN92RmbqqWc2EPFoiF1nI9zuoWUaF1FU8wwvWt5VtokRjf/GemAEf7ndXAVHL2O
 6qKH0h25/Vb8ooxUyuY7ew4J5KGuM1qb6RTDx7lnTw8DG+RTW2T0/h9v1zDHLqIYKWpu79icspb
 7udEChtjP6rwDt1lOYDeMln6rL4gOnjhBLYf0K5DwyoutCGNq+i8OrR6ImV6wwpua91rORZ5lx5
 cyUzXMRzOcmSrqghP6kEhVBXXTJrfytpg/2DVTMyOoWQo5yHo38kSG8fdM9hA3SRrzY87SacXAZ
 7c6pYihRFgk3WNu/xS01Cm1h+OVBpZVsIYLoxNFPxuAnc/qQ7L3zm0er+WBY5RkXwEwgvDO4Qku
 u+rUp+DRZeEiDnW62+eYooinjz1lymiP1oWeZSYdFMvYI5ximOMZZCafew5AMSc0H/3ZMF8aHPp
 fWUAd/np6ZQT53/xkDw==
X-Authority-Analysis: v=2.4 cv=C4p8WgP+ c=1 sm=1 tr=0 ts=6acce340 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=6ys7802BvytzPDmX/GRlTg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=FGPE5UJRS-2hhSFPCLIA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: j68PhLsc_py8o9MvNSfM8gB_chBzm4-E
X-Proofpoint-GUID: j68PhLsc_py8o9MvNSfM8gB_chBzm4-E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120054

Hi Maintainers,

Friendly ping. Any feedback would be appreciated.

Thanks,
Jinwang

On 8/7/2026 5:58 PM, Jinwang Li wrote:
> release_stream() may free the session's a2dp_setup through
> abort_cfm(). Subsequently, finalize_discovery() passes the same
> freed a2dp_setup to discover_cb(), resulting in a use-after-free.
> 
> Call finalize_discovery() before release_stream() instead.
> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
> ---
>   profiles/audio/avdtp.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 56d27b973..b8d9b8e94 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -1158,11 +1158,11 @@ static void connection_lost(struct avdtp *session, int err)
>   	ba2str(device_get_address(session->device), address);
>   	DBG("Disconnected from %s", address);
>   
> +	finalize_discovery(session, err);
> +
>   	g_slist_foreach(session->streams, (GFunc) release_stream, session);
>   	session->streams = NULL;
>   
> -	finalize_discovery(session, err);
> -
>   	avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
>   
>   	avdtp_unref(session);

