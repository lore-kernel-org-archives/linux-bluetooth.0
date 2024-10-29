Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF82A18858E
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Oct 2024 05:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730179321; cv=none; b=gLQDm6YkMglZcidyUCExJ3scgmFc+l91EUA4TlAkJTtmZ82bXFaXnBQQp6MH/zXXkDDMJidCZjvfUwAcge2Xl8s1AKXHDMnO8ZYUZ9lt7Wd5jppiK7Mi93Ts36HG4IyiugxZ5g6TMOKGgrdfpL03jb2DT+2r2zIf8jW90CF+Yx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730179321; c=relaxed/simple;
	bh=rRMpAebE5PQjx1W8QUguRDPAopuyPKFXT0shvNBtS2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jZLVm6HHrVeWvDGgp2jCQw4oPTWiJZFKiFMMi99rP2qSXadpH0zeYQpiHmTnXorZw/2svT2cT0J/Be+HWx4kzVrIU5OFW9Z1nakSrKWJGfyB0KwI8Scq9/ffq7lQvRMXxHVZ1UyXtn08THLtu/zBMyTI0PnRw3npaZa5ncH/1g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dkPRg1hd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dkPRg1hd"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SKeoul008480;
	Tue, 29 Oct 2024 05:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j1tDJDRNbwAnk/Clxdaz7CRbfABjZlI4icW0JHJdLRY=; b=dkPRg1hd/hTDH8ep
	3OeMITDwotoGSpefHtK9g5yTiDjH8y51Hp/+ZwoCx3rmgbW6UhZAzawKr8pJmjAj
	YECiZ3YAiK8ytP0hrM2vFLeHLLdHkl9ziKQ3ZykGoQV3C918MFWIj/sWG8r6fr/r
	ChVyHjIKmochMXKIqddOjyjTxVrUYUzDVHoJZkplAyz/Yf9D1lg09V4WdoTYVjaz
	FzhWvqgoZDL9qERdP3LWl3vFSP1g3QxB2NK3funPb/HnxitVxiOhUtuPcnfYswNH
	j8peZm5OLRJlyd8PXy9j6N7hCFc0za9oJDui40++VUUq0fyAuo+eBnngNP7VQcWM
	SRPG9w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gqrgq74q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 05:21:56 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49T5Lt41004917
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 05:21:55 GMT
Received: from [10.219.0.111] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 28 Oct
 2024 22:21:53 -0700
Message-ID: <1c78c2cd-a6ee-4ba4-a6ce-c16c4d9030d9@quicinc.com>
Date: Tue, 29 Oct 2024 10:51:50 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v1] obexd: Add system bus support for obexd
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <quic_mohamull@quicinc.com>,
        <quic_hbandi@quicinc.com>, <quic_anubhavg@quicinc.com>
References: <20240723112505.3019642-1-quic_dgangire@quicinc.com>
 <CABBYNZ+SA6BmRQju16PtsUB+CxCEKvGfYXxdRXG+s0T5ky1QUQ@mail.gmail.com>
Content-Language: en-US
From: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>
In-Reply-To: <CABBYNZ+SA6BmRQju16PtsUB+CxCEKvGfYXxdRXG+s0T5ky1QUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: J9U7cFC8aZIsDDF6nzSr1gVZbR_aNyqV
X-Proofpoint-GUID: J9U7cFC8aZIsDDF6nzSr1gVZbR_aNyqV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290041

Hi Luiz,

On 10/24/2024 8:33 PM, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Tue, Jul 23, 2024 at 7:25 AM <quic_dgangire@quicinc.com> wrote:
>>
>> From: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>
>>
>> Currently obexd uses session bus.
>> Distros  where session bus is not supported and still obex profiles
>> are required in that case use system bus instead of session bus
>> which can be configured with new optional feature
> 
> Well system bus is normally used by daemon that require root(like)
> access, having obexd running as a system service is sort of dangerous
> since it means remote access as root to part of the filesystem
> (similar to allowing FTP access as root user).
> 
>> Additional optional feature has been added to achieve this
>> with name --enable-use-systembus-for-obexd
>>
>> steps to configure system bus
>> ./configure --enable-use-systembus-for-obexd
> 
> If we allow such a thing I'd like to have it as a runtime option, not
> just as a build-time one, since we might want to be able to run obexd
> under test-runner for testing automation, but for example the
> test-runner environment currently doesn't start any session bus.
> 
To Have it as a runtime option.
Can we add something similarly as below to achieve it at runtime
in the obexd main.c file. Like obexd -d
-d, --debug=DEBUG        Enable debug information output

Our Approach: (Not precise we will give proper name convention)
-b --bus=system       Use System bus 
-s --bus=session      Use Session bus

I'd like to have it as a runtime option, not
 just as a build-time one?
Ideally we should be setting configuration at runtime or compile time
but not at both right.?

Suppose at compile time we use --enable-use-systembus-for-obexd which means
system bus is configured. But at run time we say it to use session bus.
How to handle this scenario and which should be priority?

If our Understanding is not clear.Please ellaborate more on how to achieve it.

> Btw, if you guys are after a stable environment for test
> automation/qualification I highly recommend looking into the
> test-runner:
> 
> https://github.com/bluez/bluez/blob/master/doc/test-runner.rst
> 
>> ---
>>  Makefile.obexd          | 14 ++++++++++++++
>>  configure.ac            |  9 +++++++++
>>  obexd/client/ftp.c      |  3 ++-
>>  obexd/client/map.c      |  3 ++-
>>  obexd/client/opp.c      |  3 ++-
>>  obexd/client/pbap.c     |  3 ++-
>>  obexd/client/session.c  |  3 ++-
>>  obexd/client/sync.c     |  3 ++-
>>  obexd/plugins/pcsuite.c |  3 ++-
>>  obexd/src/manager.c     |  3 ++-
>>  src/bluetooth.conf      | 12 ++++++++++++
>>  tools/obexctl.c         |  3 ++-
>>  12 files changed, 53 insertions(+), 9 deletions(-)
>>
>> diff --git a/Makefile.obexd b/Makefile.obexd
>> index b7e9f2d33..87432cc37 100644
>> --- a/Makefile.obexd
>> +++ b/Makefile.obexd
>> @@ -2,6 +2,19 @@
>>  if OBEX
>>
>>  if SYSTEMD
>> +
>> +if USE_SYSTEMBUS_FOR_OBEXD
>> +
>> +systemdsystemunit_DATA += obexd/src/obex.service
>> +dbussystembus_DATA += obexd/src/org.bluez.obex.service
>> +
>> +obexd-add-service-symlink:
>> +       $(LN_S) -f obex.service $(DESTDIR)$(SYSTEMD_SYSTEMUNITDIR)/dbus-org.bluez.obex.service
>> +
>> +obexd-remove-service-symlink:
>> +       rm -f $(DESTDIR)$(SYSTEMD_SYSTEMUNITDIR)/dbus-org.bluez.obex.service
>> +else
>> +
>>  systemduserunitdir = $(SYSTEMD_USERUNITDIR)
>>  systemduserunit_DATA = obexd/src/obex.service
>>
>> @@ -13,6 +26,7 @@ obexd-add-service-symlink:
>>
>>  obexd-remove-service-symlink:
>>         rm -f $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez.obex.service
>> +endif
>>  else
>>  obexd-add-service-symlink:
>>  obexd-remove-service-symlink:
>> diff --git a/configure.ac b/configure.ac
>> index d31eb1656..cc9a55f4c 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -283,6 +283,15 @@ if (test "${enable_obex}" != "no"); then
>>  fi
>>  AM_CONDITIONAL(OBEX, test "${enable_obex}" != "no")
>>
>> +AC_ARG_ENABLE(use-systembus-for-obexd, AS_HELP_STRING([--enable-use-systembus-for-obexd],
>> +               [enable systembus for obexd]), [enable_use_systembus_for_obexd=${enableval}])
>> +AM_CONDITIONAL(USE_SYSTEMBUS_FOR_OBEXD, test "${enable_use_systembus_for_obexd}" = "yes")
>> +if (test "${enable_use_systembus_for_obexd}" = "yes"); then
>> +       AC_DEFINE(USE_SYSTEMBUS_FOR_OBEXD, 1, [Define to 1 if you want to use system bus for obexd.])
>> +else
>> +       AC_DEFINE(USE_SYSTEMBUS_FOR_OBEXD, 0, [Define to 0 if you want to use session bus for obexd.])
>> +fi
>> +
>>  AC_ARG_ENABLE(btpclient, AS_HELP_STRING([--enable-btpclient],
>>                 [enable BTP client]), [enable_btpclient=${enableval}])
>>  AM_CONDITIONAL(BTPCLIENT, test "${enable_btpclient}" = "yes")
>> diff --git a/obexd/client/ftp.c b/obexd/client/ftp.c
>> index 160e0636a..e3cef32f6 100644
>> --- a/obexd/client/ftp.c
>> +++ b/obexd/client/ftp.c
>> @@ -463,7 +463,8 @@ int ftp_init(void)
>>
>>         DBG("");
>>
>> -       conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
>> +       conn = dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
>> +                       DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
>>         if (!conn)
>>                 return -EIO;
>>
>> diff --git a/obexd/client/map.c b/obexd/client/map.c
>> index 513dcaf14..815806f52 100644
>> --- a/obexd/client/map.c
>> +++ b/obexd/client/map.c
>> @@ -2063,7 +2063,8 @@ int map_init(void)
>>
>>         DBG("");
>>
>> -       conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
>> +       conn = dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
>> +                       DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
>>         if (!conn)
>>                 return -EIO;
>>
>> diff --git a/obexd/client/opp.c b/obexd/client/opp.c
>> index 90d0c0c8e..4889a3a0f 100644
>> --- a/obexd/client/opp.c
>> +++ b/obexd/client/opp.c
>> @@ -178,7 +178,8 @@ int opp_init(void)
>>
>>         DBG("");
>>
>> -       conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
>> +       conn = dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
>> +                       DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
>>         if (!conn)
>>                 return -EIO;
>>
>> diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
>> index 2d2aa9508..1658c853a 100644
>> --- a/obexd/client/pbap.c
>> +++ b/obexd/client/pbap.c
>> @@ -1303,7 +1303,8 @@ int pbap_init(void)
>>
>>         DBG("");
>>
>> -       conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
>> +       conn = dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
>> +                       DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
>>         if (!conn)
>>                 return -EIO;
>>
>> diff --git a/obexd/client/session.c b/obexd/client/session.c
>> index 7d8ebb04e..4e447e8eb 100644
>> --- a/obexd/client/session.c
>> +++ b/obexd/client/session.c
>> @@ -583,7 +583,8 @@ struct obc_session *obc_session_create(const char *source,
>>         if (driver == NULL)
>>                 return NULL;
>>
>> -       conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
>> +       conn = dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
>> +                       DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
>>         if (conn == NULL)
>>                 return NULL;
>>
>> diff --git a/obexd/client/sync.c b/obexd/client/sync.c
>> index 92faf4434..bd339adfa 100644
>> --- a/obexd/client/sync.c
>> +++ b/obexd/client/sync.c
>> @@ -224,7 +224,8 @@ int sync_init(void)
>>
>>         DBG("");
>>
>> -       conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
>> +       conn = dbus_bus_get(USE_SYSTEMBUS_FOR_OBEXD ?
>> +                       DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL);
>>         if (!conn)
>>                 return -EIO;
>>
>> diff --git a/obexd/plugins/pcsuite.c b/obexd/plugins/pcsuite.c
>> index 07c444ff2..5daed2abb 100644
>> --- a/obexd/plugins/pcsuite.c
>> +++ b/obexd/plugins/pcsuite.c
>> @@ -322,7 +322,8 @@ static gboolean send_backup_dbus_message(const char *oper,
>>
>>         file_size = size ? *size : 0;
>>
>> -       conn = g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
>> +       conn = g_dbus_setup_bus(USE_SYSTEMBUS_FOR_OBEXD ?
>> +                       DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL, NULL);
>>
>>         if (conn == NULL)
>>                 return FALSE;
>> diff --git a/obexd/src/manager.c b/obexd/src/manager.c
>> index 3c0c2a7cc..dd83f056d 100644
>> --- a/obexd/src/manager.c
>> +++ b/obexd/src/manager.c
>> @@ -488,7 +488,8 @@ gboolean manager_init(void)
>>
>>         dbus_error_init(&err);
>>
>> -       connection = g_dbus_setup_bus(DBUS_BUS_SESSION, OBEXD_SERVICE, &err);
>> +       connection = g_dbus_setup_bus(USE_SYSTEMBUS_FOR_OBEXD ?
>> +               DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, OBEXD_SERVICE, &err);
>>         if (connection == NULL) {
>>                 if (dbus_error_is_set(&err) == TRUE) {
>>                         fprintf(stderr, "%s\n", err.message);
>> diff --git a/src/bluetooth.conf b/src/bluetooth.conf
>> index b6c614908..f8879c8bb 100644
>> --- a/src/bluetooth.conf
>> +++ b/src/bluetooth.conf
>> @@ -21,10 +21,22 @@
>>      <allow send_interface="org.freedesktop.DBus.ObjectManager"/>
>>      <allow send_interface="org.freedesktop.DBus.Properties"/>
>>      <allow send_interface="org.mpris.MediaPlayer2.Player"/>
>> +    <allow own="org.bluez.obex"/>
>> +    <allow send_destination="org.bluez.obex"/>
>> +    <allow send_interface="org.bluez.obex.Agent1"/>
>> +    <allow send_interface="org.bluez.obex.Client1"/>
>> +    <allow send_interface="org.bluez.obex.Session1"/>
>> +    <allow send_interface="org.bluez.obex.Transfer1"/>
>> +    <allow send_interface="org.bluez.obex.ObjectPush1"/>
>> +    <allow send_interface="org.bluez.obex.PhonebookAccess1"/>
>> +    <allow send_interface="org.bluez.obex.Synchronization1"/>
>> +    <allow send_interface="org.bluez.obex.MessageAccess1"/>
>> +    <allow send_interface="org.bluez.obex.Message1"/>
>>    </policy>
>>
>>    <policy context="default">
>>      <allow send_destination="org.bluez"/>
>> +    <allow send_destination="org.bluez.obex"/>
>>    </policy>
>>
>>  </busconfig>
>> diff --git a/tools/obexctl.c b/tools/obexctl.c
>> index 56a76915c..07dc1ae6b 100644
>> --- a/tools/obexctl.c
>> +++ b/tools/obexctl.c
>> @@ -2154,7 +2154,8 @@ int main(int argc, char *argv[])
>>         bt_shell_set_menu(&main_menu);
>>         bt_shell_set_prompt(PROMPT_OFF);
>>
>> -       dbus_conn = g_dbus_setup_bus(DBUS_BUS_SESSION, NULL, NULL);
>> +       dbus_conn = g_dbus_setup_bus(USE_SYSTEMBUS_FOR_OBEXD ?
>> +                               DBUS_BUS_SYSTEM : DBUS_BUS_SESSION, NULL, NULL);
>>
>>         client = g_dbus_client_new(dbus_conn, "org.bluez.obex",
>>                                                         "/org/bluez/obex");
>> --
>> 2.34.1
>>
>>
> 
> 
Kind Regards,
Damodar.
