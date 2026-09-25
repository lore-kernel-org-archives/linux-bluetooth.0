Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12DD481FAA
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343551; cv=pass; b=U4EBeRT+0aWfgVUh/TMn5ai4lLXtz1km7NRY5VHlXZDijyR3tHshanm/D6suEvXfENN6uSdehHIDRiolckvPa/2J06ecGtuRZMeEd7qSsXbh9Mka2sBeOTVJBHV/R6En6yqMQ0XQsEwXfdOymJpofCXNymAhKiDDKTcsEdpCBRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343551; c=relaxed/simple;
	bh=kqdNlwg778/987rRPFcemtjB5R0/alDQShoyszIUXi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZxoQFvZFFEa6hgQDmI51SHQhkVyt9ONzRjqH9FMAehvJsKl9YQiLJMQZOkEKdOytO7gfTlDtUPNLH72dRal5sxn54XzxERxAwJrQT8YTQM8pJJkEbi3Hdvla7lu4H8Y0sfav1lTz9THGj80ArHSnopINKSbIReLPvOVL3X3UAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CiFirrNM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OjLnN41T; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CiFirrNM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OjLnN41T"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P5JPWp3628311
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 13:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kDqgsZ4XGZtl4jjOzkJ5PS9aFgMs5r1UIrTA9EsegCY=; b=CiFirrNMJE46vkez
	ab/ALVoKzVYq3KdM+wurlRbp1B6pozl0+xZlajKqHYhciUozzuBY7HlW4B9bEgeq
	01aTayxTFbLZjXcK2kUyA4C5CGDxayVgrjT12DPiulgqZp8+24MXVbQFUBKalGN5
	p9GwIgBIhMFeCrnL/r+4yFxTmyyyZcUvwHKtmgVueHEfPC1dTHXv2IcCvaA5pY9E
	bXsatblJpbCU9xw3/A1vAwABdtqMVYDxHNRpOtBokCQv+9P5D3KSurkRHYF8jsvl
	7RxWADkv+Ho9B8J+D3C4m7HNizpmI3Gz6NL7dRH63YIWrYea4jFZFF+zLX2j8bQ9
	XChfMQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq39j43-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 13:39:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-530d206e2b4so19391831cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 06:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790343548; cv=none;
        d=google.com; s=arc-20260327;
        b=ZQ1DqcCKVHtXnQuGQl+IXM4Fyy8MbVuFAbjIwKbjC7Y0jKD7Mt1Cibu6Tx88lYC+E1
         h1sFfBI7tQfTkFltQ1YjgGhdXjSDD71sR6TU/mEjsPoJZ3Ws8vG+O2evtsGw1DVCiwHo
         PnLr2e4oVEfWFiOcsmGtmqP8Gh5YjqbwvQwnBo5ws0PItS4skFDFx/7AJS2J2Qw47B0z
         ElJ1yFN5V+NnWhTAejw7BcSDJbZ6F0tYM6OmX8qa1DUx4ZsCGNm/4R6xLNrTXrnUZcqe
         gTd30TkXi9cZsVGwGbU2lMv+p61ttNR5uoC5JQQDExIuTUBQ+cPOhUKP0S95vI1eCTiN
         BWog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kDqgsZ4XGZtl4jjOzkJ5PS9aFgMs5r1UIrTA9EsegCY=;
        fh=qCTzLkCwi1CYxLa9wfD1EEAvQlH6UTNiCeQW/erkZXI=;
        b=N3CJAjuQHVH4cOa/RvsKX2X1caIMy7UNuKxcj7tkweoxxhX9EPsyhFUKi02biTXxXE
         na8HkRV/fK1ipXIiSXkT8+tn13Kc5QHm3btKx0H2Z++xpb7NBUlXw3lXDxaqhiivbrUf
         oVV1fotDTcAF3YdgM/DSUacq2kryNLOzwpm+SuvSYFXAhy7A5k0jpb97YQj75qQionk+
         +6K4gyZJWPjYSZ//QEWv7i/YpqkEupdgJC1G+Kv+QUBjLMNlHd1XgtmV0tPLZxW5r5rG
         f4sgvU/EA96pHqQaNoPpDYp3HgZBhYVwbhSPcpbN+IVI2PFZpEBV9YcmwSUXLZS3yPoe
         nUvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790343548; x=1790948348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kDqgsZ4XGZtl4jjOzkJ5PS9aFgMs5r1UIrTA9EsegCY=;
        b=OjLnN41TvHXUGa7MBrf9fj+CrpaWlDp6jgP20kUZ79RYwBnqHsD2K/ZHsBfxJr0C6X
         5bLg4kK6XWXCGlWpS4+g8GmhWc5sivFMkZ6UPcPR0PfTiZKGAXGfrZJAn1JrUrO9v3pL
         +o/3NTphHMc1pEr1w9tuiniwaSWa84DJXKLHsZJBOqqauXJKVeciIGSFjrUGEe+xevFE
         0tu5GV/o/wBP/LDnwxL4ckGIva0g4Fy9erhgynszry1UC2kIN6hUmqZne6dnMQMW7GsT
         RLoI9Iw1mSzZIhFcCnl5EDBJRUTgLvqYhyFIIEVyfYO8DPzOfGwQ8Vznq6kgHkRZsrq9
         XTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790343548; x=1790948348;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kDqgsZ4XGZtl4jjOzkJ5PS9aFgMs5r1UIrTA9EsegCY=;
        b=EzOraPzR8zImNCD9Er0QcwtidHnv06cO+8AB9n/+n9q0kPcWGdMvyKE4+hu1Ma+BJ0
         kUK9XLFHpP9e80V4R9pXFG0L++0CIXdWT/Tevvu7yD28flly3HhQxZ0WlSPqsOLAiDeD
         tdBJfIO4dU+0tJD/VxHTSzC2ArrcBcuL61SiP94pmbUJE2uXlrUQO8YkVgz/kdaJ/Ll1
         KYcNs4yrxFpzAVYRyfVeCz70KhVfeVZn54kqJV7TmsynSpdPv9eJsDLYvfgRaCrWreaz
         YzhcayCzxRyNcqS8W0xMai9JbpnSlkH9cF1E6aXKHaqpwtVV4dPDnzQf2x7ZsDtbkbBH
         obzQ==
X-Forwarded-Encrypted: i=1; AKwUvBwv6HysCe64UwnQZ3yda5MVe3uH10U6kqx8h4JWZi3IjVtGkVwtBtUvvDgDVF9PHIb2acV4HmeRAVfXOmIfHI0=@vger.kernel.org
X-Gm-Message-State: AFuF++llvN5MzXrnqh9DI4BJKeti1zHmuTJCtdXF2N8FsCyKPAe0SczW
	SG8vyUBwP8PXGbc2uUY56FYF9HRyvuf4nxYc0XuMQOfUOnoHovslt0h2fBsfLhAB0N6fDhw1otq
	/5bwecTuhg6A54qgYOr+RCpTllvLt0Lm50sCumTQRGqeE0r75t57xSVJX+d+csnSZmT6FXWX/PF
	HHK8JNBA5FmzFSxwCdso74PjOdv06FwgFooyAPtMmROq2hYA==
X-Gm-Gg: AYBFou21DrHM5kXON+/irAw0KbIe08+qmKkn6tFlHusq+1oWvrZbrjtoJibLZZTQbCC
	UW5ebq4PDkLpGZvyFpHJQLEghr7jpLrbRrOlO+WuTHum5/3boAK8HDzgim33DfL4EzguGt0A5Fn
	IOR/iQuvAHaPJnX3Vv0PBCj3pKR6IXeP51NuJuJgyTgUW0hn24290HxWXJfsNRTZB35DFoZXCKu
	ixnSERdyx9Vn5S7LhYV43LFt6pW9GfIBmEY2PncPO7W2J02oroJNpIe0BGolW19llUpbYDKG4k=
X-Received: by 2002:a05:620a:4588:b0:93b:fbf0:8791 with SMTP id af79cd13be357-93c43bf1ff2mr431888985a.29.1790343547625;
        Fri, 25 Sep 2026 06:39:07 -0700 (PDT)
X-Received: by 2002:a05:620a:4588:b0:93b:fbf0:8791 with SMTP id
 af79cd13be357-93c43bf1ff2mr431882585a.29.1790343547133; Fri, 25 Sep 2026
 06:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com> <178998281449.889291.7893229102394463283.b4-ty@kernel.org>
In-Reply-To: <178998281449.889291.7893229102394463283.b4-ty@kernel.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 15:38:56 +0200
X-Gm-Features: AclHuK99T0Ubawi22EyQadvbidnQEmVlySi-fMkWCvta4a9Udx0OX1G_I0L1lvQ
Message-ID: <CAFEp6-2P14MdYJGuH6ygRL4ZKtLnJEj=PVMx2p+b9L1RuiX1dg@mail.gmail.com>
Subject: Re: (subset) [PATCH v10 00/10] Support for block device NVMEM providers
To: Jens Axboe <axboe@kernel.dk>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
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
        Christoph Hellwig <hch@lst.de>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfXz+wMyxzhx8Pv
 ZGzXfCiiHucTnNSG9Ds+F3Tykz843y4HFz/HpiAL9VDrwQGIWT+H+k5MHIMgikqX0+byOyxbnJr
 VOtlaQWTnqTGL2xxSSffnJIIaN7KHIM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfXy5mDYjQ9qb/H
 whtwM4URr8qkbgjjCiRTWAtgKBbZNJBchZRl2Nu9fhhTmB+TkixXvL5RsQyRPupJgZJPqLHkxMv
 WyXUjhM2Psz++0Ldn69rd/lqkJ/jOgS9sY3fB8YmsfRsFxZwyNn+NzCid/S73uzuc9QaDM87Mp2
 ry/MkjfcM2TNVDMohLUgIVUR6fUigG3mIfseguzfHjwf0Gl7AkhvV58jqV5EpSfh/GusJgaoi16
 rgmLNqZ8GLUI8g9OFv6fugtO8EBJUecj/OOYRbZGgKPwC3JUnrMcqIrnIL8+sB2q9ybkz7NJ33b
 9kD4RRTHMWfSSGbfunUr49NsbtwgRLo20BrCBGjqECDoez6z7qBmWwdddy02ymk5hAuo+qBF8xq
 rOieeVhHW4E3m+MBndpwaYl67SkYf4Qqz8Lz4BsdneMSQqlDAiPuEH0cDiGbpQWL+YmjDucvbNG
 ndjtjuUjQ/O0/cs9+MQ==
X-Authority-Analysis: v=2.4 cv=VuO2kO2n c=1 sm=1 tr=0 ts=6ab6797c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=MW6_J8xfeE2cRKj6bkYA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: Y6hErwtD6Xds_2rpf8GEgaV8TSPsj3SU
X-Proofpoint-ORIG-GUID: Y6hErwtD6Xds_2rpf8GEgaV8TSPsj3SU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250054

Hi Jens, Luiz,

On Mon, Sep 21, 2026 at 11:27=E2=80=AFAM Srinivas Kandagatla <srini@kernel.=
org> wrote:
>
>
> On Thu, 06 Aug 2026 16:38:33 +0200, Loic Poulain wrote:
> > On embedded devices, it is common for factory provisioning to store
> > device-specific information, such as Ethernet or WiFi MAC addresses,
> > in a dedicated area of an eMMC partition. This avoids the need for
> > and additional EEPROM/OTP and leverages the persistence of eMMC.
> >
> > One example is the Arduino UNO-Q, where the WiFi MAC address and the
> > Bluetooth Device address are stored in the eMMC Boot1 partition.
> >
> > [...]
>
> Applied, thanks!
>
> [04/10] nvmem: layouts: Support fixed-layout as the nvmem device node its=
elf
>         commit: 9c6cab93dcd47c3075d896c777567b9d8f813d18

If you're happy with the current state, would you mind picking up the
block-related and Bluetooth-related patches in the respective trees?
They are independent.

Thanks,
Loic
