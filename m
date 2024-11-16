Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1A4262BE;
	Sat, 16 Nov 2024 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731773894; cv=none; b=OsfcKboyafv+1NimaprZBf+l/xq1G3u0+HqoInsm0Wg3oiNOmEhRjY8f3C06zoDs2TcKosM07KbB5/uyWSevOzSkbTSnhvVdwGfMMJyu57qTRkCe+4Hw0ZH5uoQAUwNF7W2f3Wu+enp156QkT9Vlpz+rEHT3vmHLyF7AoTx+08o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731773894; c=relaxed/simple;
	bh=LOmw6t/E+d3UESUVlzSpAO7MVZQar1LZB9iRDSdzsUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MAwropf4gLEqHmCV7lX76qYbx/NdjTcAZSU2a/53EnQdPehBKoNK5flkdshIeVuLMT0Yw4ALDxYEfym1f1tq1HRk+1OAshuvLOn4pD4ufz4HiR7UZ/8siK3mOAVvMyDvya7x8aFggNDzUsAV5+Y/tICqJPs3bYw2ME9VDb/0gY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CxMyor8y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CxMyor8y"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AGEcS68028855;
	Sat, 16 Nov 2024 16:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ERbkDVC0vYWi1nDWzYA+UR2ALH9IAtmrbjWrdnk+JdU=; b=CxMyor8ykgviNmPN
	3gV33g7Twpj4hDjwfs2b31htW+4pVbecFZsSkbwwlHunj6cnpxs+uyBaeosCIYKN
	ggtS8FuAxb2b+5hTOzKgUZvPEFh+F+Zknq3gx9iEqhCahb5lyoX+W5ksHs3XydaK
	1vBFVoAwfYF9qq8s+NJiWlbAQTsT5XeN1kgo+BxVGyiCbRr/frFVuaKOrOsAH68b
	dgunWF3dZ/z2+trf3YJX/Y9uOs8Spa2WvQZdQXijIP6CoeGP08a0dP/anV9P78gv
	gIpl+97tJSq4SvCuFuq0pSrX324l51ipybgJo8wpSLY9/Ds6RA90q3PYErUJDGr1
	6qN30w==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42xmp78xqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 16:17:57 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AGGHvsj013175
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 16:17:57 GMT
Received: from [10.253.8.97] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 16 Nov
 2024 08:17:54 -0800
Message-ID: <85106272-31d0-49ec-b190-597a34e2099d@quicinc.com>
Date: Sun, 17 Nov 2024 00:17:52 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: Support downloading board id specific NVM
 for WCN6855
To: Steev Klimaszewski <steev@kali.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        Zijun Hu <zijun_hu@icloud.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Bjorn
 Andersson" <bjorande@quicinc.com>,
        "Aiqun Yu (Maria)"
	<quic_aiquny@quicinc.com>,
        Cheng Jiang <quic_chejiang@quicinc.com>,
        "Johan
 Hovold" <johan@kernel.org>,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>
References: <20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com>
 <CAKXuJqg0SSLYW_XaY+vRGko33nR+Tt9BUcGaAvQt0QMAJjYzrw@mail.gmail.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CAKXuJqg0SSLYW_XaY+vRGko33nR+Tt9BUcGaAvQt0QMAJjYzrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ltmzfV1-fn61X9M_uqgFbUy-1ZmEc-Ej
X-Proofpoint-GUID: ltmzfV1-fn61X9M_uqgFbUy-1ZmEc-Ej
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=851
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411160140

On 11/15/2024 3:17 PM, Steev Klimaszewski wrote:
> Thank you for this, I'd had something similar written, so it's nice to
> see I was kind of on the right track!  I tested this on my Thinkpad
> X13s with an H2GO bluetooth Speaker and the range I can get is far
> greater when it properly loads the b8c file (with this patch), than
> with the .bin (without this patch).  Thanks again!
> 
> Tested-by: Steev Klimaszewski <steev@kali.org>

i am glad to heard that the issue can be fixed
thank you Steev for help verification with your machines.
(^^)(^^).

