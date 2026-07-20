Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C6B432BF0
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559244; cv=none; b=jgRCD529/9M+3CqIsYdokCvJ6Bayu/eeWYuirWCrEuWGnFm7dhvV0q5g34uLyHxhKhZ8wUze9ahbpzWBCPns+gIr+vSZJThYNGpAExullTeDbJPYNvTDIhxWRmfa4XKPQUDK/BxxkMmeX/8if9HHr0jdd75cy8gOP1wSG0KXFN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559244; c=relaxed/simple;
	bh=sM9YmNWfMmoiocBXULNeg6cU0ZlvNNgvQsC2ez3yeJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueiNDqSfgqAyayILjzuf3b4y3f3HhjuHrKEaa4UNoBQulfFR9HqtoNsAr64ZMhgjhxHG98vDCT/BCAmyBiy9eDnoFKZjWpPf5wCJc5+PlHJRl6bAlniP7fTDM9hv4ST1wfHYS5FDZCg4xI+hQHWULODxY5dc/cKGQEqri3Jm728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TtR3daYd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XDbhUQuj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TtR3daYd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XDbhUQuj"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KDr7EV2878792
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 14:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Fs1mfw6KDw63FRbepMb9j5Ov
	/nDWq0OUVq/0/mks0ig=; b=TtR3daYd79B6l7VKXuUF2O5lN8dSLjjKp7fFMXu9
	85HkbPvj6y+NIN9G1StixzyzPCJbFJlcV0DCU1Mn6YzYtl1COSDLIWP55A+raK3I
	Nd1Y3gGHI2HnuaYKXHUEmgdXIoUvJwbtuAgkobNmvj7XLSg9x09QbNFl4DCxzNki
	fQWz7zl7NcOJZMGTatdIMvgoGHrC519jRUbHij8yTt8yPtMxLamxLVHPhJbWt2+1
	+ailGv+MUj7dSMiwMcVeUqn3xgbGdcQ7K/0+IjrIMZoYMknCVPkgEKm+IUs860ED
	CjMtyl8kjGDs+I4Zvve4se6DzUvlWjPqC7VEXDbPVxbDPw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhf0kt0n2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 14:54:00 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9772de2c463so461692241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 07:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784559240; x=1785164040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fs1mfw6KDw63FRbepMb9j5Ov/nDWq0OUVq/0/mks0ig=;
        b=XDbhUQujh6W7l3JUJZagAIOXmq58/cvvMPH+I5aChJSInSqWb2RA9AJW3DgV/njPX1
         r+d6CqNJHlgp9X8urLEipM5WyKFW3P2Vl0p3ZsYWydVZT7hctZbzeFFZaA3BuDBx9u6s
         hvDjpdTOAdyFuHMN5xdRp0migaKyX3cDJ7z6vnv7gTTpw7tXS6yoDCyI4BQJQnGzh+In
         xkJprMAL1bI8dGCMBIPPNblB4F47AGG3oaLSLdsnJZ+SFeDh/YALw7W6U8rqN4l2o3wE
         86udQESaCAbtTJ7OeJrTPf6wOCGN3cVYKbdJ47IlLT2+3rUTQjNeRlDlNB8teTiakP5q
         Y1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784559240; x=1785164040;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fs1mfw6KDw63FRbepMb9j5Ov/nDWq0OUVq/0/mks0ig=;
        b=ZaLzQBrymcLWdvWD059EuItXBkxZFB0iVvJmT67oTtP7Js9XI+F3B+62jkhgk4AUnM
         QLkl9RAHGveMaoHZI0FmvzYD+LTc28XCUe2XGrORMQs/RQ+/XHlb5jOF9q6JM3H5SF4F
         ylW/CnfWZHv91MHZXUxkW7Fmeue29aZGgC7aWx1YUkwVchw60B7phFSCyqXb7dfN38uT
         OnItTDCBlJH03hLt40YZPN7GjtQjN0lx0W/a5IohjalWl/40B9L2B4icKo79Ra9+9kOv
         Gqo0mm8tVg7NW0uHEDbrBll/KulsGycb3oafuzbTd4I2v+R7C325B/0JFo7kWudwTuOz
         UQ2g==
X-Forwarded-Encrypted: i=1; AHgh+RqzRkgU5bDle61ZFaVwoJKdBfqh9qgV/mnfMg0g+bt8Es9nNFkMAJ0N2RjOVWD9sWy/8yZL090lsvVUHRyJ8Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOS+CakIZJF6ApPeJen3Ah+N4Dt8vGIFHLsk4TUqXuDpc08vZm
	Uu3Xu6B69puDmFtbOm6G+mm3r+KYHpQXzlBUCcLjRZCSiBfXcDnF8ifM1vgiq56c/8Wy9TDGh2B
	kiQXJcW1MTp0TVvQ9Og49aTZT+zkPehUD2wBkVA/vqJPxaGUlvaR5A3KTiJRoGO8sLUrogz8=
X-Gm-Gg: AfdE7cnKuhDxz1mHEmm+S7FjxhRHD9bNH5a5c2pxmzeu2w0u8u/xY9Zj/4DEwVy+/Ew
	dC79q4mMLvphlvIQPmINDRxpf+xxKb+O/4jLRfGzUWH45zDnWpq/b0NdlP+a43GdXCBhpNn/pbX
	7UbCZBYtGUPJrB1eZrtDcv+jVfozekDQ2SvRHoWmvFcc31VerIa99dlw4Ln2TuHccbJRreN81xg
	2mTO1j/Z6ji0HYOkB3juzNBK/p2Z8l+mLhSfvtjjaiJaoMVo3ged40tKESl2xRLEKZsFF06/MTQ
	O8CQaB825pUyGhlGYNHgFwjbwR06FpUDt0yA8Lf2Pdn/0O/3DWVSFQeR732V/JqgfXOlBgUy8O6
	dVbP57mO+hB3DPC7et6+G9DfhLskibRT2Q8nM7sFYpiGEylvsD2nchbI6r1dADmVCezMz5puTJQ
	4cMdxyJOB8rmJVYw==
X-Received: by 2002:a05:6102:3f06:b0:650:9174:32b with SMTP id ada2fe7eead31-74753439e95mr4713785137.1.1784559239597;
        Mon, 20 Jul 2026 07:53:59 -0700 (PDT)
X-Received: by 2002:a05:6102:3f06:b0:650:9174:32b with SMTP id ada2fe7eead31-74753439e95mr4713766137.1.1784559238985;
        Mon, 20 Jul 2026 07:53:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39eb4fd4ca5sm15126371fa.23.2026.07.20.07.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:53:56 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:53:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: raoxu <raoxu@uniontech.com>
Cc: brgl@kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btqcomsmd: destroy RPMsg endpoints before
 freeing hci_dev
Message-ID: <5be7vkmpzmizgmvqxyefubgi3epnlo2uf7mabcgsapvia4ckpm@ixwfppk5z5e5>
References: <0CB2D8D715AB9933+20260713072543.3348755-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0CB2D8D715AB9933+20260713072543.3348755-1-raoxu@uniontech.com>
X-Proofpoint-ORIG-GUID: jKmVXDyma7KpP_JdGuvgtbCFp-Q8XxQg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE2NSBTYWx0ZWRfX69/O9phr6kpJ
 8cLwUs8m8nh6BdUziJitChXvCeozNG6ye0kfWpKB0hEydo3rsHO8jPU3DYoLefBFovwlxyhE1hg
 B4A+lemXfHoZIu6yFWoqCnC43KSEb68=
X-Authority-Analysis: v=2.4 cv=G58s1dk5 c=1 sm=1 tr=0 ts=6a5e3688 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=iHwBjlyiAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=dfUa8Pt-6JdyB6YyXQgA:9 a=CjuIK1q_8ugA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=uNSKXYNwxGiU6LD0JREI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE2NSBTYWx0ZWRfX0HPDNxl3KYnJ
 pQ8FbxMmwt2tnubDfoW2CzcVW61IlCZ+rR/dPd1XqjpDe1q1oudE8FvS1w3XdCDtfm+Xd6P7SVp
 4y1iQa4osw2vJNdOaujR463Cnslhj8o0ElXtma25eTw0PCuaVMcvRbKaDG1wRukfunWVS91i01r
 nnrTqLNHLxj7JFZzkzZhbzZJAeknQjLIn/T+784ILUHBO4GJwp+NNXaKunatu+vMaSU052rJFI8
 khDkv9uSslkrmED14ZIoBH0KNmKwHxtgLSVoqpaGrJLEoXMRHaSWkE9xLKJhlidB5BTIy5GhJmk
 dO+Tlk9Ajqa5qCDSIddkJDzFdIEsf6NrKXuDhGQTyTI1BlVG4F5otFpOEiXNYtEqjpBZXACJjvv
 lPrJTVDd24r+9iAkTLFRRN+g7kBdda84l32jYrHPo3/sCoLKuZGwHnztW6cqh2GXx+d+MtWchLq
 8YBOUtKHOzEWujrJ+cg==
X-Proofpoint-GUID: jKmVXDyma7KpP_JdGuvgtbCFp-Q8XxQg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200165

On Mon, Jul 13, 2026 at 03:25:43PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> The command and ACL RPMsg endpoints store struct btqcomsmd as their
> callback private data.  The receive callbacks dereference btq->hdev
> without taking an hci_dev reference.
> 
> The current teardown order frees the hci_dev before destroying the RPMsg
> endpoints in both the hci_register_dev() error path and the driver remove
> path.  If WCNSS delivers data in that window, the endpoint callback can
> run with an already freed hci_dev and pass it to the Bluetooth core.
> 
> For qcom_smd endpoints, rpmsg_destroy_ept() closes the channel and clears
> the callback under the channel recv_lock.  The receive path holds the same
> lock while invoking the callback, so destroying the endpoints first both
> prevents new callbacks and serializes with any callback already running.
> 
> Destroy the command and ACL endpoints before hci_free_dev().  Keep
> hci_unregister_dev() first during remove so the HCI core stops issuing
> operations before the transport endpoints are shut down.  In the full
> registration-error cleanup path, return directly after freeing the hci_dev
> to avoid falling through to the partial-construction labels and destroying
> the endpoints twice.
> 
> Fixes: 5052de8deff5 ("soc: qcom: smd: Transition client drivers from smd to rpmsg")
> Fixes: 9a39a927be01 ("Bluetooth: btqcomsmd: Fix a resource leak in error handling paths in the probe function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>  drivers/bluetooth/btqcomsmd.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
