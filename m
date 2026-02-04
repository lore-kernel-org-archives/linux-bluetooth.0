Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D9B2459DC
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Feb 2026 02:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770173093; cv=none; b=sDdJEjnOVwGbctPKujZApiNC7yX0KOFl4/5iQXp/NcZdDTbDXJrWSYvKAI/kb1tXrOcKLzB0awQIMkk1kpbTm9boZ4aJihR8SIfo6A1u/ZFpTns4M5ISbMwySX17KQ0OStNypSaawZsU3eRkfSPXFLe0hW3MQTajvo9xclcfoP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770173093; c=relaxed/simple;
	bh=URSzt4e31IWtDehdEwM8TtFL1y1HXZAdRA2GJR4mqEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTI/d1GOKs/jOQHJU0xStPrp4gHgngReTg5+m3JI5DgEK2UNkNM4JulHyJP2jZTreqya1fnPCfjLDYF0uBDnPNEqlT3RocKWOLRhqOso7qnbkTB7xj3bsL9r2ElYOcVyPxUh7TW75mPBGy8cAaYPBtq22TgBxnk5amERG9jqrlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NER02KUj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MkmBLyp4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NER02KUj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MkmBLyp4"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613IlrdX4122887
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Feb 2026 02:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PXkXd0BW+NaXrKZqC+f14ycv
	r1b/HmaY15QlzENtKsQ=; b=NER02KUjODtiw4oi+uVa1Tyecf7N0HblURCLPzcN
	nh3CKR//I2lN2UCW+gHLpP3c61sPCtC6GM9fEcBURHei2DAU15Rm0Rs5H/u4imPV
	Xh2OuKpjSqRtoEXUTV1kSB6SNusR+ggtpkIFG2Ip1u9wktrTnsEBwBsP9+S6ClHS
	KRug7vBf5kc43wJE7WjKZr/rTycuXTllTollQQpVw6G1OpaY9GF7x3a5GcFUTqEJ
	pPrYJkFybeI0xurdOcZ4cZnUGcQv5Y1JNm6r+ylWuGJwX8o7poorX9b/hiXZAU+w
	/RtCwzuVX4qEI7qQHuq+XrycMhMmxzcIVO1CWO6GuBigHA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3kbkj7uh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 04 Feb 2026 02:44:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c882774f0dso486972885a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Feb 2026 18:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770173091; x=1770777891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PXkXd0BW+NaXrKZqC+f14ycvr1b/HmaY15QlzENtKsQ=;
        b=MkmBLyp4Xrykzfp0ueE3nm0ZUSRGC3mIvS8MAnHzaiosw0EOeLnA1wKjyf6OOdBYkx
         vAoSkbLzT6ecel2zvgKjNmrhrx5dP+yC1TiV4FRxvmeV2Oobf+R6sv9glJUJsRQWeaWg
         ocKLZkFidbVznmjusDJljKaDwaeQQFnKKFq4kHxNAE/SSJkWLgrVgebIVugQRt95akga
         PFlJqVfjaVM/Mz2de6aUs8RTMz34VSCeQWXMC5raycf2oAGGJu0JVmNk7bw8DDfON1JN
         v1OjgSuPqw3zCRZqxuq4O5TQZp9bBlvbnHs1oDuYkT9oUiipPTo+1a9RvXVs64Em6uaS
         yKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770173091; x=1770777891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXkXd0BW+NaXrKZqC+f14ycvr1b/HmaY15QlzENtKsQ=;
        b=VCijs9x/5RiAk8JSZaWhwzKpCOG9dEeuPx56Jj1oKdh3gce4reqoTo0gj+DVKq2Q28
         Lb3WQ5nBi6b41/xdH0YoJMJgbDmxQ5ZbsgEENL+L97RfEcEfYXay0csN+NMlU9LFnflG
         rqE9FfZ7EmUCBsu7HB38l6Ew54hrQ4+75nWTAFTXAnbMkPN2hPRQACKsec0kahgLYmFR
         eNQSdYHjC67CashmoPYFo5PIpR+nNApdMRERAEtuCJ/DPauz9n54lnBBG1kZHrhj8I7p
         YIjt+gCuIbwWIS1H0DLX5TsCjks0bzvStrVAAZYmCnrnKvUalTWawseRDq379Hih+NQI
         HpGA==
X-Forwarded-Encrypted: i=1; AJvYcCVCliVvkakqBgp51yb+HuVXuzvvyTYbDa8nMtT7VrAoQlD+QxpCuBC1KFCAR5dvTH39fkjvSI402xDDZK8xshg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGR7intH5KAAFjcSCmi3Kll5eHrZKDgnGEH9I1YgHZlvEyxjSS
	k3HK8fbOCxa8D9IQsu49+WvdYCH0ZG23S9EbdYmUurnSub4hoYYz1MmXvP4kOBcFXy21Smi4l3e
	1Pv16x1o/2vUF07XQGRJPCdurh9Zt0mrS5vxLNx1TSUlKTp95jPlPP/26ZcP0rKn3g78Gtx8=
X-Gm-Gg: AZuq6aLnMD4N2iux/4At0mvWPzIoIuphIfPYfAwxP7uaB8lj4T/Os3EfBjGJliUOARG
	lL4ZVN1GVEyv63dMKdoEBa4sSrLAT7juJcPTFWEPDbhO8G6o0oTyR2Gtb7RGG+cnlnG2d6Oo1Z+
	gc/TSE6vO74N/1LAby52pf6QLyfDLAE4IezoLVb3/KKSa1pS+MAiNmy1UZgiiPqvRMRX9JisdY3
	M0JXaVPysPuQPeZLZhSCUc/aLZN/FdcCrb3kQzSzoTBhIPnhlRcqWqxGj4wV9UD1FC8EAMAb57H
	/hN0tN1OdFNBSTgy84s7oLAHmZV2ChEszLQy5lnvuES7PFqzVzW3AwSmDoXRC8rhIlfiBGlJh9D
	W5eAzrNsr7NU11JxIhSvrwdwK4jJ+7JMD222gAgyoC1xPPgIZa4qa8ry9SiYtGmaFA3v7RUj9yp
	vOi783ttnXg9uiH/TRZCYg/ss=
X-Received: by 2002:a05:620a:448e:b0:8c6:a734:7d8a with SMTP id af79cd13be357-8ca2f839d28mr210953185a.4.1770173090736;
        Tue, 03 Feb 2026 18:44:50 -0800 (PST)
X-Received: by 2002:a05:620a:448e:b0:8c6:a734:7d8a with SMTP id af79cd13be357-8ca2f839d28mr210951185a.4.1770173090298;
        Tue, 03 Feb 2026 18:44:50 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e388278bdsm280134e87.81.2026.02.03.18.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 18:44:49 -0800 (PST)
Date: Wed, 4 Feb 2026 04:44:48 +0200
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
Message-ID: <cumctdilwq4nknp2yvix3sjlxbrecun22dbiwwuxnhahn6cdhg@7swcvpcc2syb>
References: <20260126162444.4194293-1-mengshi.wu@oss.qualcomm.com>
 <20260126162444.4194293-3-mengshi.wu@oss.qualcomm.com>
 <kej5u2hjxjtfdzmgtebns3amz7gmb5d2nciy45jsyglkprgh6s@kt6fodrc3oll>
 <7b9fec28-2272-4ff7-9575-76e72cecada5@oss.qualcomm.com>
 <l2ib5kalse4nop6e6ak5xronejxusnprl4qgz2wxvdw7wpzw6e@aa6fn35id4we>
 <ca86ca83-1951-433a-9903-a95dd4be23b0@oss.qualcomm.com>
 <cx3yjz2nrwe6iwqorx537qzoz4qc3yefpln5ed7z3ocgeqlwq3@arj7auyyfutl>
 <800555e0-47ca-4d2f-8193-aeef76cdfcec@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <800555e0-47ca-4d2f-8193-aeef76cdfcec@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: qgtWCqMyhH4Vw1ncWQ_y804LUOArj3CO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDAxNyBTYWx0ZWRfXzWGuViNl4Kcn
 Vobh94ZDV/8DXuE4e1jS06Ew4t3vkAhF9mG8mURJEtCLgMoYLz8WIR94Rvhz6G/Bmxpu1yWkmj7
 Un8Yld3Ej6mcc9ZfHfX5J2INr5H7Xe9PiFiBe+PD2fvc1UwRQYx5veBrbehG5iafxpDUjEeEd4k
 pbW+sm27YzH/BoABfi8EDBK2F9eoTO/2/vI8SjVnkcwycBcKOsKW9R+/EioKm4G27WdY0oqHUHG
 BZ1KByFvASuETOnPkrrJ3qYEZ9QttN+viAuPh//hrWdptkwc0UxAbpJ0+COvGtws6vjWVXwi2EL
 4FMXxcr8hC8Q03v3xwneTiJJkRqxQfFCPBmQACw4Jee6SrHQQUAjOB2MiIyc9905xZIf9dK/fRr
 V1mYmUaDNwPwGcyGZjK67Lk1Nyxeg1+hkRwFiRroAqFpqhalLK4dX/pMsb7iSw+F2BjBt5Gow7E
 wAaLQZ+YkbfPskkGNXg==
X-Authority-Analysis: v=2.4 cv=BKy+bVQG c=1 sm=1 tr=0 ts=6982b2a3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=zKM82OUwgC45EebPwgwA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: qgtWCqMyhH4Vw1ncWQ_y804LUOArj3CO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602040017

On Mon, Feb 02, 2026 at 10:33:53AM +0800, Mengshi Wu wrote:
> Hi,
> 
> On 1/30/2026 10:31 AM, Dmitry Baryshkov wrote:
> > On Wed, Jan 28, 2026 at 11:17:49AM +0800, Mengshi Wu wrote:
> >> Hi, 
> >>
> >> On 1/27/2026 11:06 PM, Dmitry Baryshkov wrote:
> >>> On Tue, Jan 27, 2026 at 10:32:58AM +0800, Mengshi Wu wrote:
> >>>>
> >>>>
> >>>> On 1/27/2026 1:51 AM, Dmitry Baryshkov wrote:
> >>>>> On Tue, Jan 27, 2026 at 12:24:44AM +0800, Mengshi Wu wrote:
> >>>>>> Add QCA_CAP_HFP_HW_OFFLOAD capability flag to WCN6855 device
> >>>>>> data structures to enable Hands-Free Profile (HFP) hardware
> >>>>>> offload support on these Qualcomm Bluetooth chipsets.
> >>>>>>
> >>>>>> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
> >>>>>> ---
> >>>>>>  drivers/bluetooth/hci_qca.c | 3 ++-
> >>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>
> >>>>> Any other chips which would benefit from this flag? If you are setting
> >>>>> it for WCN6855, I'd assume that it also applies to WCN7850. Should it be
> >>>>> set for WCN6750?
> >>>>>
> >>>>
> >>>> Thanks for the reminder. This should also apply to WCN7850. WCN6750 is not
> >>>> considered at this time.
> >>>
> >>> What does it mean? It either supports HFP ofload, or not. Does it?
> >>>
> >>
> >> We have not yet enabled the WCN6750 hardware offload feature from the
> >> software side. Other chips will support this feature subsequently. If
> >> I add the flag too early, it may be kind of misleading since the feature
> >> is not really ready yet.
> > 
> > By the software side do you mean BT firmware or something else?
> > 
> Yes, firmware. And we will update firmware later to support this feature.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
