Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEB941F34A
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438319; cv=none; b=ah1Myd6ooCDoJcH8zp2KQZDc4nEvJphD/SP7L7fwVV/XsX0C9NGpNc5NHvqjuVyM6/VTjpEzkEMaI2pzEMH6yGgJlbsanL+B9dqHewQRjL1dGwq8qdhtPZg/Kw+1KeNYVafWSwvH5lsl26Gg25K4zk9KXTg8joC81Dtx+pmBAYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438319; c=relaxed/simple;
	bh=I7nPnuHKAd6p8Q9qirUeBbr32XOXSg2puw/1Nr5yEm0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=t+M+TDtz9h1Mn7NR+cDbibatRL/6LsnDaIJEW10a+qP0ZOz7O8s6sMMbz2wvJ45rtuQNxoKgAxtE51UTNY6X/pvjm6B/RN2p2rKc6IyvnE59Xz4n5Cf/ZlWJxwYsV6M84UcgoDfMGhOO4713cEuwu1vLKM+9lJoi9/K8OR59nE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mptQ0Iov; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cjLvkADN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mptQ0Iov";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cjLvkADN"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B6uXUH2812807
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 08:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SPf3Qq35sizRfvRrlkrIrvuvqWT7RAryjsZcrodDY1c=; b=mptQ0Iovyl5nzwSj
	ktLVhbhNHYukgPzRYfj0kXZdB+EENabqatZRi1PaX4XaKAo6xmWM0j5WXvaHAu13
	kmWQzWoLWtOtG1SMUndmnMgMUolNj4+igIHS5ucD8ni3UnGVZYwep6P0J0A0+XQO
	z7ewLdAafeE3raFSWXBca+XFuwGJkEv1UdkTW5exBom63ZGLhK1FBGLHP/nXoCjv
	iSMj5rjzYr0I1UKEBMLMdMpfBGTKl2MwPBin6aBJ2/tUdLJ+2HjsPLkbpOHTAyzW
	pROeblbMy+53LiLvunvfd1ID8yOWaikgNGxASqxi+V2NEnSjncRji4VrYllF8N3Q
	MGNzkA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyxweresq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 08:51:54 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-91931144870so318526185a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 01:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786438314; x=1787043114; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SPf3Qq35sizRfvRrlkrIrvuvqWT7RAryjsZcrodDY1c=;
        b=cjLvkADNswzCKZrJDrNcCBUTBbTiiRjapumb8XUk+NbIrInzaPtqihEDM/9MyIv3S9
         n5kXPob9lylZ7cFwys/lEJKUtctKkQ5efvrey0Oi+GpQ72/F9maKCte/2BcfTgWpQ5S4
         jKrhTmog5b0azaFnl0CcO7rbi3n9owuRe2Q0/kpqUBbypjmDG0veC7aebJRkzLBiccjM
         CQvF+RPDCuDqNKXlOPBuNH4LqSYXiYsXuX3zCRj22y9l1gJU31ww8uFK22Y1+9/Q8ZMZ
         snlH4RKdB42OE+cwukE12shQrxftRfUW3WDOSEEJ/IkSXBT6QOtxd0+MwK02Vtvp8n1V
         NlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786438314; x=1787043114;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SPf3Qq35sizRfvRrlkrIrvuvqWT7RAryjsZcrodDY1c=;
        b=SJuzTrft4iLkGGhIM8xm+6IBrVGght9+Uf5vwOXZUZAX8i1EC92MvNgO10qaKMQ5Sl
         JBIWbZdgMe1DyuSQMDHJpoLUJS9XFi8Yq3B+1t9nqQSS1nAUkYvx8jN5Flih1FWnqvWe
         e/v2eLcvaJM5zobK31OgQ/ocFyxZ4oBd3x3KLTAeMJgzPxJu9vzBUiZr6GqgDvPd6Ild
         WhfrT/4GxrLaVO/e4JBamDg3h2AJe+FcBxyP0C15Y7wexsEY9RBxLAn3Gv2xBHzifMJ/
         JE1i646dCKHsbwiCTVL/VMenqs2Wr13axd2Aw1W9TypiHBMcSZRcN3UDlC50M2ecUAsN
         Fqjg==
X-Forwarded-Encrypted: i=1; AHgh+RpCA+u6cxSur23jgCfHiq0nBgIVGQLoXbHsjHt1ppYppdoIRNqugodwfnvXoUC4KWEW4v915u0gdWwOSHqr2dY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGLWG2WKNkXK2TOaC7cPQRduHcLUoY+bKq7Fn0XJQoXAnlLpgP
	Nh+tYKfCPsOKBkVRQk3No7/CU9qLkyctAKu3i/xGae3SGyea8/UhS8Hm4IOFRAEvkEE1danJ/Wh
	n8Q7AZ6DVg0JfuFrRikycsjuStMRGC7czN7CGEyoxfceLC+IrloNXW2FzOmSYBSuuleNQB1w=
X-Gm-Gg: AR+sD10ZCCjSr2M2gvjE403on9VejX7AiR9VdEbGXBrXXSBTM9qjmlYEAwDdQugs/EF
	5RxX9Ga7a7fUEuMvbwU+dycz6q22WvH5R7xjM1iDjAQzvuHPeddqBI5xHuiYgKFf37LBvcB0VA6
	6vFAJckJliAaZLwWxKRHrZ32vxHpJc1vzhKxKTEGUr6e8K0NccD3Ugl8yc0CrUrhLEK6Q9Uqw6O
	zU73B+CWW8HZRiQMpHW1klvU5rKuoExgvU0WaIx7VnXAP6kuZZR57OPreM0jywvq9DPkItjuKH7
	6wOdLK++LeDIpOwjOyqmK/1cQ73VZC/AjfwwpcWYz0O7w/UrKVV7GpA9o86Mgl4XV/BSak8Dqwg
	KIUq6UN3zBLjXKNMdHEtJaeZ+GDX5UlvYgOMj/ycv8dOEqixE0U5Y7HuYZgUQv7X1hsfWSygB/j
	MEzvyPzS/0qgPbUtFxu7vZ3uMLonn6OkXOPHKYfleRL+si0TXhs9ui0ENExuwwIZiOsmE=
X-Received: by 2002:a05:622a:4d0a:b0:52c:cc14:ff5f with SMTP id d75a77b69052e-52d5869539amr13603331cf.38.1786438313961;
        Tue, 11 Aug 2026 01:51:53 -0700 (PDT)
X-Received: by 2002:a05:622a:4d0a:b0:52c:cc14:ff5f with SMTP id d75a77b69052e-52d5869539amr13603161cf.38.1786438313450;
        Tue, 11 Aug 2026 01:51:53 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20e435981asm27364266b.42.2026.08.11.01.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 01:51:52 -0700 (PDT)
Message-ID: <154779e8-5f73-4f3e-8618-104effb85538@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 10:51:51 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [RFC PATCH 0/4] device_schedule_reprobe(): core helper and
 conversions
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Golle <daniel@makrotopia.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        linux-wireless@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <anpxFdwNxk0XwPjQ@makrotopia.org>
 <2026081139-strenuous-greasily-f4e5@gregkh>
 <cb0d42dd-4755-49a8-8a05-297e4283914e@oss.qualcomm.com>
 <2026081133-crazy-enquirer-97ce@gregkh>
Content-Language: en-US, nl
In-Reply-To: <2026081133-crazy-enquirer-97ce@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jSQsdAV48hLAmTAiyB9HlvJHqEayuscv
X-Authority-Analysis: v=2.4 cv=K8QS2SWI c=1 sm=1 tr=0 ts=6a7ae2aa cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=66NDgXRySrwKPkD-ur8A:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: jSQsdAV48hLAmTAiyB9HlvJHqEayuscv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3MyBTYWx0ZWRfXzHDEMA/wXi/l
 XeTmvYvBEZNEXbbAg/JRx1RsJPTUAifFVOuG96AaMaXHzeYUuhgEpaYWbSfclpwhYiLnQXXtp3x
 zBi5M8MFXB58LTyFpXPV0tf3Qpdfyo4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3MyBTYWx0ZWRfXzRbTILKro88q
 Pw/FMqp+BwH06IKa0Yj2bPo4qGYomJs3y5MMq0JbmyxV/8GHLevitb5x/Ol7NTTKeB9Pj/5xdks
 eNkWPGtkluerQWWcttZk0VWyjfQSinHRMKkG6f47aUkoJ8a8yAKPQsczlpipTRxdrtXt6cZeBU9
 cX7GTuaN/AOHr3JvF2lyzNzsLeIaCFuaIFi972vdVGRxzBCcVbbQX88Q8t2BGJ9FHX85sm+2EHS
 AAAQdNbOO6OSRPzn6YCAg9z99zMuIACrM1nLgEUAcpHS/OhxbZh3tdQvxEtm++D7vA5SRIqdKZj
 51voU+UeMi1aJWzvPNy7ljt3L32LdNI3SrVeGsspaEaPchotKzlS6KXvAdMLBuNafCt06ZBouOw
 AKKtZvJ8HMuA6ojhbktmdyS+GD8n1VxrxqhsYywpP3QK83QIJUCM2uvL34929OceheSXC9AsB68
 DMl/C8ATJg0mUGaG+TQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110073

Hi,

On 11-Aug-26 10:07, Greg Kroah-Hartman wrote:
> On Tue, Aug 11, 2026 at 09:32:45AM +0200, Hans de Goede wrote:
>> Hi Greg,
>>
>> On 11-Aug-26 04:33, Greg Kroah-Hartman wrote:
>>> On Tue, Aug 11, 2026 at 01:47:17AM +0100, Daniel Golle wrote:
>>>> Three in-tree drivers (iwlwifi, hci_h5, btintel_pcie) schedule a
>>>> deferred re-probe of their own device from a work item in module
>>>> text.
>>>
>>> That's a mess, why?  Why not fix that up to not do that?  Thousands of
>>> other kernel drivers do not do that, what makes these so special?
>>
>> I can only speak for the hci_h5 driver where I added the reprobe code-path.
>>
>> The problem is some of the Bluetooth HCI devices using hci_h5 loose all
>> state during system-suspend. This means that the HCI and the Bluetooth core
>> end up being out of sync.
>>
>> So we basically need to tear down and re-build everything including
>> e.g. the firmware upload which happens at probe(). Doing a full reprobe
>> is by far the easiest way to do this.
>>
>> I suspect the other 4 users + the pending driver which triggered
>> this are similar.
> 
> Full reprobe feels different than the THIS_MODULE stuff, which is what I
> objected to here.

Right, the helper from 1/4 to safely do reprobe from a worker actually
removes the need for THIS_MODULE stuff :)

The THIS_MODULE stuff in the open-coded implementations is there to
avoid someone doing a rmmod while the reprobe is running. The new
helper replaces this with some checks in the workqueue function
checking the driver has not been rmmod-ed in the mean time.

>> Sure we can do the whole tear-down + setup from some worker
>> scheduled at resume, while keep the driver attached but if we need
>> to duplicate that over 4 drivers + the pending driver which triggers
>> this then IMHO those 5 users are a pattern which deserves having
>> some helper to do this through the existing probe() + remove(),
>> rather then requiring those 5 drivers to open code this themselves.
>>
>> Note that we already have device_reprobe(), which has 15 existing
>> users. This series just adds a helper to do a device_reprobe() from
>> a worker in a safe way.
> 
> That feels a bit better, as long as this code really is "safe" :)
> 
> So, how can this be tested and fixed up so it isn't a RFC anymore?

To me it looks like the main things are:

1. Agree that a helper to safely do a device_reprobe() from a worker
is helpful (I think this is done now?)

2. Get patch 1/4 reviewed. I can do an initial review but I'm not very
familiar with the driver/device core internals.

3. Test this. I can test this on a hci_h5 BT HCI that will hit this
code path.

I'll try to get 2. and 3. done soon-ish.

Regards,

Hans


