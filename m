Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF8915C13F
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728897731; cv=none; b=YdDt+/ARuNbYMpihQ92HlY4p9e7Mzu6kWhk42uxlJS4vIOgF4uwoicWLCYagsvvXTUlUjIqz8huMrfwUNxE8nBS71t/hNszbvBC0lt8gR9Gmj4yngYJTgDK5wpzyN4fIXFrB2ASHpkpmv+At6F4aihQXAAndUahEarh9MCAs8OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728897731; c=relaxed/simple;
	bh=qxIGLf6UNW0lg/s5/CTzyks/yK6DG5PY+aNcNZpLkSY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=K7xYEbaRTrh+k1fZsjzGX5JzV8ruQoo6xza0xWqERY0L3FC8g/6+6z6wdax9yCsfM8ZMFNnV4wtdURelKd1ttdVBIlMEH0pisaQBOT9QfD1K0ReWNhYvvMiYdfTDRwb3FaUFwFypIokdJtH57V+yUmDBjCBqK3VpJ53QlYNDA8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KfS62xnG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KfS62xnG"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49DMMXud031475;
	Mon, 14 Oct 2024 09:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=l9fRyXm/onQxSe6tm4WSv2
	5+U2z3a0WF6kWSG8B7WfE=; b=KfS62xnGS7hbYFp+DifBMUM7J0ITqMRR3Ylyo0
	EAAkVC6JLUzUj1EZVQ6YHqFMbvlpQvkxVsRjp3WRXuUIyD7s55iN//N4/8QlqkBp
	9zVaF7bQ9QlhDa1pTKQzjJ7jiTongYT1u9yxZ4NvKR4D9ABhhI5r4Z0ic3fPyytv
	UOgtBbwhmGpmmm4oiAMz6cKw1OBbXZBIeDAHCmLxqlHIiMAunHc/3RUwrX8Y3G6P
	tGM0aIg8yXl5uB1krpV6uRKwtpgEmgT3urRWVksd4+q/RusyDeJJKWMe81dso4Cz
	d7wgyFLRLnzS83U+joAhIBV5Qy5DFXDfMcB3NI7Z6ATynBqQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 427jd8uunc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 09:22:07 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49E9M7xc013365
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 09:22:07 GMT
Received: from [10.218.8.166] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 14 Oct
 2024 02:22:05 -0700
Message-ID: <5c89e37e-9ac8-4fb9-91a4-8bb4a3cb458f@quicinc.com>
Date: Mon, 14 Oct 2024 14:52:02 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Raghavender Reddy Bujala <quic_rbujala@quicinc.com>
Subject: Observing A2DP disconnect from ubuntu for incoming connection
To: <linux-bluetooth@vger.kernel.org>, <frederic.danis@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LAlDKLfi6GZt7Ig3DyH-ayrd11R4Hnwi
X-Proofpoint-ORIG-GUID: LAlDKLfi6GZt7Ig3DyH-ayrd11R4Hnwi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140068

Hi,

we tried connecting rpi and ubuntu device from iphone.
observing a2dp disconnect from ubuntu device sometimes.

connect and disconnect ubuntu device with iphone multiple times.
after 3-4 repeats, we were observing a2dp disconnection in ubuntu device
due to disconnect timer timeout of 1 second.

same scenario we have verified on raspberry pi device, tried several
times and it didn't failed in any iteration.

observations:
pulseaudio versions on ubuntu and rpi varies as below
ubuntu v15.99.1
rpi    v14.2

there is a difference in pulseaudio with respect to sbc codec.
In 15.99.1, it supports different types of sbc codec settings like
below
https://github.com/pulseaudio/pulseaudio/blob/v15.99.1/src/modules/bluetooth/a2dp-codec-util.c#L68
     &pa_a2dp_endpoint_conf_sbc,
     &pa_a2dp_endpoint_conf_sbc_xq_453,
     &pa_a2dp_endpoint_conf_sbc_xq_512,
     &pa_a2dp_endpoint_conf_sbc_xq_552,

In 14.2 it supports only single sbc codec setting
https://github.com/pulseaudio/pulseaudio/blob/v14.2/src/modules/bluetooth/a2dp-codec-util.c#L33
const pa_a2dp_codec *pa_a2dp_codecs[] = {
     &pa_a2dp_codec_sbc,
};

as number of capabilities increased in pulseaudio v15.99.1, it is taking 
more time than disconnect timer(1sec)
in processing getcapabilities and due to this timeout a2dp signalling 
starting again from ubuntu device,
at somepoint both setconfiguration collides and leading to a2dp 
connection failure.

logs:
Oct 14 11:42:19 ubuntu bluetoothd[3654452]: 
profiles/audio/a2dp.c:confirm_cb() AVDTP: incoming connect from 
DC:B5:4F:A0:78:7F
Oct 14 11:42:19 ubuntu bluetoothd[3654452]: 
profiles/audio/source.c:source_set_state() State changed 
/org/bluez/hci0/dev_DC_B5_4F_A0_78_7F: SOURCE_STATE_DISCONNECTED -> 
SOURCE_STATE_CONNECTING
Oct 14 11:42:19 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP: connected signaling 
channel to DC:B5:4F:A0:78:7F
Oct 14 11:42:19 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP imtu=672, omtu=1004
Oct 14 11:42:19 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:set_disconnect_timer() timeout 1
Oct 14 11:42:19 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:session_cb()
Oct 14 11:42:19 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:avdtp_parse_cmd() Received DISCOVER_CMD
Oct 14 11:42:19 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:session_cb()
Oct 14 11:42:19 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:avdtp_parse_cmd() Received  GET_ALL_CAPABILITIES_CMD
Oct 14 11:42:19 ubuntu bluetoothd[3654452]: 
profiles/audio/a2dp.c:endpoint_getcap_ind() Sink 0x562abb4990c0: 
Get_Capability_Ind
Oct 14 11:42:19 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:session_cb()
Oct 14 11:42:19 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:avdtp_parse_cmd() Received  GET_ALL_CAPABILITIES_CMD
Oct 14 11:42:19 ubuntu bluetoothd[3654452]: 
profiles/audio/a2dp.c:endpoint_getcap_ind() Sink 0x562abb492ec0: 
Get_Capability_Ind
Oct 14 11:42:19 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:session_cb()
Oct 14 11:42:19 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:avdtp_parse_cmd() Received  GET_ALL_CAPABILITIES_CMD
Oct 14 11:42:19 ubuntu bluetoothd[3654452]: 
profiles/audio/a2dp.c:endpoint_getcap_ind() Sink 0x562abb45c1d0: 
Get_Capability_Ind
Oct 14 11:42:19 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:session_cb()
Oct 14 11:42:19 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:avdtp_parse_cmd() Received  GET_ALL_CAPABILITIES_CMD
Oct 14 11:42:19 ubuntu bluetoothd[3654452]: 
profiles/audio/a2dp.c:endpoint_getcap_ind() Sink 0x562abb474890: 
Get_Capability_Ind
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:session_cb()
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:avdtp_parse_cmd() Received  GET_ALL_CAPABILITIES_CMD
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/a2dp.c:endpoint_getcap_ind() Sink 0x562abb46acd0: 
Get_Capability_Ind
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:session_cb()
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:avdtp_parse_cmd() Received  GET_ALL_CAPABILITIES_CMD
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/a2dp.c:endpoint_getcap_ind() Sink 0x562abb488cc0: 
Get_Capability_Ind
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:session_cb()
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:avdtp_parse_resp() DISCOVER request succeeded
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:avdtp_discover_resp() seid 1 type 0 media 0 in use 0
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:avdtp_discover_resp() seid 2 type 0 media 0 in use 0
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:avdtp_discover_resp() seid 3 type 0 media 0 in use 0
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:avdtp_discover_resp() seid 4 type 0 media 0 in use 0
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:avdtp_discover_resp() seid 5 type 0 media 0 in use 0
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:avdtp_discover_resp() seid 6 type 0 media 0 in use 0
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/a2dp.c:discover_cb() version 0x0103 err (nil)
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/source.c:discovery_complete() Discovery complete
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/media.c:media_endpoint_async_call() Calling 
SelectConfiguration: name = :1.2921 path = /MediaEndpoint/A2DPSink/sbc
Oct 14 11:42:20 ubuntu pulseaudio[3923256]: D: [pulseaudio] 
bluez5-util.c: dbus: path=/MediaEndpoint/A2DPSink/sbc, 
interface=org.bluez.MediaEndpoint1, member=SelectConfiguration
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/a2dp.c:a2dp_config() a2dp_config: selected SEP 0x562abb45c1d0
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:avdtp_set_configuration() 0x562abb4bc510: 
int_seid=8, acp_seid=1
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:avdtp_parse_cmd() Received SET_CONFIGURATION_CMD
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:session_cb()
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/avdtp.c:avdtp_parse_rej() SET_CONFIGURATION request 
rejected: Configuration not supported (41)
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/a2dp.c:setconf_cfm() Sink 0x562abb45c1d0: 
Set_Configuration_Cfm
Oct 14 11:42:20 ubuntu bluetoothd[3654452]: 
profiles/audio/a2dp.c:invalidate_remote_cache() Invalidating Remote SEP 
from cache


Tried with single sbc configuration and commented out other 
configurations, then we didn't observed any a2dp disconnect
issue on ubuntu device.


version details:
bluez       5.65
kernel      5.15.0-91-generic
pulseaudio  15.99.1

Is there any workaround for this issue?

Thanks & Regards,
Raghavender
