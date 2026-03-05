Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212CC366558
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Mar 2026 08:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772698104; cv=none; b=bMNBxQwoSMjDayG4jVoxpvrPVKWMsksPumR9/7Y+rxhEyN9phOBq+d0anQ6Pd/H7oBINxdGjUSvMaqmDSa3wUPnDO6/IKzuqjw65IWR/Lqs1jObhPXfLmn5M1GBxku3l4/Ee/39p3BazgySqW4LDSPgm1ZX5NmLUxs3EBamIuyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772698104; c=relaxed/simple;
	bh=0mu40XqlmT9C1K5v14IN1e21NLNB2K/mZDZbVz5wGR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8KE3S9Au28u3wBzhRb25voTXHmGnJjc1D6yH9gwNsbKIv8M5tP2spALMmvg93HZcD8EO0V9y6cAzaneiTr7CO/FGgTd4Ql2JCSz18FYsAPj9hfW+gIqgZJu0RFXZe/MtwLtStaDRwi2qsuS+g+PcRMYbBR7oJXXYu6eWG9j8ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CcGZcqCV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZFTYU19A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CcGZcqCV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZFTYU19A"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6251Bqe13482746
	for <linux-bluetooth@vger.kernel.org>; Thu, 5 Mar 2026 08:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1Tu9sOHON+DSOPBlmrUYoifOv0lkJ+YvIm7FtkVs0cE=; b=CcGZcqCVNrYtQjs8
	WjggGerePfHnvl6pWPGq1HxUOl6y6UnD4PkK14tR6vpCVwFV7ljXqK5xePGJlCSr
	eqJ5AqDrDEd6ScXdgOHfZcmAPViPpUpWA68aa271K15SVZhn5gLdHfyMabqrX0d8
	/1QURoDQHYVFOV9TvbATB04H0In9AaBWHJa5BScUs6iRGkK144zkuTLQy6Q6NtyF
	6N3wOPxo/N4cPsBZBfy7iNFw0MAuQcWn41Vyrm6xtedwB46CXM7QJM1N/hd0xFLI
	iZahZcKlWq6ydFc5eALixxrpZ49EUvdbgwRoGrmevulBC0fWj7FCREOgDLtAWzOP
	UgZTnw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0wjcbn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2026 08:08:20 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae3e462daeso24188165ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2026 00:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772698099; x=1773302899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Tu9sOHON+DSOPBlmrUYoifOv0lkJ+YvIm7FtkVs0cE=;
        b=ZFTYU19Az8GdaNP0Yq4c3qvTQ5x9OHhA1/OxEcmJAvJm/rCFB2Xvgtrgb3N9pmx1uS
         4pCw4AL5fVF/z4rNWOq7VLIBf+LVHUaKschhQzEywMIDdxvepqnC44W7nOO0sWZkR3UT
         pB2Bz6I5TABueYs975iD+IE++/+BeIM1G7Rf0D+W1QVNB74govvmKoA4PsN0yAbpf0Jp
         DXxNyrMp2ee6o8knudkuOagr1bMomdwgILXJpxq4sVHAOU6bcAZV6QVoRbcg9chi6uil
         m94r6o6k+FTuMVZcDq0IcUPqqtnD/z/QD8SZETDTNNNz+wK4vYAyIM4AYVXD5D3VW5hD
         Rtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772698099; x=1773302899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Tu9sOHON+DSOPBlmrUYoifOv0lkJ+YvIm7FtkVs0cE=;
        b=bj/43cLjwUR/ZhepRdfXN/G9A8TXFpSlUSu0bY4HgnFs3MUjUmn77IEDvPOr1prkwZ
         vtX5xeGWUcKhWez2wciqFqCka1A5cujqzd0GSiU32PMvxNfntgT1XArqmPOS4oNNK4Gv
         RcKm/3CVZz91LElw7nHOKKJzkINW2oSW9QzqLX4q+2p0eSqq3jPR+7velLVvZXn5g3LF
         wxKn0avTLNM/d/TEfzFgI00wqc+1F9li46vXlWKYR1/NrAFShB2tJvAFGgSniJLwHRqE
         hXQ0Bgd7E//STEhNQJbaS/t7zPxDjAmsw/RvtkdVIUmqs7QG4X3b6YuyMIapxRYV460k
         Sbng==
X-Gm-Message-State: AOJu0YylN6/SmFBl1ZmAuxvRU8A9WB85CMnKXAapjl1roLd16SLDlRtf
	qmHo2AZAdiHHxLtHQCASlo0S00dzhXAECHhalOlwh7tUBALc1glHIrHI8MJodxgBHqMWqrtOJOW
	52/GwWv7O7kSSsi+3vT3LbIptIVo5EPPsd75690OCSDle7VjcvR7hsFiiyyurawf7L1LujAI=
X-Gm-Gg: ATEYQzyXz03zlv8V/TP4THfcv7VdMEqXvZuRZXUnxJoA7Kl8+rj053oW0uQrh4Gx/Pr
	LkEgY258h2R7SBOFHZPJv0ahs4WE2r6+8GFNIL066a7DZMxnCaiAhrsI+v3Qn7TTwvD5s3ZuAev
	PCvlOGI73/1s56/XQKooliA8geud0CQ06sM7JTZx476M7vHp5bIe15GJYK3hi+WD6X2jeszTvJ/
	D0wlVI4pkz4N1uVFbdbsF6ngvK1OxHriUaBgchGErrNWwHdkWdmdjnYNY/XtiIKHfd8sv6Jh2Ew
	CWumlSk/qr3cC7TiA2OyNrD+N9IXR+j+iRPZgHf4SB98b1fRz5TqSAvZg7PkLCYJUDivJoEhzHP
	8jPdTWdfyU2HvajiKPVNd7KVro+v4wvwv/jZPNB2821bx56H+
X-Received: by 2002:a17:902:f78a:b0:297:cf96:45bd with SMTP id d9443c01a7336-2ae6aa0943fmr49881525ad.19.1772698099316;
        Thu, 05 Mar 2026 00:08:19 -0800 (PST)
X-Received: by 2002:a17:902:f78a:b0:297:cf96:45bd with SMTP id d9443c01a7336-2ae6aa0943fmr49881165ad.19.1772698098846;
        Thu, 05 Mar 2026 00:08:18 -0800 (PST)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6df578sm220846945ad.81.2026.03.05.00.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 00:08:18 -0800 (PST)
Message-ID: <30122c93-7447-4f7b-b546-e4dcf80476a0@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 16:08:13 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: btusb: Allow firmware re-download when
 version matches
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
References: <20260108074353.1027877-1-shuai.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <20260108074353.1027877-1-shuai.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Uh1mhkMsMM2vBzsLOlcr4O1qfKKG7P87
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA2MyBTYWx0ZWRfX3FzxgUdZIJ1g
 jm5Lv6MGBN/DdCOqGgMkyOxzqWsxrZMS+T9qetAltRCG4ndILxA5a4oatJmNQR43itIT4L2RH2E
 loGidBY4GYJyAaTUK9uiaWXN5r+Rj1fhmU7GW8SJ80snYJPdEp4lCGR6oqLa09XRpfdyYmD9P+h
 kgvdpP8+deHhucF6x0WiGnw3Xcev9+eCifPnGD4gSZ5P+Fck4WJxtsCd+jscs7NchBEN6XECrQR
 Cc1p79gkCnV3qZwgif4molbNfrDZUKVVgxiI3Ky+zbQx1t+BkwS/aRurG89qn1JslgJ51h10d46
 0i0bwsWEDEMtUDw11/BqANtjhukwHMhd1YDF46McIiGe1bmbVFVFNRPbDN4tLdT29AcNNEjO9X2
 vShHrYVwMJ2O+8pFgq4Lkjrw+Zf1XlS/KERTeliA+HI6wWazLgWXBIPu0I00eKAmDZ0JP4AgaoI
 a+o7QFdPZmItmgstpmg==
X-Authority-Analysis: v=2.4 cv=OYWVzxTY c=1 sm=1 tr=0 ts=69a939f4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=XLcW7MSiMK0kOx3OsRAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: Uh1mhkMsMM2vBzsLOlcr4O1qfKKG7P87
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050063

Hi

On 1/8/2026 3:43 PM, Shuai Zhang wrote:
> Since USB can disconnect at any time, if it disconnects during
> the BT firmware download, the BT controller firmware version may still
> be updated even without completing the download.
>
> When USB reconnects, the BT host detects the same version as in the
> firmware file, which prevents the firmware from being downloaded again.
>
> Therefore, remove the equality check to ensure that after
> USB reconnection, the BT host can still download the firmware.
>
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>   drivers/bluetooth/btusb.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 646de80c7..991064a25 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3503,7 +3503,10 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
>   		    "firmware rome 0x%x build 0x%x",
>   		    rver_rom, rver_patch, ver_rom, ver_patch);
>   
> -	if (rver_rom != ver_rom || rver_patch <= ver_patch) {
> +	/* Allow rampatch if version is greater than or equal to firmware version.
> +	 * Equal versions are acceptable for re-flashing or recovery scenarios.
> +	 */
> +	if (rver_rom != ver_rom || rver_patch < ver_patch) {
>   		bt_dev_err(hdev, "rampatch file version did not match with firmware");
>   		err = -EINVAL;
>   		goto done;


Could you please let me know if there are any updates?

Thanks,
Shuai

