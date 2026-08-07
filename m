Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC34C27466A
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116107; cv=none; b=AollE4vzzTMBxZWkGAqwSwD2K1ivjqh5QnCqVcKEtyIcTftLyrT1mytbsoz/Lu0DADHEasepwlImiUcJml5JC9ogrK0M6pBxNKCwDsC6qAciL95LJm/iMH4DbYxRJFP4esFXFNGrKyeihiDMPFO11+Km8jVTXQEjLJMEtJxlIDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116107; c=relaxed/simple;
	bh=eXthG3pwF7AdjE6Zu2onIWo5e3+oLbrtMezp3Zvbm1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsfKAqjx8XUQ62MDALjyET0yaiXrPeAbdL/44NFHuueD+8o8U6Fr/hbDpT7Tb9cZfMusIlc8LVYV4RirXaKtrIuNl40XBf9aQf9MpWgU3wFLICjuIKgHnjwG7siO1cPsSeM7u/yCwV1l0yo3g/nBxUVATL4egxndQFM9UxyZKZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cus5LkxS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SjgATUL1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cus5LkxS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SjgATUL1"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677CgFLD263949
	for <linux-bluetooth@vger.kernel.org>; Fri, 7 Aug 2026 15:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fIN2n834rIS
	hCbSttoGPoLBBWFwgRPau6O7pYEVDiZ4=; b=Cus5LkxSQyoPITe4InwwZGjjQEu
	WTZbTdjdK/c9qnWkJE2zCIqmqK7LnFxDVclJkFQ8lO8SdfKIB5vPSmcVD6nBq30/
	UkA7tlivEyfYpNst9mrXqceefX4Y3/t4Afm3W1nWrue64cwI0U4jzgExJdos/1Og
	O+0XszP33YAWQHXl9fueznbnQUogEYYCyUuZSF+NxoqjuGbV0ZJfOMM1sKBMmN/X
	Lz6o6sNfP27k4v8EXSad9pBEej/VM1X72O6QeLXqtH5Xyj1ih2hojYQzO3K/U24U
	/YyKzvsWjnNFGFNZGsfnmNlB6II0oOBWtC7X0zKGEKCD0GgYTBItMXlcKPw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fw9vu22rn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 15:21:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1eb52e1fso57851681cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 08:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786116104; x=1786720904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fIN2n834rIShCbSttoGPoLBBWFwgRPau6O7pYEVDiZ4=;
        b=SjgATUL1Wrn4N+zXmWQ5Jg6ty4FX8SWqohQ7GOlJTJ2iqdpVDopxGgIFN2zzVAFYRX
         rpTzas3tCPMZbuiXX5rwMerpWhrGjR2GMwNoJeAq/bEJTroI+xi9gln3EOhWQ6/8B0PZ
         T+z+n3YNGXa+Tj0HIPZSUcNh3mbsRz0VUonzx5Mt091z/Jzq4V2QlP/hG8QBpfXMV/Ej
         4MqLdslwf/lGRqbyTCd78dGInFQ4j2NKveYTPHzbbmrJ41EVzbqkkwIfYLKGsRZ7S3ot
         NNnBtwIjdCfw1X8wa4447m1h2HMQwdAXE0grgbxBN5KC+/pdUETOFeellfNni3L+53oN
         8x2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786116104; x=1786720904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fIN2n834rIShCbSttoGPoLBBWFwgRPau6O7pYEVDiZ4=;
        b=Iy43i1d345djatGsAGmhW7ml4tUXsHGxZt0TQ5Nd36ewr9oA5RL5xPPVPLTYpVM7uy
         QlCdtLU8cKURdown3MzD3D6o4ZJnO3I2pwsoCh4y5Mw3Ewf4+mabOcBnymtxDhlfmxab
         F6otA3amL1R3+MxlR82EvScjbuNVSNcbEGmQHM1d+58c0GE0WJnzZTQs8QJUZfXI23JW
         1rCwiPdnS+8c+d70beuJsmKRGz60RsFcTfdGb/9cs26U+o7Ga3i38uGcpusr1CErFcVp
         wYDfzfIAEyF3f3aRw5mshdNLjZQsCnjPr5ePrvz1P0rJAerjsqltbBXiY3llOKWyS6Oq
         vjtg==
X-Forwarded-Encrypted: i=1; AHgh+RqCBrawtLmVXzpYjQsCJXpd/z2EjiF0ANxQKv4h1KP/U6ckRMtVzOYpVYdhlI/vaJAkvaOTsvRfEAlq45SMbtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwednLLVK7vwjtnHHIQiGVe+vrYr3ugZ7MLJ/aUzD/GOOY/mLL/
	A3gq5T5+ZpdO51YIPxaH7qR+SeY/duYlTrd3AuD/glhTEDNZrczPxxHXlDGizSq/dweNmIt/cJs
	WkpCCnw2w95tIF8fSVLCAb/JBeU4sg064t+b+v4NBubh4cJLOmeDOodx1G1TQOJR2JbrgkpU=
X-Gm-Gg: AR+sD11i1Ufb75arIIkoD1DoysrxY10SyKcbh+MWFkhTX0WL3VA3hfdCLfCbhfrSnoR
	wa/ly05ZrHBWrm3A+8Hv1EFo7+YaPgKDdUJX57512pbre0XjwoVtw9BLK1c03AVSXr8z9eoJqwW
	IVgSip9eHDUhvuYjWTTxn9TDsyqyDVJJt+8LrStrIUiQcNExHvNPxckvZ7cl+rNk5vXArUE0wJ3
	RnZ7zweA3lAY7iVNbtRy/W6pkKS6jp5IIa3Zl+R7ns3SHKkAapjsypUs85euBMPdrtUxqCFp9ms
	uZ77ivwHQD2gtjjW8luSyp+OsfbU9QqcWCXF6hBw1ZwYYt6eTvtlgGGx9w1Ziw7rBcjKxjsK23e
	gN7oRPaPuCjb/ZkGVCM6lNJJPEJouV8c=
X-Received: by 2002:a05:622a:480a:b0:51b:ee11:e71e with SMTP id d75a77b69052e-52ce5f7e829mr259021011cf.1.1786116103649;
        Fri, 07 Aug 2026 08:21:43 -0700 (PDT)
X-Received: by 2002:a05:622a:480a:b0:51b:ee11:e71e with SMTP id d75a77b69052e-52ce5f7e829mr259020311cf.1.1786116103200;
        Fri, 07 Aug 2026 08:21:43 -0700 (PDT)
Received: from QCOM-WFsSr66Fqw.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1e7c9d78asm774026a12.3.2026.08.07.08.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 08:21:42 -0700 (PDT)
From: Igor Skalkin <igor.skalkin@oss.qualcomm.com>
To: haoxiang_li2024@163.com
Cc: error27@gmail.com, mst@redhat.com, marcel@holtmann.org,
        luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Trilok Soni <trilok.soni@oss.qualcomm.com>,
        Igor Skalkin <igor.skalkin@oss.qualcomm.com>
Subject: Re: [PATCH v4] Bluetooth: virtio: Fix virtbt_probe() init and cleanup
Date: Fri,  7 Aug 2026 17:21:34 +0200
Message-ID: <20260807152134.1525-1-igor.skalkin@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709114745.4030794-1-haoxiang_li2024@163.com>
References: <20260709114745.4030794-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: EGjy5ldBWhdugHXs07SI3jzDWJ5Kya_4
X-Authority-Analysis: v=2.4 cv=SYbHsPRu c=1 sm=1 tr=0 ts=6a75f808 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=6wz9AUWKJ1XHrY9wszAA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfX1nL0D+HoIN8e
 EDMdt6yDiipS5NG7SYfshG9SxMw1yNttn2E4HmgdHaQGz4RTUMsKosaPEQg+HniockSHMuRNvoJ
 RI/TTTHSc/OewUZ4pjPcjTOR7CDDtsU=
X-Proofpoint-GUID: EGjy5ldBWhdugHXs07SI3jzDWJ5Kya_4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExOSBTYWx0ZWRfXzb0gE5pKjpsW
 CaV/Q6gMXOQrJjv89E49trvUIpR4LxEsydclA2q21ig3GjPB9PxZAJIX5yWzauKtkHxVnpfp6N/
 yhoqhGGD5B5sj9QpqtuF8iGm64FSa3Igl14GsptCNTakp4o4SqgpaIdVNHEWrZpfvGuu2cPMQIn
 ZYzmXKC+cCVwM4io45EEWfqIFqQIRdrPfDm35J2RhJgv3ml/CTih/9Ig4XjN+gAnwyFhkn4YlXO
 TfhNTHGdXah4uVXSTdT7TANIpqpm3YTc/VYLoF7bW+kVCk07TCsXTzzVhY7Oyg7RUK2tnPaS+fN
 XzvJ9ESIgtUGsLd9wa5q7RQD5P74EJs4+iCOQZueINLgm9N6Sd5gxSYZmeksnO1tayQ/CpgZeuz
 fFNKqrAvMTQj0tQLo92U5DmLIGNnUnejcFok/ZPpljIueI6rUtgDt49lTmQ1UH5sKTEN1ADR2eI
 Bq5PpR0YC7ON2FkLXww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070119

I tested this against real hardware (not just QEMU-internal loopback):
a MediaTek USB Bluetooth controller on the host, exposed to a guest
kernel through QEMU's virtio-bt-pci device via HCI_CHANNEL_USER. This
exercises the actual virtio transport and the real HCI core, not a
mock. No other local changes to drivers/bluetooth/virtio_bt.c were
present; this v4 patch was applied alone on top of plain v7.2-rc4.

Test setup:
- Host: Linux with a MediaTek USB BT controller (hci0), bluetooth.service
  stopped/masked and the adapter taken down for the duration of the test
  so QEMU could bind HCI_CHANNEL_USER exclusively.
- Guest: v7.2-rc4 kernel with CONFIG_DEBUG_KMEMLEAK=y, booted via QEMU's
  virtio-bt-pci device pointed at the host adapter.
- This patch (v4) applied alone, on top of plain v7.2-rc4, nothing else
  changed in virtio_bt.c; built as a loadable module for repeated
  bind/unbind testing.
- A module parameter (test-only, not part of this patch) let me force
  a failure at each of the four points virtbt_probe() can now fail at,
  to drive every branch of the new unwind ladder without needing to
  fault-inject the real kernel functions.

Cases run, each followed by an explicit kmemleak scan:

1. Happy path: probe succeeds, hci0 appears under
   /sys/class/bluetooth, remove() runs cleanly.
2. Five back-to-back insmod/rmmod cycles on the happy path, to catch
   leaks or use-after-free that only show up cumulatively.
3. Forced failure at virtio_find_vqs() -> err_free_vbt path.
4. Forced failure at hci_alloc_dev() -> err_del_vqs path.
5. Forced failure at virtbt_open_vdev(), i.e. after
   virtio_device_ready() (post-DRIVER_OK) -> err_close_vdev path.
6. Forced failure at hci_register_dev(), also post-DRIVER_OK and
   post-open -> err_close_vdev path.

Results for all six: no Oops/BUG, no lockdep or RCU-stall warnings,
rmmod always succeeded, hci0 was present under
/sys/class/bluetooth only when probe actually succeeded (cases 1-2),
and kmemleak reported zero unreferenced objects after every case and
in a final aggregate scan at the end of the run.

This covers the ordering fix Sashiko flagged (hci_register_dev()
moved after virtio_device_ready()/virtbt_open_vdev(), so no buffers
are kicked before DRIVER_OK) and the vbt-leak/priv-cleanup fix on the
virtio_find_vqs() failure path, both under a real transport rather
than a stub.

Tested-by: Igor Skalkin <igor.skalkin@oss.qualcomm.com>

Happy to share the QEMU/kernel config and the fault-injection harness
if useful for other reviewers.
