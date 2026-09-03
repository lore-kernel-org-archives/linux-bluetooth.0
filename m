Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDCD48C8A2
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430635; cv=none; b=QHXck8gpHGHughbGGdawuzEWfzwKxn0IyL7VRBYgveAhdqyW5qJJGi+wj66rXvPHk6LWNV3pej1EpT8gIKKQQwRPrqY67rRV5XRXQBSRdNIMHbf/S68hQdIbZ5rCbegdUsTVWLdNv+giw3aak6CcWQTpbx1CIMS6md1BWTE3pOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430635; c=relaxed/simple;
	bh=DZ5tEXkaMqp4aQjxIsQ/lLAOwF0NBftZYrjPOO5E0KA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qXK5HYVybxeo5qwMhyi8OAvDriV5j3nDjnNbv52rVItLDKawi+3QzIBOXemww4kl9lh+nQuvX7yQS6P0SsSVVm9r4KjocPwr37gWdL7OfBnbCWr8wvnnUhrChdj4sG8RTHlwMH2LL/gSbBtFKqP+k8QIvfaa4TL2TLiRcq1yqZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g0ngpOZq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=csPk+jNe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g0ngpOZq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="csPk+jNe"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683924tv043820
	for <linux-bluetooth@vger.kernel.org>; Thu, 3 Sep 2026 10:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=I2+CTI9dVwg
	eeT/daBsn/m/tpW1rsYIkELatYuK6Ap0=; b=g0ngpOZqztyqMCGESsBy1vtd7E6
	APDjsVfnv3fpX/4plSgVe3tgPlIkzav1zjFsBunp3/C6ClGvqS8gEGP2ose5YEWG
	z/zGl1vNMJS5aPrBzfSyngFavQv9zYpr7onyDdRAKn66eWo8M0NXLfSmZYo7v1pW
	8uuCWnlUuuEeNPKysoXwetTGtqZI5/q4yHvykZcL6t3Bam1GbVPjFO8Evr4EbKS2
	oR964WeuA5zB9QDIgxWQ/aNAZxkse71FG4H/I5yWkUzUnT99LYlGPQY6/cljUpGj
	+DTu6sRPVahdsUaBuY0qOLFIJZ262skvklK6KhvVFl/QYaYxIU4d0IF3b3A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1pyhd74-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 10:17:03 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dbf293831so5114819a91.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 03:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788430623; x=1789035423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I2+CTI9dVwgeeT/daBsn/m/tpW1rsYIkELatYuK6Ap0=;
        b=csPk+jNeYsnggELINgCg7Sj72ACIzZ4VjIQILI10GvMfhvZAc3PMGrg7V0mV36zqkp
         GS7kJL2vL2cywWKWy/tKlMHdZ2tXdd+Z96eUiuIYMnZmspK2yRUYKJADL3mHXQtS526F
         tubiyxEVlZ0Zzns+zdXjR6AcD1Q5/NPfVA7dqB1eRDD4EEWb2u0FytSd7TRHXBMx+w7p
         efdx87NPoYpEviy1uczyIEsxlgtjGN5NoP/eIyOWvZbsE12agvaspsnZDXUhj1NTWgzy
         MEHsMLxoBVUEIFBYWNW7Y3s0ZrBWdBWgWqJNPtVcF92fmeHXT4QDycXH+bfHNpA1gyVn
         zYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788430623; x=1789035423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I2+CTI9dVwgeeT/daBsn/m/tpW1rsYIkELatYuK6Ap0=;
        b=lPvnUnDRuVefGmH0G0zXVEBSsDpobfkbUGf0qlrbWybUPoq8Ke9ml+tk/N4EK03/ae
         Cx0P1cvq+McUYSwKTRKg2kBXHZBBIha0ljLCJGWnwYmr07J0ySmRNwhIEUwrjkzQMOry
         19BeZglw7f6IlNpwYa7UssYoTaan1LNXTEAN+okMvJKvlRGmUnq3iGQuypw2pJpznQa3
         +oSxWOCkmPUOaQ5foML5HdkFIV+AzBgDXMVH8c5Vp1WEqZf2qBZklb22xCztmtG7iHUI
         JqF7koCjPDLtztx3+cJlR34IBYI7UmMhVEnrn2Ft9/kyxmoiusNpil8dg30gHk8QTPn+
         kJlw==
X-Gm-Message-State: AFuF++kYZXyO7JQr42XgJbyFo8sK2AnYA8QUecgsqH34JFRy6DV8mDj6
	tmjHctJ4DprmtDteTM7rPBGpuiBDk3O8w7iDMBdLYeQZdeGUTsUTTIsWfexrP1/ZfwH41SB6rfe
	g/tU1aDrIgN+8sxC/bmA8MqOCx1qfwHjdTuvEvHr8aGQfPaYRV8pfQlqXAcPp6rijPywKfoNyKq
	rP5e0=
X-Gm-Gg: AYBFou1bD1FIigoVxWQs6iAfXI5JpEfn83kUBBhYa0hOXeHr24PcHFdMDQNqsaV8/aO
	r+X6L56pO9v+jWICFiLF83eZFuW3qd4jjlr2q1v9FGtMnFPz6ndneyGNvv5ggs4BJynqKhfmYBm
	wKpvQUAUk/OKdcmF8Kqn31u0k5ONInp1P8Ubrtma+R9SjxmBafwUl4YGHUq07s7//N6EZ5iq5Yt
	G2Y7++2958s+9FP9SBuZixp8CCCa8GUI9PpADfNtr64nLS+1D+GVM0qQHxtiEd8KeKltYrYGfAs
	E+5No2hWNylm28GcBOFZ1U0QGjPjlqgOV0+OffVqd80yOaySLebT9xrjYV4U47Dgw2DvhsYzAze
	LiXM4URy5cR+lqiiZbBWTXChFTzNSZQ==
X-Received: by 2002:a17:90b:4a4b:b0:38e:70d5:b12d with SMTP id 98e67ed59e1d1-39aedfd74f9mr15441145a91.6.1788430623096;
        Thu, 03 Sep 2026 03:17:03 -0700 (PDT)
X-Received: by 2002:a17:90b:4a4b:b0:38e:70d5:b12d with SMTP id 98e67ed59e1d1-39aedfd74f9mr15441090a91.6.1788430622660;
        Thu, 03 Sep 2026 03:17:02 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14319875cc0sm4933483c88.1.2026.09.03.03.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 03:17:01 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v1 2/2] doc: note RangingProvider1 objects are nested in bluetoothctl-cs
Date: Thu,  3 Sep 2026 15:46:35 +0530
Message-Id: <20260903101635.3370149-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903101635.3370149-1-naga.akella@oss.qualcomm.com>
References: <20260903101635.3370149-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA4OCBTYWx0ZWRfX++fBXHbfabse
 IQjea5l59zAhEB/SROrJT6r5PkR//CTm3k2Dj59nXg3aS2pM8zffgcq7qeASKesRQvmiB0sfAvb
 +oWKry68uMjueRqwyzLCO4AtxRVi5Xb92diUGRhRqq1jKo7wD1HGMI0MwnwGIKbSo8A9VFENvFl
 8bwAHBe0qJq8OMEuZvPijyCzvk268Lx/Wx/7r8Ubc3twiCIIUxCZg8k1VyHpOWP40QgwhOriACo
 QAsrl0UP+Bu5QhOLZWk7KSPtmW7L9NfaYBweqAJ/zwoUdpAQnfwAMp2gKW+4FsMoBCYu9LPtP5M
 8yHaCZ0uiY08JXmFzZx9yAqzpJkhY64GnCSFVnm+LboNOHL7brmGc0o+R/bvWLgQRwqjcXQWccG
 quxqaZegEjOwe5UnYuat6EWG8pU1/qpVgYPkkis5bMMbpMewaPnSoZIqYQoXe0qXOfs5hQU2r+z
 CsX7+v+3prfIIO3oRGg==
X-Proofpoint-ORIG-GUID: fv_qHfw4C7MT4273l-2Bbnv2KKOSVogz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA4OCBTYWx0ZWRfX4AGRqlq44k2+
 404GSJ3Q3sJ8JvVejeLK2DmtyKMpQPsSHwmVBNY3LJJTxUqq2V0hmiBN+wDMnkMA9kVyvQwN3Vw
 QggB/Odj7jLsEJtkPQ+enw1GBI8f18M=
X-Proofpoint-GUID: fv_qHfw4C7MT4273l-2Bbnv2KKOSVogz
X-Authority-Analysis: v=2.4 cv=DMO/JSNb c=1 sm=1 tr=0 ts=6a99491f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=sFkhFCKofwIcdT3JafMA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030088

register_provider's exported RangingProvider1 objects live under
/org/example/ranging rather than directly under "/", to avoid a
gdbus/object.c bug when linking new top-level children of a path
that already has an ObjectManager attached. Document that alongside
the existing default-path note.
---
 doc/bluetoothctl-cs.rst | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/doc/bluetoothctl-cs.rst b/doc/bluetoothctl-cs.rst
index 08a7cafc1..c3d67fd2d 100644
--- a/doc/bluetoothctl-cs.rst
+++ b/doc/bluetoothctl-cs.rst
@@ -135,9 +135,11 @@ illustrative distance estimate (not an accurate measurement) exposed via
 
 The provider path defaults to ``/``, the only path bluetoothctl exposes an
 ``ObjectManager`` at; a different path will register but bluetoothd will not
-discover any objects under it. See **test/example-ranging-provider** for a
-minimal standalone provider skeleton, which reports a fixed placeholder
-distance and does not parse **ProcedureData** at all.
+discover any objects under it. The exported **RangingProvider1** objects
+themselves are nested under ``/org/example/ranging`` rather than directly
+under ``/``. See **test/example-ranging-provider** for a minimal standalone
+provider skeleton, which reports a fixed placeholder distance and does not
+parse **ProcedureData** at all.
 
 Only one ranging provider may be registered per adapter at a time. If a
 real ranging daemon is already registered, this command fails with
-- 

