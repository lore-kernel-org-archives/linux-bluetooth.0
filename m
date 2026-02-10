Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9A4328616
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770725645; cv=none; b=Rs19PGr5MbeoZ/HEgCmNMvygAl4Z5TabwzYrCpOW5SMVPFOXpk45RR4QAss9V2YHp8307WQMYnR/xtC3TrI3XmFp+lzsE7jAHEW4ycf4w2F6mQekw7CnCC1/S7CMSoyaJ/icCX1lPneNuhXnoiotN1ss8hlcoel3KJvLSjMsjQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770725645; c=relaxed/simple;
	bh=ibg5Z5sNlI1V5hopvxZ6n7KyKbVMe6RnGme4Ln1yk6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyitTa3vvWv4CbHmw/qr6xrRfyLKlQxCrtC71v6zEeeJ7SdsS0LWNGbU6WfW3/ea/+9xYQsLtZ9gLQlHZZe3L9jXnMfSQ9njGc4zXGr/6vcLdCuJjolgdB5h+xRvQr2COkUP5DeQ5+mvTbWOfuv+YefZVopQHIQuW34fpc42O7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FBBLPDq8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iFbUMKod; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FBBLPDq8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iFbUMKod"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A70DNt4004332
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 12:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3mhxAAA7pR+6yd/Is7X+V1Ot
	104elKM1yy73mC58os0=; b=FBBLPDq8nlSoicUc+uXedbM3vibJ5we/Ff1z4Nto
	30YU143KUosJKjPGCrDR7/gqvk6Ocuz5NszYE5xqmNZA1lR0tKbifPd/noGl/mHv
	p5DzfwJyBBRdPV2/2tcj/L8TeENf7C8J2jxXAVVtVPuQ30mXWh79t4S0ULSKyPXr
	9T4EYujzblmUov2HwqcZ0vG/E95I++MAtj+X7OaGqiyR+7kEDkmNavHDV1sAeKYh
	Q4qSaEbieLWLJm/cHmmliwky86ptUSFgfvHg4ylTGB+26ON8214mpxMchfqZ3v+2
	/Zn+36t69ip0SN0J1/sxBgYV3Rqyxl1VU9QFfjYWjCrO/w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7r23jg23-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 12:14:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c5296c7e57so1586081385a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 04:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770725641; x=1771330441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3mhxAAA7pR+6yd/Is7X+V1Ot104elKM1yy73mC58os0=;
        b=iFbUMKod58U+FcH6IhMnF5iO+CrsvOdFFHB3GXLVr26jb/hvsrnaV858H4NThWpI4i
         1H+Zy7qa2DqlHyWZhOv8FXknmk3INe4+h+WuWL1kEynY7puNhHlpW+i3FnC5fQsOQ8gV
         i3HFS6lAjUuEq3Lo0/rmA9sk8FiP6oEXPw5BZpg/41kT0I9Vr91iB2mu7+ZaGtUt7PvE
         LSe2AjDV0n9Y3wiOQ3Q0kCS5AcXbyyfA/3byK+sWIyqqCllHRRJ3obzxpJHvas408/Gq
         6iu6LBNPhY1MrPYgfvDJv+m4IL1qTOLfQzyMcUHrWv32j/1ZAfZSSaU2j/i9He/qPVcr
         HTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770725641; x=1771330441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mhxAAA7pR+6yd/Is7X+V1Ot104elKM1yy73mC58os0=;
        b=LRD2B7BYJY9thJSt35PnFtDqvASWmtHyih/IQMtI10UcCyrB9JYBPEiJZcFhLde7qX
         ui2pKSrwKdc37uyuS5mlY/2ZhP1WLeZpm/5r15qOGF6+e/a9063IEjGps4p0ytcbxRGt
         z0xUTJI+4auE/c4r+Rc3pmSqGgr3HvHKAlCyGetv3+VDFoo+fKu5XO+6JCoL4idQX7XV
         Ec/EqrdXNZyyO1gyd8z77tYUg5WkV7WrHRSkMWudxt+goj9tLlCECcywO4350J0Rn8kK
         2mbIFBcEbMXQTkNMQQ0srapM9njKdF5ftXOgtW2VLuGXvj5u8pXagKYbffsqNO2n2aMi
         RfUg==
X-Forwarded-Encrypted: i=1; AJvYcCWc6STIsP6D72xKsXQmUbNMrxULhxpUsk9zsP2XeU7I7aAuEFE0dVjfQ3LD5JbmYxPa60W3KY9Wj9VNWwPqcGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8rsmbbd5QTFr0uP1KqfV+urh5E5Uair3kukzBOOnUF4Hil2EN
	B299uKlco830tGtgBRl5WtFW436Ot9jN7Mk9nEOR3AfeDAW+EH6z18e5+GFgmQIePhhELAAZqrp
	YNl2UwkCMQujbyZhW8bRQtz8XLExt3eOfgpFKHkSTUapIKv2hI1FE9OcABRpbgt0oyjmJLUM=
X-Gm-Gg: AZuq6aKx5JVkVpBb9RjDEGfthWgPwiEMBB7Bo3E0sCKCPpONdG+sury6/UKckCWeJ7R
	45Nan8zBoOdGCrNpJeX/5rncoPLYMFJ34X0EAX/DKvqGA+VOHzDFm8Qk1IwPFuHQokeR9m35zUK
	ma/CTMFNkZ1ggXi5qIcHeh+HYf9He0oo7QPTAtVazqMsfSpm1aFBL13KAH9yjqvL+Z862aQX6v0
	BIF6Xb3FLRTXCn973BuJX8lLIvjXd1hGEZuu+kfucvFFLL3F7MvGwBMmdAk75EB23Jrvl2GB+3L
	PZIIEmsM75W61wxCIxRyAelbsWB/rUdlcoNWB35jmY8MCvaH3d5UyxOF3JGLuCiii3jzYkOHdwT
	eLTFPBdxKM4z3q7IB83guYXpGwnGYjDXWhJJN6UNgV78tnmBBoz+XUEsWEWYbW6dap0rHT9QW22
	g0bNp9eGtx/uZIewZFZdmotND8uwQ6EilUZSk=
X-Received: by 2002:a05:620a:1998:b0:8c9:f996:8203 with SMTP id af79cd13be357-8caeef2c1demr2162185685a.13.1770725641176;
        Tue, 10 Feb 2026 04:14:01 -0800 (PST)
X-Received: by 2002:a05:620a:1998:b0:8c9:f996:8203 with SMTP id af79cd13be357-8caeef2c1demr2162182685a.13.1770725640787;
        Tue, 10 Feb 2026 04:14:00 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44e21982sm3293335e87.71.2026.02.10.04.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 04:14:00 -0800 (PST)
Date: Tue, 10 Feb 2026 14:13:58 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Bluetooth: qca: Refactor code on the basis of chipset
 names
Message-ID: <5fqaddyc3xfpqe2tb7amc2xwhgq4ytekkjheqvlcmf3qjjslxk@q3d2sgff3xl2>
References: <20260210120101.1046091-1-vivek.sahu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210120101.1046091-1-vivek.sahu@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEwMiBTYWx0ZWRfX0ywYEXImCzU2
 LyPXkEjxFcmPu+D4TRv36XUTMDXbZ+HUWO5nRBA79qNXFCrJw+OmkCo1G8l/YHldk5Z0YE7mGZJ
 i2olGvzeMHyswJeehHHjXETyNjospSpzfVGEPQctacSCNMYT/zCkBmfm69hHJD6dUMSEnj7jItW
 05A8wRtklHNSa8oPrRLWzrecUkXlkWszgEzRXw0c6niFSy3kKH9sXnkldEUG47cuEBMvMuKzZOA
 7kSJfcyMIxrANeDekGLUXdUluttsfHa9SKzaVhl1vB0DcpB/nVrVcUip0CmFViNMYKWvEYPoctD
 bdjn95dyoIrot6TWoTSbrHe0Q9a0UlF+RNm8GHHxbdrRIsRmg4jWhpm4ioatdkGG2sNxLtxF10U
 cdZyUSVbWGGPExVWEA9S8WSASkcEFKGvc9C7bRObbJTxC90KOMvt2wqU0ZZz+0wgpeLyRBjGGOE
 k+iDB8K26lIRV4Kz81w==
X-Authority-Analysis: v=2.4 cv=MLRtWcZl c=1 sm=1 tr=0 ts=698b210a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=gBihFXd2_hD-ogQTx7UA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: Z-bP8MLC7dj6HL4DnRcEfoQDs5vIbxSU
X-Proofpoint-GUID: Z-bP8MLC7dj6HL4DnRcEfoQDs5vIbxSU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100102

On Tue, Feb 10, 2026 at 05:31:01PM +0530, Vivek Sahu wrote:
> Whenever new chipset support is added to the driver code,
> we ended up adding chipset name to the last of the switch case
> arising code readability issue because of improper sorting of
> the chipset names in various places of the code.

If it was true, the file would have been less oragnized than it is now.


Aside from that,


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> 
> Refactor code such a way that new chipset can be added easily
> in the code without compromising code readability.
> 
> Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c   | 37 +++++++++++++++++++------------------
>  drivers/bluetooth/hci_qca.c | 30 +++++++++++++++---------------
>  2 files changed, 34 insertions(+), 33 deletions(-)
> 

-- 
With best wishes
Dmitry
