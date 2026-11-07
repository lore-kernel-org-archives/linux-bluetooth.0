Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794035829;
	b=TcTNpihEIIs/HwL9xmCz1VcR8xV1ZmPSgxAhbEXMiXjcf6lblSSfzF4Tcv4rC5u0mqcJ
	 vyK6Tg7/HnUOh4Z60aLY/tZfjisJp0OlCoB93fQIFZBNuCxBLwwtsKfEkLUtjXrJSizq7
	 921a64Of6k3ROdYAAnGO2ovzVCn4hzW5QXo5g/k7LI857YBwaltn5fZfQtHfMprjCItQ+
	 pPiLUwWCOEPdEm1U10lJTjnqxQ5h9lcNh4QxywlkystU1XvWUt6ExMto+yyJwV9pF7B3X
	 KxuTt1uZnStr/FjtYW3YPi2bx8jyB6tRxfABoT65x2rVFwslkX80HJ4lZYjIOVxfjSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794035829;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=H9xsbynJQhEaJ/3HbmjiNS+dTo3w9nFytwU7E25SvA8=;
	b=o9E3wjBnr6ExE1TbHngoGpnbhKfHsIK5IJ+XuB+E5/5fd830218eEpHU0y2xUbweLQj9
	 6JCjf/MAO7iRrgCzaUlv2b707Z0zS1xOouJ++Vu5UVMnIt/OmbQNMZQ1NvFyI//2qwTDD
	 zWGgrzwU5csRTnPyA5h5VbPLRf0+C9l39esDoa77REZa3ZTy1U6L5Kf+ZyOnpPf6pA0rQ
	 eUZtIAczX+FwBvJNRpWgMHCDCfJuZzdKdaQdFzHQse7fiKOnSF5UyxyxA4E5YJ2F9N1Ah
	 Bggm6uxu/0S9rXmGWeLn0tNnOQROijqbyltUMVZ9zWYbCWQI4TZXeoPHJqusPvex89Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="KzLc+/lS";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jLux9zVO;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75DE606A32C
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 07:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C75DE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KzLc+/lS;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jLux9zVO
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A75eIjH2924064
	for <linux-bluetooth@vger.kernel.org>; Sat, 7 Nov 2026 07:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H9xsbynJQhEaJ/3HbmjiNS+dTo3w9nFytwU7E25SvA8=; b=KzLc+/lSWUml2+rq
	1WTkQVc68o845G87p69S4xaUjRpO+r5+o7abQJ3IfwsMjVW/6LVdPE/uuQ9kXOJu
	brCXuQSGQZla3DIBIFhTyhIQh/yjNGlNE0MWLxFYWvGWQgTRrqjbplineuKV8N4h
	PPSJv2r/iVs0gCB/B18vXxgAhamYJI4sq1zJkW7zpRT/JnitllGxSpvnLqYPxYcY
	YZC63inKp/dkWjsUUndk8S5MEl465qF9S2m2sTCKysK/uGRIU3pGCxy+RMtWaQLb
	gubgkPU2tuRrVFKjsR91iWkeQqH+9wKRyf5mKFSN/EEIICX6SE3orRL5oWvc/lwu
	ZioMzg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsspf0r2a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sat, 07 Nov 2026 07:17:07 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3aed37745bcso271979a91.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 23:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794035827; x=1794640627; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H9xsbynJQhEaJ/3HbmjiNS+dTo3w9nFytwU7E25SvA8=;
        b=jLux9zVOryrvJOZl85pydAz6JQlnJ+7TlhoYL+7ples2OyQX5nCSqfTMfc8RLR6Ilt
         v3JDeVrSYqo9zASq92vV7iQpjucmBZ/1huqZm6Z5y0PZM4R6tTh6bLhPd1jWhkx3gyXe
         0UGxVJeS7FGPCFMXjKQFG7cDQUktM0HrOd+R3sjQjXCvQrj1wIktqC7acrH2KNp1LH7n
         fKqxdwOmEEeNQFJ9HasZoPHw7sj0HRaPVCdeNDKujicevkxRy5o9JjL+e38clx784Kja
         e24fHOCPstzvJmmR+JuxywuipAjscXMwM/iUUhCBoEYrp1d3eJgwSH0h/ftwEWJCHrpA
         QuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794035827; x=1794640627;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H9xsbynJQhEaJ/3HbmjiNS+dTo3w9nFytwU7E25SvA8=;
        b=A+9NDoL2BhD/alRj+Aee5yb0d8BRuxK/GtxdzV9blyAaGLZs3Si7uhWiUcMky81W19
         fNPC29VybmS2XInwPza3jLFG9p3DRpGma/PKXVznJyj075hYNe+M6rPhUx4nbb3IFSYS
         IWYUqjFLKZP9jb7P0QWO+aGGkp5CshHV6dnfaafOVWBgF3dtlMTN5/Qq6qDd+E+rGR12
         Rpezal03A5WrBihAkK6N4+Pg3RwpTVp16AeRR6Gyknz6hBqH0d4ZOUV0zB7QkRDjbHSg
         ENt72DWsGCfHUbf61UYrM8blNjSGoSkZV5oB8X/DpWkNyYQQicHKDLmzeP5/yJnXP1D6
         D+1A==
X-Forwarded-Encrypted: i=1; AL+hErEuGFlPt8t51Bv6Sn4Znk+Hl1OUJASpusuy2FWcg5sS377lZl2T/SiNe2YdJQsW8o2JRA8cbVEPkLzL4CouvWg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hdXCBXuhlb2FCgbjmM9Ffv4l0Kt/SzxdeNdvoSzskksdWVexZ
	JRmCoB8DiyXLDibjD5xdzjyvCTFuZdredS8ke2c8LxiULHw60WkwGpv9gj+/zVqyMIskIFBTsPD
	cT6LdqOExknGKCoTZvqP9PwMm9xZxo8GObhrNObGj3qK7IE5qqi9TMpAe50G/cRt8fb0MNsY=
X-Gm-Gg: AYBFou3pLorkQ+GAHti7Yphhl7NWczC5MiiC9pSHzbMEGNgsS2UA2JCAdgi+c5Aj7Cf
	Qx8HU8cbkc/zTyvbYeuJeQIL86ju3ezV2akH5rO2NAh07ZtdZbTsl486lNuBUQJ20NWTae2rVX5
	1kMb59Gi8QgD9dcFIVKXgttIID7MVr308M0G/lbpE3GwpZcYnYSpjXsjz8hj12hCo9mivzw+hgp
	jntcMfGe3t734cF6spttOtBDZ+IS19VZGUCXnhGc3yomYUV+zCrJOV3xZUt+S345/fecAuXvbOa
	XCcpX5iOB3YD2TgjKshPYMrSFmmHjyhanfNKZHzg/JhMVi+0+1P9X3ExEmmTmbOiIBvyHs4I7AZ
	auw5tZEHSZTpq5z98nL2umrVTdcveMsgTH472KwoYc4JZuZyowhNyuvKdurZ44KhwJHRz2zSrvH
	s=
X-Received: by 2002:a17:90b:4c07:b0:3b0:a413:dd8e with SMTP id 98e67ed59e1d1-3b1068bc47cmr1044933a91.43.1794035827120;
        Fri, 06 Nov 2026 23:17:07 -0800 (PST)
X-Received: by 2002:a17:90b:4c07:b0:3b0:a413:dd8e with SMTP id 98e67ed59e1d1-3b1068bc47cmr1044923a91.43.1794035826641;
        Fri, 06 Nov 2026 23:17:06 -0800 (PST)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10588225asm2187339a91.8.2026.11.06.23.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 23:17:06 -0800 (PST)
Message-ID: <5637c611-69d9-4d16-b4c4-06fb794aecef@oss.qualcomm.com>
Date: Sat, 7 Nov 2026 15:17:00 +0800
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
Subject: Re: [PATCH v3 0/2] Bluetooth: hci_qca: Reopen port after power on for
 QCA2066
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, chejiang@qti.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
References: <20261028111839.2148515-1-shuai.zhang@oss.qualcomm.com>
 <ygy2hd47c3tb4vr2joiiy4bbg7rd4pn66x3co7iifv65cvnrf7@g36i65agh6p3>
 <561c0f8c-3252-4802-9d2c-ca1f93c65247@oss.qualcomm.com>
 <62qrp73oyhaismnbnb7q57z2loovfpwsut4t4bwy6vda2vaewc@sbifauqgi4jx>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <62qrp73oyhaismnbnb7q57z2loovfpwsut4t4bwy6vda2vaewc@sbifauqgi4jx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAyOCBTYWx0ZWRfXzimEvslZzhvy
 5Hwiw/qK7RUDsihQtBYu2h/aBdEeSEpRuaOO4wIyuxumd5e/Ui9HacWrJovQbupWQyxe8cayOdy
 W8w+VgE2/thjP97KPB9Hw2TtKbHApxg=
X-Authority-Analysis: v=2.4 cv=LJzz05W9 c=1 sm=1 tr=0 ts=6aeed073 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9anGb3dB1dyhe_3J-4kA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: pg-MQspz166koA8UbXN10e8BRpbSg4V0
X-Proofpoint-ORIG-GUID: pg-MQspz166koA8UbXN10e8BRpbSg4V0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAyOCBTYWx0ZWRfX5cappkCWwchS
 wgkK6MOsVv2qea80ZAzym1uePZccGjQ4zysVR3hj0/iY6ZJ9UBkZN/Oa2oDHqC2whsEdKKRi/lT
 OWaMXjGjSysbcoVVFvaMPSADjqrVKt/4+EVIHu1o8SzGqbQvA4xlCIGgtkpTSYvRUKj75LkakXA
 H8M8a0XFn9v6dJ8xDfGuWSW99CS2+mjZHPuhvlmkH66bK7TxTlVxhAebO17+uwsIc3SF6ia8QNJ
 eAQycFEz5c6Fr9Xp2+YoxOcpCJHJzM/2HmiOaNAkPPKr3WgmjtflW7d7hFmz86oopFr7XWMQQuc
 7ATBK0Wg6IJTB/kQTOyVPkqbHr/bP7wl9/kjyr2WD23JTDMWtIUCTGpZszGDumi/cl5OC9nj+2L
 94qJb7Do8byLejzaay0WL7ZFI/UYZSiwyQAlcgB7pL26pj7GMt25CrhRdQt/bTC4j9/y1ifnih2
 dFm6KfQSrhdBKpEz6zQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611070028

Hi Bartosz

On 11/6/2026 5:17 PM, Bartosz Golaszewski wrote:
> On Fri, Nov 06, 2026 at 02:35:25PM +0800, Shuai Zhang wrote:
>> Hi Bartosz
>>
>> On 10/30/2026 5:29 PM, Bartosz Golaszewski wrote:
>>> On Wed, Oct 28, 2026 at 07:18:37PM +0800, Shuai Zhang wrote:
>>>> QCA2066 needs the serial port reopened after the controller is powered
>>>> on, otherwise the host and the controller run into RTS/CTS
>>>> synchronization issues.
>>>>
>>>> Patch 1 reopens the port in qca_power_on() for QCA2066, as in v2.
>>>>
>>>> Patch 2 keeps HCI_UART_PROTO_READY in sync with the port state, so that a
>>>> port which failed to reopen is not closed or flushed again.
>>>>
>>>> Changes in v3:
>>>>    - Patch 1 is unchanged from v2.
>>>>    - Add patch 2. If serdev_device_open() fails during the reopen, the
>>>>      port stays closed but HCI_UART_PROTO_READY stays set, so the later
>>>>      serdev_device_close() and hci_uart_flush() use a closed port. Keep
>>>>      the flag in sync with the port state and skip the port flush when
>>>>      the port is not open.
>>>>    - Link to v2:
>>>>      https://lore.kernel.org/all/20261016022302.4003647-1-shuai.zhang@oss.qualcomm.com/
>>>>
>>>> Changes in v2:
>>>>    - Use a separate case for clearer logic.
>>>>    - Link to v1:
>>>>      https://lore.kernel.org/all/20261015092224.262158-1-shuai.zhang@oss.qualcomm.com/
>>>>
>>>> Shuai Zhang (2):
>>>>     Bluetooth: hci_qca: Reopen port after power on for QCA2066
>>>>     Bluetooth: hci_qca: Don't use the serdev port after a failed reopen
>>>>
>>>>    drivers/bluetooth/hci_qca.c    | 46 +++++++++++++++++++++++++++++-----
>>>>    drivers/bluetooth/hci_serdev.c |  6 +++--
>>>>    2 files changed, 44 insertions(+), 8 deletions(-)
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
>>> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>> Just want to confirm if there's anything else I need to do before applying
>> it.
>>
> Luiz uses patchwork, I'm pretty sure the patch won't get lost.

Thanks for the clarification. We need to revise Patch 1 and will submit 
an updated version. Please hold off on merging it for now. Thanks!

> Bart


Shuai

