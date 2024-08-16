Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A6313DBBC
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Aug 2024 07:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723794429; cv=none; b=rQsAf2OPxNcPYzRRuGO1AADtjCivznQR6nfuZStzeW1XGI+xyzkaVW7m+Je5d84HmqiBbhWBY2Ds3quC43QNpRQ9LqkhqOH55p9b3pYJ+LKISHM+60K0+son/QX9r668lVaoXOGQmy+Z1v7TUm+pT9VhNAreJQ0AMOXxDrqrCUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723794429; c=relaxed/simple;
	bh=BMi6EXAjyH7mAjAAXcgWfMaTrqeIQj1w3EGqmiC0nQI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=EdFE8wL8eyBze73OtJlM2FvRcFrAIXsF/nNw13EUbpn8kaD1PW6mSSF3d3cfA6yG13CNq8RVFxuNi7JIOlaEBiLbyuVqJn6o2KS6LS098yhkZA6J4nsUvGCyvWS3c1b4PDWxtHw48MbzH8fSiA82tIEbbV1P0F4LXPURA8NTf3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o9wEYulV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o9wEYulV"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47G5r1Vx001511;
	Fri, 16 Aug 2024 07:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WR3DluiHSXeAEeVlyI0ZkP1HOTjz1zm4W6//FturMD4=; b=o9wEYulVVrOJXdC2
	1wHk+nYzLjk4PWp2H9uyHNGPEIlrgNRIDWLEyCIAGMdMmPupRrx17i4EZ246BYT5
	mR1tdGjljsRUBIM2hUjzi6JGz8khGEpYNWZG7Ix59MIid7pbZ2qkCQuT3HdVDY7d
	k9XVdnxoEoJZ0YP9HvKiyXD4JCFN3xwkW+DpDl1Q2wBJi7kAwyqtqMm4Uim+zXyq
	f9KasMOL7t9HlfmpIBzu62VPEMxlg0XnBn0cAawV/w97hIF1Y4uC/tVsWVhc6rvy
	AbGcgU2Uop3gxC/GrMHJurY0SfW6WtQp8NP+lBrQ/rcUqrAWEhTK6PTs5L6SzgXd
	jV28Pg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4104381k09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 07:46:56 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47G7ks30024834
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 07:46:54 GMT
Received: from [10.219.0.111] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 16 Aug
 2024 00:46:52 -0700
Message-ID: <70f65184-e263-465d-a627-d9a1bf3b03d4@quicinc.com>
Date: Fri, 16 Aug 2024 13:16:49 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: obexd: Add system bus support for obexd
From: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>, <linux-bluetooth@vger.kernel.org>
References: <20240723075455.2934376-1-quic_dgangire@quicinc.com>
 <7c427210-24ad-4769-9c11-aaebe9656cec@molgen.mpg.de>
 <89308a3b-c4b2-4dad-89df-aef86c53a5e8@quicinc.com>
Content-Language: en-US
In-Reply-To: <89308a3b-c4b2-4dad-89df-aef86c53a5e8@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kARhwhiKhP_19DkpCvvTPX2DW-6g6E4h
X-Proofpoint-GUID: kARhwhiKhP_19DkpCvvTPX2DW-6g6E4h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_18,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408160055

Hi Paul,

Can you please provide your inputs/comments on the whole patch.
https://patchwork.kernel.org/project/bluetooth/list/?series=873224

On 7/23/2024 5:19 PM, Damodar Reddy GangiReddy wrote:
> 
> 
> On 7/23/2024 4:10 PM, Paul Menzel wrote:
>> Dear Damodar,
>>
>>
>> Thank you for your patch.
>>
>> Am 23.07.24 um 09:54 schrieb quic_dgangire@quicinc.com:
>>> From: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>
>>
>> Is your last named spelled in camel case?
>>
> yes
>>> Currently obexd uses session bus.
>>> Distros  where session bus is not supported and still obex profiles
>>> are required in that case use system bus instead of session bus
>>> which can be configured with new optional feature
>>>
>>> Additional optional feature has been added to achieve this
>>> with name --enable-use-systembus-for-obexd
>>>
>>> steps to configure system bus
>>> ./configure --enable-use-systembus-for-obexd
>>>
>>> If this optional option is approved  will add other patches
>>> on how to use system bus based on this option
>>
>> This paragraph does not belong into the commit message.
>>
> yes, so removing it and will share the whole patch
>>> ---
>>>   Makefile.obexd | 14 ++++++++++++++
>>>   configure.ac   |  9 +++++++++
>>>   2 files changed, 23 insertions(+)
>>>
>>> diff --git a/Makefile.obexd b/Makefile.obexd
>>> index b7e9f2d33..87432cc37 100644
>>> --- a/Makefile.obexd
>>> +++ b/Makefile.obexd
>>> @@ -2,6 +2,19 @@
>>>   if OBEX
>>>     if SYSTEMD
>>> +
>>> +if USE_SYSTEMBUS_FOR_OBEXD
>>> +
>>> +systemdsystemunit_DATA += obexd/src/obex.service
>>> +dbussystembus_DATA += obexd/src/org.bluez.obex.service
>>> +
>>> +obexd-add-service-symlink:
>>> +    $(LN_S) -f obex.service $(DESTDIR)$(SYSTEMD_SYSTEMUNITDIR)/dbus-org.bluez.obex.service
>>> +
>>> +obexd-remove-service-symlink:
>>> +    rm -f $(DESTDIR)$(SYSTEMD_SYSTEMUNITDIR)/dbus-org.bluez.obex.service
>>> +else
>>> +
>>>   systemduserunitdir = $(SYSTEMD_USERUNITDIR)
>>>   systemduserunit_DATA = obexd/src/obex.service
>>>   @@ -13,6 +26,7 @@ obexd-add-service-symlink:
>>>     obexd-remove-service-symlink:
>>>       rm -f $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez.obex.service
>>> +endif
>>>   else
>>>   obexd-add-service-symlink:
>>>   obexd-remove-service-symlink:
>>> diff --git a/configure.ac b/configure.ac
>>> index d31eb1656..cc9a55f4c 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -283,6 +283,15 @@ if (test "${enable_obex}" != "no"); then
>>>   fi
>>>   AM_CONDITIONAL(OBEX, test "${enable_obex}" != "no")
>>>   +AC_ARG_ENABLE(use-systembus-for-obexd, AS_HELP_STRING([--enable-use-systembus-for-obexd],
>>> +        [enable systembus for obexd]), [enable_use_systembus_for_obexd=${enableval}])
>>> +AM_CONDITIONAL(USE_SYSTEMBUS_FOR_OBEXD, test "${enable_use_systembus_for_obexd}" = "yes")
>>> +if (test "${enable_use_systembus_for_obexd}" = "yes"); then
>>> +    AC_DEFINE(USE_SYSTEMBUS_FOR_OBEXD, 1, [Define to 1 if you want to use system bus for obexd.])
>>> +else
>>> +    AC_DEFINE(USE_SYSTEMBUS_FOR_OBEXD, 0, [Define to 0 if you want to use session bus for obexd.])
>>> +fi
>>> +
>>>   AC_ARG_ENABLE(btpclient, AS_HELP_STRING([--enable-btpclient],
>>>           [enable BTP client]), [enable_btpclient=${enableval}])
>>>   AM_CONDITIONAL(BTPCLIENT, test "${enable_btpclient}" = "yes")
>>
>> It would be nice to see the whole picture. Is it just for creating and placing the systemd units in the right place?
>>
>>
> yes, it is used to place the systemd units in the right place.
> Will share the whole patch.
>> Kind regards,
>>
>> Paul
Kind Regards,
Damodar.

