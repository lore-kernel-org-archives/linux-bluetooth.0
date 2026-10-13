Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B007D378823
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879211; cv=pass; b=boUnB+fW50Iv2LipXLocbZcXd80o5jC9yPTaH/qmrbqjxrE0aNHK3Zm1VOGvz+XMag147xosw/DUqr1t6X/G0HTThFM/GSY422Fykxs1HjNiKQzadeuyQ5QWzfCY4oP4DT8IOu25yaZibhS7cCPXaoxCX0B7xtsQfbzn5/L9anw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879211; c=relaxed/simple;
	bh=yDVbioxNd4XCv57rDSmGntAP/3NDtR3SNAz7FzfXNc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7DP3xtlN9VpwTQZlnbNdknV0XjhULKGPv2GxxLrgrHgN0+GLAvlv35+ATI33TnAIs3KDvRlnzjSrSHm2Ji79RHHV7BtRj259peaF0RZK58Tq/Jm+k56SHu8YO4yvS1WjhTs/YzA05Ang6Xt/h8FgN1U/hNbTaYZjmEuM+NCmjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eakeK1RO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OMuRhTGg; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eakeK1RO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OMuRhTGg"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D6Z2vS3208820
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 08:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yDVbioxNd4XCv57rDSmGntAP/3NDtR3SNAz7FzfXNc8=; b=eakeK1ROZyb8KPLG
	3/jfbyy3Bp6xBcbhHboSF8Q8FGAnDq6q03VUlPb0Mu9M57aPARFDHNPncw/aNRl4
	ipDLCW1vAyRi3nHyziZ9A3hflTwYSHPLHFEQUIOYj7aj213wk9EYZQQ9spT7JkvZ
	xo+W0bIiPp5e0pE97AzTrZjOgJCgwhLMaBfRG+5i/Q2rnwg0jUXQ0aAwHFVvWZzL
	LYly6BBvnG0fTjdpmdk4uqGqfxDtW29dxR173HDhZgJIjPqqyUkMh1g9dZLQ6Y3k
	539vfPWP7YF0XFiVn7IhA0qLaFGdRkqRirDyX/LUJX8qvB4qR0m+acC/rrkE/8vM
	VBPFjQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9fgjgcba-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 08:13:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93e46b4b700so480681885a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 01:13:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791879208; cv=none;
        d=google.com; s=arc-20260327;
        b=J93C1XakkrdbSvTHxfTxgwjMNFVhnZGtNZ8P7vcOllr8boHNGDyj75C704F1a6NAZz
         qepC353Cf3+uUNbCSOqYt8TWVOmMJkmU5/mqAPtP1Qhy8AJGUyZ2bmL8QZNgTfn4FhEE
         PoPuuB0dJawFX8LLOKPT9fBuD56NeJGDZYquR6UiIlehitrXc434v7apYOZ7skyd5mu8
         sKz0fmi94tpatYqOsWRewE5FehDj9M6eOl4wbDNbU64LzuxOlIsmZ2TBWy0q0sNfRcsl
         J26o94USPjemxGXMzZtvyMCYH0Qv7UuCa6Bkf6AOf78N7NtHLHJ1loq8TQf7ilj+Vi2U
         xzqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yDVbioxNd4XCv57rDSmGntAP/3NDtR3SNAz7FzfXNc8=;
        fh=Bgx5antx0RYy0ujQRoAJg5kuTgQGoDGQvbQ5NFS0/BA=;
        b=dY5l0LuisLrSGJYhi1Wt8Vv4at0QWILAQ8FmxpOkU4+WhdYmt8ic9JIQ7nKjelHixx
         AlRMRU5Tl/PLc4IvX+ir7xZjcQLdzxsMsK2PfbvjRWzDmgaI2G1J1tbyM3S7IYH/hkrV
         4RNOxkZLxkgr2IuF9tNUAgOHQMomqODeofD9D0/UP0pAdMoXDxp2OaGLbbUNncUyjD3L
         Aay3j1UOfHrwrRQLlsPooVesnnDKKccVwsPXZ5hRey8kLGxgsJWKzcHRR5ZiOg6X/X/e
         1GKN1aaIlbiiuU6Qz1l7IzBMPPSljuCwBzEKPGElz87j4ALAKjrv4CQtLuyHHqFlcTRo
         K5AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791879208; x=1792484008; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yDVbioxNd4XCv57rDSmGntAP/3NDtR3SNAz7FzfXNc8=;
        b=OMuRhTGgkvOVaH9NnHyxYbcToGntFkQb+CEerxns7UebVeN+1O+DSgjq6odsd4KyJh
         eDNtVvgMXfCSdZ3qex9S1f4MkgRJu5eqAd0yRbuPRkbX2UA6f7hvawI8yFUkCoaqxfck
         xrMvnog5fvq5ZDzzbWUF60B6yStYDGCgSI2G4GPfSYxVq7V+2Beh4BoIbmmruDAnHuEX
         3JLrpXd4a9gbtEb/lWiHzJUExby3YkaizmQGU5hKwxQ95W6xVdS1tcDP8gYwjLoftm5/
         mTomiUaaXiM7cF4Oi2gte63NnjBk+ME0LJ20HQSgAdb06FJIbKBgul95bWWCcHTLMg4B
         8CFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791879208; x=1792484008;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yDVbioxNd4XCv57rDSmGntAP/3NDtR3SNAz7FzfXNc8=;
        b=VEhh+F0AM3a3PHjqOzyt+pyLak9fG4ED2rnDbquCgkhWOiGwpNz1/dC3h3v1GIVVyD
         B5NaLQvIjnNKN4FrRJNk/dxasHmDCFh727i+F3mSINIkNMnDulv98Gj8m1/9W/FnsySh
         8iKsVfMqd3bC1mTpCujaET77pSgCW660916MU0DiMukImxPz4G1Ozsz5MF/wr5c/xpzL
         b10HYmgqUaxnoRdib/Uhq0l9uHmyh33h8Zf60GmHYf0zvl6+QdeBddp4bMzIWmpieQJp
         cs2QAcOhrX9A7+XRiiwtDjBnnf7ZFGIPWh2JTSuJL7ORQnZE32su2oaJu740UaE+zSSq
         YiQw==
X-Forwarded-Encrypted: i=1; AKwUvByWufXHKrXhY6VcIbfe6nVAWmjdYXiIKzE0ddx9JVcYRGyC/fy3TMiM2EcxG4cQ3loJEzC4u/f1mEZIKk3mApU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKfdFrZf3/KU6lOk7jSOyKb0k0zaptpJnmdJG8sQl0fB3OMTOk
	UYmKelqY+igkGQw7vMDSbB6eb2kaTWLtF/JLBvmHH1CJRNsttTlzh2jsUx31KcEml+5kHkhYZvF
	ID4e5lvru5LfvxlPXrqX1WZf0OeDxImefxPl2KvH+4lvOw6YcvT1VgdqfKn6RLoGUEzsukJ4mCH
	WOz0EePkv+IYbCkyyIv/FzwVdz7q5rnE6A5fVmTXj4rZGAYw==
X-Gm-Gg: AYBFou2HKBkx7aMAmk6G1sxeDCl00FfL3fa50JLGHW912tQmKDKLO5eZLP5Q+9NmpZI
	k6j4QlqmVKNiDQoanQgmx9rGmvllQTobEHcU3+Lw8m5uTnGrdC0bVthaiXM3V4jJB7/WRdG5iq8
	iYO5gZ5PriHbmkDAeUxtplzpz8bpGJE5nUmr7B+q8R3Z+toL3Bk0otQFN8Lj/DPfTGbCRxfPpWE
	PPOMFdHbpyPSF3MrK4JcKxYMumtwkaQKAD1PSG3fH9Ie3v0fc0ZXYTezaWWtHOgLj5X5iMf+YbN
X-Received: by 2002:a05:620a:1981:b0:93c:b420:c2a1 with SMTP id af79cd13be357-93ebd26256emr2008878685a.65.1791879207613;
        Tue, 13 Oct 2026 01:13:27 -0700 (PDT)
X-Received: by 2002:a05:620a:1981:b0:93c:b420:c2a1 with SMTP id
 af79cd13be357-93ebd26256emr2008876785a.65.1791879207179; Tue, 13 Oct 2026
 01:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0303224f-4c2c-46ec-9866-5ea1fd0fb4a3@oss.qualcomm.com>
 <20260825092715.5794-1-wei.deng@oss.qualcomm.com> <isbrpaztfrgwfcleujrn4w26cshbi2mgn57tbh5bubvsegn6lc@jh3ab6htvd24>
 <83b67ab2-ab68-427a-94aa-881454f457ba@oss.qualcomm.com>
In-Reply-To: <83b67ab2-ab68-427a-94aa-881454f457ba@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 10:13:15 +0200
X-Gm-Features: AclHuK8FF1WzYIEKdmFAQIHjYBcgky7I2UfsPLuRu1T02zadG_wSv2Q4BrBkFes
Message-ID: <CAFEp6-2KDxDrfTZLN7KPRg=aavj8nqQr7ftna23n9C1Cpbwwbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: monaco-evk: Describe the PCIe M.2
 Key E connector
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Wei Deng <wei.deng@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 6JDAJHLQmxlnnraQiDhLscVHppru2ia7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzMiBTYWx0ZWRfXzvjzVLDW1v2F
 GQpTnikuK1UfAH6P64xBcamnmIaEQuAz9+bgzhmRiN7vFiQyU+CVU3ez34CLWxqZ9JrUvjJTRfa
 Bnjf5/b15r2aVmoV47rILO2KaU/24xn3Kn4MdWCWT0rJE7LSXdC2xtfLZOLP6rEIoBOefmdVBzz
 HZgkobPF0D9Fz7ZWHbhpTIvyduHt9vQlIO38wxm7nsDft1vl1owoxpJpPDndhrgouuU+pW10K1S
 X7EcQ3XKB+NafJGYxdAcxuSGV7WO5HC1bQuzy/xmuy8rJMSQK1XjvhycgP6Xg515X72m0pAQ+Tm
 2tRdOa27KvVI/shHF3H6jkG848DATIzuY/cn3szO4qT46U5YBmxWQgyX9zr+FoSsNdkJl4cChxo
 TZ+1O44pU4Fnv8OcPx46uK6kYrTAs8/oBDCOm8btW/9SbkfIfaHTTZ9XtDdwiiQcRp0mp8Kq3lJ
 LlFaJ3TdHFefFB2ZpDg==
X-Proofpoint-ORIG-GUID: 6JDAJHLQmxlnnraQiDhLscVHppru2ia7
X-Authority-Analysis: v=2.4 cv=PedqFShd c=1 sm=1 tr=0 ts=6acde828 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=BlC6lpywZLIZl5_qNqMA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzMiBTYWx0ZWRfX5OO4dEDnQDWa
 v7hUOMey7PF1ukaCO8NzaV1g0nblJ1CRBcRd4OdwwHMowJObrVUqkGZdO+DAgzMQwzZD3MiwAUL
 md8SR0rBAvPcRV+FjzSfxegfOd5dDmA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130032

Hi Folks,

On Mon, Sep 21, 2026 at 2:38=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 9/2/26 3:48 PM, Manivannan Sadhasivam wrote:
> > On Tue, Aug 25, 2026 at 02:57:15PM +0530, Wei Deng wrote:
> >> Hi Konrad,
> >>
> >> On Wed, 19 Aug 2026 16:24:35 +0200, Konrad Dybcio wrote:
> >>> On 8/19/26 4:13 PM, Wei Deng wrote:
> >>>> On Wed, 29 Jul 2026 08:06:54 +0530, Wei Deng wrote:
> >>>>> Fair point. I will move the port/endpoint anchors to monaco.dtsi in=
 v2.
> >>>>
> >>>> After testing v2 on qcs8300-ride-sx, BT init broke. qcs8300-ride-sx =
has a
> >>>> soldered WCN6855 and no M.2 Key E connector, but the pending series =
[1]
> >>>> uses of_graph_is_present() to detect whether an M.2 connector is pre=
sent.
> >>>> Since of_graph_is_present() only checks for a 'port' child node, the=
 empty
> >>>> anchors in monaco.dtsi caused hci_qca to incorrectly enter the M.2 p=
wrseq
> >>>> path on all monaco boards.
> >>>>
> >>>> v3 moves the port/endpoint nodes back to monaco-evk.dts. Please revi=
ew.
> >>>>
> >>>> [1] https://lore.kernel.org/all/20260720-monza-wireless-v5-1-69ec674=
3543c@oss.qualcomm.com/
> >>>
> >>> The series should test of_graph_get_remote_endpoint() instead
> >>>
> >>> Konrad
> >>
> >> Hi Konrad,
> >>
> >> Tested: replacing of_graph_is_present() with of_graph_get_remote_endpo=
int()
> >> in hci_qca.c works correctly. The M.2 pwrseq path is only entered when=
 a
> >> remote-endpoint is actually populated, so boards like qcs8300-ride (so=
ldered
> >> WCN6855, no M.2 connector) are no longer affected.
> >>
> >> Hi Mani, Loic,
> >>
> >> We are adding M.2 Key E connector support for monaco-evk [2]. Konrad
> >> suggested moving the port/endpoint anchor nodes to the SoC DTSI
> >> (monaco.dtsi) for clean DTS layering, so that board files only need to
> >> fill in remote-endpoint for boards that actually have an M.2 connector=
.
> >>
> >
> > This means, the dummy port/endpoint node will always be present even wh=
en the
> > M.2 connector is not used. I don't see a compelling reason to do so.
>
> I don't really see a compelling reason to defer re-defining them to each
> device DT either..

Adding an empty port/endpoint at the SoC level is problematic for
uart, port is not always expected, this depends if the uart is exposed
through a connector or to an onboard device. So we may end with an
unconnected endpoint but still have a bluetooth subnode, which can be
a bit confusing... Also why adding a port/endpoint only for a specific
uart in the dts, and not for the others? This is a board/SoC level
choice to use a specific uart for M2 or not.

Regards,
Loic
