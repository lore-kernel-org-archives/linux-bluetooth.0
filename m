Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB95A33EB10
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849564; cv=pass; b=CYEpTk77V29ofp2yb07j+fKcf4Na+DTInLX2yMquk+kR8AkP0QcS7570zD5ylT9aBOC6H65A9U3BOMO8kEO1WwN8DjFWGZ9SFQOsr6BT/vIlJc6GeflitbM54INNdKc3AQ7FJF/8YOtYPBLMZUTI66/bta+Gd6mThCSfBLF5O9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849564; c=relaxed/simple;
	bh=RiKwOhz2rdMC9/aebYm1g33822i4EXTv8wYdbkHCerM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cohp+UqAbA8Ecl5DAZEIkAVoX1LEHGwe1rfDtHaCxgjnFRUxsuVeSqhkG5MgQRH35TVso/4VW2EfLtL29b1zmmWiHS+6lLGLoz0rtDVB9uUqDba7vHTNzwcwyn1o5HAtt4JgPCuAPjoxVZ88jF8/7zqfIKXBpctEfuKn9hLAbJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cdR8HRwp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XN24c5TU; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cdR8HRwp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XN24c5TU"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJDfeB2960014
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 19:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	24HwDmxkwRqteaHOqqQJzmtBl1Z3hVbm1sSUYzWXHUM=; b=cdR8HRwpOL0F5KGf
	Pa72vskx0M2kP/Z35S2cu0vrb4j+OEKIt6KMM7Th6UonX+P19BpjlUhTk5Li1d1Z
	Y/Wv59ciZPfT/RYaiQrRsZFm3fZPcDfKBwaFfoTbWjAmnFyZj3n9bpk2D9uAq+as
	Zefne9lZYGQzV3whovwFyt/TN8jYz46vzYj5NL0+/lOGbG9MlNpdo0tsMl5xk0yg
	fCV3pDFQVQuR35FiZSvIftsxLo2l1P5E5HN15BL52dlkXhgQkdoSVKvLPz9tpEoo
	i0SPA3tzquu7dDbPf2qsPBmIKC29344dcx2/YoqDcNf3SztycbPjKCqS4n+bRngs
	SWWdJg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j910my0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 19:59:22 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8ec3314f65fso76871276d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 12:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782849561; cv=none;
        d=google.com; s=arc-20260327;
        b=TNWXX7RTBZvQEVVrAkcxDXmYcdZNqkYyHPd/3yxDplHexbXGmCIPrB/7KyoOBZYOlL
         mRH3eOnFlJG5OTXEbreqD/Yz/jA23xfrGeZxiW5PNUmrt0oq+CvozAwDj8anDH4ThG7R
         KVKxJiv1LJn8ySSAePZwxMNoB1GNUKiTr4Jps3f+uAQkBm5t5SYbwEyZUWp40WHk1eSp
         HL5/JFjZGYz7fhb4sC8rK6Ny8m56KNfFQAnx2qrHpge2S3qjqgfIHGfBkktKLVZsnegu
         hbzKEuLX9Yg9QPTSKmVhGD7DxfDnLFLrAawzoyziITlOdsZaN/LPDZXEARTp3eS3S5iI
         MkBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=24HwDmxkwRqteaHOqqQJzmtBl1Z3hVbm1sSUYzWXHUM=;
        fh=bCsnazkxL6I9J61WKwNbwP73UJei9U1uYcRvZHLEfRo=;
        b=WihzItarUlRlQIQq6vS8lHw+313Q0SWRSchYL4uQmMbYPPmBJ+k76rn3hIzMueJDfy
         8kKV7jHi3ivRiF2fc4Y8Umg+0l3SXtPeu4ktmATCIrOTyFMJUZpyXcsrOyjmSxVG74rQ
         jGwTaoCQ1zaszdMhHwSJrCVyAKqW04KTQfboOuoQBjqxKJQMuSw+TbO4zhl9GF+vMdzd
         lOor5HHRDc5C0TPuMMEpdC0vy4oM3i//cdpmFQAv6khpFTVjtIbQL09VNOvmo17yo8Xd
         yDjEAUAwihDqDZM1B7VgdOGddDriOjcg35ms+dYfNNvYxzCDmc5Xcu8DlU7PehowKmwB
         HkoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782849561; x=1783454361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24HwDmxkwRqteaHOqqQJzmtBl1Z3hVbm1sSUYzWXHUM=;
        b=XN24c5TU1mLtMwwVQrpsA3cb+Ec8JVOKflkTLwTXGBmehHakzQGPaN2aEZbPFpbD97
         LJXI7Xi/LFKLihPbM/Ozc33AJiWJHQW3D1ngB20cGK4F0B+mw1KKlsWOORfLOvwYsoe+
         pmnAxjzZ9/JjnTdkln0XJbGOPCH4QQHP6a4M2/WUsRbPfukntEC+Cb5T4b5ddzPzo/1E
         Fgqd0htDz4EopwjnY4LZMQlSDeipFKR95uSEQi4bnEoxNaYVXOfOSGL1EIqOhDX1SE0p
         xMUobMZUWaIXPebd5HgAPV046c5JKpeaohJhunSH/eiRKkNKEPKNFA+8OSveeGfCXZK+
         ujaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782849561; x=1783454361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=24HwDmxkwRqteaHOqqQJzmtBl1Z3hVbm1sSUYzWXHUM=;
        b=YAMpK1ovdWt/8MWK+j4mFYsaaVbT7OjYlQURJR3KVaB18MT/lNpL0Ghc7bden/CKDX
         YK+YFlt/AKQqPZ2QDGM6mZlz51FI+D6beorft0VgEfKXvwE2rzgmioymA/+joO7piHIr
         XBlzBsrGpmF7RP4DUi26BE401s3QqqiBGgK5bQ3qX6DraBh4goFlCIsFXxOe9S3QKnU7
         29G4WCifsp7pAUxFzTQQ5N+JElYYbJTHxjzGlB3GIdx/044+7yFlmZVkujE47N7urYps
         ZtauH+tJCh06nVBsUjfV0LRJEfUtiJqJ8ML3oEn1ENhbWMNDEVcIzFdBa63hJDD+HXhr
         WdMA==
X-Forwarded-Encrypted: i=1; AHgh+RrgYpXIZ6eQpDsBP3BAJ1VQ+/GgHsiNqlgdr7UAn/5o5BsLrsevW42M2OngcxwEvUKlu5cGCEqS3LTxsV9OjY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwp0RFAVgx1+tZtKnJXzxBfGRb0MCOLL3ju9LYD8eWw0xUw/mS
	h2y4sfUbPQ6tBtURj6MAebMMlZNVW660YmPHxSON6Tww7nQA6cny7y59iZcTHSZrkYBapIbXc2a
	0JAfKHpTCf4pRX0r9ybcq3l7B/fbkhiDTRhmClO3N0X6BKM1f+n84V5LobQknlrfjYtDnqjsMwZ
	/uVXZFlX7RSBWCzS3E76DCPyWVBN/PE5RUvLKZgp0OVe8uSw==
X-Gm-Gg: AfdE7cnUDcqxMtq2cI9fDu6UgJAwJfxQyi5hCAIuuSd+LD8lT4Zk8Un+EY0CgL15C9U
	kO9ck45Vul4558kTvXWmVZ85pPumid6WAMVYl8pNXfqTAildomGZIXxklTL7OIZfExNlOT8cxSB
	dN1zLq9APx7N5gnFUPL77Y/s+vXa02YMSaIjrcQjkr3PVlDnw4YhvpNFHC0AYYNVmH/5J4TETO8
	fp+RioBEgmT1yvxn+v06afiwG1LpiuekaH2mrt3BF8VkQ9K8Xv3yVDSAK+DY0mUJF3mfaCfF0dG
	B4IC0bIksNs=
X-Received: by 2002:a05:6214:821b:10b0:8ce:e651:5d63 with SMTP id 6a1803df08f44-8f2d1343d13mr25863656d6.31.1782849561030;
        Tue, 30 Jun 2026 12:59:21 -0700 (PDT)
X-Received: by 2002:a05:6214:821b:10b0:8ce:e651:5d63 with SMTP id
 6a1803df08f44-8f2d1343d13mr25863166d6.31.1782849560532; Tue, 30 Jun 2026
 12:59:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
 <20260629-block-as-nvmem-v6-1-f02513dcd46d@oss.qualcomm.com> <20260630180219.GA4139943-robh@kernel.org>
In-Reply-To: <20260630180219.GA4139943-robh@kernel.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 21:59:09 +0200
X-Gm-Features: AVVi8CcrbqRCRkmYSZLH_ub9JNgkd2IUQmjyz1dD9_QoekOgl29FSB3CCebEUbk
Message-ID: <CAFEp6-163adAq8-H_pCzGnq+Fo4jpyKGs6Jv25j3fSpZg3COjQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] block: partitions: of: Skip child nodes without
 reg property
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
        daniel@makrotopia.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 4JWnsQur30Cw2S8fbfLYeEngTOnJydjp
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a44201a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=2sLY7anfMaDELvqluMMA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: 4JWnsQur30Cw2S8fbfLYeEngTOnJydjp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE5MyBTYWx0ZWRfX5pp4puaG36JS
 1X9hxsyqJjIJ9b+m+BI7cAAuJGt49rS/eA5zNXzuIFiIXNMZxGF4fxg26VWGZNet8T5JMRaKKhE
 su5cXlITJblglui6Pywxsd6tsxeYri5HIjaut2az2o41QbBHF3F6R1Cs9VszEmkNzHPeWKg459/
 wq+hMQqwOaD5cvg2J/FosVk0VI6ni2tHXi0N65bWWqwBCFohzTV7qDg/mm2PkQi4xSEvKMsmuqq
 Fr/R0Ne/r0I0296hHDYlL3PlFAD/O7U9mbb/coK670pmkcXEwQ4DmFb405B/85EhBWLdQeezQ5Z
 crHdhG9iSQf0DwSWEnhvFXLY+YO1Fcob6Ih8fXbecqPhqEg3Cb/qZAcqHHfTTcJZhpChjKyo5On
 agTCenq2PYb51xXNw46MaqvZqzJWe8+2YfxPEaB+yaiu6EIO2kjewmAI9ABgI4KF0Srh2UZfoPd
 H7EGAZZuvJ+h9FkoRYQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE5MyBTYWx0ZWRfXyiRQcQaTExWu
 TkaMmaEnNTdvjOiStyig5Nw517O0C1Q030ucPB32g4PbFET8uXY/+Y/Cq0x5JloYNa2gANFbBX3
 3kw9u6LwtlQ1yyvLBVcw8UAppR/Pi/w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300193

Hi Rob,

On Tue, Jun 30, 2026 at 8:02=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Mon, Jun 29, 2026 at 10:55:20AM +0200, Loic Poulain wrote:
> > Child nodes of a fixed-partitions node are not necessarily partition
> > entries, for example an nvmem-layout node has no reg property. The
> > current code passes a NULL reg pointer and uninitialized len to the
> > length check, which can result in a kernel panic or silent failure to
> > register any partitions.
>
> That does not sound right to me. A fixed-partitions node should only be
> defining partitions with address ranges. I would expect a partition node
> could be nvmem-layout, but not the whole address range. If you wanted
> the latter, then just do:
>
> partitions {
>   ...
> };
>
> nvmem-layout {
>   ...
> };

In our case, the nvmem-layout needs to be associated with a specific
eMMC hardware partition, nvmem cells can be a simple sub-range within
the global eMMC, each hardware partition (boot0, boot1, user...)
having its own address spaces.

That said, your point about not abusing fixed-partitions is valid. I
initially dropped the compatible =3D "fixed-partitions" from the
partitions-boot1 node when it only carries an nvmem-layout and no
actual partition entries, making it a plain named container node. But
it's a bit fragile if we want to support both nvmem-layout and
fixed-partitions.

Regarding your expectation of a partition node being a nvmem-layout,
do you mean that the nvmem-layout should live under a fixed-partitions
node? Something along these lines:

partitions-boot1 {
      compatible =3D "fixed-partitions";
      #address-cells =3D <1>;
      #size-cells =3D <1>;

      nvmem@4400 {
          reg =3D <0x4400 0x1000>;

          nvmem-layout {
              compatible =3D "fixed-layout";
              #address-cells =3D <1>;
              #size-cells =3D <1>;

              wifi_mac_addr: mac-addr@0 {
                  compatible =3D "mac-base";
                  reg =3D <0x0 0x6>;
                  #nvmem-cell-cells =3D <1>;
              };
      [...]

That makes some sense, this would require extra work for the
emmc/block layer to also associate fwnodes with logical partitions,
not just the whole disk/hw (hw part), Is that the direction you'd like
us to go?

Also, Note that regardless of which approach we settle on, this
specific fix/patch remains necessary to validate the partition node
and prevent NULL-deref.

Regards,
Loic
