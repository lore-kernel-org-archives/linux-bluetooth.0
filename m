Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B3449620
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789801453; cv=none; b=d2l7ZBuJ6m3DUAyAE0S8j2NQLFDKYRjij8Z22EqOMNAWykdJmNTAwHSQgFFjTCFF4JiNDDAGUoYba5/9XSUo/PmT/6kMbugGh6jFZes3goXBMQPFTGXuN0jLem/KPJan9HH+N3f2vCeRV9Lhh9SL/zGPyH91FvLXuyWzlp2qYIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789801453; c=relaxed/simple;
	bh=h2e0NF0LAmtFPPgP48R1onwy7nSv9IPGeacquOeBPtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMDaYnx1O3TS5MMO2mPdAz9dDERJnfsaTQTfpF/hL2fJJSgCjL9rDuXw2Wr9kHmxelC6qWyN81Ke+dTj3j/5m7m6hE4W+Locr6mGQRpmiyAPPPkp0C3odngkjP9KzT8oRRwU5Zd+Iv2k4nTax+xNHGT/fqwq4P6j6BZaM7F05lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aPTy2Ear; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EzEqUQVy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aPTy2Ear";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EzEqUQVy"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68J6dsWu2322809
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 07:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	azCDaLIwldUp7JFcBmNVbEouGk8MVtGFlcuw5DMZ1GM=; b=aPTy2Eare8Al5dkV
	tjHhizspMAQxx+qzIYcTwwGktFWAB6HQkiBNMcvwOzxlAVrkYfpDaMnMx6/iR2cC
	tOHHGlv33vbJ4GIOObJdefqjfauiQvqEAVLIB8i6vhNITu8oLiIip5agwf5pLJU1
	CwGJ5UtjFsRlLG81NscZmIzr3e2vAhn0aKZg9hUGrBG7zCYFZup1uoybwo+5PB8v
	H4tEz6UKlNqZMYlbjKgr30zmfVZBDC9cO0duQixL7H1gPucfx/BLS63eNYaI6Oxj
	Eid2tCbISma/Uc/s0yZh+1tkQgdle5D4J+PeEfMrU8zAUiwSwffG8+I4R30XsHo9
	muPPVg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsjs80bjc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 07:04:11 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2dd66645d0eso2389985ad.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 00:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789801450; x=1790406250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=azCDaLIwldUp7JFcBmNVbEouGk8MVtGFlcuw5DMZ1GM=;
        b=EzEqUQVypd8xdunNOb5US5ivFFYgQ/25mHewyV7CvMKbqRVI6cvcJ6fLd7AcjE+h8u
         uxPhN1jsaSeP88qLC2DBbWaEbPwp1e4Fs++/c8aK4hDWxn+P8eBpMF0ZXMABk78Wszce
         qC9raA8nCmWjdi/dPTWOAaMaLpNcReA1Ss/2EdtoZOyVCcUckqBbLUmtMxLmLrl9sQbD
         dPJdOcZgzAPEQuOncY1h2axq81EoIB82PnNrC4xf6frQjeit80mJ5+ylFYjFwBhGH1cA
         LkH75tLHOF0ZgvPN2z+WgDtl8zCF/gqCpchVJyQI5flpH4iuTI2TxIl+Ic3gK5hIrbsp
         hBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789801450; x=1790406250;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=azCDaLIwldUp7JFcBmNVbEouGk8MVtGFlcuw5DMZ1GM=;
        b=00kG75BsHb80eMw/nI5T95M6CsToK0j7qzVgj8jwkhBDze0puy9cdRffvu6fLXKSMt
         Z6ekZ5HF0NR4L2N4De8yYTFypDKONt1mepcFfoKYM8dfvAj6CUGfNE98yTSBnlo17eHz
         2yOV5AOHK7tGfuVmcjqGHpC3KYC/2d+rX5mTUmoAn6OmPoko2WaTs8eDGyIqcmx6OHmT
         8JrZlaAWJv5ZcORNJMN4R1e+2MsbzhvU+MO9NNbI9SFLOdBolmH3Qo1PKs2gnLz81X8p
         9wq6LE7vPnVyTdt4I7QXhEv2Ag+NKoARzMv58OHGLbMHXyjV5bsRLnZ0dgvAsNZjAUN2
         rovw==
X-Gm-Message-State: AFuF++loWoxdqSGUhnmBDAZralvXLRUh8wKiFDTtLDkX2cDZrBykoDJB
	hL3t3kZZz3NP6QtWxZxT4L7+9kjOeQpAZihWLPHY9vaVnZpmXau8+plpRTQfnGxkKIJiFh2uar2
	Q6ioO3hS2kdiBj+nb5bImi5Gkc7Qs/fnbBTLXO5+4i8SfOEjTuUACbG1UQoSgvGtlX5EGlvLWb/
	YvZtg=
X-Gm-Gg: AYBFou102CxLRCarDvwDjM8t/0FY96/Qmg/gL0syLjWaQwDQDOCPovobk870Rmz6sgz
	MnyIyhhtjezkWnwlusW9A66yolprMendAswtl6uhrsrmTSmZQkrOgtaSNacmoE3dQTzUtec3Bv/
	jxOnXMQGa+6KMhb+9ptMAfRYOisqexiOt3RTNIxRL5NqaaJY/02B8csPcad3O2rXHkwEvz/ylHS
	vi6CbKGNuRZVTpYBHxSfk+p8hf3Xz3BmkA9Q8YV4clrbdllt8U4O9mGVN8lsklh5YbT+VS96UT2
	V6QOJdK+B+NEevXczfjo3EOxBqJcOJmvnuAvCtUewxg75aiw9Pa7Ldey3kEzG6qxXNIhI3VDTMg
	Gu5zAlA+UHf2Zf3lidL8vvK6EctreandlXnP4DT6LNAwA5FqFwoGHQ/yZaZi2e5g5
X-Received: by 2002:a17:903:b87:b0:2d8:d29b:c1e5 with SMTP id d9443c01a7336-2ddb644f014mr81435455ad.0.1789801450184;
        Sat, 19 Sep 2026 00:04:10 -0700 (PDT)
X-Received: by 2002:a17:903:b87:b0:2d8:d29b:c1e5 with SMTP id d9443c01a7336-2ddb644f014mr81435115ad.0.1789801449684;
        Sat, 19 Sep 2026 00:04:09 -0700 (PDT)
Received: from [10.249.21.41] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179db55sm6621865ad.32.2026.09.19.00.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 00:04:09 -0700 (PDT)
Message-ID: <988c4737-16a8-4c79-b3d6-e96de8dd174d@oss.qualcomm.com>
Date: Sat, 19 Sep 2026 15:04:06 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] Bluetooth: btusb: Add support for Qualcomm
 multi-subsystem QCC2072
To: Dan Carpenter <error27@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <aqw8ShHyjdZhPc4U@stanley.mountain>
 <aqw8zNc6tXeaNPNV@stanley.mountain>
 <74e197ab-7bb7-46c8-9485-70ba64b4b552@oss.qualcomm.com>
 <aq4YdQS3RhUEIm9z@stanley.mountain>
Content-Language: en-US
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
In-Reply-To: <aq4YdQS3RhUEIm9z@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: uKZbOrT6YoNDwdGgv_LqVg6VFGmDWTr_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDEwMCBTYWx0ZWRfX50VSS4VGBuSj
 gO4JxR9wXVc3G+0Pgyub2y3CuUHTXAGss7cO4aiGhhtBPz77eqtxqAL8QZmmoAUfW7Lb74F2Et6
 21cHfRfHQv0SAXCw4WYyE4isWERc9t8=
X-Authority-Analysis: v=2.4 cv=YqWa1IYX c=1 sm=1 tr=0 ts=6aae33eb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=Nc9fs1d_jVmOuUqAJiMA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDEwMCBTYWx0ZWRfXwXiinw5ihAkY
 0qKno5E3wHATwUGr1faLL1qG8D21l2mn+xLtT9AW7Mim+0A/ajo99uB/gN1rk7cQAFXhOhrPEc2
 6Vi6Itw7SqkzlpbrZrTMYsKdyKrdZEyDQIuY1yNoSZip/lxWk2eN8KSIaU61I5t94gRWluckQNn
 7K0Mmd8x4bjNxm2YLkrj9nSjnCKVjxJllCQQiD0oVMV9+qwcoEu07VPTKMMY6XtTScaoPAo5AZf
 GSQ8K8QSdg2KlKvifbYBRI4snHlxvuB8/3J9evlrfnwT4nn2mgvurHWsM+PGf5aNOJKN/huWcSd
 BuDlzESF4ZqgA8wYs5a2L2Gq+H1K22v1HI/SGBW18LgWGhl6Adq81EGYIUUERe4OOxz1XvEY+aH
 a26IYTc+vaFZskm/TZgAAOcVNVbs+L127eFf8vtJXEkOtKet7lEiSiOC50Ezqbx1MUazzxEN0zI
 Ot50mSaiVVMOzeIKdcw==
X-Proofpoint-GUID: uKZbOrT6YoNDwdGgv_LqVg6VFGmDWTr_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-19_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609190100

On 9/19/2026 1:07 PM, Dan Carpenter wrote:
> Zero, sure.
> 
>    268  
>    269          if (IS_ERR(skb)) {
>    270                  if (!event)
>    271                          bt_dev_err(hdev, "Opcode 0x%4.4x failed: %ld", opcode,
>    272                                     PTR_ERR(skb));
>    273                  return PTR_ERR(skb);
>                         ^^^^^^^^^^^^^^^^^^^
> Error pointer.  Fine.
> 
>    274          }
>    275  
>    276          status = skb->data[0];
>    277  
>    278          kfree_skb(skb);
>    279  
>    280          return status;
>                 ^^^^^^^^^^^^^
> But this seems like it could be a positive...
> 

For HCI_OP_RESET, execution cannot reach this point when status != 0.

>    281  }

