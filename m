Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D918C3E63B2
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650046; cv=none; b=K9JoN2hCyaoURflVSQM3hU5cYrl05h5igWOab5sxHUOplVJzAo3gNqcoYjNgsZJudB8O85YfCs42y8VU6UjysBzrnF3p5WOaWlT8YrPaon7o3Z6RivL7ktSTvxKkryJVLI0CxwUpMfP4iprOSG2Uz1wCIQQoExiglUn7MrbRT5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650046; c=relaxed/simple;
	bh=Z2nHNnY/QMJFmx+vHqqQ6hD7nI9vXkZF4s7JVGcwhrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sbBXbZN7UG7nevn3n85rG8xPRFxwnqWYccAUMr8fSZBWm9wilonz2+OJlO0giN5BbwK4hzqeTzNmJ29tJPxVrxEqqgfj3CvkxF7tWdFuZ4W7kHsVvekGbRg3Jy1gS2zmYEXYEsYjrIarWdwmFzhIFYZJahd91EQPlYLD7bhaxbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ADjJKq8D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JN0tD6DY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ADjJKq8D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JN0tD6DY"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P888EH771417
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 09:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UwswW+trkorPb9/kJlbj7aHQ1vtmSmdJQh0C2ma+CrQ=; b=ADjJKq8DoQTwRQj2
	KoZWEu9cvtB529d6C1/tvpxMQHfkgXc8mCP2xO6np5cNeaA1VvaWVIMVNJZ/i7+V
	QvQNpiYoc8iQtgZf/rsQcanBThC4FqacJaLXewo0tN56M6Wd97dUnY1qhmQHcfOi
	ZqNxdw9SvclBcaVy9bvfItPanjnHlRkwoMSRYMaDUAiZ8ljb3KyArr24N9vGtGJU
	OrBqHbTsoyjzhDGvDxLr1+6k+vVfrLeH7f8HmPNRC6JDpnPt8M2EHxX5FX8hhQQ5
	uhdTZLonjVVQKOep+gol37z5ViakCcICoAjZEB5SqniEQleicYkS3NXBoXx0T/L9
	i6YsYA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g93nas6d8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 09:27:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3883dc4ad23so1287318a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 02:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787650043; x=1788254843; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UwswW+trkorPb9/kJlbj7aHQ1vtmSmdJQh0C2ma+CrQ=;
        b=JN0tD6DY3lUBMSXxN0M+RRwSwYhwDxqtMh5PyK8MKdJaS2IAAMx+8cgGiK84DERWGN
         0BSQ0bObNjMviKqKm827fvOrBZhgAjg+Zjw/Y4uA8rdMxTiOSsmDkvOUC0gnKw6aLqjE
         MKcW4TBrR/4hJBbUG2GN0fWSM7yKHG143IxVnCr01cdcwsBMQLgv2zsOeMUbkNqB+i4o
         wPntvNMUki0zC4uN5ZYsH4HlANdfuEKhjrOBI7WVau4bwx5GtqVkyg9t6kKUBEHR1N59
         zuaK1lBbwf9+QQhNx6rdIShdLp99ac0pBPxjEa5/6rpvbZm6NgPPmFcdMdzr6EAbMUFb
         ttaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787650043; x=1788254843;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UwswW+trkorPb9/kJlbj7aHQ1vtmSmdJQh0C2ma+CrQ=;
        b=Y1edB4ccA1krte+fMrWy+NC/P2APPboVkxdGAgXDA56Z65E7OjpMMHKHrXYOgB4fba
         ZmhCctMvnXLLm+SxqQCDKN/EtLOhHzxu1InL+LSgj2eZvQIJ+R8BPGzkGjA5T14a18Qm
         t+ZqhFlhQrvRIZXs9kd9jn5+NdaG4RQzwiRN+5fYqDvy5P5JOemjS5W07voJ+8LInOMv
         KParXvd6c1F5p0mqovj4XQr6HdljJ88FgBnQ4b7mnncRji+/Foc2UwZSlO56ZlBZ8jk6
         4xKOPdBUQ1GVVU61C6tOuBwNpfYcm8hG8KG2c1xxE9L/xIydYikJU6MHo1+OMgkDbUIn
         DKCg==
X-Forwarded-Encrypted: i=1; AHgh+Rpz/xyVEtqX3QVHntUwSnvW2ElOLz14ap2ahKoaWrd994sbnGmJYUO0wRqG+8axFPnsR9N3YZlPRK/xqL7ijF8=@vger.kernel.org
X-Gm-Message-State: AFuF++m2wbf35nDHtKm8WPFcB8dbEOFY6qS05gswJGnRnnxjAYRlkEuk
	3rZ5Oh0UuWeqcDjOITCBGmTycuzLMF9x3XrOOrcrUvLJSqGVELKPKoc8XYdCofQQgIL45uER5MM
	08+KYk7H/xItIkVHZ32pEeXLI8zgwkcwBSeNNoIqkoH14YshZdaVby0HomapOYgme0BJJpGA=
X-Gm-Gg: AR+sD13gC4cEGVOHda+7RuMB8rL66sm4lkc1whklIX9haZDOFKgzxhJtuv8nUaJHJkA
	V5wi3OJ7D8NWvV9cBWn8vMEUG1PY+6VnI3t9Fdnx2LCBv9SCRFiaMgbVUhu1LRb7qvj6sYhsJTL
	wFjHpTK3x1zcZGoaDbbna7BjvEgtp8+rwl51gIgBL6Bcy3YKnJHMM+PF4RSk+T3iSIWywzrmb77
	ZDfWSyB7bwDnjTHMFjcnHhv75SArhzEs2bLnrkaVbBj1HxaReff8T4bPU+KxtTRSUgzxrsHVZK7
	L6zaM0LdrQ4As/fbdYHCm1jwO56hEt2PYTU35d8+EYjGgP/pu0fDsrVaPBmt1sn1agEnm8+Prid
	lwlrPcVH+1G3FE8xtNFYyTlLhADwLrMRnqaFI6CRQq0UIsNIkAlU=
X-Received: by 2002:a17:90b:4f45:b0:38e:91a8:fb85 with SMTP id 98e67ed59e1d1-395c35e7049mr26395921a91.3.1787650043393;
        Tue, 25 Aug 2026 02:27:23 -0700 (PDT)
X-Received: by 2002:a17:90b:4f45:b0:38e:91a8:fb85 with SMTP id 98e67ed59e1d1-395c35e7049mr26395848a91.3.1787650042890;
        Tue, 25 Aug 2026 02:27:22 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39662c80d6csm175496a91.1.2026.08.25.02.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:27:22 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com
Cc: manivannan.sadhasivam@oss.qualcomm.com, mani@kernel.org,
        loic.poulain@oss.qualcomm.com, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH 2/2] arm64: dts: qcom: monaco-evk: Describe the PCIe M.2 Key E connector
Date: Tue, 25 Aug 2026 14:57:15 +0530
Message-Id: <20260825092715.5794-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0303224f-4c2c-46ec-9866-5ea1fd0fb4a3@oss.qualcomm.com>
References: <0303224f-4c2c-46ec-9866-5ea1fd0fb4a3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA4MCBTYWx0ZWRfXw4Mcnpq6DNZG
 L50ORybsNkHxZo01U2gH20MQl7is8I8IyHVWaF+rVolel8WoNpP8o+yKbzIfV+V2yGI/ZWrQ4O5
 lkcNGNnROzf3tzkLUrB1ZjMOGjLyux0=
X-Proofpoint-ORIG-GUID: zm2sQTqVQPoO2mNjDcU0zTJGhUkhp1tF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA4MCBTYWx0ZWRfX0NNsncPLJuz7
 e9gkmmiMo+ZbWGqwwEUfiOxD2aMf1EoVJwAfZ0qOOxkJgJB11pCQ4guF5zImy2sxOrfvrDglqtY
 gzIAzt+yupmmgUgCcmp5MW6s8n/S6YKlloIAahFfKTvKwv6eMuZVFwPgqQzU8dlJr7zx1hGSQgJ
 6cmL3RywDJ1tOZbmshw+r09/8FWB2sjM6LFaFLE//m0H2H0epHvX5FeQ8S+eMnZHvdD1nQ8E7Nd
 H3ENWrHZqZAM7LT8Hvs442LhTvdKm5vCOjLNrztCHdBl/ezzIDUK+nqZ81sDZfJGkl7KqjZCByW
 1ufkg+ezhxE0UPugyAjtpaC7RaN3iHJ4Ohjk1RkkyJyNY5o89/7cIBmDkosPbb9+LF8i1oOmurQ
 EQSImU1yy+nsNN2kqnPhpdj3GK1Qyh99GYQpl7BlK7IGbcJKeWCQz865wpPXi634Km8HrzF7NfI
 n/aHcNqcjzhfmwCzxrQ==
X-Proofpoint-GUID: zm2sQTqVQPoO2mNjDcU0zTJGhUkhp1tF
X-Authority-Analysis: v=2.4 cv=W74IkxWk c=1 sm=1 tr=0 ts=6a8d5ffc cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=kMy1FzuGdVoMj0jAqlQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250080

Hi Konrad,

On Wed, 19 Aug 2026 16:24:35 +0200, Konrad Dybcio wrote:
> On 8/19/26 4:13 PM, Wei Deng wrote:
> > On Wed, 29 Jul 2026 08:06:54 +0530, Wei Deng wrote:
> >> Fair point. I will move the port/endpoint anchors to monaco.dtsi in v2.
> > 
> > After testing v2 on qcs8300-ride-sx, BT init broke. qcs8300-ride-sx has a
> > soldered WCN6855 and no M.2 Key E connector, but the pending series [1]
> > uses of_graph_is_present() to detect whether an M.2 connector is present.
> > Since of_graph_is_present() only checks for a 'port' child node, the empty
> > anchors in monaco.dtsi caused hci_qca to incorrectly enter the M.2 pwrseq
> > path on all monaco boards.
> > 
> > v3 moves the port/endpoint nodes back to monaco-evk.dts. Please review.
> > 
> > [1] https://lore.kernel.org/all/20260720-monza-wireless-v5-1-69ec6743543c@oss.qualcomm.com/
> 
> The series should test of_graph_get_remote_endpoint() instead
> 
> Konrad

Hi Konrad,

Tested: replacing of_graph_is_present() with of_graph_get_remote_endpoint()
in hci_qca.c works correctly. The M.2 pwrseq path is only entered when a
remote-endpoint is actually populated, so boards like qcs8300-ride (soldered
WCN6855, no M.2 connector) are no longer affected.

Hi Mani, Loic,

We are adding M.2 Key E connector support for monaco-evk [2]. Konrad
suggested moving the port/endpoint anchor nodes to the SoC DTSI
(monaco.dtsi) for clean DTS layering, so that board files only need to
fill in remote-endpoint for boards that actually have an M.2 connector.

However, when we did this, BT init broke on qcs8300-ride-sx, a monaco-based
board with a soldered WCN6855 and no M.2 connector. The root cause is that
of_graph_is_present() in hci_qca.c only checks for the presence of a 'port'
child node — it returns true even when the port/endpoint anchors in the DTSI
are empty (no remote-endpoint set). As a result, hci_qca incorrectly enters
the M.2 pwrseq path on all monaco boards.

Konrad suggested using of_graph_get_remote_endpoint() instead, which only
returns non-NULL when a remote-endpoint is actually populated. I tested this
on lemans and it works correctly.

Would it be acceptable to change the M.2 detection in hci_qca.c [1] from:

	if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
		qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
							   "uart");
		if (IS_ERR(qcadev->bt_power->pwrseq))
			return PTR_ERR(qcadev->bt_power->pwrseq);
		break;
	}

to:

	{
		struct device_node *ep, *remote_ep;

		ep = of_graph_get_next_endpoint(
				dev_of_node(&serdev->ctrl->dev), NULL);
		remote_ep = ep ? of_graph_get_remote_endpoint(ep) : NULL;
		of_node_put(ep);

		if (remote_ep) {
			of_node_put(remote_ep);
			qcadev->bt_power->pwrseq = devm_pwrseq_get(
					&serdev->ctrl->dev, "uart");
			if (IS_ERR(qcadev->bt_power->pwrseq))
				return PTR_ERR(qcadev->bt_power->pwrseq);
			break;
		}
	}

[1] https://lore.kernel.org/all/20260720-monza-wireless-v5-1-69ec6743543c@oss.qualcomm.com/
[2] https://lore.kernel.org/all/20260819141353.96467-1-wei.deng@oss.qualcomm.com/

-- 
Best Regards,
Wei Deng
