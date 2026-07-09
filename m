Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302B5212548
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601514; cv=none; b=R55N5RHe1RTuEnMlDIzCkZpl0I4d8ihGL0guAei8EEQ9cgy89nBySUhGcLPM9WrapzogmYydGLyCsyo/zcs69B0bq0/B9eaCGz/xVPlce4f14rvpJ6vB4rdlyiWGSwCYK6A90P3o6397vIaqjuEaHl3H7uio/kIA9tJPs+EiG00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601514; c=relaxed/simple;
	bh=gG5zWqwuMu8ApOu6d8A1wOtafwpC84IJDuMW2G5TYJE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gK9uBU/K9XI5VDNpKm6HXEPHrumaTPXCXmdJvvKjb7sqWs4zz4Z9LXEcki8lAIhtSbs0zc9qAAiduDW1OcVbXbG57bwR4dbBx/MKtSm1VwjmkJsPiN2C++4WAaaAoxxyKgqSuwmvUGckkF40d7xiqTBi/AFzO4g5tBGyi+B/3o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UT5yIZ8E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P6O2lhoe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UT5yIZ8E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P6O2lhoe"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669BNT0c1489088
	for <linux-bluetooth@vger.kernel.org>; Thu, 9 Jul 2026 12:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=aVHv/qvuO3yALsIYRdKVYocl2ys6ifkekwG
	OPg1Bkbk=; b=UT5yIZ8EyDsjDrboWk1jWSqtVTqVEGva7a0zR65917a8Ba6Lp1k
	EP+s3lpA7sSEuoL9DqxWhffNYYeHcGLZPpduuhnM8HZfyGUsIKKNasKspXNNoFzv
	8gAVvCGFcUzpv48Bx2HZxU7E+pbm7vB56GxOVZ9NnTXjCVzEojFxr0ULSs9OfQav
	ln6/XrfdeFhWENV7A4Niz+L7/Rth2i0WJqalFhjONeAmLUNkZ3U8aUyeY0SFw2OQ
	Dm4bXfPv/mOArDJXnst6ks3vM5W6hEjq+uD+XcL4wyQqexwak23KA4wmMc51915j
	P4QE813naJLSOwvK3Zv1enggJiSNGIeVNVg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9wwfu8d4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 12:51:52 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c894c1c4aa9so1441067a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 05:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783601511; x=1784206311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aVHv/qvuO3yALsIYRdKVYocl2ys6ifkekwGOPg1Bkbk=;
        b=P6O2lhoePgSSSqKZFXy+IarEXsT+1njW5Cy5Yc0TLnozfo886PVjmm4OaieMqEjlrC
         PLIZltq67o73myAK2tY4D+iOMn+7ZegjJpg4kABb67bya0wdNU/SGhZLlPMqo8XWHOsT
         L9phkCNteu6wAbAz5+puf7IzAVULWc+bcVAPT3yOZrJ0/HLyHNCuvMz+6TcJojezNZJP
         PI0qPpysPOf5mbfNKyLgH51BRQbKQUss6q/QiXNb/LGQkxVCw5NqKYWigKmG4xbAmAHc
         qTYVkdZwjYxDvgUS/eUjPhqEBYJ12KU7CvdFEux8qvG+FXjAgOWZkX80L6VpAxo9wxGq
         Ynww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783601511; x=1784206311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aVHv/qvuO3yALsIYRdKVYocl2ys6ifkekwGOPg1Bkbk=;
        b=ZLxvLQ8IhepXF+6HQsE5JvfpwGi6fzpBXZfffTSjWjCs7yw/6Nw5c4iJH4zjGZJjWf
         e5T4ACsAefDqAcV7AOnRfrioOAPMu4yS0ER2vWOh7+5ycnhqQmLNMutETN3/aFiVEMAP
         lmRW9qmmnxzTwl7tIhOOp+dLdJnr/7JI7LFQV6laXwPGg+VCFl9comrzAnYLDxQu5wuv
         5pw6mgPwZRfVHrvF6kzs/Js81+T3pIaTwRZxiyydPEQjg/gcqUK6KIYpLTyaZg7lFwp4
         N7rmFq4KYvHoY5TrNeZ1N9VcV2UFL4+HHcdyuhI71182F3oO+1x7dMLEM+7MV+eCbvFk
         kiwg==
X-Gm-Message-State: AOJu0YwzcAtn+4hHDWIl8R8IIsu/Ed8LNHg4cVaBSYJXejmd5cb61NBc
	R8TA5Dcl1a6DvNeN64w4A5PeRKsjdsN1hFKcmsTkiVqdhyGXoMB7gMK04n6WdFvE5vSfZoQusce
	3GakHxT8Pg1hbD66gTajpzkksZeKLcTknK8Pk78hYPqBAH5NZfsGFDhwc0SG2f+NHFLXpSPeifA
	vR3sQ=
X-Gm-Gg: AfdE7cmj9ux+aurtcowqiOp7WsS8A1DJr5raXDhb6kcVmQ8C/2bjyKNaoC8rI+ncSjo
	J0sak/Qy1ojEQxCc/eL1b3MaIv87RefmbouPhxVQT8tTVq5aQj0U2SacaagHdhciZpe9yd6qRST
	g0C0teF92Birseian9V7AR5NDEqCBUkfgA6mNkaFrrfBpUkh4bQ4I96wdadcO0pCMG0OIlW29sh
	OHgITyy27WIByPwuG4MJvbxA1T74Doz+IEu+q4x5d+l0KfCgb10eFYaCgUHydH7zjqfBxJLSTEC
	d25HXS0j09bs6mTl2jXIRcCvYo/fPNHoliDNX4XUlGjn9BeK05o2DikNvy7u9f9Y6bMYiihxmMr
	3zmb1k5Vo/w1w6geIlyLMvySL10ibEQIZKjLgYSfh
X-Received: by 2002:a05:6a20:cfa8:b0:3bf:b931:b3f4 with SMTP id adf61e73a8af0-3c0bd1588e8mr7873031637.51.1783601511014;
        Thu, 09 Jul 2026 05:51:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:cfa8:b0:3bf:b931:b3f4 with SMTP id adf61e73a8af0-3c0bd1588e8mr7873005637.51.1783601510485;
        Thu, 09 Jul 2026 05:51:50 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm28875679eec.18.2026.07.09.05.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 05:51:50 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 0/3] doc: Add Channel Sounding API and bluetoothctl documentation
Date: Thu,  9 Jul 2026 18:21:39 +0530
Message-Id: <20260709125142.2655974-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEyNSBTYWx0ZWRfX77JgMVFu3PAh
 X+D2jhKJlAHkT2k4qnkkWTriOvtLdds1/51U5AwXMj/0iselPAayXDPp3TysMAOOy9+8iiMpRoG
 5ncqxfzPS1BX01lVW+qHRFBtLsajranNOq6dV66XHAt59d5kpibbyiPkvY2lNxXKheCmhH+gH6D
 I4IexOSdaWJ6m4doQE1eg9/WH6H9CHhWUwHmKEuqxXVdPgbFyiQVES9ifTUT1WRvgk3vxqtb4Km
 Q0FG6ce1CHnDqrfomEJQ4JStjdywEbkouMxGp6vhl2iGYv8Og8VBgPutQ5DzUqUuOUreRRlAQrb
 2LW/DtNzXRofWq4/UAR+PEVw5KBYwtH7Bei89l2oo+bNi9B49W2X4AuCMb32m/4gkoMmWMcPGZk
 s/8ZeT5piS4NMDGTFIq5jnw/mVT8L7Lig8PtYAc/gnxzYACKxwRHarilvTgpDoKmeZMndPVBqL8
 Wu5OCkFemrrUax0qUhA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEyNSBTYWx0ZWRfX0Evae+mNO7HF
 61oIiiHIQzcSyyj4DnGzWRYy6zRhzgfmTDOZ/0unQZnq85Uv/5OsSFEfZNI63aNmNgUz8Ukic/x
 0hiGjPtB6DHjyMvoe/6yziZEWnM+/CU=
X-Proofpoint-ORIG-GUID: EqPWTW0JwE0YthBuZVrlrFJGy5L89j2l
X-Proofpoint-GUID: EqPWTW0JwE0YthBuZVrlrFJGy5L89j2l
X-Authority-Analysis: v=2.4 cv=Krh9H2WN c=1 sm=1 tr=0 ts=6a4f9968 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=iSzkMiWJHOwH8bCpblYA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090125

Improve Channel Sounding documentation by adding cross-references
between the D-Bus APIs and bluetoothctl commands, along with practical
usage examples.

The D-Bus API documents gain :Used by: references to the bluetoothctl
cs submenu and examples for methods and signals, while the
bluetoothctl documentation is updated with :Uses: references,
argument descriptions, and usage examples.

Changes in v3:
- Addressed review comments.
- Dropped the rest of the previously submitted series pending redesign

Changes in v2:
- Addressed review comments.
- Dropped the rest of the previously submitted series pending redesign


Naga Bhavani Akella (3):
  doc/org.bluez.ChannelSounding1:Add Used by reference and Examples
  doc/org.bluez.ChannelSoundingRanging1:Add references and examples
  doc/bluetoothctl-cs: Add :Uses: fields and document arguments

 Makefile.am                               |   4 +
 doc/bluetoothctl-cs.rst                   | 281 ++++++++++++
 doc/org.bluez.ChannelSounding1.rst        | 532 ++++++++++++++++++++++
 doc/org.bluez.ChannelSoundingRanging1.rst |  66 +++
 4 files changed, 883 insertions(+)
 create mode 100644 doc/bluetoothctl-cs.rst
 create mode 100644 doc/org.bluez.ChannelSounding1.rst
 create mode 100644 doc/org.bluez.ChannelSoundingRanging1.rst

-- 

