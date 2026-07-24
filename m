Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE24E34D915
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907347; cv=pass; b=NRV1PVHRcWy1R6ZfviX9p+gpAjl5UygNHbJ1/CSIxJwL90tnbm5cBuQabHoAThB0Xkwiv70lGJYODYc6qVPcY2h32gBFpsP2y+l0x9jyApRceYOAGZSIVVHovp+kHZ37jsWudZWEs+zfT7A/p5z4hqomFytFU2hgJfL1INWHF18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907347; c=relaxed/simple;
	bh=0AxRvCjS4SeGauYtGrq3Gxj0CFvSuzE9MU+SB8VxZqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWSPFlIUZ5DKkFsvjEmeUr78E7PiAWuxb328gZe11qtYg/8KSeo8uE1cDopbkhFHL8rXN4NZu0JUVsjE3Imv6Z/pQTpAwMgNF7jDBqBGXGGEGqUmCPzxYJ9XMcoNPBcJoUnaVmXndHHi0mJvT5No8slvCql1wIzN/8IHVEBlK9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U0UZBLpm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mh26x3LK; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U0UZBLpm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mh26x3LK"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OEHU3x3467953
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 15:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0AxRvCjS4SeGauYtGrq3Gxj0CFvSuzE9MU+SB8VxZqM=; b=U0UZBLpmLfPDvk4s
	5VVXy1GRsf9VjasKo9AZa15zarTyGa1QjJqnsNNIcbBeIhq1YHNQb+NLdvyNnDBN
	7R2Qp6iSbQ65AuK6J6JrFFQ1KCQdPr2+h/xLiVb0Y/MG478NDq04DnEdkLa8RE0C
	q+9xAuEvlxgPwplct6yAF7BlP/BSC51W0qX4xC1wqPCC2kNiVj4k938GrWe9if+u
	71b3BDT2ouTx0lPbmDcd2jAvWSKlChEuLO3YlNrfAItJPh+7d33op3mu57wYkF5k
	m5xvoz86F6mTz6U79nCSLiaxF3eZb68e4/ZCxZPnHU/bjNLEQ39PFmoJr1mgXWyD
	Gn0Tzg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm9pd09f1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 15:35:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c26012cd0so7547681cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 08:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784907344; cv=none;
        d=google.com; s=arc-20260327;
        b=OO7A7gOXsYni6d3xiARa5rJWSy/Y2YCx0ski4ENb58diuxOL1oAWShjl0KllCc01Lo
         f0XiZSIFkFDuq7picjLDyS+NCVDNrDsXFhzlt0svvggZN36HKrlN9+xDEbBwQkImPWjH
         IiKka1Tb1QLQbT/nh50JVk8TOzG+1I3kOJKyGL7akHj6p7qV/LPVNFNyjsB+uPB4jMGm
         feGe5JYceFGc8IxTQETK/FmKLMb43fYOFfE6/4Jvuu1HHo5H5+pD4ZIc8R8eS4N1MSMn
         sSm51LWG5MjG180HSZWE+8tV8OBQ0mFhf7Sogqkb49P7fiNVh8jwMz7H9pXCrxijETr5
         sLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0AxRvCjS4SeGauYtGrq3Gxj0CFvSuzE9MU+SB8VxZqM=;
        fh=TPP+Oai0h1z1CPxMinHYLuoHzWWK191WbWMWEtFGF68=;
        b=XRD85x7PijZajOhEHXIVZbKVs06rIIMidsZpgv1dGgsdq4W0RSiJfM6XmQrQvybd0d
         yr7Lxr1NdRx4IsDV5KWhSxfrRoBvS7ewgad58HJkNqbu1pI7HiR37k01/yr6/Xc6mvzs
         U6J7HZDAopmOk4FOZNfJk1ohq3IA+ikMacRoWTi+a1pw2HdoWAvLgW6Hnz5aceh33XMV
         2v7b6tnfn3nQLe6AeQGylVB9AlqchM4/N44ZdF4EYZ7lMD7ylBWA+4DGsqQHe70IMP9/
         2Tga69mWKsVzHXfl4H1okgzYn+SfNkk+vO1drDMmpkQGB25+NwzmUj8FVXK5z3G9WNcj
         qvdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784907343; x=1785512143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0AxRvCjS4SeGauYtGrq3Gxj0CFvSuzE9MU+SB8VxZqM=;
        b=Mh26x3LKlUfjMyUTMsdPzBsSIeHZkdI+mvNO7yint5/pGl5OhGKGzyUhVm4cwzUhP8
         ByS+yjWITK1i3sYzP0P77bSL6q6Vr0M5GLkpA6K0FB9VXq6660zEBGCsjMZi0ZgKaEyF
         gWvk4HYyBCw9GSwJVBa1EQB6KJxkUcxFZamUuH2IRWXAtfdcL3SuFVwWMh4tx4OXMZH3
         Md7ZkQvgwbnuaG1kyvFOiB3SRvHuQi7whrPblAn6CuEp9/NRGs4eky9fg0R783/J79sN
         1mnUAWmrAxBie3kHUD9RnHxWTycPzad+sEga7XvGUy95zriVZo/XQBC03Ya41b3iKMIZ
         Hqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784907343; x=1785512143;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0AxRvCjS4SeGauYtGrq3Gxj0CFvSuzE9MU+SB8VxZqM=;
        b=nGKnv2J2Z2r4JSbN4DvXBqPB3QKz5dHze5DScWYOrq0KVImj7FBhJ7V8o7pRVsaZqu
         AYJ6GfbhGw/lTcUwis5hzs/SN1nfNq49meBTfZg6nHrQGGiz6SdGte56rEafc76LbU0Z
         EEi/qXgPaBxyrKDn2iOg36LrMlOPytSXDfPUSkrTt2gHI3eBSzMYp/AvtxavieeSpoJd
         FvGG1kH7cPEoAOw/gO6GKWQ9HFGGRcc/4DyS6DwDYRFNsSfz75yUosklgsvd5wX+NWxi
         IKsDP48vp/MiplxbSe/W5aEkQF/oztLNxew7hO9fr3zjIIP2qQPz1IzuLaeNG8LdCb/y
         c31Q==
X-Forwarded-Encrypted: i=1; AHgh+RqVpb4utnnQ6ci3j5COgldRdJUSjc9VWn1HsJCuE22uNDjdIqYS77gxEvMXTgbKR/8oUD9vQBKaYwrnF/sen2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl4/8yP+x704vs6PwiZ2ZTwsinkCG8y603EqfJmUBy4KdYZbW7
	UgMX4cdYqaiYYE9agH0wNq/EjNs50VmEw/DS01jg2dMyCKc8JUvaz49UJcmNTA/i4vbPXRuQcML
	bBy8OVP09p5PfQFaQtBJHZXFoj948flpKRgGrJR3qu/7grGfvmA/0DPvlrOE57ZuaytH6WwcD7w
	iWJXci9TEVoVPApbHTd+t88IPXq1YbqOMwQXJqeWPIIbyxdw==
X-Gm-Gg: AR+sD13IxNRUXGEjaGzIY3jAVvzwoZF+wl735Zn31ScrAEo5WTs9O3+cf9jg8d5LyP2
	QQBB430Iqax5xxroL2VAeG+QRgj7GqvIrrd5TdFewjbS3XaLC/ojGSey7j0H9kAcXG3zCGx4I0z
	05V5ONKpm0lS0zU5dU2B6OnqhFroUNWeIgcDD1yqM09llqRonVI+beotN2uA==
X-Received: by 2002:a05:622a:228a:b0:51c:1241:3b09 with SMTP id d75a77b69052e-5283de54e1fmr76891561cf.39.1784907343631;
        Fri, 24 Jul 2026 08:35:43 -0700 (PDT)
X-Received: by 2002:a05:622a:228a:b0:51c:1241:3b09 with SMTP id
 d75a77b69052e-5283de54e1fmr76890551cf.39.1784907342860; Fri, 24 Jul 2026
 08:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com> <3d954cdd-6dde-4be6-84c9-2f2f7d008f5b@kernel.org>
In-Reply-To: <3d954cdd-6dde-4be6-84c9-2f2f7d008f5b@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 17:35:31 +0200
X-Gm-Features: AUfX_mwd1WNIZvdvXqoWeMIN9Hp4kEAy8VC-hn59NszviBxEKOIP4_juVgFnXVE
Message-ID: <CAPx+jO8-9YSJtXNfnTrUX_JiCyddXHn=wHek9=c99+fNp22Zog@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] Support for block device NVMEM providers
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 6Q_3Sg75DiYr4rIdCaGZspjtB4VS3cd4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzOSBTYWx0ZWRfX5R7GmT89x/34
 Qt/NMsCW9pGhaspMgjGS1CV9ZIHRIcnBgA6IBHaE3BiSSP9skOe0ngMg1BNBe/rhgiKe8uDs8Ja
 WmO0RHz7TeO3d1gqv9KiO5QscNtBnU18FkT2QFDUvY4EwFC09Lqt/l729zMu4sS3iMXLNaxhUI2
 0bV9wZeuWevkvw+Vmje7DQR2ouEV1q9rIV1h5q00d0tSEODz3e6ofghDaEbGIwFjhr6jZP4eecR
 Rfu05SBqcpCT5LbAJaopzaoXJmovwUT/YgY8c/cfkyiE3aQpRWCocueU7Dm+jFQb4VyyQZodiJQ
 uiBISZRuX7d8EyBBzpW8JZ+lBIv+e6V15xZYF+LGbv7cRaUZIF75eFdu/hph5p7QgduKXKVMFeq
 RjYhQbah3YWDiFNeHWab2uRn5nXxSbTBYZnBeakbRWc5DH/GBjTUu2lpEh6YUUGLulCu2Gbrta4
 oY5WRP0A2DBGa/Ww3bw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzOSBTYWx0ZWRfX9B79/yhfSywb
 YJRTdXg7nWKahOrmIn2Aifq6VutYaK6kNbkhFzxarZY/uTUJqhFUyegA/9LcuAsyh2oZmALbv98
 8RkEI/pkAfeDnmS7EPPm6yN2g0xJT9k=
X-Authority-Analysis: v=2.4 cv=DLW/JSNb c=1 sm=1 tr=0 ts=6a638650 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=VT4XjZGOAAAA:8 a=EUspDBNiAAAA:8
 a=XoVDlNqzt-XzKL8N3f0A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-ORIG-GUID: 6Q_3Sg75DiYr4rIdCaGZspjtB4VS3cd4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240139

On Wed, Jul 22, 2026 at 3:56=E2=80=AFPM Srinivas Kandagatla <srini@kernel.o=
rg> wrote:
>
>
>
> On 7/3/26 2:45 PM, Loic Poulain wrote:
> > On embedded devices, it is common for factory provisioning to store
> > device-specific information, such as Ethernet or WiFi MAC addresses,
> > in a dedicated area of an eMMC partition. This avoids the need for
> > and additional EEPROM/OTP and leverages the persistence of eMMC.
> >
> > One example is the Arduino UNO-Q, where the WiFi MAC address and the
> > Bluetooth Device address are stored in the eMMC Boot1 partition.
> >
> > Until now, accessing this information required a custom bootloader
> > to read the data and inject it into the Device Tree before handing
> > control over to the kernel. This approach is fragile and leads to
> > device-specific workarounds.
> >
> > Rather than adding a new NVMEM provider specifically to the eMMC
> > subsystem, the new support operates at the block layer, allowing any
> > block device to behave like other non-volatile memories such as EEPROM
> > or OTP.
> >
> > This series builds on earlier work by Daniel Golle that enables block
> > devices to act as NVMEM providers:
> > https://lore.kernel.org/all/6061aa4201030b9bb2f8d03ef32a564fdb786ed1.17=
09667858.git.daniel@makrotopia.org/
> >
> > It also introduces an NVMEM layout description for the Arduino UNO-Q,
> > allowing device-specific data stored in the eMMC Boot1 partition to
> > be accessed in a standard way.
> >
> > WiFi and Ethernet already support retrieving MAC addresses from NVMEM.
> > Bluetooth requires similar support, which is also addressed.
> >
> > Note that this is currently limited to MMC-backed block devices, as
> > only the MMC core associates a firmware node with the block device
> > (add_disk_fwnode). This can be easily extended in the future to
> > support additional block drivers.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>
> What is the merge strategy here, Am happy to take it via nvmem tree if
> all the non nvmem patches are acked or reviewed-by.

I am planning to pick up patch1 (dt), but waiting until all the
complete series is ready to go.

[...]

Kind regards
Uffe
