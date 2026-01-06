Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367902192F9
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 02:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665772; cv=none; b=cP5qK9ZBP2dcugXoQgHfx/NSTjdS5s2rx5LUxeer/QG8mQOKzaKtMF/7GOUBUSKn4Zx2Sa+B3FRwaF8GzfoDUkJnqIXHYWP5Pb8gjCq/zPcGUWGwNM5NxprdqbgD1yjO/+hXUvlqCbiKJCT0LifPSgjZs/hXaCPmeor7Ilm3G5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665772; c=relaxed/simple;
	bh=TUHF9ztNEs/7czt1Jxow6KX0t+XWIyloinz7D4p9z4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eggEknRTwsgFA1zCZv9BTvAl9XOYiMjo7Y2lyrEH6nLIvpGKVfqGE5KkJFrWUJIHRQIXLibBcDJmHoMVy7sk47bOXCe0d9P6buh/VKmLFeVOqQUaE6Rgx+dQngtP6RcPLs4+vg/2f+B3REcSmeeIW80gle54g6YkbwbunE8nxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gosSQmKy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J3IoUnIV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gosSQmKy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J3IoUnIV"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060nLMp2886425
	for <linux-bluetooth@vger.kernel.org>; Tue, 6 Jan 2026 02:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=J9iomrFfmYg/6HA3LVSllQen
	Xn+0Kal4uTrkXIWdGSg=; b=gosSQmKyGNgZbeFNXMqaoGUcauR8ahd8Ce3YAHGs
	v3fin0wz0XZ24NFFo7gPsIqQJ0NjVPZkjSHgT7O9XHmddWBeeG3dtWxMoCKFc5zK
	oi2BN1ACia9yfufO5BagWU//8/vn/9TyXxiM6PdQYP7ciIZKTnQnXumOsxQnry/1
	nVy13f0LfnTBkwelFZvRnmjSGVsINzD0vxGosYSR7iJZ+QhsblLO2sbQqUe/occ/
	+r9h1g7Ns4gozywXKUyZB2SEOyQhIvLvMyoq5OFQTthF+Mr5Gk6bbMQw/g5LVaRr
	69bbAkNlI8YQVyVYpl5HCoVYhA/k6ZsQzeBI4k6CYtzscA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgpnd8cwu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 06 Jan 2026 02:16:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee16731ceaso11830521cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Jan 2026 18:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767665769; x=1768270569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J9iomrFfmYg/6HA3LVSllQenXn+0Kal4uTrkXIWdGSg=;
        b=J3IoUnIVo5nHcAGFTajmc2tcqqtIEmdAqbvzRRIXu2R1tbddyPCoIQW3JsnRQuRoxC
         zLIux3t+KVwKBkAA9EdKBDyhobb6X2EbDWTlrx4WDq+BttKPNuhG254d74f4uA7dbBfz
         6CehH1EA2Etz38qL5dqSD4SIHzkek3xxMnC1jNnGbIGkCRiou+lYMG3NuGtJ8WlM9Jmg
         BBiDlcKxZYY3XVmyvNULe/PFLJ1GjXzKr1WGDvtci69iOD3N8xiu3RH72f5VIatUky3B
         ZtcZXb+lqz4MpVURzBIoxvvV2U50HGYSEgii1NKaqhYA3AYuvqFrtadquHEoiDy7d3SL
         gbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767665769; x=1768270569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9iomrFfmYg/6HA3LVSllQenXn+0Kal4uTrkXIWdGSg=;
        b=ZRZkPrI2xrT0KEpWfhWTHeeQo/1LGpKNHJbRfXMNQSpbtzHHHXKogmJyFp/4/83vl+
         SQH7l/qlasOzS78BzzJz1Pb1h1Jc1+KioYUxSWWjns/KX/WXsQ+jHLTiLhS+4619Q2Qt
         HD6yhwvfnoj6l5C7ohD886tuDi1UHy94CUck2ulbpQLAHYqo7uZXpLU1lgWyQKzwWNLm
         lmCKbGFd9oAlZRLxiE5tQWtC8GgZUY29GoVEYj+csR1pu6ntoiS3xYx5FdEILCcJSJvr
         MGkcXK8AikwKdg/sROGdjZ7nAN2N5HNDGVCNvEJaB2U+RxHI6mfZZCu0vW7ESsC6szn6
         XGLw==
X-Forwarded-Encrypted: i=1; AJvYcCUGNRtudIsvh27lgwcD5E7+kmtlz/z6jzjdU3zG6A/dKwX5B8pkz4qkY3f5UQ76IOUYxBhTiQWP3mCxiNWqqJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr3o2MsKT9KEmOdYsXvLilWircBapottKA521v0EJ676+Lnc/k
	/WkdpllQtOeMGDVDGuilaE6jlJZuzPwXpzmHKvzTV9sfYndnEZgu+0drH2/u8C8IcH4EM3nO8iA
	jGj3zDHrpVgOdPNPAMj6izXpdjIHHbA8RIjKQbK9qZxAiR6C0pUf7IcODzlAnKpZxFPT/juQ=
X-Gm-Gg: AY/fxX4TckQdDwKdVTcDOFfzTz74PGi8HCVxXcvEGaTmSpbJhhDD7O0cxunkXzlgR8u
	Vqg0tj9Zb6t0fo/TRXb2/il9ll+RrLrOytRZUDLrIAfhd5n8MwQ9FYg5KpQZwP1fsmP7NSgn9hB
	pJ4eoq3FZ/wbkbYFb3J46c6vvKOSU6RWdj7SQXrlCtM020seeb2uId0MUrGvXyBfNXk7GOXQps6
	KyFNjPWTNhpbOWqDxLgs0Yd1Q77bAOGWruFtiYFPnIUDBxBVz8z9tRmeNDek7vSWMk7gcP7mTsB
	n/s2/5wHtAw2htRYoMYGadVQfc6uewM7x35h1a2BAyj/vs7eb6F51H23/VfjQGH9petC5Me+gPV
	4ibBr42TmX0Z7FwJxo1dGfKWcXUiU7+utgFV0I38uyxcfMDDUWChbSM45CHT98p/e5NbyYLHKnY
	OuVTESQ+6Ysc0wKiY1jGzgo54=
X-Received: by 2002:ac8:5d49:0:b0:4ed:b134:38ea with SMTP id d75a77b69052e-4ffa77c0ceemr20486451cf.41.1767665769444;
        Mon, 05 Jan 2026 18:16:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/6jccP836wcg2kfbfEdXzrlFGXB5m6tGWTv+uag8uHyDAZOcFC3gNYkrsdpmeEcB1fyxZQA==
X-Received: by 2002:ac8:5d49:0:b0:4ed:b134:38ea with SMTP id d75a77b69052e-4ffa77c0ceemr20486031cf.41.1767665768880;
        Mon, 05 Jan 2026 18:16:08 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65d1a153sm211351e87.44.2026.01.05.18.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 18:16:08 -0800 (PST)
Date: Tue, 6 Jan 2026 04:16:06 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH v7 0/1] Bluetooth: btqca: move WCN7850 WA
Message-ID: <tfdeucc7opjtjuo723hskens3te3eg5ohm7db6tbhompbtgkkq@vsqgz5qtmbr2>
References: <20260106020738.466321-1-shuai.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106020738.466321-1-shuai.zhang@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: Nhlf8Y-GNzz__xtClo6nQsdIRhVxh5U8
X-Proofpoint-GUID: Nhlf8Y-GNzz__xtClo6nQsdIRhVxh5U8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAxOCBTYWx0ZWRfX0ORlAib6r+zg
 UIueGhw0KmczdZqdxtCKJqnki2HxhMF2iQ4hreQ2RZ4UK8f5MtHGABeQQOwoOuHLQ+rMnSZHK0I
 5Ng3DCsxiGXa/8lpNu/++UEutpigm6VMU5nRrd1fxRZT1p4C+M+orBL1wmZ+5nd/QMIs3szBNh0
 2Ui0msfnJuJNIcCUpFtnhK9SyMh27ebTjW9iTx9qD4FJ6Y+lzItJaQ8AtnsYSh2KAXp5pKXALJu
 WXP+vqKMsdr7wLIbA+7TiDmWJnlfzPu76NcWk9rZofOg9NLA3k/+e08r76rr9D7x9WNx2Tv2nfO
 ZhtNs7y0WKE87ZnTFt8lJlsKGI3yCmxD3C15oQmT7Hb84IEJx+jzYGvrE3HOf2QavZuCSsqO7qo
 DjxQ3eFgzeM9dJ3FCu7h1fArs71MwgfC+tUhLCLWgz5Tvc30k8kFK94/p/i+ALo2RVQ2/3KEqeb
 M8XpZrUWIVyVKGOguDg==
X-Authority-Analysis: v=2.4 cv=Jpz8bc4C c=1 sm=1 tr=0 ts=695c706a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=GL40hWPH6WxBScVHmQYA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060018

On Tue, Jan 06, 2026 at 10:07:37AM +0800, Shuai Zhang wrote:
> Move WCN7850 workaround to the caller

Why have you lost the second patch?

> 
> Changes v7
> - Update the if logic for firmware retrieval failure.
> - Link to v6:
>   https://lore.kernel.org/all/20260105055646.3816296-1-shuai.zhang@oss.qualcomm.com/
> Changes v6
> - Add WCN7850 workaround details in the commit.
> - Reduce the logic nesting level.
> - Link to v5:
>   https://lore.kernel.org/all/20251231075817.2611848-1-shuai.zhang@oss.qualcomm.com/
> 
> Changes v5
> - Separate move WCN7850 and add WCN6855 fw name commit.
> - remove WCN7850 unuseless condition.
> - Link to v4:
>   https://lore.kernel.org/all/20251226075621.3223336-1-shuai.zhang@oss.qualcomm.com/
> 
> Changed v4:
> - move WCN7850 WA to the caller.
>   handle cases where the firmware cannot be found.
> - Link to v3
>   https://lore.kernel.org/all/20251117021645.712753-1-shuai.zhang@oss.qualcomm.com/
> 
> changed v3:
> - Remove CC satble
> - Update commit
> - add test steps and log
> - Link to v2
>   https://lore.kernel.org/all/20251114081751.3940541-2-shuai.zhang@oss.qualcomm.com/
> 
> Changes v2:
> - Add Fixes tag.
> - Add comments in the commit and code to explain the reason for the changes.
> - Link to v1
>   https://lore.kernel.org/all/20251112074638.1592864-1-quic_shuaz@quicinc.com/
> 
> Shuai Zhang (2):
>   Bluetooth: btqca: move WCN7850 workaround to the caller
>   Bluetooth: btqca: Add WCN6855 firmware priority selection feature
> 
>  drivers/bluetooth/btqca.c | 66 ++++++++++++++++++++++++---------------
>  1 file changed, 41 insertions(+), 25 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
