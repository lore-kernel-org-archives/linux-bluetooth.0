Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623453E1CEB
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250658; cv=none; b=g4TR89olXJ/BSpU53xd14l8fbfWnGILeFy+Qf8oMwD8FVDjm+A9VjvvS60Sf3PHYs3fjMUoIN/UOQ25TDj4nCUs7SURK+g6+JXpOPCI0hCgLrPeujIxTyCG/CJZc7QjOh5wdi8qnIm0P3F10Vo0u1qEpUEYMNAQ626NjiDYTSO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250658; c=relaxed/simple;
	bh=XtBD7I/wcbfYFMlmpNh0CZUl/vymWdbw1dvgjEpRpE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFksM/p9TugLWorJmm7KuViB3KYeNUZJescgxmPJ60C6GF81PfZhWOokgnv/FE/qo59i/tOBC+tw2o8iauPiD/jzEXBz3/8RzMWgLVwdNR/OMwSJ0zMO9LDygrMVOpNKmJFJg2K1L+HIRqM3FmAsTzfZsiJFo+EcCXkw2yWiE4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I5SEIU8T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b/fD+se7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I5SEIU8T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b/fD+se7"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C3BnMZ2451184
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 07:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zFFhwvPhE9ToJAkALCoRS5tzqSMrukK5siAZ9HiB+88=; b=I5SEIU8T6owUNrWo
	7lurTImZJii/gc5Mf0jzvxW7UqhsFA5cVrnBaqFBPSjaY06gqzKZTB+4SdfruYUC
	kMYRJEE3l52lRmxqI+W3GSv5/WouxM3m1tAt5AM+nxQXr5i0zBRHk3Jtkp2v9RYV
	Yscf3ql3ztSfnVNMFMLjEtU/wfTrGL2L7DZstLvXHQdNyMbzbvEYHyU09ZBiit8C
	B8HIjZjsKXjLkJN82bcUSfA2Ebu32GssC2VGL3oepHtcMH70SmyWRs5VJbLr4/WQ
	BoayNG+aQYgmnPJlmquSgnd7HWQ/vzksBMqZcUaqZw5vYpv0TIKZ7laa0ne5UkSY
	GiEFuw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1xcjd5a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 07:50:49 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-963b744b61cso653795241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 00:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781250649; x=1781855449; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zFFhwvPhE9ToJAkALCoRS5tzqSMrukK5siAZ9HiB+88=;
        b=b/fD+se7Furt1IGKi47J9FXtXkcYT1hzxe+1xtiODsTad9jB+6NZCeTer2UT9CRjdV
         ymWcbuFwpih/OyywB1SX22PSM+IJozgNO43zEjPT+NwV/5eIB0EW+z4WtpUcldrxfyFN
         mNyvsDeo4ua0uCOTqgSFM2dXlU71flYbdoMBT1vFSAVLp4LCCGqMWu0uS5oOugJW2yd6
         RuLrSWqI/cQk2QDeX/0llUkP4OC65grntKgR5kkHPzZHXvWQ/WXgH91y2a3UOT0qYQuW
         xa5u67gGOBAOs1JwgQaLGvy6/E5EgoPx8D7UioESfylwF84ytmcO+YFaOhAvJP2mVWnN
         Q1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781250649; x=1781855449;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFFhwvPhE9ToJAkALCoRS5tzqSMrukK5siAZ9HiB+88=;
        b=Ml/zK48yWv9T6zUrougLZ5DbfBLErRK2bPHPjMDi4cCPz3eaK5aQxYlXiWTON0F1Yr
         05cONDaSsz/iOruon3xo6dPp3nAV0MU5fAVFyypXcOzoQCLCam/y3pGvLHSlO5SmL7G/
         XBhARMX0enUcvCfFJLcDjhP1/CqihJDA5XqQgPiOoueUco1O8loCXaKA9fnckmPtsdSr
         kMjHs5KyTxTfqX7a7rXvukfoaGG6qgQVYFD3WSaN16W1gwHJlhMCRKyz/g6kCI47gJEV
         8ukLaj7+S13r5jd99Gt8OFTFf6gc4ue9WHs5LoYleIJmNGIOIpjAEzouNdy4ttsq14Rb
         V7Rw==
X-Forwarded-Encrypted: i=1; AFNElJ83h6QUlhV1JOOTSkxNZH0jVyw9eZ4i+fgtN4itmxT7jfYSEjp74nMUfa6B4pMmthg2ULJOMFFe6VKDbZKlJ9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe3nopEcTZ9oZe8r+m4WYUz8PANWkcvvEGlnqP4Af1QtHU0Cl3
	mPs96PZu9/aq0R9fFYtmP0XwyonfZpNFOO4af/WeV/Hb06yYhNc2PCMlJyp6/SV2yxu9KPJEXya
	FUrwe02SRM1fzeiWsBuvHjuh3MA3YUqWjLRROj2j5vjj3YScTPTpYphJiwj2ctRQGtnEZ0YI=
X-Gm-Gg: Acq92OEpjvSv1RaPR7ZWuUg4pIwYLa3vmotF24LSMviJKwUt/fr5ezru3O7KHgnr+vb
	Kfpt89+fit/aACvsaCzgPbMiNW3Tihb9K4ldJlfHPw79fvJ2MAy4+5h8eYTXX1BSwADE6/FINWq
	teB4ifDYaudFb92JBka3wkDsuGdkKlvtMzDXYmxA/oZ81VXVjeV+uQ9I8fhxabtkkZqz2a14Y+V
	eYhxhVONxKIPWVVILYQ/UM1Y1ER1cTQXyPnWXaBzPXVKp1gnRGLwV7Q0gtLmG3MvBbtOekrIsbD
	Jv4skOpgnB0P/WYu8R1jGjHEItShuK6eUtHzgPErjxj8P4Mnc+3o4rC3sLNsu747hXa1SloiaWv
	xjpOHqtkudYXazb+uh7irPTernbFI7ttvmOQfIiKHTaLkwod3EfSiS4YNosboigzS11+0pukuX5
	yJr7uXVJuOFWNQaPLtniyEEdFE4R/r2JWEEDg=
X-Received: by 2002:a05:6102:5e88:b0:631:4580:6a46 with SMTP id ada2fe7eead31-71e88c4f8c1mr731849137.17.1781250648996;
        Fri, 12 Jun 2026 00:50:48 -0700 (PDT)
X-Received: by 2002:a05:6102:5e88:b0:631:4580:6a46 with SMTP id ada2fe7eead31-71e88c4f8c1mr731821137.17.1781250648555;
        Fri, 12 Jun 2026 00:50:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39929c6c9f7sm3928361fa.18.2026.06.12.00.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:50:47 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:50:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas.schier@linux.dev>,
        Hans de Goede <hansg@kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        "Derek J . Clark" <derekjohn.clark@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v6 6/9] dt-bindings: connector: m2: Add M.2 1620 LGA
 soldered down connector
Message-ID: <ttik5qwtbdqgtuu2hsnqsuok75ofs5itlnkzevawazw7lckuem@l5ogmc4b4u42>
References: <CAL_JsqJXrHCJt770bJkMmAUhirSF3kHjYwSzkG7cXp7-eys8Rg@mail.gmail.com>
 <6aef3xxjjd4nbgrfx6jc6jt6rpqmttoui6hil5zqgdpas2j6gj@ie6j72orenou>
 <fsvmmgoe5wslmxebhrrwmdg2ldcmhzvj53gjkdfnfg2m2rz2lw@dcfboaakz7ae>
 <bguhzabwryayyqkv4ilzwr3ixwv6bzxncblo3ircz2wm3fs52k@66zvcrfcb4oe>
 <blhm4csjyw6r667cleljgzd6rpwagttjo5rau7wjrlnjakq2qm@ekyhc4jvwmwf>
 <m44mupdmg7kgco62n4evcviagqo7wwgyt3gybugbxwesd4ekjz@o24r6v4tpezc>
 <3faffec9-dc9d-4eec-a652-a84d30d85c96@app.fastmail.com>
 <cvqdbqnzjmzoowxkvz2lyv4avropu5jw7h2r6zng3ecf245hgg@fsysjqflqd35>
 <acv2f1qbqu4PlSL1@linaro.org>
 <eftahohsx3bbvmgxuciofjjcrybnsm2qc752hwyt65rb2uwaon@h32nh5fcpo7p>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eftahohsx3bbvmgxuciofjjcrybnsm2qc752hwyt65rb2uwaon@h32nh5fcpo7p>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA2OSBTYWx0ZWRfX+MmgNSeooHra
 1cB3e6f3kIoHyjAnGLpYYyK8kYM0TzUMk0K5NoHaZ8QRe5aolVrMjAkeeM0fiz9Z6pzY0AcvHE0
 FP6ysiQl4uNLhbRsOLrOeJKjiRqpWdexT/kMVcDEWu+xoEObTS3jA6yd14UpsULBNH8lqzhGB6c
 GX9gwWFAYJmyjrIgZkEx4/+JoQ0RbBG3i5QnyD79HY3sh7ZSWqIg2Jur9CsLIemRVBS5ypyzFTy
 yNdRjc0b+X9FmNGURhO21E8bNlL0pH/vI919dnxRBCgV36eVsUmRXuq6r2/4M0jXUHsVOSDCu0V
 pGAQjUngErJrvjHo83CXjBxg4vifP1aNUfZOBOOOPQOAWZz333tRT5vBKgxcaYrzLslfxKN87J7
 MEl6Qi/jWoDmYyxz5mSxLKmKi9PS9AyBOABDac+O6m+ac04sD54OeQuH12qWOOR0GI3wW49JnaQ
 Db5JK2CRxIw87QcNWxA==
X-Proofpoint-GUID: se35W_GBhT25M9tr1r011nLhbRzg1weN
X-Proofpoint-ORIG-GUID: se35W_GBhT25M9tr1r011nLhbRzg1weN
X-Authority-Analysis: v=2.4 cv=NZPWEWD4 c=1 sm=1 tr=0 ts=6a2bba59 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=GUbesZiWAAAA:8
 a=VwQbUJbxAAAA:8 a=XDz2VUyccH_bepKxGScA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22 a=-cUrBSrepuC47jtK_ZRV:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA2OSBTYWx0ZWRfXxqEQvVYhH7Je
 DzyIv0z5x5YkgoMR7CP3cxlpJ9MqC/H236Ntkm7QDmKAkvD7MlWv7tz1USJoMUPVXge8c6m+W+e
 zSbohn8O6OXtL3JDTWzvRiagxvgX1W4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120069

On Wed, Jun 10, 2026 at 06:44:59PM +0200, Manivannan Sadhasivam wrote:
> On Tue, Mar 31, 2026 at 06:29:51PM +0200, Stephan Gerhold wrote:
> > On Wed, Mar 25, 2026 at 05:36:08PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Mar 23, 2026 at 01:23:07PM -0400, Mark Pearson wrote:
> > > > On Mon, Mar 23, 2026, at 12:52 PM, Manivannan Sadhasivam wrote:
> > > > > On Mon, Mar 23, 2026 at 06:45:15PM +0200, Dmitry Baryshkov wrote:
> > > > >> On Mon, Mar 23, 2026 at 09:26:04PM +0530, Manivannan Sadhasivam wrote:
> > > > >> > On Mon, Mar 23, 2026 at 05:14:30PM +0200, Dmitry Baryshkov wrote:
> > > > >> > > On Mon, Mar 23, 2026 at 07:14:25PM +0530, Manivannan Sadhasivam wrote:
> > > > >> > > > On Mon, Mar 23, 2026 at 08:39:55AM -0500, Rob Herring wrote:
> > > > >> > > > > On Mon, Mar 23, 2026 at 7:16 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > > >> > > > > >
> > > > >> > > > > > On Sun, Mar 22, 2026 at 06:37:13PM -0500, Rob Herring wrote:
> > > > >> > > > > > > On Tue, Mar 17, 2026 at 09:59:56AM +0530, Manivannan Sadhasivam wrote:
> > > > >> > > > > > > > Lenovo Thinkpad T14s is found to have a soldered down version of M.2 1620
> > > > >> > > > > > > > LGA connector. Though, there is no 1620 LGA form factor defined in the M.2
> > > > >> > > > > > > > spec, it looks very similar to the M.2 Key E connector. So add the
> > > > >> > > > > > > > "pcie-m2-1620-lga-connector" compatible with "pcie-m2-e-connector" fallback
> > > > >> > > > > > > > to reuse the Key E binding.
> > > > >> > > > > > >
> > > > >> > > > > > > What is LGA?
> > > > >> > > > > > >
> > > > >> > > > > >
> > > > >> > > > > > Land Grid Array
> > > > >> > > > > >
> > > > >> > > > > > > If not in the spec, is it really something generic?
> > > > >> > > > > > >
> > > > >> > > > > >
> > > > >> > > > > > Good question. Yes and No! LGA is not something that Lenovo only uses. Other
> > > > >> > > > > > vendors may also use this form factor. PCIe connectors are full of innovation as
> > > > >> > > > > > the spec gives room for hardware designers to be as innovative as possible to
> > > > >> > > > > > save the BOM cost.
> > > > >> > > > > 
> > > > >> > > > > innovation == incompatible changes
> > > > >> > > > > 
> > > > >> > > > 
> > > > >> > > > Yes, I was trying to sound nice :)
> > > > >> > > > 
> > > > >> > > > > > This is why I do not want to make it Lenovo specific. But if you prefer that, I
> > > > >> > > > > > can name it as "lenovo,pcie-m2-1620-lga-connector".
> > > > >> > > > > 
> > > > >> > > > > Depends if you think that s/w needs to know the differences. Hard to
> > > > >> > > > > say with a sample size of 1.
> > > > >> > > > > 
> > > > >> > > > 
> > > > >> > > > Sure. Will add the 'lenovo' prefix then.
> > > > >> > > 
> > > > >> > > Is it really Lenovo? Or is it some other module vendor, whose LGAs are
> > > > >> > > being used by Lenovo?
> > > > >> > > 
> > > > >> > > I remember that DB820c also used some kind of a module for the WiFi card
> > > > >> > > (which might be M.2 compatible or might not, I can't find exact docs at
> > > > >> > > this point).
> > > > >> > > 
> > > > >> > 
> > > > >> > I don't know. These kind of designs might be reused by several vendors. But
> > > > >> > considering that we should not make it generic, I'd go with Lenovo as that's
> > > > >> > the only vendor we know as of now.
> > > > >> 
> > > > >> ... and later we learn that other vendors use the same idea /pinout,
> > > > >> then nothing stops us from still telling that it's a
> > > > >> "lenovo,pcie-m2-something-lga". 
> > > > >> 
> > > > >
> > > > > How do you possibly know whether a single vendor has introduced this form factor
> > > > > or reused by multiple ones? Atleast, I don't have access to such a source to
> > > > > confirm.
> > > > >
> > > > I've not really been following this thread/patchset in detail; but want me to try and check with the T14s platform team if this device is specifically made for us (Lenovo) or not?
> > > > I doubt it is - we just don't do that usually, but I can go and ask the question if it will help resolve this (with the caveat that it could hold up the review for a bit and I may not be able to get a straight answer)
> > > > 
> > > 
> > > I can drop this specific patch in the meantime.
> > > 
> > > > My vote (for what little it's worth) would be to make it non-Lenovo specific. Then when the same part causes issues on another vendors platform I won't get asked questions about why Lenovo is breaking <other vendor> :)
> > > > 
> > > 
> > > Even if Lenovo prefix is used, it won't break other vendors. Just that we will
> > > end up adding more compatibles.
> > > 
> > > Anyhow, I'll wait for your reply and drop this patch for next revision.
> > > 
> > 
> > If you need a vendor prefix, I think "qcom," would be more appropriate
> > than Lenovo. This form factor is used by most vendors for recent
> > soldered Qualcomm-based wireless cards, not just Lenovo:
> > 
> >  - Dell XPS 13 9345 has exactly the same soldered M.2 card, I assume
> >    there are several other vendors as well.
> > 
> >  - https://www.sparklan.com/product/wnsq-290be/ is a third-party
> >    (Qualcomm-based) M.2 LGA 1620 card, in the block diagram the
> >    pinout is called "QM.2 1620 LGA 168pin".
> > 
> >  - If you press F9 while booting the ThinkPad T14s, you should get to a
> >    screen with "Regulatory Information". For the T14s, this screen says
> >    "Contains FCC ID: J9C-QCNCM825". This is the WiFi/BT module in the
> >    soldered form factor. If you look that up on the FCC website, the
> >    applicant for this module is "Qualcomm Technologies, Inc.". This
> >    seems to be some kind of "modular certification" that vendors can
> >    reuse/adapt without going through the whole process again.
> > 
> > Perhaps you should ask around inside Qualcomm? :-)
> > 
> 
> Sorry for getting back after this long. I did ask around, but our HW folks are
> saying that Qcom is not the first one to use LGA M.2 modules. They claim that
> other vendors also do that.

I think, the idea was that there is no single standard for LGA modules
(please correct me if I'm wrong, I haven't checked the latest PCIe
standards).

> 
> But for this specific card, it should be fine to use the 'qcom' prefix as
> apparently the module was supplied by Qcom.
> 
> I'll submit the bindings patch together with DTS change for T14s.
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
With best wishes
Dmitry
