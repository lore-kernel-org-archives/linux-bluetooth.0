Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761482;
	b=Qrz9cOsAGaaqY3tdL+ecoFbZKxdXr2s6Np/LcnIvR8xbfKb1692TaerA9i76+sBKbxCY
	 OdT62yC+Oez3lybKvTgpuy0xewX6WMABTMN5cy1FOlHZIHKlEa22HSvOirrYQthQCA9qe
	 AL2MKX7JIU8UEiR6TejJwDQ5urvjm+P00rJHqN2ya5WzFStnUNOCquJSOxi4LFgFPT87l
	 VNGsTHcnwkBe64JWZMMD1L5olzKAswF0KNEKvJngihDNCYhdKV1OfIMJNU35lzMbcxWV8
	 6jQ2R8njt/UptkCTxtL6Sh1zAW4J3suEXmwS0Tg3x7F/xNryMb3cxiXmj9F0CwflhhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761482;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=J59q1RuiLOcFlIcpyBZNyQXF9Ce6bIhyN3klDyXNyhI=;
	b=y1ktRM8pO6HzTiNumB/gmdiQO9W3mVNSaRJZ2RjBJSHhCNkKryo5t3rUnHEnDMMppYXG
	 MukmAFH0IXyQhFPgDzMqmBUa4gMEArEY1aNuVm3QPtXc8yTGlWJ8/egf4SgFMTAU1wvhF
	 LE4bHz6rXSOPd8x5C7DOrG4CVeZ1lPA8hCpaqq5YKHS2x2QDzas9+68qlfAEbDeXUwbBp
	 nu8YUpnOc3d+o1OoNRb8ewkzBZNMOuPUjK2a8VFwibs2qz0D77vtEGEnyBSX9ZbkGRmVf
	 857+hImqRvUU5eKqj9VZP1Zh0yp6TOIZRnaXf4VENjl3ULoWnMGt3/4yWDNKP2DLMyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gv37S5hp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="bm+LAiA/";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7B3606A31B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 03:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B7B3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gv37S5hp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bm+LAiA/
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A40R0K41191067
	for <linux-bluetooth@vger.kernel.org>; Wed, 4 Nov 2026 03:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J59q1RuiLOcFlIcpyBZNyQXF9Ce6bIhyN3klDyXNyhI=; b=gv37S5hpsKopKbfs
	aIcALoYD3Av36+AL7Nvm6qdQImQiCKLWJbFrh+QSL8ezlgj3GCojljigoPUFdzyX
	bzPDOeP6olGM4nWOzcE7lm2i6BJStcsbk2aDgWyV1rbZGPcaje/srup7/7vyJxvm
	nk6n+pUOUJwoQ3vW59wkINRxJa1MPilWlvNQDSAGIPVTdBMX42jDWfHt8D509eXk
	QV6T2hkHgzx8eIkoaUtiWE99qvMcpKDtYkcoJXNggFgZERrjiKjWk1/JdAsSxbdv
	2AOYQVwxYwFeXhBVolvyUiTQ80C94RjlHjBILe0CAXIJ+utVvH8spDD2nsVdUnRr
	pEb10A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqm2phyhb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 03:04:41 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cdac8b7169eso183777a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 19:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793761480; x=1794366280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J59q1RuiLOcFlIcpyBZNyQXF9Ce6bIhyN3klDyXNyhI=;
        b=bm+LAiA/QGsh3NunjkWJ2+RR36h9jjOojHM5Jj1lFgr5/K5Nz2XJKFJ/bPz1qQgTDb
         Fk97M65xw73bWfll4evo3lXrGG5CpJ4Japp0uMT+2lSWiDV5ur55bkOQxIP6/4BNb8rm
         2Dveb6XhmzZMeA//TY66EZTjZkhZmJo2kW7RJT07tbG/oFAynoOw6pJhKsH05NnaBsZu
         M0iMeL/pj2QdL7VEpM5Moxa8vHqUU3IsCf4c80J9cVKHfs4kBbXtngU+UQlivh3o8Bus
         ENPieQ5sxZ331pUKLHLjzj6tR5lGzQ2PYNWBaRrFp4m6DIdbR3ItA9LI2POvfzyM1Vop
         rq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793761480; x=1794366280;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J59q1RuiLOcFlIcpyBZNyQXF9Ce6bIhyN3klDyXNyhI=;
        b=GPnEVsKOJly6eFMv8nNUovhM2vMljO0tK8GaYYNKPA9cIfN59XbFO8TOptYgoFeugu
         Ilt540cqeHJh38bJrRiRv1osVSx79HRsgw/2gy145b9FiTpL6KDGtx+kpr+zww03ydFI
         4vGw0vE4LpdASWhwFE4q8p1c6gBe3AEtJsHsVCD3IDIrVj0pz3lq4XkKeaoKSoCKRlNw
         B2F5pwMITCJnb2YvLLLLEWKpdnjEL4vujKlz+V2KAHdW57pgP6Ac4U3m4PvhRU2Q18nS
         1eOku4j4scRb8VqaQt54L5++so0YAqKuVeiCMsuBEvXIiTXrq+c8DAo2xIXWCKVw+SAB
         4JVA==
X-Gm-Message-State: APuU4Z+j738AwyznUlcQfS4hFWDc+Mqowg7IYLJP3V/YXxwebxbok8TB
	KIsXJTZUTzsXeVMMFRmJsn1mVGT6DqocuXlG9TX5CGUACUBj/zvl4vIXndeQU+U2GNxF9+MO/ka
	JeCkm9Ko9AxezFmvWPWtAhK+wsHJhh2YUhWNqYHtJ/JkVg1iuy4aM5PZ2Ynns9OSkImA6gmHxbY
	ni5eM=
X-Gm-Gg: AYBFou35j2KypG7AmUIWgLmCTRW6yfChpj/vftCpMjoNRbSj45XuvUl1jLnQSbbyV8z
	zBbv0d3/OBa6HTbLFfewAUabhazCfhfmqKX+dzIhrceyQ7bEZEtB+eo2KalTel0Bf/2SYgmiW8s
	rERk07XRAPhRKLIhL42SEzq+NirFqBeGFXeOxSu8tgrShPPG19E7iBQvHZ27xsMem9B7F8VRZum
	9NnfGpcdIAhqAArLVrupyN9bcKosHvvsaUYBIESTiHeWR+dScJNe4Pkf6BeUVYZoT+qEgzRgj8R
	wevH4iZrsR9oWKg2aRvT8+e+7XK9a/0Xijz9fiMNvns/BTPqOIMB+dAg+Tcu8e/7eoq8HCIqGSy
	osGzEX5SQvDFaqP4nS8aiyZ9lIKS/uoTkQCq8yegIuS1veapyCa6wlmtDaAENxj5eHpc+c2LQ8r
	Su
X-Received: by 2002:a05:6a20:2583:b0:3e5:396d:1f89 with SMTP id adf61e73a8af0-3e928aacb12mr14142285637.6.1793761480257;
        Tue, 03 Nov 2026 19:04:40 -0800 (PST)
X-Received: by 2002:a05:6a20:2583:b0:3e5:396d:1f89 with SMTP id adf61e73a8af0-3e928aacb12mr14142250637.6.1793761479640;
        Tue, 03 Nov 2026 19:04:39 -0800 (PST)
Received: from [10.231.217.127] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46443d6esm380516a12.2.2026.11.03.19.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 19:04:38 -0800 (PST)
Message-ID: <5941ceab-3f38-4d11-bede-054898c8680e@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 11:04:33 +0800
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 00/15] Channel Sounding and RAP fixes
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com,
        wei.deng@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com
References: <20261102081913.1623864-1-cheng.jiang@oss.qualcomm.com>
 <CABBYNZKjiVFVgNxxjTGYKBD0kZD=bQc6kbavcV=6cHGirBgMGg@mail.gmail.com>
Content-Language: en-US
From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
In-Reply-To: <CABBYNZKjiVFVgNxxjTGYKBD0kZD=bQc6kbavcV=6cHGirBgMGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAxMSBTYWx0ZWRfX3lRbHTjLTLlE
 h1zCxgZWiwoK/tJu8rtBy/n2R9tH+rKFsxMoC/2aGo8OOt/JGAcWLdWKpdu20lQGgJKI+/9YpnW
 FexkpLeB8khZPrX2lNgS1PP0fw24xGhxc5vUaON02lhkexvMEwP9AL/yc9NXfds9eJJcF5AI3uC
 YRiKWNMhrcJOMBOpN3To0MQOqy8IHJvhWlxEQnnrH3S0Zt3Mwh+Tzl38Rt7MZFPG97wR6+7N99C
 88oVYI8ESFY0DKLxwuZVtKElIIZtRvGgSWROKyM0B3mJcD/MN3vuyqSpG+pgrlfPsiNXvTPYWrK
 AaHml1nc7hc3wVG4/k2Gw7isdSfNTJotpX7s83gy5QCiyz6ZQ1G+os99aVzbXX/a0XFD1G7DQ9F
 1ZzSFk3jrII4bTLGLdn725ZfU3/ysVTQBaxx2CAJAe9LssRC1u0IuXPvzA6sQuRPPpdra1LlUXL
 a0wtIx+GnnD6tYxPOyQ==
X-Proofpoint-GUID: Xlk9EA-yrYfrsa1blmnYh-JTtjmThPjW
X-Proofpoint-ORIG-GUID: Xlk9EA-yrYfrsa1blmnYh-JTtjmThPjW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAxMSBTYWx0ZWRfX3a81Bfsg6zqD
 Sg/mWXE+EvFGMiwtscdl1uagf9exWqC1uYSjMyonGVI+JN1qqREHGiEeZscj6p/y+dHAKb2TARm
 ENuqQINtF890JpQTF8u/jsDFhhLMmgE=
X-Authority-Analysis: v=2.4 cv=c64+0h9l c=1 sm=1 tr=0 ts=6aeaa0c9 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=SFbVVHpyxijAfi_Ti1wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040011

Hi Luiz,

On 11/4/2026 4:38 AM, Luiz Augusto von Dentz wrote:
> Hi Cheng,
> 
> On Mon, Nov 2, 2026 at 3:21 AM Cheng Jiang <cheng.jiang@oss.qualcomm.com> wrote:
>>
>> This series fixes problems found while running the RAP Requester (RREQ),
>> RAS Server (RAS/SR) and GAP CS test cases against PTS. So far the
>> Channel Sounding code had mostly been used between two BlueZ devices,
>> with the local side creating the configuration as the Initiator. The
>> test cases also cover the Reflector role, a configuration created by
>> the peer, peers with different antenna counts and every Ranging Data
>> mode, and most of the fixes are for those paths.
>>
>> The patches do not depend on how the CS session is created; they apply
>> to the existing session set up from the RAP profile probe. Creating a
>> session for a peer without the Ranging Service is a separate question,
>> which I sent to the list earlier and is not part of this series.
>>
>> GATT database and RAS (patches 1-4 and 15)
>> ==========================================
>>
>>  1. A device removed while disconnected kept its CCC state in the GATT
>>     database, and it was restored when the device paired again. Drop it
>>     from device_remove().
>>
>>  2. The Ranging Counters read from Ranging Data Ready and Ranging Data
>>     Overwritten are scoped to the connection (RAS v1.0 3.4 and 3.5),
>>     but were never cleared, so a new connection read the counter of the
>>     previous one. Clear them in bt_rap_detach().
>>
>>  3. On-demand Ranging Data was always subscribed with notifications,
>>     while the RAS Control Point, which only supports indications,
>>     followed the requested transport; with notifications no On-demand
>>     transfer could be requested. Follow RAS v1.0 Table 3.1: the
>>     requested transport for On-demand Ranging Data, indications for the
>>     Control Point, and indications for Ready and Overwritten whenever
>>     the server supports them.
>>
>>  4. Reading RAS Features subscribed to Real-time Ranging Data at
>>     connection time, when no procedure is running yet, so the 5 s timer
>>     disabled it again. Subscribe when StartMeasurement() is called
>>     instead, unless SetRangingDataMode() already did, and use On-demand
>>     when the peer lacks Real-time Ranging Data (RAP v1.0 4.4.2).
>>
>> 15. RAP v1.0 4.4.1.1 counts the 5 s Real-time timeout from the start of
>>     the CS procedure, but the timer started when the CCCD was written,
>>     possibly seconds earlier. Start it from CS Procedure Enable
>>     Complete.
>>
>> bluetoothctl and shared/hci (patches 5-6)
>> =========================================
>>
>>  5. Fix a use-after-free in the StopMeasurement() reply of
>>     bluetoothctl, where the Active=false property change had already
>>     freed the session.
>>
>>  6. bt_hci_get_conn_handle() always listed the connections of hci0 and
>>     took the first link matching the address, which could be a BR/EDR
>>     ACL or an old link being torn down. Use the right controller index
>>     and match the link type; this adds LE_LINK to lib/bluetooth/hci.h,
>>     replacing the local copy in hcitool.
>>
>> CS role and setup in profiles/ranging (patches 7-14)
>> ====================================================
>>
>> These depend on each other and are best applied in order.
>>
>>  7. StartMeasurement() returned early for a Reflector, so it never ran
>>     the setup phase and dropped every event the remote Initiator
>>     drove. Run the setup phase for the Reflector too, subscribe to
>>     Ranging Data as for an Initiator (the RAP roles are independent of
>>     the CS roles), and do not send Procedure Enable on stop when no
>>     procedure runs.
>>
>>  8. With Role_Enable permitting both roles, the GAP role decided which
>>     one was used. Since the setup phase only runs from
>>     StartMeasurement(), take the Initiator role, and tolerate the LL
>>     Procedure Collision that two simultaneous configuration requests
>>     can cause.
>>
>>  9. Config Complete overwrote the Role_Enable value with the negotiated
>>     role, so a second StartMeasurement() sent an invalid Role_Enable.
>>     Keep the two in separate fields, and do not send Procedure Enable
>>     from a Reflector.
>>
>> 10. Config Complete was only parsed in the state reached during a local
>>     setup, so a configuration created by the peer was dropped. Parse it
>>     in any state, ignore events for other links, and ignore a removal
>>     whose parameters are undefined.
>>
>> 11. The Set Default Settings response rewound a setup the peer had
>>     already advanced, and an Initiator then created a second
>>     configuration. Only advance from the initial state.
>>
>> 12. CS Security Enable needs an encrypted link (Core v6.2 Vol 4 Part E
>>     7.8.133). When the configuration completed before encryption, the
>>     command was never sent. Defer it to the Encryption Change event.
>>
>> 13. The antenna configuration was always ACI 7 (2:2) unless the
>>     application set another, which a single-antenna Controller on
>>     either end rejects. Choose one that fits both ends' capabilities
>>     and the negotiated role (Core v6.2 Vol 6 Part A, Table 5.3).
>>
>> 14. A StopMeasurement() during the setup phase did not stop it, and the
>>     Initiator went on to create a configuration and enable a procedure.
>>     Remember the stop until the next StartMeasurement().
>>
>> Testing
>> =======
>>
>> Each patch builds with --enable-maintainer-mode and unit/test-rap
>> passes. The PTS runs (PTS 8.14.0, Qualcomm controller) used a
>> BlueZ 5.86 based tree carrying these fixes.
> 
> We really need to start testing with test-functional though, since
> unit/test-rap only test bt_rap itself, it is very tricky to do a
> proper verification if these changes don't break anything since we
> don't have any functional testing coverage yet.
Thank you for the comment. The current changes have been validated with 
the BCS certification tests using a BCS-enabled PTS dongle.

We’ll also run end-to-end tests with a BCS-supported remote device to cover
more functional scenarios. I’ll share the results once the testing is complete,
and then we can decide whether to merge.

> 
>> Cheng Jiang (15):
>>   gatt-database: Drop stale device state for removed bonds
>>   shared/rap: Reset the readable Ranging Counters per connection
>>   shared/rap: Subscribe on-demand data with the requested transport
>>   shared/rap: Subscribe to Ranging Data when a measurement starts
>>   client/cs: Fix use-after-free in stop_measurement_reply
>>   shared/hci: Look up the connection handle on the right link
>>   profiles/ranging: Let the Reflector run the CS setup phase
>>   profiles/ranging: Let StartMeasurement() pick the Initiator for Both
>>   profiles/ranging: Take the CS role from Config Complete
>>   profiles/ranging: Act on a CS configuration created by the peer
>>   profiles/ranging: Keep a peer-driven setup from being rewound
>>   profiles/ranging: Defer CS Security Enable until the link is encrypted
>>   profiles/ranging: Choose the CS antenna configuration from both ends
>>   profiles/ranging: Do not start a procedure after StopMeasurement()
>>   shared/rap: Start the Real-time timeout when the procedure starts
>>
>>  client/cs.c                        |  40 +--
>>  doc/org.bluez.ChannelSounding1.rst |  21 +-
>>  lib/bluetooth/hci.h                |   1 +
>>  profiles/ranging/rap.c             |  16 +-
>>  profiles/ranging/rap_hci.c         | 414 +++++++++++++++++++++++------
>>  src/device.c                       |   3 +
>>  src/gatt-database.c                |  25 ++
>>  src/gatt-database.h                |   2 +
>>  src/shared/hci.c                   |  12 +-
>>  src/shared/hci.h                   |   2 +-
>>  src/shared/rap.c                   |  82 +++++-
>>  src/shared/rap.h                   |   6 +-
>>  tools/hcitool.c                    |   3 -
>>  13 files changed, 484 insertions(+), 143 deletions(-)
>>
>> --
>> 2.43.0
>>
>>
> 
> 

