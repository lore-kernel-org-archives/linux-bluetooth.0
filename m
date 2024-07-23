Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82EF13D609
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721735442; cv=none; b=AdSi8PhhLi0RhKyr81GonfksTOQodnRqu7KKQrlw2R+yfqWs6E39SGlrTq7DAtZqA48L4Bus5zvjcz067d2SqZ3zNqOaQxlAXtAFSqbCgldYgZaJ4jMbbrmX8y/BUKtpd3A0LE5IbM8ihbMRT5dRvJK3krsG+p0QhfWOBk2PDa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721735442; c=relaxed/simple;
	bh=HhRJY1p68GSudlIISnEU07R6yywpcU+Ql9OouYkzhWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O1j/OaIG7i76ZZ4lL8L9iTzOJFFG1MWvQB/wGMLT2i6KuG5kHzaKVeOuq6vUS62CYPmTw9t4Dlx+ga9NX4bhHELJ4bd4spW04OIkc6ITPl9v9G1ulGQ+vVd4ADdAOVwm6Q3TEyNYJBY2CUyNwfD7jWXUG2QEgJEI1aOxabg8Sk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AE13IkTy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AE13IkTy"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NAR7aO016784;
	Tue, 23 Jul 2024 11:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	apqA4xW8Vu39n/YlG2L9onYBYI7o/6VUEVE43eIkplk=; b=AE13IkTya0CoNq+Z
	fTv4moljNgSTToUCmsLcdembu9VPQQxKtguW+8bKDOTIsGX7fMtWf1tq1notweHd
	7jwO1t40S/gBoS5+O44Ffg0YKPWJz8FE9EyhzmcmBOiUhioVKz0F0Nfp8YLHeSnY
	8voZkr7v3vDh4Cj7jhDUgC0ZisgE92X7qHbbRPf4r/hqdz7GsjMYpliU/68lmoIJ
	1cCF+KhuY82zsMs5/5z572gyCQPegUVCl5zHK+dc/FCB4LUwcDORjzpK792tcDxa
	ctBOs81ASvCyVWkuVZONWGR22sTNxby9lTDOHrsxkWfQ8N+FdseuayiGyJbrAebF
	NBAc6w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g4jgxm9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 11:50:35 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46NBoY4m002751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 11:50:34 GMT
Received: from [10.219.0.111] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Jul
 2024 04:50:32 -0700
Message-ID: <89308a3b-c4b2-4dad-89df-aef86c53a5e8@quicinc.com>
Date: Tue, 23 Jul 2024 17:19:32 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: obexd: Add system bus support for obexd
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>, <linux-bluetooth@vger.kernel.org>
References: <20240723075455.2934376-1-quic_dgangire@quicinc.com>
 <7c427210-24ad-4769-9c11-aaebe9656cec@molgen.mpg.de>
Content-Language: en-US
From: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>
In-Reply-To: <7c427210-24ad-4769-9c11-aaebe9656cec@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -hIpNDP543f4_8GztJnFYOBs8UEmNROm
X-Proofpoint-GUID: -hIpNDP543f4_8GztJnFYOBs8UEmNROm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_01,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230085



On 7/23/2024 4:10 PM, Paul Menzel wrote:
> Dear Damodar,
> 
> 
> Thank you for your patch.
> 
> Am 23.07.24 um 09:54 schrieb quic_dgangire@quicinc.com:
>> From: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>
> 
> Is your last named spelled in camel case?
> 
yes
>> Currently obexd uses session bus.
>> Distros  where session bus is not supported and still obex profiles
>> are required in that case use system bus instead of session bus
>> which can be configured with new optional feature
>>
>> Additional optional feature has been added to achieve this
>> with name --enable-use-systembus-for-obexd
>>
>> steps to configure system bus
>> ./configure --enable-use-systembus-for-obexd
>>
>> If this optional option is approved  will add other patches
>> on how to use system bus based on this option
> 
> This paragraph does not belong into the commit message.
> 
yes, so removing it and will share the whole patch
>> ---
>>   Makefile.obexd | 14 ++++++++++++++
>>   configure.ac   |  9 +++++++++
>>   2 files changed, 23 insertions(+)
>>
>> diff --git a/Makefile.obexd b/Makefile.obexd
>> index b7e9f2d33..87432cc37 100644
>> --- a/Makefile.obexd
>> +++ b/Makefile.obexd
>> @@ -2,6 +2,19 @@
>>   if OBEX
>>     if SYSTEMD
>> +
>> +if USE_SYSTEMBUS_FOR_OBEXD
>> +
>> +systemdsystemunit_DATA += obexd/src/obex.service
>> +dbussystembus_DATA += obexd/src/org.bluez.obex.service
>> +
>> +obexd-add-service-symlink:
>> +    $(LN_S) -f obex.service $(DESTDIR)$(SYSTEMD_SYSTEMUNITDIR)/dbus-org.bluez.obex.service
>> +
>> +obexd-remove-service-symlink:
>> +    rm -f $(DESTDIR)$(SYSTEMD_SYSTEMUNITDIR)/dbus-org.bluez.obex.service
>> +else
>> +
>>   systemduserunitdir = $(SYSTEMD_USERUNITDIR)
>>   systemduserunit_DATA = obexd/src/obex.service
>>   @@ -13,6 +26,7 @@ obexd-add-service-symlink:
>>     obexd-remove-service-symlink:
>>       rm -f $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez.obex.service
>> +endif
>>   else
>>   obexd-add-service-symlink:
>>   obexd-remove-service-symlink:
>> diff --git a/configure.ac b/configure.ac
>> index d31eb1656..cc9a55f4c 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -283,6 +283,15 @@ if (test "${enable_obex}" != "no"); then
>>   fi
>>   AM_CONDITIONAL(OBEX, test "${enable_obex}" != "no")
>>   +AC_ARG_ENABLE(use-systembus-for-obexd, AS_HELP_STRING([--enable-use-systembus-for-obexd],
>> +        [enable systembus for obexd]), [enable_use_systembus_for_obexd=${enableval}])
>> +AM_CONDITIONAL(USE_SYSTEMBUS_FOR_OBEXD, test "${enable_use_systembus_for_obexd}" = "yes")
>> +if (test "${enable_use_systembus_for_obexd}" = "yes"); then
>> +    AC_DEFINE(USE_SYSTEMBUS_FOR_OBEXD, 1, [Define to 1 if you want to use system bus for obexd.])
>> +else
>> +    AC_DEFINE(USE_SYSTEMBUS_FOR_OBEXD, 0, [Define to 0 if you want to use session bus for obexd.])
>> +fi
>> +
>>   AC_ARG_ENABLE(btpclient, AS_HELP_STRING([--enable-btpclient],
>>           [enable BTP client]), [enable_btpclient=${enableval}])
>>   AM_CONDITIONAL(BTPCLIENT, test "${enable_btpclient}" = "yes")
> 
> It would be nice to see the whole picture. Is it just for creating and placing the systemd units in the right place?
> 
> 
yes, it is used to place the systemd units in the right place.
Will share the whole patch.
> Kind regards,
> 
> Paul
