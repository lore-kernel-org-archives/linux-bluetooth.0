Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B04D29992A
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783937184; cv=none; b=UICyspz3LCr3DGLSEGHOP8lUkbaAVxDTaPfLKbampDvSOz/IE1W8Y5ZxGL4LyvloV7UBw3ZXnT0b8Iv1B3f83qiwlDk9gGNySTOAx+/mO0OGHKtK9Z3T0YQ/xGq1Z/F3P+RrYqLblWBvynECubOpzDlJ3SXTH0t7znuwc46Xsss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783937184; c=relaxed/simple;
	bh=XF7U/lYM/mIEfdi0c5wI826IjFjdQbBsD6evkV1OtKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2BE2v5rXfr+D8F4ZIkxfjxGpErjpvwnIj06XTG2In9o8Qt/Xf3HSyNzRq3Rm8u8VudWaXPDelqnBAUaiHFUx558ZSNCrSjur6QuAUQ6czjuEYTLOwqTPihfZjruFrvYcnRr0kPzr51IQ/y8pfM8bdbispl+tZHC9q/sb/iFKuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WqB2vFsX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SAncp/Wb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WqB2vFsX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SAncp/Wb"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D9RZou1124047
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 10:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S1gLhtHZ0jheC8LoszOPIFkfzVvsvb92ap+0EdpZuB4=; b=WqB2vFsX3pZAkkF4
	kCuAGEQolGPY5Lxc+InkMzMtdJBhTCmp7HaJ9P83qHlbXIP9xyOTwwtuaISClXwF
	CzDoeQxCCzQOQH37b4TgB2C1Zs8kt/+37eZM6oSR54faVvbqHWjKraxC+yHvqKLb
	pRB9hJQ2Pf617klMxz2eP2U0otA+F5FLYfteyCI3cUVk1JWTvhCXpcBgYnhfvVAm
	tG1NfwO3v2Qwgvz6XzaqpQUD2Y1eXJ5CPuXQYLkJ6VgOon3+VM2OFMkEM8Ve18qO
	0rwjYOehUJPO9wN1Z/aqC/+j5BP5FJNb/nDf1nwAMsb5D3tclhLslXRtSOvQ060d
	GmTvlA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwda04se-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 10:06:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ceb3d20b7cso5633975ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 03:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783937181; x=1784541981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S1gLhtHZ0jheC8LoszOPIFkfzVvsvb92ap+0EdpZuB4=;
        b=SAncp/Wb7IIv2fc7fDFRG5Zr56AHY6VPTqFPhPOARrDb1Kf/QToOltdznTfiWN/13b
         YlD3M17Bmsyu90EVok4mXuJgSPMRVs5o2m94tkKGcq2Jm7P8qONQcL0zbgcvrdIRAxhf
         nB+11GGvBm98PyTcDhlO2Fau5c2Cz1ACitRDgvYjzwYzBBlMkwRRfPYi30e9F/hybZy/
         9Zy+5tzP3S+vKGdmTJrL4gBWfhLGAQl4tjIu1TsPEAqBNTtDRkydhm5g36JfSCw+01lG
         BCW3BLsFZznnLfDu/XQtpcGZl513KK4rvCPOAk7dxH4VYgOWzYX3fQTvVilVfac3I3bR
         o26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783937181; x=1784541981;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S1gLhtHZ0jheC8LoszOPIFkfzVvsvb92ap+0EdpZuB4=;
        b=Pw9GkPtxUW7gzd8LkFkQPxMsvtWbxtMYhdFCSY8qU3e58QwirK5du10/mJaIgl7kGt
         T6NOyWeLarE9GeCYHqnceAivn7s/50t0HJEXwOP1HZKaf9KtB92qYypfSvUVImVwscBz
         6mkYh85TRa+huJ23DVXSji6Iv7vGf0XP+KnKxzge9FwC4uOdLDmWIy8p2YdaFoYY7J4f
         jPWZNPyDTh66euruhI8BPPKWrLGqd4SggTG4JrXPFQdSL7l9vrCjMCfWsZKxi8V1B7Ty
         ZdYouG7iz4BRlD3MuW/fpH9NSEF3JJn1lG52FdQHjv9X9Mm+pr9rUWqLT0TIsU7GsVPl
         g48Q==
X-Forwarded-Encrypted: i=1; AHgh+RoeMx9c6f6uqMUe1Sb2zRmjqD4f9WEB1dzNn6GxcKD79VQJ2phvKZS2yLWXvbl7ibmC8wt+raieJTlY+JbCDyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAsaw0FNXoN+aiuVIn+0WIGUhzeJ2kvgsA3MQ7hWbtqNx+Ndkj
	ubEHic0TgJmpsHci7DhTCax6Fol+gpSEw4KIqKKz0DaSx/Pt4Jr99AxYUNMZ6eqQvtJ8L2BkJtN
	jII3EEPf3ml/6y6Qv1XFSYp046TH1Yb/t7ddhsyC7VQC8D8P215Gyu4GSQiWxc/alaDd+Iu/Ipx
	uI8Xs=
X-Gm-Gg: AfdE7ckKIUy1p+jzydf5jBjplcJEWZNCtAZRT6y84j71CHIt3EdjgU2NbJK+l3MesOj
	QGJwC4ugWudNLIQ9uKUmbtN6WxBLiPcPQH0czMCAk+F+b8TBYbA4yXROYT0uI07vy/s3Zo7xT2b
	I0QwAeElWnNHIXypel4b6cuZ9lI29qCxjFBHJPNsRfHu3JysENGx+K1reFvygeLho6MvGeKUsxR
	QKVINxOpF9sdUOPoVhcBlJfWOKpdwgyk/8TXDnaUcb2M3YPX+HswQ4yZJ1N45tMirDfR6GxcWeM
	OFKYvZS+EGI/uxW3oBABgPz97mLATlUN8EXP7Y5NsAuH1Ir9XR2XsFygAalyoV2wAj6U5f2iu4X
	lnvQ1QCXQi0uceII4UTVc3FTZW3R77uGJz3jfMSZMoVLrZuuuG2eiefYZNEiAU8sFx/YOy/hGT5
	XBOA==
X-Received: by 2002:a17:902:ec89:b0:2ca:de3:15eb with SMTP id d9443c01a7336-2ce9e1c7c46mr66505175ad.0.1783937180988;
        Mon, 13 Jul 2026 03:06:20 -0700 (PDT)
X-Received: by 2002:a17:902:ec89:b0:2ca:de3:15eb with SMTP id d9443c01a7336-2ce9e1c7c46mr66504985ad.0.1783937180507;
        Mon, 13 Jul 2026 03:06:20 -0700 (PDT)
Received: from [10.133.33.254] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb775sm96972915ad.2.2026.07.13.03.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 03:06:20 -0700 (PDT)
Message-ID: <8ab79cf2-60b3-4844-94e5-7d198169941a@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 18:06:17 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] Bluetooth: btusb: Build the driver from multiple
 source files
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260708-btusb_prep_qcc2072-v1-0-d835b187fd01@oss.qualcomm.com>
 <20260708-btusb_prep_qcc2072-v1-6-d835b187fd01@oss.qualcomm.com>
 <CABBYNZKxEm2rR4nB-1EE7X_S2d3BmLnNWr3WtDjLgk09CO4uXQ@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <CABBYNZKxEm2rR4nB-1EE7X_S2d3BmLnNWr3WtDjLgk09CO4uXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEwNCBTYWx0ZWRfX117ZYYjfKxlX
 yyUlTDQYAVBOdymkuC7edfhp6uRzXBrvOZ8uDgbGE0dXc0cQ7ow0zXrRX1KxKqQqxO9/NNs42Es
 B/16dobzyL446U4uewTx6+G8UlN7Pz0=
X-Authority-Analysis: v=2.4 cv=cNbQdFeN c=1 sm=1 tr=0 ts=6a54b89d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=EYz1plNDl9xBMI7ec9QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: Awa_vVLS17UE3mVYdGSAtus4Fhc-48DK
X-Proofpoint-ORIG-GUID: Awa_vVLS17UE3mVYdGSAtus4Fhc-48DK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEwNCBTYWx0ZWRfX90atSWu5uB7t
 ayvKFYYiDSF096pOpUE9brXQi0SP0TbzSg8Y2RsfJPQ0cmxmRqGYI3CdrKy/CPwHzsxIzNi5LKZ
 bvFk3drNgy+WVVrOGv7aP3DUf65JTPLZ51eRQTc+UBuS+wn2lyGH97TZhjMa3R2hmauhzbY/qfQ
 O/4foPH37gb7KjXdsAyj4rFwpbQHmPCJjrq1OaQHKZq9/toNL8VPlW1PHUJ8y5ExdtgZHAuRToR
 p5Jw5uKINAPz4oy6TfoCZ3xjbvMSgChiUUBth6zZNTQXInAH66QzT8o9/Yp7YwOq110g6a/FE1b
 LifQZBYadp08PPUsTl27+6auyfWXIC7dbeTGZy9g6ojFbo6urwO1JDlKM6yGWd3W0gHSzbk7aWx
 aYJ4BnsQWvB7Q8d9hckThN1usN6GQWEWoOs9r09gRupQOYMqk1GeRiHHDmII6Nkc6Xk8n9E12Gx
 45BtoBk7j/RfbOV/kNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130104

On 7/9/2026 9:40 PM, Luiz Augusto von Dentz wrote:
> Hi Zijun,
> 
> On Thu, Jul 9, 2026 at 2:15 AM Zijun Hu <zijun.hu@oss.qualcomm.com> wrote:
>> Allow the driver to include vendor-specific source files by:
>> - renaming btusb.c to btusb_main.c
>> - making btusb.o a composite object
> There is already support for including vendor-specific code, see btintel.c.

Agreed, but there are two kinds of vendor code:

So the layering I have in mind is:
btusb_main.c  ->  btusb_<vendor>.c  ->  bt<vendor>.c
- btusb_<vendor>.c: vendor USB-specific code, compiled into btusb.
- bt<vendor>.c: vendor transport-independent code, its own module (btintel.c).

One of my goals is to move the qualcomm code in btusb.c into a new
btusb_qcom.c, linked into the btusb module to keep the migration low-risk.

Does this split make sense to you, or would you prefer a different approach?
