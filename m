Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0903312812
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 02:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769740304; cv=none; b=Lo9o+h9m2uGzOb7mizpeLuKiw4gTeO9YRCet2cmTTPG/9W3UOVeIigpaTYO3jF5oKb0DpQC/kq+5WJ6hktVM8RMb3ieWPOlecZRCk1jv6jsa280094MTUH6xplZmSJtwsXxUXSdLbM/QVTWnS63IBba++zoo0blDxV0NCcBi52c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769740304; c=relaxed/simple;
	bh=BfyBYwNaNKCUI11MJFz8BZKCdTnNxlfZcr0RetvwSlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ru1Zw7eo2UXSn71xHiSxowUMi1ZJVdMa9qB7uuTvcxly36jHUfyK5slTwdZq539QeldYXdkIdkjiy7D4ETaaRn8E6WAcKvWe2tYZm5GhnwWBnGloL+mLGh+NzIqwy65QZFTVdmetSyTPFyxxh+G5BIOILJV1j63c/Z1jU66GUH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UdlAaDEA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IzRTqTHZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UdlAaDEA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IzRTqTHZ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TJqmbY071964
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 02:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vgOrTPpRiUhXd4iRRn10dbHm
	8K3qvcuMqSML4u/AN34=; b=UdlAaDEAaImYAMe6NR55CPpb7nrseC6AtxBz645F
	3yn32Nf5Js4uXtYAp0EPhOnwJtYAdsBiDHPgBpkn13xmEQ/xsOYWljan/98Ebzbj
	uihuwjek1l/9STy5AqbkZSP35LUE8xwFT7ZUYk2A3W/kVANFs42zyz+wLuxEmdxl
	3yGVP4bSV8wE6U2vD8/8QingaXirb8Z1m1KQmvWfN1qGB7gH0ltnoTM+3QKLK3j+
	cAQZLsYNAqBLrHKUh/JHPxSCcyOO8zrhZU29liPeuj32rEKmrnPEFW1x//4IdMzK
	gT3BNwSuBOiYOR3CvNP1UKNPEClpPB9AzOoIMW9DsTIPHQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0e3k8vqg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 02:31:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c5e166fb75so490141085a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 18:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769740301; x=1770345101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vgOrTPpRiUhXd4iRRn10dbHm8K3qvcuMqSML4u/AN34=;
        b=IzRTqTHZgYrfkT01fWpvbKzDFw8FeXYtTlCM83mshuYqkco99RWR4NSanKx8cks5Xc
         06mV+u7djVjeiTYQUoIJqvXrrVHjI9s6sXU2y4FDxeJ/tLUkFSbVpsiAsIvjw7UgHv8I
         OtCSymQICSR73a9txsgzie3Lfld5uAkzf2J9sKoegid93XGc8PTn65R26PMuxcPiZjrF
         xHgN1WUSWd1/iMK7Mas8th6uu0RpcVrDypq6JfXFev6/JbX5Qh5I5vmqHHKtahmCtqZQ
         VnV3c2FQ94PC4PD0nzyolmcts9XoO2xbAmGK/aL4MaO2CKcEQyqmtgW+r7HaMqz0dv8U
         Gf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769740301; x=1770345101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgOrTPpRiUhXd4iRRn10dbHm8K3qvcuMqSML4u/AN34=;
        b=oNtoNgN4tMRTbYHODFeF6cFBm0H/5Ey6oIGeJMtIInWk3kYqpc47bW9/VPsm3Cw0Z2
         izduQhvrWM4qpPS350+ZqJmIgnxLoSiovjmCFz3Eu/5RTUMtUVVxzIwlumDngCaXbShW
         o0Kgbp6APY4Q7FMqjTs53UOv0W7s/LiaHoINvqQ7KvyNCsDPbAU5CV3XXb+rsxppf9jH
         E2yBjmF9CIs0RAhftWN8h87Ct7Yl5JN6IO4G6V9gLRh7LFsHLiSDzk0rcP6UbMqkYXkH
         uigypIkrChymdQIaepb7kF3RDXT38nbvWKqbKjhjJB217P8o62ReeiefguwLNA6GWAle
         jCgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx64p8pcYTeUa8w2h3/ec2WFlJBH4iWINkHsAQ/x/005w5ndCUZuoWcZhHxNcLrOiYokoTp3QJhyYxNcO+tQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb6r0GLX7vk0+9wPa2yrmp0Q+P/Gw8LFwW2UpV7nBqPWlAfESd
	s4P/KexLlDkBDPt8ShcfDb6+YwOxCyjcif70qQcTuBXwrE5d88mQg0FNdLeAQ4X1Y8Hry7pTURg
	ZP82Pl1Cr5YHP0psk56sUtXKm4Z0tYGbl+0EAqK8jJlpGc0Kimuxo8VQsMyyDERdYsF7YECBW+r
	sTOSA=
X-Gm-Gg: AZuq6aLMyIIeJNUm01/DEP6OXzhG3Cg9VOF8rNP9K3H/Cv+D9awOInuJF3yOVGe3gY7
	D4VCJFDOqfC2K3v4Mgg1D5+LuQSjpiJ8WBYuahUZED6Ik/j6aBJIAVXeU9xI61cKiMTLLjMqp12
	bkEA0kBssuu2r9FrEQconpXJvTczDNwApoKc2hHEX2KC47iSqk8XTJiYd93yTy4rTKnEH3wwBAC
	gnuG/kWjKtbCFIzMjf+3ZRYsNDvSp8kIL6A5j5vN+/AwAP3sqanQ6ADF9QDljX3yFYpJUGMxNUc
	tk9RD6tJED5FlqjtaVz0Aw/LzXVQ0oKahjwQbqTTAyzLvJgcjZTItWtVf+1bVr2QOddyFP/y0ys
	/obDVdHcPqFVcqFqC8izxY0uA0HleTrcBf7MmTKczUhydDcu4Kbx1NB/MmCtsLSiPp3LZBnwjGB
	z08Hp7ezA4cNCEE2IPro+UFOc=
X-Received: by 2002:a05:620a:1a13:b0:89e:f83c:ee0c with SMTP id af79cd13be357-8c9eb310f3emr208417885a.74.1769740301028;
        Thu, 29 Jan 2026 18:31:41 -0800 (PST)
X-Received: by 2002:a05:620a:1a13:b0:89e:f83c:ee0c with SMTP id af79cd13be357-8c9eb310f3emr208414885a.74.1769740300465;
        Thu, 29 Jan 2026 18:31:40 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38625c8e417sm11659371fa.21.2026.01.29.18.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 18:31:38 -0800 (PST)
Date: Fri, 30 Jan 2026 04:31:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuai.zhang@oss.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com,
        wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_qca: Enable HFP hardware offload
 for WCN6855
Message-ID: <cx3yjz2nrwe6iwqorx537qzoz4qc3yefpln5ed7z3ocgeqlwq3@arj7auyyfutl>
References: <20260126162444.4194293-1-mengshi.wu@oss.qualcomm.com>
 <20260126162444.4194293-3-mengshi.wu@oss.qualcomm.com>
 <kej5u2hjxjtfdzmgtebns3amz7gmb5d2nciy45jsyglkprgh6s@kt6fodrc3oll>
 <7b9fec28-2272-4ff7-9575-76e72cecada5@oss.qualcomm.com>
 <l2ib5kalse4nop6e6ak5xronejxusnprl4qgz2wxvdw7wpzw6e@aa6fn35id4we>
 <ca86ca83-1951-433a-9903-a95dd4be23b0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca86ca83-1951-433a-9903-a95dd4be23b0@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=VI3QXtPX c=1 sm=1 tr=0 ts=697c180d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=xRJYRmCiUkmOlKP6qXQA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: IA6FBgVYzdVnjQqWpcu4vX38nDC4FeQ-
X-Proofpoint-ORIG-GUID: IA6FBgVYzdVnjQqWpcu4vX38nDC4FeQ-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDAxOCBTYWx0ZWRfX8+BaBHmhyuAZ
 Rmdw6Ay8wgqF9N7/7OMyiVvnFcduw9V16mSvgfj2EnZC3Tbxai8sClEndUQ0f/w7pDnw+eH0aUq
 bkCkp6wPKTggk/jwSi8n9HoPgtJITwVoIe0w4pPlvlR9TchqeRxU4GIi25OPuVCPEziZmFx2Ass
 OUVFb4i8HM4YeT8k4ImX6pdur2eGUF/v7blpJ3qSPNbRWL/ZwoEWpBzd08Al9KKzQwRS4H6dzlx
 7LgvjnHR89QH9pAftNuGg8KbaixEkZQrWfUWKuxEfwvnhzOr2y6F2lhD/HnPKuD8iEI/t6HpZY4
 qixJWcnkGHGOBos/C/zqs86XQoKpluza+qkj5lvOzkOUgE9fPd2rX5jB+BJDwn5hRkDOI3npo71
 aH3KfCaXtNkeOA1p96sp13TrtHkT+5SadIEFlX93pXUHkNZA0/FWPjFz06PToG3c8wXi0V4E2RV
 E/X85rAhcZOIFipn77w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300018

On Wed, Jan 28, 2026 at 11:17:49AM +0800, Mengshi Wu wrote:
> Hi, 
> 
> On 1/27/2026 11:06 PM, Dmitry Baryshkov wrote:
> > On Tue, Jan 27, 2026 at 10:32:58AM +0800, Mengshi Wu wrote:
> >>
> >>
> >> On 1/27/2026 1:51 AM, Dmitry Baryshkov wrote:
> >>> On Tue, Jan 27, 2026 at 12:24:44AM +0800, Mengshi Wu wrote:
> >>>> Add QCA_CAP_HFP_HW_OFFLOAD capability flag to WCN6855 device
> >>>> data structures to enable Hands-Free Profile (HFP) hardware
> >>>> offload support on these Qualcomm Bluetooth chipsets.
> >>>>
> >>>> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
> >>>> ---
> >>>>  drivers/bluetooth/hci_qca.c | 3 ++-
> >>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>
> >>>
> >>> Any other chips which would benefit from this flag? If you are setting
> >>> it for WCN6855, I'd assume that it also applies to WCN7850. Should it be
> >>> set for WCN6750?
> >>>
> >>
> >> Thanks for the reminder. This should also apply to WCN7850. WCN6750 is not
> >> considered at this time.
> > 
> > What does it mean? It either supports HFP ofload, or not. Does it?
> > 
> 
> We have not yet enabled the WCN6750 hardware offload feature from the
> software side. Other chips will support this feature subsequently. If
> I add the flag too early, it may be kind of misleading since the feature
> is not really ready yet.

By the software side do you mean BT firmware or something else?

-- 
With best wishes
Dmitry
