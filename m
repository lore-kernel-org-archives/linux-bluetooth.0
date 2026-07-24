Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6992340EB9A
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909970; cv=pass; b=SQgYuLtgNuPiFk3t41kUACh9VTuAU08agVzCK0KeCqwnLR2N3wJNlF3hH5hkgJlX4Uu3IcQcGls19rW8QkiOY6ialWMRnPJ5d4LB9J+3AZTt14MhR7CwnprTa8f2C9KfAQfnMhJUt1pejKpAb4CLE3LPR6PibYhQVyQapFPHC3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909970; c=relaxed/simple;
	bh=2Pz7yi8VnRHhiqlQrvwuFgDpKz5CVC4Q8lP2Pw68SCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I93ygVuOZbXJlKvi+pfvqxCBRDliGKWWQkwSnPRAtN0QXWzozzgHdBdTp3w2w2nbYC3sng/XlyOIA8gx/v2uI6TJkxiBGqHHdkdCEotiQpS9suwgktTn5BkXDhcaetQ8z/jY39W01SeB7APF0iR6CWqj8Mqk0P28hBU5Owx0FLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nbVcHouG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QBnWBs8p; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nbVcHouG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QBnWBs8p"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbABw3344414
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 16:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FuTrxtmptBklBXvMb0kKcU77gZb2KY5onwBT7j6J+nk=; b=nbVcHouGe6Z+VeOs
	h7qeGBArJI327t86C+PrctOZsyltv748m/ScDV0HsPpenC1z3jFTg4LyiV6J/FyZ
	owGOr/4SL9LTo2UqQvKh0uDL88gNcHr0uVKuOvntU6WpM2VT9F00DWYccU7reCNf
	3W+Shr4Az7Cj3bgZwWT10I5+AfeG1ieAsn6FNNauwF6wH+zK8KT/3uOxiM0PKJA5
	g5hCgpfIWj021uazh1SKvG5t/yYiUeiG3mZT3crN8cA/gFB3Nd8A8h8MQQObHNWx
	CXusUmB8HAJeYd6rra2az3epDYLosYNDbtF7F4WrLTpOgjM4yHXPbGflsMaEgVX3
	My6sdw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm8cf0tfb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 16:19:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92ec91dc265so51945685a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 09:19:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784909956; cv=none;
        d=google.com; s=arc-20260327;
        b=Gdlp4EaVa7EMaOBzvJ+NY8AuwZd5u9MetU9PunlPnBE9XGSpB4BxsZeH8JRKJ1VKeZ
         rWdoRDFidiG3sVDPh4NbnI9CKT7wpnaoV2kBaYNpEDY6VBJJiKC0DICJmlu+c8a3K2lj
         IXdyk4E2obqnIugNYqHb30WcKd/do8tPTcDRl83ogrfyG90XGg0mbIrvKJZG/DSb7gnz
         FFuy+Ax5+kNm6UK0A4WxGdc4farbkFWn+5ciBagDyiejgG+MKW9eEylMdo6KzWJ4Wygv
         iM1qIUcSe8yWdiUSNm0s8XAK1KyHvX2RlfpgRZ0RtD8DnokHZ8U4/xYdD2hLAZkasON4
         bOmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FuTrxtmptBklBXvMb0kKcU77gZb2KY5onwBT7j6J+nk=;
        fh=XcxUMSDr2oB6EffC3JeNGaDBQMM3qT0OM1ON5OLskyA=;
        b=hkAgzZZEFyjjpT+8awJlT9zZJHXhb7dx1ET+ET0V88iJwiiNv+WLMjuD16cmLA2fi/
         fvpsfnszK2whcJPqA1+9UvqX2l8nTFkp2dXPALIvKapTHmFqkxU7AqmLrrQTB3FHZjBq
         yWygOpic0ADmKgIkC9L3tnJGbAqDGmW9qOxUtlkbKLbofjrZufwi4/bVT+qQ17I1RgsY
         KllXmB2ZQPQkhYVtjXQsNu25skqlvikQFVhj5+MtZm4bkq295LTtrZVAK661YtBKckxZ
         SWCPbVL+rY2nNf9Q7YFzaBNUzLf1pe5FcxejrbFRsqba5f2waE+/tiCJbXJnQtLeNVbg
         Q10g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784909956; x=1785514756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FuTrxtmptBklBXvMb0kKcU77gZb2KY5onwBT7j6J+nk=;
        b=QBnWBs8pQw5wzNA8WwdaOkxUQQF7Ena/XK3A2pUYAMvQPPyb581gO2Mi/SAXt4VDxb
         pJNJe7B3v2OfgFRxwFEEBcaCxpmAOIGWUzmyQuttmynAImfQD73xIZdZl4l0P0rERPJP
         /lpeco0LGrc68SVmmkfXDi/Aiw6UgwokLKaftWKsyA4eseUOQuApP6mrpcFDoGn1Wdp2
         XzAotZjdfQ0eU3U+C+NtkPomPdCRd4j8kHoXIpQM7ncqY9xHNmrgaWVaQoVZS3puy+79
         pPlDzrHQ7WmKBGJy7BPyjCLZwlU5rtEpJaNSb/4DoSuZoS5RoR+vhvY0bbEDi+a4G8IK
         uohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784909956; x=1785514756;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FuTrxtmptBklBXvMb0kKcU77gZb2KY5onwBT7j6J+nk=;
        b=ntcuIpjzyYgq+nTGSLkpDHbx/6KD7qHDzJephEQgnK5JKnUFRQj2CcXCrMPe1J54Iz
         /3YhIBDT6rXmVh0Q2zqjVqYQr08/cUSmHUgHZBBB/V4D2d8VsoHKfkMmX5ihZCzW15m9
         WB2XUDE1I2ykJ0S5myEe1WM6zK0+0nokxFzAzUjeu9iHmxB1j34DIlUXpdong1XFrET4
         vug8DH2JSMAuJYKhPt2QG8+IR2D5RVQ1ThlsgvrRAH6FVp758CKF0r6qkDI92VFnmjfh
         0I9tbYpr6vXen5FjQ4GpiullB5e7UzVjYM1HuSSuilK5TCLWZtxNwo9awcB2fQmyZyOv
         mL3A==
X-Forwarded-Encrypted: i=1; AHgh+RpbB4lVDRVS7NtwmfafqRr0UeI4vEuvlBYP1ty22rM8/LcWQRY5dNbGYjdswRkBSyGn2+i30KYSELIx8MyuKbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws9gGr3fGMBCfoB5MLeX3rByOu8cXfE6ByHLL4m3ZbaMy8xjyy
	mk8xmun7P2g8xkDgHFhwFeJlUV60xGb9ewdtdTQiSoQdWlE7v2nNuL0xsP+pCw+1HMVfJNmvoI9
	OQuAiuQZwO0gxf7jrPXoqDdnhtzA7lFBfrvlsKDrA5fPlJgR2sK/BdvweSzhB8+JnYbKycOe/bO
	d8gj0/w2xzuHfOQzCa/JhHwXXHFmz4LURShvxko442QHyaLQ==
X-Gm-Gg: AR+sD12oHMkveh2fdpYjWns6Eo+aX29T0e9IgG/GHhbiN3yPXlpX0XQbHcSxQUS36nZ
	7Q0ZPrvJuipIH00XWqKXCiaCoPA9+t/3MSGDTndOFnDusgR44XNzn2lbRz+499vvr5hF4L7bwgM
	j95K0uhF87tMulpkUtoe6sH04zPPpada+EFYNaNd0sKp9WywlEi4jRL3r8HuVX+3x12eX2gKUR0
	qfFReYOdX7pcyugd9+HEM47Nh5MOgay6hG1Y0BLwlm+lGiAqUvfl2eN9fX/lvpCNN4aIOV+uu4=
X-Received: by 2002:a05:620a:a29b:10b0:928:f440:2dc7 with SMTP id af79cd13be357-93103608240mr655011785a.35.1784909956471;
        Fri, 24 Jul 2026 09:19:16 -0700 (PDT)
X-Received: by 2002:a05:620a:a29b:10b0:928:f440:2dc7 with SMTP id
 af79cd13be357-93103608240mr655005485a.35.1784909955860; Fri, 24 Jul 2026
 09:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
 <20260703-block-as-nvmem-v8-5-98ae32bfc49a@oss.qualcomm.com>
 <amLwz6WuHYUwKKJo@infradead.org> <CAFEp6-1_iariDyqWj0KezHAtULSO+piPHX0F=Z46Rx4KDNLmXw@mail.gmail.com>
 <amNkX6HV7c_8jRUa@infradead.org>
In-Reply-To: <amNkX6HV7c_8jRUa@infradead.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 18:19:04 +0200
X-Gm-Features: AUfX_my698y_ctqeRF24VMWwW_1w27mTDvVkuG8C8ZhXfnEBEfynx8DYsYuY-cE
Message-ID: <CAFEp6-2sZTBba4isNDmykh1X0HCxoeWQb5_bJp7AGQHU1E+MLQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] block: implement NVMEM provider
To: Christoph Hellwig <hch@infradead.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE0NiBTYWx0ZWRfX63qxLr6e6Z8x
 J8lK5xONkNsQujy5pbh0OAquTtVEIdRNmp7PrczuSldZ78k71TnNLWXt88ArpRnd1mTqVnqYEmt
 X1Il3XAhr2FzhAO74Uh4h2fFehaI+3k=
X-Proofpoint-GUID: cb3S5c0cM30L41DzY2pyC7diRgMt5ZqJ
X-Proofpoint-ORIG-GUID: cb3S5c0cM30L41DzY2pyC7diRgMt5ZqJ
X-Authority-Analysis: v=2.4 cv=er/vCIpX c=1 sm=1 tr=0 ts=6a639085 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=JfrnYn6hAAAA:8 a=-e8Xlw_gh5nxI56MKtwA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE0NiBTYWx0ZWRfX3xz74rHMfQE1
 f0JqJVMQkPfXTaKPcN+RNJqWkBA/2B+c95UTGwZaQC+5z8JtNCVelCXcpJzd9dZfX0h77TsNpbB
 GTo6rmLwpE+LIuLJ/hqzlPU9Q3voUrJwSNgmjhBrpzPKYD466YxkZflR3XLSM3XmfqohHy8BJgz
 dcOP8AF5qYUVrDCYX+ySbjUL4YXicbHyK2VT4ErLi4vPt+FPjSJak3kgwbFxdVduDfYDnpuHyFh
 Sz2ck65Xc3DXiH2FDNdrU8BL9B9xjwrzMyCZw+muKRcUsQz+0LF/HCIhjdTwttPjuRe8O2zrHte
 4IinrjyG8uwdfJ4MdnJP1tiv+TGWFT8cgxXlW4A6BO5QSlmWcXGo7ephs2nMTYq5dHsFAAN1Q6v
 vEbybORpmUVuUiUvJBFZyG15LQLZw9RZz2roUsTl9WGMVqtZkwYfnL/LqwemNLEG9F38P0QEu4X
 mUGiD1F24sMxoN9OwdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240146

On Fri, Jul 24, 2026 at 3:11=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, Jul 24, 2026 at 11:10:58AM +0200, Loic Poulain wrote:
> > Right, I was planning to add partition support in a follow-up series.
> > But since this is really supposed to be a block-agnostic feature,
> > whether it's a disk or a partition, I'll include partition in v8.
>
> Please include the partitions, as including them or not matters for
> the interfaces.  What is holding that support back now?  fwnode
> magic?

Yes, there is a bit of fwnode magic involved in partitions of/core,
but adding it is fairly straightforward.

>
> > > Also once you register the whole devices as nvmem provider, we really
> > > should keep it from being used a block device, shouldn't we?
> >
> >
> > I'm not sure, the whole concept is block backed NVMEM, so we still
> > need to add that block as base layer, though we could discuss
> > suppressing uevent for it. Preventing block usage would make the
> > feature much more intrusive than other NVMEM providers like MTD, where
> > the underlying device stays accessible. And we may genuinely still
> > want to write the disk (e.g. for factory provisioning), updating the
> > very data the cells point to, etc. There's also the layering aspect,
> > if a disk (e.g. mmcblk0) has logical partitions on top (mmcblk0pX), we
> > still register/expose the whole disk mmcblk0 as a block device
> > regardless. So if a disk contains NVMEM cells, I think it should still
> > be exposed as a block device as well.
>
> So we now get two unsynchronized ways to access the same device?
> At least we need to prevent exclusive openers on the block device
> side.  And document the side channel very well.

Yes, effectively, so the simpler is to open it exclusively per read
in reg_read with a holder (exclusive). This gives us proper exclusion
against other holders, but only transiently for the duration of the read.
It's the simpler solution if acceptable.

Another option would be to claim the device for the whole NVMEM
lifetime, but currently we can't bdev/open the block device from
nvmem_register(). That path runs early, while the disk/partition setup
already holds disk->open_mutex. So that would require a larger change.

Regards,
Loic
