Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF66286881
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787808067; cv=none; b=kZ12b1b0fdAonOmoZtd/kz5U4iWeDlqjvPwQkk7KewhxnCQ3MGj5Ps6Ma4glRWUXYUzdxtgYpO4xNAZC68Ous5xcnU/E+oz3iB7rrAoWJdwalSp7DQYdDqJfVH3Gcg2qGn3Jqa8OKoJnsZjoQnQ2paxQD9i+86Z42543WbiEduo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787808067; c=relaxed/simple;
	bh=zmTjNXplbmU7UlNKUa4D1W0h7Ke8dF1ZwIGYBub6oSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFT9Tq6+pH1srzoz/seTSuJq8yI73WL5iR6XHavjtEV6OXZsgQHfBc4kjE7Qh607TMU1YaYpErxGlaQUfCUiTQzjDkiDr3V7EczW82CJh9JnhL657n7IPdpnvmqJO7zWPMuiwbunohXxbXfAlfszQDIkesEjuXC1yBAQXDxE+MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D4y+ls3/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FHf7AuFV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D4y+ls3/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FHf7AuFV"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R3JY5t2633725
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zkG2bgbyEQNOxdaPvd/XUNpxJtv2KplSfkXBZObDBOo=; b=D4y+ls3/cXc1agZL
	MQ8XCdJL12INfcHtZHZK2IBx3v5WyiPWySbMiu2LQSOOAd4GZaTYEwSOS5pAUnjr
	m2au49+zlHY+ecOOs0GvtuJcvBsQ8cbo1JPCDSMABfS8JpOeVho856owj6XtdnEx
	6s9FlEWdJfUinBZ8dh/MuGW5JmWBE+g5fBtoi6D88TDYD5Zy2WJFb6DrKza7hCXn
	pqNU9nztNtM8VU8QlH4NdmllL8VqwPliqHAnStBNJMeBkstajyb1kOk7H1N+kgQw
	a04pQhuRvH0OrB9oYD+t+tOeNTxDMp0eBpIO+jMrKULJatKX6TI5yCijABd6H0VG
	q3Xd2g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga03abajn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:21:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f5ac7354dso574530a91.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 22:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787808064; x=1788412864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zkG2bgbyEQNOxdaPvd/XUNpxJtv2KplSfkXBZObDBOo=;
        b=FHf7AuFVKKAbrKh/laUDI+peML+rEkQeJYEQzW4ZnwXiCuS1NQagRPHJQ8wOAM2Abl
         Dh/wMg10nYeW959s9V79tsqECWsd0MqEOx/7NhRyKQR9GuzstlVY9yjgeBUFHJHeR3TD
         HilRFm+q8y5bu0eLj/EpRFRryqB4zrCBfFtMyt3XhuMHmu9elHX/dnhQkDnJqvQLhcQq
         +dNol3dWK5aliKlHLoi/hskhtt0bHLHnViQDoM6Fgz/FIP93MkVk07QaVVS2H39CNYeQ
         kGbcds7mGr9JviAOpyvvRkYsrKZoslcCq7laPdeRf6j+svNDUGWe/YEewFgatiI5Y9C7
         8HOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787808064; x=1788412864;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zkG2bgbyEQNOxdaPvd/XUNpxJtv2KplSfkXBZObDBOo=;
        b=kAVuHOzyGCFrikMAzqS+KKnTSHj8220QuGe9spHcrQgOqqTjqH3oxczvULCUT3pcZH
         TJ8GLp53xjPLuIn+x6k8XFLA46ao6IGIl9vF2f0K7NRxRPLVSvEEqWCaFZdRwIGLVMn6
         BNaAn7QOhif1apP7PzfjSjUeDr9SUNafCxC7d86H7HahUh9lmCHmSushkoGI+qSjnxJ3
         hlQGdML08M44e31SFYPE9WnqXfsHvLGZq/U928VxZMJPtirLdyPlgoFtQGMSC/xM+5qL
         PIEWofV2UoKmU3jCU4qVrxbd/sPDtGUK0LxjqFVshwplPBMKgQh7wMN9XXt7orN35lXM
         G7RA==
X-Gm-Message-State: AFuF++mmXG3MDY+B90eCtYXDAXlG9ZHLOiuHmOWrJlcp77+1JTqvw9+/
	ATnugG0kUwkP8h+54l5NLcTsFziopksmP11HxEJ/c/LJJ4mUoFKq1ZsH6FGlmVgB2i6Nmeg32Zp
	1WNkkEMsHWyFkIpslT4N1L/Ig8UvVZuEAWLuP8qurje+NMTwIcPnCfiMV2o43fAlCaWxlRxt349
	pbp2g=
X-Gm-Gg: AR+sD1332yJ/4+86gexO0aToezzN8OHkPbkNk+cXrCpgXDNdGWF24K9zoewclMH0X/r
	IuSSssMnxfc+hKa46CJdGBQPRN9h98D7bDSPQxWLEaz/3l8vwS1wUuwYu6wfGwU9xwxPAW9nXRn
	WK6HvwByLSZvL7Gi/mD7S2fGM2BJMSvD7Lm0pxQHNYmbKEIPSIO1sJqOpwg1bwXWCGapQHrb14d
	Uhf739Cvjj/+RNG1GlhKkwW+q5oBRnCwfBxdSCyQokZWMlmk9ZD+MQdvepKmWx8Df8k18n+aiEZ
	dNqnQpgMSyUeB3NDB0fuI8UnOvo+Sm/3a+YfZHO22utb5I3hY1amfK/x6QTU7KUrzgS3IiAX9vw
	fPorYlwXCd7lSPsnHF4HBbqCqw/7zzw==
X-Received: by 2002:a17:90b:4b04:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-3966d5f900dmr24437267a91.8.1787808063592;
        Wed, 26 Aug 2026 22:21:03 -0700 (PDT)
X-Received: by 2002:a17:90b:4b04:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-3966d5f900dmr24437163a91.8.1787808063017;
        Wed, 26 Aug 2026 22:21:03 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a9035c06sm11903265c88.10.2026.08.26.22.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 22:21:02 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 4/7] doc: Modify bluetoothctl-cs documentation
Date: Thu, 27 Aug 2026 10:50:31 +0530
Message-Id: <20260827052034.1374180-5-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827052034.1374180-1-naga.akella@oss.qualcomm.com>
References: <20260827052034.1374180-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: x2zacEsZAlimmkh4qJQ1jUEA16tviaAd
X-Authority-Analysis: v=2.4 cv=VdLH+lp9 c=1 sm=1 tr=0 ts=6a8fc940 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=vem7RHmOgr-YD0lSADoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: x2zacEsZAlimmkh4qJQ1jUEA16tviaAd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA0MCBTYWx0ZWRfX96CauzbCntIU
 c1cVjY+Cz7RECdBOq5ZlRxLCfL4M23/UD/btdSb7aCvcZ3fN26dvpv0VqSiB0qzXoNSHKkbYQU2
 x8IDT9m5CrvqIsqnTs68tsP55qiy4W+2dNwPjSx/LuSpNFCwOMTKyGn4yMLJY6Pi/BZ3je10PtQ
 Q2J0kjhYpqBD6LE/qP6vXOZfgkYCK3F0eIv3pjVmdwhJA1GElTpigL7Eq7GZGpuv4p2SVkG2mC1
 vwBge+uzuEwvDSVb1eA+6ymLbaY8k0Y4A1kHtsAP2mdDtXM4fl5JDX2tXO66qqOV3wyZtt5rPbN
 Dl6GzVYJSadbDVhTwuK6vXqH7zMXZGx87NUL99BHUqR2KqQStmoEQoCe97RGgMir5ewKDvTY7nA
 0z71FjbQRFp3fuN/kl6Adyi4g9sjH6Qa3gr20qqc5GqjhUIjuLUVWbeu3G7HGJRYa128C4tZ4im
 rW0PYTfcH1Ql69nH6zA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA0MCBTYWx0ZWRfX9cIcX+o9y/lq
 j/MP+MqTOjzST/+ZmZyOtoNkGa/8uSWokzslWFb06WdCl/rwF/v5hBAZTtD4XqK0XwX68y7v7pw
 zbBSsX6lcTs+AxYrnm4/lBlOzaxtZ/8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_02,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270040

Add documentation for register-provider and
unregister-provider cs menu options
---
 doc/bluetoothctl-cs.rst | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/doc/bluetoothctl-cs.rst b/doc/bluetoothctl-cs.rst
index e49b4ea08..86be5f519 100644
--- a/doc/bluetoothctl-cs.rst
+++ b/doc/bluetoothctl-cs.rst
@@ -122,6 +122,47 @@ The parameter output is divided into three sections:
 :Example Show active session and all CS parameters:
 	| **> show**
 
+register_provider
+-----------------
+
+**Reference implementation only** — not a real ranging algorithm. Registers
+bluetoothctl itself as a Channel Sounding ranging provider via
+**RegisterRangingProvider()**, then listens for **ProcedureData** signals on
+**org.bluez.ChannelSounding1(5)** and turns each one into a bounded,
+illustrative distance estimate (not an accurate measurement) exposed via
+**org.bluez.RangingProvider1(5)** — visible on the device's
+**org.bluez.Ranging1(5)** **Distance** property once bluetoothd reflects it.
+
+The provider path defaults to ``/``, the only path bluetoothctl exposes an
+``ObjectManager`` at; a different path will register but bluetoothd will not
+discover any objects under it. See **test/example-ranging-provider** for a
+more realistic standalone daemon built the same way.
+
+Only one ranging provider may be registered per adapter at a time. If a
+real ranging daemon is already registered, this command fails with
+**AlreadyExists**; conversely, a real daemon cannot register while
+bluetoothctl's reference provider is active. Run **unregister_provider**
+(or stop the other provider) first.
+
+:Usage: **> register_provider [path]**
+:Uses: **org.bluez.RangingProviderManager1(5)** method
+       **RegisterRangingProvider**
+:[path]: Provider root object path (optional; default ``/``)
+:Example Register with the default path:
+	| **> register_provider**
+
+unregister_provider
+--------------------
+
+Unregisters the ranging provider previously registered with
+**register_provider**, removing its exposed **RangingProvider** objects.
+
+:Usage: **> unregister_provider**
+:Uses: **org.bluez.RangingProviderManager1(5)** method
+       **UnregisterRangingProvider**
+:Example Unregister the provider:
+	| **> unregister_provider**
+
 CS Parameter Commands
 ======================
 
-- 

