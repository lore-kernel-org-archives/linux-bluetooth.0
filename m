Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70401DB13A
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520319; cv=none; b=tJHJFuKqop8gHrYJtO5uHX7trgmXhGqkktssVsl+mIZUCFlr35yR9YRpIXLYfsiK6SX4b4D3vkeKpF+dhy0QK0UVWx1tXLS++yH+IhPVF5kxj8JzuxUqPk1bJDJY50vy/B2o1aKdPkaz+tVDK6N3zR0KkqgRpcy7wVbnXfyO9xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520319; c=relaxed/simple;
	bh=N8oV1ye3kyRVmWb89WE0bg6k1Y9JF8dAPIWQxWyJUBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F0e5HUaTvRUrU35gWAPXqnV80SPqqRLTdfxCDkO5tGwP2WxNy13DentKI8wG3H5KkxH/fIbYoyou1t1pQLmQzgoKNAgftRWxI+keqUqcZd7RHQMHxlhU763HZnKVauWBwP4JqbbZ67Ec/MuhHYASja0ObAgjD4EpP06UU5MN5V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FWXvrY/7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZYKJoBRo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FWXvrY/7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZYKJoBRo"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C3Dde2751263
	for <linux-bluetooth@vger.kernel.org>; Wed, 8 Jul 2026 14:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3l2OMlA4C7U
	cIBdpwe30DowJhL8nzE3Mqi2PJDoB/4Q=; b=FWXvrY/7Avhv9RI9S+eKESqLJzB
	UMbC09gVTsDm+EqwW2QtA5wcgMLaZ/EcXZKGHSyo9ZgxnBLIp0c1ENW/RiAa2xB5
	sz0asNtIeGQbr04cWh3EI+2dZzBj6Y7wZcF3wLTcT0kEqqPucl43w0HAegB+URWA
	5hYvTGi1vGZaYgbcfo+Ly7CY05xwb7EjQjHhlF9H5UVx9xeLTSjOcY8wxhrK718C
	qcR1IpEESaJm8fdKPeqwA5W/K8rjx3+AabyGb5tCIfs7mTYwQAaDXDuxV9set1Dl
	lBJixHcPQuu3u/uQ4jfV1zjIGe87n1kscPoENvkDRspepOcbWxT7TeioAQA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9g7hj29e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 14:18:36 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-380c178acfbso741803a91.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 07:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783520316; x=1784125116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3l2OMlA4C7UcIBdpwe30DowJhL8nzE3Mqi2PJDoB/4Q=;
        b=ZYKJoBRojsn6C4u5DiKhK/+L9xfN+GOrxwN2QA+pKvXxvWGLwIDcIra7Op0BW2LbSm
         fzKtC3Sgi53vX2l12CLbxXPAhzcPP6M9INU2wjDkXG1cRH356OLYH5vz12X0UuWD+aiO
         ifByjGw3O4FLJENGN2IVA6VgIlTdWhQUmPDZe8emvdh+EO/IEPaIiFk+COCGXtDolrUL
         FoRfrjeL85hsiwNMWGgh3joyR28h7yTGYk04cruGQ7AaxNwsbEET4B8I9i7KA/zLk7Hx
         4IdbUFKg+HlfWVjlx2Il2s3Nj1MA2XcwjwAqzC+weHXkv0jkxFhGUvhVKVLRXeF3SDva
         +j3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783520316; x=1784125116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3l2OMlA4C7UcIBdpwe30DowJhL8nzE3Mqi2PJDoB/4Q=;
        b=hRREgTrfhThX3XRuu0E3jFEwsP84XXmvlFm2ahZ/dxb4NfO80C+7RZpw1XWFLqHQHW
         lmDeSzrXopTFwVYbBs7PTD+T/LrnLUk+4LHSDaO8UnUpip1VMUDl2ES6H6KVtOD1R6Pd
         +u/SlR8UWG2Ruh2rTYFakBIKThN1VH/YdLZPDGD1Zyo5Hb9/3Uy2HT4m9z1bsS/CsES0
         88wq1pWigHo8zRXOyANVBBtu4LiUyP5MX7w4ndPvPoEm6DYYM5CBTJqAPlbFFJ2mA9Ws
         fQJY+aWw3PUdGEmEtyh1SNjYSzXzowvhvVAciyVjXHRePH9tDrEpwHC+QvfnF9SS84RX
         eklw==
X-Gm-Message-State: AOJu0YzCqByNwaf+LqgZ4aaQiEfOn6REd/bHltTJDme5vbfQAHrrdJaJ
	xKMuj0OTa7qJ4/DozndJFqh4CvJxTpn770jdSUccP35mMJfHwX8Iq9mevRRsk+TZyp1sdp01WwA
	StiM1wsNdtoLa7mlugou3qWLmUjf0T3Dy8loDE2Wn70+ASxWgFbBeGB8yN0uMSXvXcykDFaR5E8
	XJqhA=
X-Gm-Gg: AfdE7cmOSk1GGwbWVKD/WM1dfFS/1XOTsEVokRr5LXKAhzT/tM0Lqu0ek0Iz68wu/vf
	JQtFCn9mkCy4IumhGJuO/bDxifVHvHsjq11y++0uJNnrO99zqu5KoL8gGrDp8/XAVBi9bp7DAMM
	KzcJmA5s5PJYv381WP+5FU0r74AcOmAp6HzHOMgP/qyA5T+3aaeawj3PMF8kpoGBXPylOiI4ruM
	sdi2QWF2PDICkoJwwAgjgQKXym2+yb+zDFfTgtcYvFTZJUn5+of/ek91wGSaBjJpLxxC2qFX3JK
	6wziADX3Dix+/y9ol7PaqXIgU9rRPEu8OK7IVZar/wh1f1v5kP22SBd4devwqkWjaIrzao1bWUI
	0D5WL0SsjxWQWEB7/htV+aXdfZMpYetF7MROtBOU1
X-Received: by 2002:a17:90b:58e5:b0:387:e0db:bc32 with SMTP id 98e67ed59e1d1-38942692cffmr2968519a91.40.1783520316257;
        Wed, 08 Jul 2026 07:18:36 -0700 (PDT)
X-Received: by 2002:a17:90b:58e5:b0:387:e0db:bc32 with SMTP id 98e67ed59e1d1-38942692cffmr2968457a91.40.1783520315537;
        Wed, 08 Jul 2026 07:18:35 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5982sm22665427eec.5.2026.07.08.07.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:18:35 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 2/3] doc/org.bluez.ChannelSoundingRanging1:Add references and examples
Date: Wed,  8 Jul 2026 19:48:18 +0530
Message-Id: <20260708141819.1284821-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708141819.1284821-1-naga.akella@oss.qualcomm.com>
References: <20260708141819.1284821-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE0MCBTYWx0ZWRfX8Ef3ht+1ywqa
 pLBT7RWjER0/H0g9TvWQP3qdJZ18AZ2AkBAKgHkWVllUTkWRF4RIw6xNeBtFka10soOqNlJr9CE
 xdyIWoso4s05qHmAIN0hRKVzO/wBxX6rkm8jLWw4nx23imBiYtDAR3k/mujcbKkJ+GBwfyNYoT6
 uTUgmDjdxPl657C18KZ1jLDobhadKInMQF83XGAMfJTz/1cV7SrFTJlCa33uydlNzZYtIuPWvY0
 LXPGVVV+O7j7ST/SiMoBGcO6m0sEdRr8evCtqvj8Ac8mGQh9mwwGaXBMpY/mVd9LOsR5Jqr/F/d
 xrd1EfWwgVSoRcLTfCXwIgnZpHCaoI2JqeZZMRsiwnS3KsJfWYYA88Ilbr9nW3Gyv+oTSKrXzkk
 8bl4Zt9kaTpR5/MvfXHmChrF3O8G73i/7WsW0XH3gnRYAaErNK7o1G2l9zMvurQArW7+wOdV+p/
 0K0UhX3mMXqChTfpIAw==
X-Proofpoint-GUID: 9YcQmS4wnqOWmJC7ZeRem2A3H1mKyM1b
X-Authority-Analysis: v=2.4 cv=TMp1jVla c=1 sm=1 tr=0 ts=6a4e5c3c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=wa7QpaTpAAAA:8
 a=VwQbUJbxAAAA:8 a=VtwmZpwU3GMrFe7YWn0A:9 a=rl5im9kqc5Lf4LNbBjHf:22
 a=ehqneT2-Ts4HTEaPPMaO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE0MCBTYWx0ZWRfX3QkUGk0+VlbX
 PE0Nzp4XcEH4ZB5wBFC2xTjwn8mN0IoOmEBJoFf96NgiNKw2IBvmdfZyRF78BvQpaFdcj0Ci8MD
 mWrVy+bBJ5DhBJ+YgcX/RyhVch2+wq8=
X-Proofpoint-ORIG-GUID: 9YcQmS4wnqOWmJC7ZeRem2A3H1mKyM1b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080140

Add :Used by: field linking to bluetoothctl cs submenu and
Examples section showing the corresponding bluetoothctl output
for the RangeEstimate signal
---
 doc/org.bluez.ChannelSoundingRanging1.rst | 66 +++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 doc/org.bluez.ChannelSoundingRanging1.rst

diff --git a/doc/org.bluez.ChannelSoundingRanging1.rst b/doc/org.bluez.ChannelSoundingRanging1.rst
new file mode 100644
index 000000000..0151ac503
--- /dev/null
+++ b/doc/org.bluez.ChannelSoundingRanging1.rst
@@ -0,0 +1,66 @@
+==================================
+org.bluez.ChannelSoundingRanging1
+==================================
+
+------------------------------------------------------
+BlueZ D-Bus Channel Sounding Ranging API documentation
+------------------------------------------------------
+
+:Version: BlueZ
+:Date: July 2026
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.ChannelSoundingRanging1
+:Object path:	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+:Used by:	**bluetoothctl(1)**, **bluetoothctl-cs(1)**
+
+This interface reports distance estimates derived from Channel Sounding
+measurement data. It is emitted by an external ranging estimation daemon
+(**cs-range-daemon**) which subscribes to the ``ProcedureData`` signal on
+**org.bluez.ChannelSounding1** for every device object, feeds the parsed
+CS procedure data into a distance-estimation library, and re-publishes
+the resulting estimate as **RangeEstimate** on the same device object
+path. It carries no methods or properties of its own.
+
+Signals
+-------
+
+void RangeEstimate(double distance_m, byte confidence)
+````````````````````````````````````````````````````````
+
+Emitted whenever a new distance estimate has been computed for the
+device identified by the object path on which the signal is raised.
+
+:double distance_m:
+
+	Estimated distance to the remote device, in meters.
+
+:byte confidence:
+
+	Confidence level of the estimate, expressed as a percentage
+	(0-100).
+
+Clients that started a Channel Sounding measurement via
+**org.bluez.ChannelSounding1.StartMeasurement** and wish to receive
+range estimates should watch for this signal on the same device object
+path.
+
+Examples:
+
+:bluetoothctl distance output while a measurement is active:
+	| [CS] Distance: 1.234 m  Confidence: 87%
+
+RESOURCES
+=========
+
+http://www.bluez.org
+
+REPORTING BUGS
+==============
+
+linux-bluetooth@vger.kernel.org
-- 

