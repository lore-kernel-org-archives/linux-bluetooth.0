Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E4136C0AC
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781251086; cv=pass; b=nmfRqEzzxOvNKi2m3RBfQwobah4w+nt669sFXlNHlfwRUv8751fzb3ocqaQoZ7Ak1znuomtYoa3UueAtAmsJytws+MGU+1CumXWp+DxcFps+8Ac01BLblNz9cq96F4rxtkWCDE7jE7eMLyinlMcCH1HRJaUevHOvwe1j3BRty4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781251086; c=relaxed/simple;
	bh=qE9FqkhndnGAaai2XsKnxnIlLJwWvj+Km/dAKpVTNrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5ET1qTJcYFP6XhV+anV1D5UxoEZetspbFclZwcGK+Q7Wa0/ZNxPgJmwmLsrfyqDHdOe3jtGnjOZk/LKAAk0Yfo5Iy1G+AHnXFQ0TqdCb7ldswxLSS8vo4wj8QV6+xQo8GOjkSGqkwHxeaF4KIeZRk2Wa+FyjS+o4vHPFeve08I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Be5VGx4g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=POCygWzX; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Be5VGx4g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="POCygWzX"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C39Ob4940306
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 07:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	17iUDF7mL5ise0USHzQNeOsFGrHXhTmPVnwtg7/+gNE=; b=Be5VGx4gTUql8Vgx
	MQd5cd2DNjjeytK/wVvLvtoz/4GCK43dIUZNL2r5LzQm64n2OSWrhgsu+S17nxAi
	biRk5OxZn7ZLEuhzG1n7N1H1hG/Hvyl2ZjPusePOMwVKv9m/jpnfo1fPGG08gdKR
	qjpflDb4jHHwjQa8Hms9E7dNyqZ39kDJ6WjummOJ8TE1sUe+W1gQWbbpKqallgw2
	orSXB+5jHzb3rVakigr3LCMzzfgBUFMlcjyakZw0BgPrmAKnvLwwQHbUHdJKNklW
	3TPJmVF/kb7CIXaZBB5jiYLL1964zpfhv1RNhb8810SNEDTCKV+lesMe5jgvamy9
	2ZUL6A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er014k3w4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 07:58:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9157f453a27so110068985a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 00:58:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781251084; cv=none;
        d=google.com; s=arc-20240605;
        b=W3CoFMXSDHTPF1YY52x9J8QGNDtSUHKFMupxY39Y06aF38OfsbDxWCbPJZpg8w4Evd
         Up1bGAhflFMRxHQP50L6+HiHB9N+T3b8dpe4QDxN0CrQR2ROHm2EQLEWXAc8JmjkStqL
         HK1uIMZ33EXYQhm1ACdvNZaAGpFLJvBpqO5WAZSfy4lc0CgaOlFHNTVydX7aZ3cU8+mS
         zCuEje61S2oIvZGpxtHgbDa4cEBIALZJkCZeo2eA+aPTp0Pi4hGty2qQqaX0BI08OnON
         Loy5aVOV6Qk9SC55S+uF/jj/7zEOCsWz4nWHLV36hV+7XkoBKpCD5K2oKMMpByiZz5j9
         +x8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=17iUDF7mL5ise0USHzQNeOsFGrHXhTmPVnwtg7/+gNE=;
        fh=hR4Kgsg8MNG6vzv7IDvcaSXwHUM/D2M/+puuJqhfrOE=;
        b=GfVpPh7oJsWbvb9KH9n8bVCGNGY8nTcQBZSzJ8MPaDfaIZF3JeEhSX4/AuEgMuCj7R
         Q15fFigXbhUcHFIZngmt6DpP7CK76UdBRwA6qf6toi4HXUYnNczB82JruYLDNuwohyfW
         rpY0tFGUWtzt/NoHrG5jLep47GO2mBvO2PJqldibGd1+9LTsBzSKlHvNMuSQSexRS4sH
         Dfw/etea0de3MUmoI8nlPoEXgMBmXqiPMv4N3vrpbPQEDkM/npU1qtidZdhUw+y/aWjk
         /rVkTYNgi46GLSXYFuIp/LgT0dbMCWxYDZ/dcRgXA4PKT73+dOlCNNBEk03mmDT3Ktyk
         bvfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781251084; x=1781855884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17iUDF7mL5ise0USHzQNeOsFGrHXhTmPVnwtg7/+gNE=;
        b=POCygWzXRhSGiDVOhcRBLv6GKKii028tspR9dtQ09i0fzdtpSdNHuDevaXhLi6vHss
         ygGYWvQZbhMAC81YgzG4ky6au+Aua6+am2FqMiJhu3Y3LaJ4FGkhOEDPcjsrG6m1KBQQ
         yNBwDK9HoxMy+koaGykJHN6A2niBDo0j5ZUzA8DHNa59qy0PB3Avr7UeTSut7kbfmLGo
         twkUgFRDoX/IYqaGw5P6zSSpiraKk+7uAdgurVbxgLX4MiLriUXStmObAM6S8a8BcDSC
         DgcbBvyIHfUbBW3qxP98JRx1PPzmyY1kgcRfeq9GqcxrtlQqokXWNRSyrn+Yxc6WtzJr
         aTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781251084; x=1781855884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=17iUDF7mL5ise0USHzQNeOsFGrHXhTmPVnwtg7/+gNE=;
        b=kV4c7pYEILMSG6yrjbHLSTeNg4JISYm2RYd94ZnOxhFYWBiLM9t7BjkB4QgPKB3rON
         3If3URXkirenQghuds0IBRzVXZFKFnAPYiSh7DNU8v3wojP2de2hchtXd0fbU/Ym3IoN
         saGdTyzfN/cODtJsr2tRfRYov4ULjaaEpg5Y3RNtYh3F9CLbfDgURnf9TxdcJ0SAmni9
         LNZstVP8yfTkwW/g55iMeNqs+9J1Dchl1HjRyESXQAKp06yAS1YJXeBzdfYS/G7U7DWn
         xU10fPTg5AjNkiIzf/H2KptJOjRfskKRPzUIcM5wEfGzPpcefQAVGo7TngmHZ0QWEDg7
         f0tA==
X-Forwarded-Encrypted: i=1; AFNElJ9YpTWfK0Ffr1sxlt/XPpOMsKtDUUBBP0bf0001ydFrw7Ti689VtHCTzf5h9s8Bk7WKxS60wvCL3E9vylChWoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe2IX3rZPvBjkIJPR5ahMMOBsO23SHxHFuuDje4oFJLNSBNYrb
	RoKSHErRwrKh4X5/YLiLYrCh24ASiPzBPLq4sacPGfR3EflXo7bZfv+NG4sA5V4T8bnuC/fxtHt
	yBe93/KDecQC0rK1gOm8KTjcv0MVgJMxWQ5Hfhn4vKsg610xNXlTOVACl67kd4/OggVXRMznD9l
	c7Vqg1X1nksIgcGl3QvILXpdpyghCt2P7O4ef55/TotVwHeg==
X-Gm-Gg: Acq92OHtQ2AoSlGdzv49vstBZwuoIuBM5PfLRsgTiwlJyDbSmFuuku4JnSXhdB/0Lbc
	hZShIZFgprWXTjAeTPj0G8vQLfmSPkWGY2jyXU2CNLts5ZnavQg//yZa/nARGMcn1F8NoMkpFq6
	mviJDCxnalyZxoXFJqztJI9MoMhyeaQ7q8/0oPsDJr25LUenkr9oPBOCrKni7xHu4851TX7pRGo
	S7TpOcyeqjg/KBgt767TbyrmGVX/t6Y9idbpe+CJ/UnN/6eWwURbKNB1bKw06Bi9BkOaqrp1Ei3
	cNx9+DMQqBSvKxViw7oy
X-Received: by 2002:a05:620a:2406:10b0:911:1a2c:f953 with SMTP id af79cd13be357-9161bc5db30mr150537685a.20.1781251084079;
        Fri, 12 Jun 2026 00:58:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2406:10b0:911:1a2c:f953 with SMTP id
 af79cd13be357-9161bc5db30mr150534285a.20.1781251083533; Fri, 12 Jun 2026
 00:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
 <20260609-block-as-nvmem-v4-2-45712e6b22c6@oss.qualcomm.com> <20260610-funny-paper-warthog-25fa0a@quoll>
In-Reply-To: <20260610-funny-paper-warthog-25fa0a@quoll>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 09:57:52 +0200
X-Gm-Features: AVVi8Ce9FPbWU1H1fFzoHrS06e66vPYKJ71XBeMTddYgFQq0vpvNpz1VnR725W4
Message-ID: <CAFEp6-0Jqw4HqTu89QVOVtWEYMpNdnd0vYxRyZDgn6oMENCqTw@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
To: Krzysztof Kozlowski <krzk@kernel.org>
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
        Saravana Kannan <saravanak@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: KOLoMhyFlN-2gC-QSWeCZaRjCnMA7sRy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA3MSBTYWx0ZWRfX8OVXWyXanyEZ
 VlaSzrbu3iDuiPU1fE42+rTmNaf5rYqLgqVLtWNOlLcPmxenoGov09jfrnwwqEUINe9nR1mW8zC
 2zunFmomHOIdhWCzds2Y2bi6KiUKXb8=
X-Authority-Analysis: v=2.4 cv=Qp9uG1yd c=1 sm=1 tr=0 ts=6a2bbc0d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=HRdx1Oj2DPauqesJAvUA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA3MSBTYWx0ZWRfX7IxVhJrdTcic
 63FQxuH1+fpxpZDa2CWbcORkmwXucbfvhpnyAK1PmtQJjNta39yuCFvgQSTfqKSqPxRVGNQ2NCw
 ExfzKEPWt4al3PZYUneD5t/67R/7ul2acs5pawk35Z2OxBN+J/Fm4XJcF5v3jiNac0qXhQV4Ueh
 q5h5O3mVmqsQX78e86r0wtHGXyjx1mmvLRbvag1ofZhdPlpoqY8heW+qjrw9GlLXQgfUgxl0vPk
 pr/Tm/R4qBcYh4VJTi/3a7gb0EYlZwVIThZNJ5afVW3QHOWaFIdxuTJDic8sImppjFU/WBJFYVf
 He58lDdV0bUy/Mv8BZRJwVCmn+beZv7C8US/6zcxq04gt2LZkDVAZK6OMqQxESI39aTqi+W/SXL
 qByV5JdzDXkhnyMT5uKkCavlZUwtV4qiy7/0tuoYtChOOJfoYfp2hkRnAz5d8I1QTP1xNhVN3rB
 OwMp4XLQs+0W5bkv91g==
X-Proofpoint-ORIG-GUID: KOLoMhyFlN-2gC-QSWeCZaRjCnMA7sRy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120071

On Wed, Jun 10, 2026 at 9:16=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Jun 09, 2026 at 09:52:27AM +0200, Loic Poulain wrote:
> > Document the NVMEM cells supported by the ath10k driver, the
> > mac-address, pre-calibration data, and calibration data.
> >
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 16 ++++++++=
++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k=
.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> > index c21d66c7cd558ab792524be9afec8b79272d1c87..7391df5e7071e626af4c64b=
9919d48c41ac09f1e 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> > +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> > @@ -92,6 +92,22 @@ properties:
> >
> >    ieee80211-freq-limit: true
> >
> > +  nvmem-cells:
> > +    minItems: 1
> > +    maxItems: 3
> > +    description: |
>
> If there is going to be resend:
> Do not need '|' unless you need to preserve formatting.

Sure, thanks.

>
> > +      References to nvmem cells for MAC address and/or calibration dat=
a.
> > +      Supported cell names are mac-address, calibration, and pre-calib=
ration.
> > +
> > +  nvmem-cell-names:
> > +    minItems: 1
> > +    maxItems: 3
> > +    items:
> > +      enum:
> > +        - mac-address
> > +        - calibration
> > +        - pre-calibration
>
> This means you expect random order with variable number of items. Is
> that intentional? If yes, please provide short explanation in the commit
> msg.

Yes we may or may have any of those cells. Will document.

Thanks,
Loic
