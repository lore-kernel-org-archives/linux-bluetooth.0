Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBEB362128
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773418007; cv=none; b=JkyGK6tNlvA92Bha5F1fKDg5re34YhwChrMGrkf57bObPyBlcyL785bO9fx9HMJ6i/q+pV2lPhLbCTNXTcntC2f3nSahpgNmCp0P6mb1QEl1YpSIQ8+EzkccNydPScTgcZ0giKdgk1srY0HsURr5vmG/XQeFWBLLWXZVJUBk71U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773418007; c=relaxed/simple;
	bh=XDzpKOsRfjAmgNfBlZ75TWB0/RZDAqgkCir2RdKUkk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLo2ibn4EmhPlj3A5hSCcLwh0Vqr2am0oovcD0pOxTY6VOOIvHnT7Pp9/v63r+8BPYN84mcfw6DXZgSeLnzbUMH74U+0k2OnefTL90gLgg6zwlLJ5mE0mru+oq8Mge0eT2ewNghi7rNDSitknrXVuOqf6Vb6JopwvHaeW+oCUn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ctt2n72O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bPWt12Je; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ctt2n72O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bPWt12Je"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DC02e74140725
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 16:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zzoiqEK+L9LoKeSCfNcVbIY8
	7RnJDltQUh4LWr64y04=; b=ctt2n72OeYpnwnW6cOIUh/c2xfXf8NoyaVsNYIp5
	GgOGvd9hLqxpc3uM583dOd7DXwD3P02TolBAV61SIoaN5j94gYNMq2+b3NjtXBWR
	G9dqhMuL+EmbokC6K7Wz02Vihrtsvru2BQbKJP8m6SYGva2l9rLvoXF5ziJAHvMa
	PqRJeW6THNuIJvPG9KkiH0sheiyV5woJrCtO0sM9JjXtWPL3GmW/4TTO+tTJROwH
	Yub4G1izWzC3GGrnr+uEau+6EPhB05sWBp9ZHD+lhQe0QzKc7jwHv5oheRat+3HB
	YKRnoKDa3ESQ2fPkhD9rbvRIG0bnOJM9syWWHjm6hJspKQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvbn2aa2y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 16:06:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5094ba09affso147178441cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 09:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773418004; x=1774022804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zzoiqEK+L9LoKeSCfNcVbIY87RnJDltQUh4LWr64y04=;
        b=bPWt12JeZDZpmJ/dTO4y0ZndVxQ2JH04GH+lRX757qjohg0ZLiLqQslK4wKfWnEB9P
         +FcumWJQpCAOfq7mP9v8VeAYX9YtVh99X7WjZy/OfyknCTWt1nDF/fDUHM1stQkfn+fD
         GpwuHZESThtR597tUbltxccyGpBvhQKaUwn++sZc+IZEwZHgpmQuR/RUunrUyHLsXe6n
         wUb/IC7gmZC/53FwcPzC+LssglL73wytV4WQEUa2HvohyYVGOkvOQuLeVA8VnISVXRnf
         s957xxpu7OIapEj3wgEWGa81oiqgppdIvVn5va73Usd3VXSscFfTw8pOPvSaWsfjqFV7
         0RnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773418004; x=1774022804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzoiqEK+L9LoKeSCfNcVbIY87RnJDltQUh4LWr64y04=;
        b=CBkkPyMvykQWMX4UqYpmSU+gChCJkjTJ24QWdoS6i7OCWjsK2v5o3jVTlBfGGgwgAx
         OBE7sYMvz1FbTMDkHH3FXJssQBE45hjVHb3AETkkwfVs26MWSQAYnUC4yMdJ6yjoXsFS
         zGN8uPvwthRC0P3Z5UkuwuXVQ4Ht022bWyifSTQxJo0kOzlJp/3nZA1YjkOQD6Wnv4cA
         Grzm+X7rurAwPFjzU8tuHgvC0NDCis4UkxqO+kurTCSHnHKHjjIEk+lNZsfx4lR0eCEC
         K11d11E9TQwzpoRllTMCqvHRlxVS1sNxYg+/QElFZZH5MpMjMsm15pSmxQnpPTvBdJVO
         l2Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVAUqi9oAWdoq1bvvZ2rCulMTaq8dvU9cSi3ObaNMKa6bX3QIPbf6tofHu0WBepyGRQR4vVqqcxc1RpZeAVxxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuBIIgQBrCW9Lmdzb8Glk7YVhYE6WBPA2kp0mJXk6wTQTi0jho
	FQD9jFfnicSShwgLKRuStZ2pwF8vLn+uC78K8a5M9Nlv7vFZi0T3aIK94UV2SKbGy0jIHW+LIc2
	I9QK3psLcQGQ6wZ05AedstQO+r10G9lT070YddmfOTukwZo4yR2ytHpxvuP8buJ77WIdl5Qg=
X-Gm-Gg: ATEYQzxjDLs0pYYpSsWH7JQ2HKg7hZkLDWx86sYDtS7+zAZ+JH/s7iLYx5WiKG4G8tw
	zExNRROBexjNczW5AZE+68/6OZ7LY4+eTrrSxLprx0GK0eu6B8vkoAhUmzYCM6hyBha/0VfgebI
	XFgYWAZLgiXNVbnVGyGdmGNshL2DOLd3JyylztAZzW8bsdJEvkdJfFcfkejrRgpWZwGAdgDlUXV
	yOKcHOtosz9AuDVhQe1fwq73KKzou/RbzaMT621/v5eV8kDpp8CvSR0K/R8FZVlcS5ceMbu8nAF
	4to6GIExIyhxBljRDxeGkw6Zojpj6VhRJi01rDxiC+vZ857fYqp0KbrpiuXFCXxdOD7od2eTbcN
	tWg/fgYayDKXPrIX/uT/RUw57QLIWcUCEMzkW/qqiVFboIH41oZGU1pp9zjycsMld3f8IO5+fW1
	8A7oFYALO1MQhVMPJxmfDlLMzUdoZUP3du0P8=
X-Received: by 2002:a05:622a:210:b0:509:aa4:4a02 with SMTP id d75a77b69052e-50957d21b89mr50678301cf.29.1773418003797;
        Fri, 13 Mar 2026 09:06:43 -0700 (PDT)
X-Received: by 2002:a05:622a:210:b0:509:aa4:4a02 with SMTP id d75a77b69052e-50957d21b89mr50677381cf.29.1773418003103;
        Fri, 13 Mar 2026 09:06:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a1563775a2sm1588559e87.89.2026.03.13.09.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 09:06:41 -0700 (PDT)
Date: Fri, 13 Mar 2026 18:06:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH v1] Bluetooth: btusb: Allow firmware re-download when
 version matches
Message-ID: <zcn4iagkp4wtcg24obdhlv6pj6xyakcbezuzz6so3nvwneuybo@5bg3qjsuajqd>
References: <20260108074353.1027877-1-shuai.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108074353.1027877-1-shuai.zhang@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: cfvpCLHFt9vmZNuQ3bLT4h67238raU8Q
X-Proofpoint-GUID: cfvpCLHFt9vmZNuQ3bLT4h67238raU8Q
X-Authority-Analysis: v=2.4 cv=ZKfaWH7b c=1 sm=1 tr=0 ts=69b43614 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=XLcW7MSiMK0kOx3OsRAA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEyOCBTYWx0ZWRfX1pTxfgPlf6yX
 A2vNHwAqrEHdC6ZjLsbmy9UwL6mN80XJfsc2XEUeBGWCq++gRieoMdtgfyHsBxSMEczqquguSrG
 KPp+tKSL+/jJSaKMY+WQ6xaST3Dt1GaP9cMJKTjI8Hy/xSy2qOXmL9r2w/Pj9sC1J/1A+A2QC5G
 RZeNBJQGsKlfif83ksQF07vPZXORFGUtqmn47haDv22AeTpySBkzpnquSeLfxmVcQxxrxsNLBmF
 MSz/n3uRCT81gglS0Jgouecas2g57MisIEp+gHbSsr1D/09jlW7D/2a9U1iCedpDAtNXL8H4YwU
 c8crBFgK1LsKks0hlGl8NgvLTvpjsS/HiiDLu7Xo2wsxGlVonLLPZXEaIlc4UZZnSaWiNksPrzK
 hS6H0/OZJT1JXq17cShGK9hGRPE2FycEJHf4LP9jFO2jHMDK2VazanpNL5lVA/Z9ZyNZFodoEgH
 +O8ByycukJw+UHS0pnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130128

On Thu, Jan 08, 2026 at 03:43:53PM +0800, Shuai Zhang wrote:
> Since USB can disconnect at any time, if it disconnects during
> the BT firmware download, the BT controller firmware version may still
> be updated even without completing the download.

Does it not have any check for not completing firmware update if the
download was not successful / complete?

> 
> When USB reconnects, the BT host detects the same version as in the
> firmware file, which prevents the firmware from being downloaded again.
> 
> Therefore, remove the equality check to ensure that after
> USB reconnection, the BT host can still download the firmware.
> 
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btusb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 646de80c7..991064a25 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3503,7 +3503,10 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
>  		    "firmware rome 0x%x build 0x%x",
>  		    rver_rom, rver_patch, ver_rom, ver_patch);
>  
> -	if (rver_rom != ver_rom || rver_patch <= ver_patch) {
> +	/* Allow rampatch if version is greater than or equal to firmware version.
> +	 * Equal versions are acceptable for re-flashing or recovery scenarios.
> +	 */
> +	if (rver_rom != ver_rom || rver_patch < ver_patch) {
>  		bt_dev_err(hdev, "rampatch file version did not match with firmware");
>  		err = -EINVAL;
>  		goto done;
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
