Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15A0175A73
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601525; cv=none; b=CLPYZnfkB8xavY8HMYcud5oS5KqBlhl5RjajO9kjaxolnFjjILR0o08wNfbyNdh8nVFrp3do0vO24QEo+VP0msl1imnwPzJEVRfGSi1dIxxO5faYXySQDp1GB/nwLrkfGPEVCnUpInJJS/Sosybgw1x8V7S8xP0+hf0N6Xz6l88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601525; c=relaxed/simple;
	bh=N8oV1ye3kyRVmWb89WE0bg6k1Y9JF8dAPIWQxWyJUBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SCCyzh+niU48cFRkTfz9y0ZN/95XhfqboX11wUASV4PASXc6mjBMx2Wxuw58xehVOm7fUnZ4kxbXWEp0dO+TQk+yQZhvHTTN8MqzwtskGZZbHrznGsS3hfc+Bqsqej0W4R4WpjMRMJJmGa70s6yEETyld32aO3SFMB/9dw3Q25A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n3eCXR6h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X1izc2wa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n3eCXR6h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X1izc2wa"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669BNcxs1489278
	for <linux-bluetooth@vger.kernel.org>; Thu, 9 Jul 2026 12:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3l2OMlA4C7U
	cIBdpwe30DowJhL8nzE3Mqi2PJDoB/4Q=; b=n3eCXR6hA1h+24fE3/NKBon483L
	O4C7PDYTNoZX9/SAoLQ3jS8lWHSboDZ6L5V1keRMngiubORaeyivM+66Usp40XKy
	neN/ySRYA63TPg4bI1kY0MU651Frlqvnxg8WdCxMUEXGYORfSpjKIuZhSNc5iGMZ
	BClhi4TWA4tSQjtEjlhuqgyZ0hqy9pS+iH3Wd6/ut8XkYZaVYm0nnytrAw1L5E8b
	cfFPREMzF2CfcJsp08VA5j4o+Go+M1bTV5+fMyYtAzzZSsLs0vt5A2cOcxH9mSjc
	PgjlqhkUzPUW6H3+QNfKvl01xdb+IBfC4AyEH4p2hxxzdQ5BM5hO7kY8uVg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9wwfu8dw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 12:52:02 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3855a987c0aso2362578a91.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 05:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783601522; x=1784206322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3l2OMlA4C7UcIBdpwe30DowJhL8nzE3Mqi2PJDoB/4Q=;
        b=X1izc2wa6Sn4Zfo0vQaTKPEjJ7os5IZxPPtHHyzF7+49+NJYOZOh8Bdgz0XTfWwzJ4
         lxonMTucwBbIeU/bvEzSbe6ImmfD0zatTpR/KJZkd98i7yULxYprsKYjh62NXy4enbMI
         mb0QN+ah9LOcLvNKU9G50L+P6ZwtLklejTUAk2rZf/oy28VhdiAGsMCGZ+XxFz9n6z4b
         kPDj/qF7jwtjNd4gBDrQEfZn1V1BJiQ4V8mWLtvtELk/gapJ8n4njcILvx6eyzpze36M
         79UKATW3cNIemLEERQjM9w82NwGll4mrMGUOMaR6Yb+fplacGwgYslxLccWQPnyCdsPb
         Il/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783601522; x=1784206322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3l2OMlA4C7UcIBdpwe30DowJhL8nzE3Mqi2PJDoB/4Q=;
        b=PAMy3qV4xrfz7cTls3vxDN7WDHdPcAkceN2WD72oe0zK+fBPv3tPse343IyvVUT9HC
         7xWOBY8U4qGWhzPmzj4RD57CvxN+v5wEccjRU8T1oa6DDPZ3TBy63x5Qnt9PiwjFpyUt
         Bu5HdjLupS5kant8D/OxXLu+HHq4G7iO07hZnvdrDzobr/2olPmKKlmn91TSdjHffeGx
         CZ3kZ2Cf/JT5il5ul8r8NWTnK1BKWuvTEAmyVvWMEUAapCrkMahXFII2scaZhzc1tEfo
         ZcjEPVIS7ttCo5GaXvOFkqldLBYGXDD8avchiHhAYrRzqW3pURaC4z09AzfSwXviQCEI
         Z7Og==
X-Gm-Message-State: AOJu0YyIUDmAeMDlygysQ1zdipZq47wWBDH6WHhcM8ud0JieugLV9+f9
	nwJoK5gcCRz0v220kQpDDH60d0lD2T45GnLojOqIU3F5hciCX5bUzLnDoZlNwHagTLPSyH8g1bV
	XpmbBcPVF9lrgeMROnw7o4+3M53snUmI8VGXaxRrdBa3lCwcBfE3er+KoN/cZpF9Zsp/rhQ/2J8
	BwKmY=
X-Gm-Gg: AfdE7clCbU4QvWreHl7sba/PCmbcdFRq95aZ1Ixgv5k2xp79pwRygFotesQBcBz0a76
	FQ5ovUyGKLQiNM2rNu5i4FIx4uD4OkZy9gNyFL4Tsqnh/CSOIui4UVzXx/Pz73tnKegyMRoVi1C
	LTqwnFaAP7qegLnjd8NE7x408MIl06t2lnUnhsDCc+SmhjwS25kQv388HMly/sq454D+q2niOSS
	FGun3o0I+W8kqegufo65GvSpSMls7CRtg4QGQcUzf62tkCk0tk5YbmRFAtGXaXTnxVQyKBdsKQt
	d9calz11eWwpY8V2/bdi5ZIWnvBKj7OhEV26hCZtz07abjEaSUT0I5o3ZIhl+0w6Z1sTuMec4DE
	6cTqiTd0ddWVeFOBVoQu7XVriaMuqbTj0Su8M1d98
X-Received: by 2002:a17:90b:54cd:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-3893fe5b650mr6915812a91.9.1783601521740;
        Thu, 09 Jul 2026 05:52:01 -0700 (PDT)
X-Received: by 2002:a17:90b:54cd:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-3893fe5b650mr6915781a91.9.1783601521091;
        Thu, 09 Jul 2026 05:52:01 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm28875679eec.18.2026.07.09.05.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 05:52:00 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 2/3] doc/org.bluez.ChannelSoundingRanging1:Add references and examples
Date: Thu,  9 Jul 2026 18:21:41 +0530
Message-Id: <20260709125142.2655974-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709125142.2655974-1-naga.akella@oss.qualcomm.com>
References: <20260709125142.2655974-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEyNSBTYWx0ZWRfX3LDxhftfDK7s
 Bpu9HuOJvXLiCpvBPZ58MtVeeLs2fFfRs4z23UJerA+7Vm6917iA4Wil5uM0gSb8Q2q1FzJANLL
 LFIbEf1wHLCGal0sHIfFivSocCPulk+eXm7cFv+f3D0wwgfcmALN1VW9fxvlaHtLkkS1Z55HodS
 7v4+XDn4WfFJfMrKDEPZ4X9AQL9fOI2Ul90NnbLiTYDlLWdb6nozh0beRxrzDz9PV4lGG2JndvO
 7OJR8gKDkrR/ZIQGjhgrTY/6F4r2tQ7ZIB9pUW++W8UnlficdhechCBO38XaafdjBM/8YhgadMX
 bLWZ87+Yb5Hw5SHxrRCtdXE+8J4Y5aBbiHwspSHGWw7ymE++PmT4nFNt8x2bLuoM/SrKzWPkEPd
 ILZaHB2pJ3C1lrkOKQpPMfwCRtB12rya++SbEE/4G3VbUeHvdzYZsUFzGnYwfZP3r+0ukz5s2c5
 4KkYrFeql7LXU3Tux9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEyNSBTYWx0ZWRfXxJwYrrBplrQh
 1+yrRowL1y7xDLtSz0LqwkMfvGA3Rt1zOCwnBCL5LUmbpLzUK9yp+mTvhxvF5E/qpNOq0ygPmRj
 pFUIHiKwLw3InPJgKjUHnpYAJWwMTWU=
X-Proofpoint-ORIG-GUID: 6kgRN9PRdJgraKKWbhnLmH0rhQkEdDpy
X-Proofpoint-GUID: 6kgRN9PRdJgraKKWbhnLmH0rhQkEdDpy
X-Authority-Analysis: v=2.4 cv=Krh9H2WN c=1 sm=1 tr=0 ts=6a4f9972 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=wa7QpaTpAAAA:8
 a=VwQbUJbxAAAA:8 a=VtwmZpwU3GMrFe7YWn0A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=ehqneT2-Ts4HTEaPPMaO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090125

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

