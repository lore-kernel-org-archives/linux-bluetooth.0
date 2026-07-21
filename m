Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAE9409121
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784633771; cv=none; b=OmUnWttgV7PBNosah3YzfNynIdg6rGZdnxFPXysJhO/mf4Vr7iin+ju8jYPuEiaM2+2dxswNdMX2nCN5eR4hjTQF74PflbavZgeGkhjTwLq9bCSgP3ffc9Nc/aZ2Sm3R5g6pZWRqxrU1tr7bFcTPy17ZSlbbqe26k49l8ZlOZ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784633771; c=relaxed/simple;
	bh=4JyJ6+fbkovfNwBYb5o7zHypjY72a8GcMcq85HouKAs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qLqo/N/ztMpHG9rKizV+vtGX8oxP/ceWxr02WgMkOhQFCp6EhUZczmqiS7q+t92bqoyn5zvy2l0Eg1Gmsu+WtATYANaneJJ6KFi6ElSe4hu0Aap3ifjoac7DCmP6Vvr3LQmoqn0wxw7JPUHLBsYnP5jK4l+a+xN/UnHhmN9ml9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T6+c7vnv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fKS6sRLG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T6+c7vnv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fKS6sRLG"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LARPri1229977
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 11:36:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m9Ap7h1iQzF657SfJY0129sRlz3zmF+0GrJPlJ/KK18=; b=T6+c7vnvkdlRu60G
	kWV2UwVgulHHyp07+9z11itlsYBl46gB5YBmke75EL8AUdzPmxVwivKkAztqvRkv
	tZR2yeYAzkgy5W4vEXi3BnR759HrKrl8uUcxVlXfINd7ZE/zTtAsFE8LtcrfBREO
	63rW0+5K5rczlWFSK4mKr0xpj2Afrk6/HMZOjO3eYhmamA2R+gsgx7qh79zehBku
	YrsFxPKYlgldZBOlrddPa4gp28FFXVFmJI7OeeYX34aym/7z0GaBjrRGQBRnsPZv
	jckFeJnBX6LxZAKe2uJGwJne2gQ3UevdxMWS7pZU2IJnfnsTnUrwso4vnolkLZlq
	XFpewQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj01aad08-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 11:36:09 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c9e11ee2b43so1738332a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 04:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784633769; x=1785238569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m9Ap7h1iQzF657SfJY0129sRlz3zmF+0GrJPlJ/KK18=;
        b=fKS6sRLGpsZs2vjwKwLQJ2JbOGPljf+uc3qX38UEtfiMEwFmo6CpBPPzHKz8FLoi6d
         S3exsmtz/mQpuNgpKl7BL2V65oGx8AOcFyY4I3da/fMVEhFtpX+ujDb2BP4za7fpRMR6
         JRI2gKJirDMzEhnGpaPYt1BqerP06igOATrO5q3DiaygvqOIVDKsDBJXf5PkRwGAs+R+
         MUimO1P5K7YsqYzEycRkevis0y8TSUTgVQwxrjltj+2czuEQOrbh22fJi2ElSlL+M5RY
         hdj/d289p0r8jnchS9Fp02tuHvY/jTqlXhlsbcGstdly5yoENywJfnd+6bAh2XspQMTJ
         c2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784633769; x=1785238569;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m9Ap7h1iQzF657SfJY0129sRlz3zmF+0GrJPlJ/KK18=;
        b=Dtjjn3Q39m52ZSX8RqUYJaxTItTSh4vU8gG6KIEpC3Uzm7r5fLVbw5KPNV+dCaNPDw
         RxOQdAKZxp85d/057LzfgGiJ1FFve2JolXHFSR6LWXSRXydeWlbF7fVk8Buz+JRdU8f/
         ocjKaSvPoIU5dv4M3vtefYRgKOdcJIQt2ewCXj2VvshdnVRj9bF84sXH8ZaufU+oPcwV
         JMUFGbzhYD9GaOC+DV6+bPenhVfiblMWPizmI6lPK2cxxU9DEG3ewXZtqX5e0Mqc0XUQ
         1q84tGzwxL+NgCk/jjUMgB1E5hYTEdoNHCiSuNoOlNVk3eSMrWmwrbBIOSsAgNYya4Vn
         hiCg==
X-Forwarded-Encrypted: i=1; AHgh+RozTu6+V8SrH4nANtXDwxuzCljlK4+ihnUGfQkcFpkn+Po4dfwXthdbaH0s8Hw91pvsQnPIo2pOfictWn72AJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSlMMTgkx1CR0gIMgL4TT8z/SrDZfPbKYtiVZzujw/U9eCc2Q9
	+v2Mw7Acg2hLwn0LAk8QKsXbo+7wvY1CwIUwu43DjHu+2wAkDYWEVBSjb1SqDouqdwQpE3qt2RM
	Y6Ox5TozPbLjyuaFiExNy5s35qnzD8jflcI2ikEaG3RghGag1miy+I3736ldSJfRUVyvOG+c=
X-Gm-Gg: AR+sD1319MpHShBBs04ZzWTyftyb8JgwYAu1A/nTxXCr83SRlzUg/4bBxULpc4SSIur
	umGY8Y29WXlaDjj6uKzZbliB+HhQBnDUi/ukeDRYMHlMnLGZ/wjUr+R5lxGlMmftRZ3SFf1ByM7
	FxB57l32bhYB30UsKeivWekvK6dI8HFRWCyXhKtJS9ubq+Co18+czUy+MJbiZCmo0ESFXAG2l3c
	BdvCCQJytPBwtyawME3xNbKY33iPkR9ihaOPs25DbiqmpmlWUyPQy3CIpEMj2HP/a8IE1i2fZL0
	1UiBnOGYbvexJwAJ1xYUEnh8Lmdta7Mxqe4hbnTBO1GlP3ZPBcR1cvk7kV2Y76JSbquJna86ndQ
	UuTlrUs/x1UWMcZuk+TMnn6DbT8lFGwFUAoS/rSmvvbNwatutqM70Bex4lEELOqbgXJk=
X-Received: by 2002:a05:6a00:18a3:b0:848:3e03:89f7 with SMTP id d2e1a72fcca58-84e0332e78amr2281365b3a.7.1784633768965;
        Tue, 21 Jul 2026 04:36:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:18a3:b0:848:3e03:89f7 with SMTP id d2e1a72fcca58-84e0332e78amr2281333b3a.7.1784633768417;
        Tue, 21 Jul 2026 04:36:08 -0700 (PDT)
Received: from [10.133.33.193] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2afa1244sm7301742b3a.59.2026.07.21.04.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 04:36:07 -0700 (PDT)
Message-ID: <3df57e43-f500-46a2-8890-d867e50424bd@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 19:36:05 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] Bluetooth: Add generic support for vendor HCI frames
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260719-support_vendor_hci-v1-1-764523a4ca3d@oss.qualcomm.com>
 <CABBYNZL_H2iRAshF-RCX41jbt0jots5i5W=aUUJC_wEN6wzp=w@mail.gmail.com>
 <0c5a924f-7382-407b-a0f4-dfd7dfe0d5e6@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0c5a924f-7382-407b-a0f4-dfd7dfe0d5e6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BL6DalQG c=1 sm=1 tr=0 ts=6a5f59a9 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=5F5QtF9u_9E6x0JBPFAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEyMiBTYWx0ZWRfXwQ2wUx9oKxVW
 iI6NRqqvW8kXnxMxLamqsrKVqBwB5GxNom2hfX3CZnwJA/FjtT48nhnE4BFN38WnBKcAl2RnF4G
 mnw0vtw+PUVXIEbV5bvpXR7CtE4xPs9DIuwxcyQ+25p3aAJ9vqD9aYECkbVc3Fd/WYXCAjOtweB
 c5qVjXSUy/H9Wij4OsVTfWG1OQ4PAWjmyXFCICTO3UHNARh975nLeudQfd2JEG5QX5P6BOuNuQz
 mQAztVXzoRJaOpvA6m6jAqLp27Ugd0uatN2UCzUu5vsH8YHlYoX6rwt0aj31Ay7tSsbEn7te/CH
 FhzmBl5ffJgSx6qMyGe9FCUn97u23gbJ1k4CBNhYr0OkFuIqXGH7icU8/dvEf8fy6DZ6py9tbP2
 Yf0jKFzeeTg/ouNb/b6bNrCFGtiYT83QfuZSX63r92RZQdHHRo0VlbE7j9oPL6ZaxknsPi/FL0w
 YRpSWhgO1XqTXO4c+tQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEyMiBTYWx0ZWRfX61LdJKstEmHP
 yx0vdl6gA1tRopLPcwhU/BD81GXhPg2A0I0+i7T1cyeVt7ElOo28+4orthDjllK7plpIi2/0ygK
 dBGYZyhY+GiWMgUIjQY8lnUDAIe8j54=
X-Proofpoint-ORIG-GUID: XW7sd033SJNlYB7jApnPhI6TJsVksFUo
X-Proofpoint-GUID: XW7sd033SJNlYB7jApnPhI6TJsVksFUo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210122

On 7/21/2026 4:52 PM, Zijun Hu wrote:
>>> Hi Luiz
>>> To address the below concerns you raised on previous
>>> discussion, and inspired from your suggestion to add hdev callback:
>>>
>>> - Not use safer skb helper like skb_pull_data()
>>> - It will skip sending to the monitor, making debugging much harder
>>>
>>> Looking forward to your further comments.
>>>
>>> Why hdev->is_vendor() instead of multiplexing vendor frames under a
>>> virtual HCI_VENDOR_PKT + vendor indicator byte ?
>>>
>>> 1) The virtual HCI_VENDOR_PKT isn't used by the core itself
>>>    currently, and may be removed later.
>>> 2) It makes full use of the indicator (hci_skb_pkt_type(skb)) space,
>>>    which is large enough to accommodate vendor frames without an
>>>    extra layer of nesting inside HCI_VENDOR_PKT.
>>> 3) It lets userspace and btmon logs see the exact same frame as it
>>>    appears on the wire.
> As noted above, I chose is_vendor() over Solution A. My reasoning follows,
> for your reference.
> 
> 1) Userspace sees exactly what is on the wire, in the same form as BT-HCI frames — 
>    clear and consistent, as shown below:
>   ┌───────┬──────────┬────────────┬────────────┐
>   │ Frame │ BT-HCI   │ PERI-HCI   │ PERI-HCI   │
>   │       │ existing │ is_vendor()│ Solution A │
>   ├───────┼──────────┼────────────┼────────────┤
>   │ CMD   │ 0x01 …   │ 0x31 …     │ 0xff 0x31… │
>   ├───────┼──────────┼────────────┼────────────┤
>   │ ACL   │ 0x02 …   │ 0x32 …     │ 0xff 0x32… │
>   ├───────┼──────────┼────────────┼────────────┤
>   │ EVENT │ 0x04 …   │ 0x34 …     │ 0xff 0x34… │
>   └───────┴──────────┴────────────┴────────────┘
> 2) is_vendor() puts PERI-HCI on an equal footing with BT-HCI, so userspace and the transport
>    driver can reuse the existing BT-HCI path rather than add a separate encode/decode layer —
>    less effort on both sides.
> 

add one more entry:
  3) It can let transport drivers avoid pre-processing unsolicited BT
     vendor-specific events (VSE) before hci_recv_frame(), which many
     transport drivers currently do (e.g. the QCA memdump event), and
     handle them in recv_vendor() within the stack instead, if put in
     hci_rx_work() as below:

        if (hci_is_vendor_frame(hdev, skb)) {
                BT_DBG("%s Vendor packet with type 0x%2.2x",
                       hdev->name, hci_skb_pkt_type(skb));
                if (hdev->recv_vendor)
                        hdev->recv_vendor(hdev, skb);
                else
                        kfree_skb(skb);
                continue;
        }

        /* Process frame */
        switch (hci_skb_pkt_type(skb)) {
        case HCI_EVENT_PKT:

> Could you please give me a clear direction 
> Solution A or is_vendor()?
> 
> I need it before I can move forward with the remaining QCC2072 btusb development work.
> 
> thank you.

