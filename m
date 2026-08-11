Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6295401A37
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786433574; cv=none; b=agM+XSUWeFD+GnRzwBwxLS3VCwq5JPfzZkJQnlxtbKiOQ48O/Q3x8qlGzVh9ri4oWtN7fqlKRBojN4QsHAwW2X19JKE7bPX/AkJYcu1/IBwOnnMLb4b/mIfrdTp2B5K9SnZe7A9iHrksgsPlTvUUWgo4Qs0pTCkGEXw8Ga3sSDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786433574; c=relaxed/simple;
	bh=+tp2PqGdyroqhAj3m1ptq0FdDfaJu4hLv1vVQUx8a4I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BIZWC9Z15z77UR4vvyE6dRFqimnu+zoyQhnN85iZn4uqy0GBXndFjKQCqT74e1Y+WKd6s+GGP1cbjlZdIiz9gKHq3PFpS46BRBkeaqrcGhB7bIFrnsQJUAaPFGo6bmqL0v0PxLDcF46GnUZXN0zkuysgQBMqUs2REjhd7wtlLSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FR0FZJzc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LXYI+R6h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FR0FZJzc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LXYI+R6h"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B6uS6j2812371
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 07:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zik0MM+Spytg8wiKrAMNSNHAKxnc0Bb68YfojdbtMK8=; b=FR0FZJzcNUR7w6Pg
	oL8H6ZkTmc0LNQKOxbJGG+cgzeVC+2q++BK6wBlW0mr9wKl+yzJ22eF9u+oVjhR2
	FrC3jTMC567StOT/lOytiU0oGtrNy4Bin+/iw+ZiR+3iZwDhAtnh0sOrktSyQgnf
	DNLH9w30DOWOKsGCqC23Obnja5KDo2P0AupE2r7HD5gEImW/Eq7EdNu1qoEjF1ok
	Iqdj/sLxVONotn6Z6WHyjjsfrGY0dnWOAkDvezpd6WyG6azUpKzNLht6Za0TlwIK
	deNKX8bB+HMFcWfQOuVqTXFy2l1r5Xjs3o/IfK3iOo9Vfjh37QgTJtLecpTj3DIG
	77/ZvQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyxwer4sy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 07:32:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-934956beec8so515494685a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 00:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786433569; x=1787038369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zik0MM+Spytg8wiKrAMNSNHAKxnc0Bb68YfojdbtMK8=;
        b=LXYI+R6hYMTebyjhHl8DhEcg4BfLPAUI/BRhonLwCpJQv/quLMkT/gcltaJIHDhw8M
         u75/ME/KxgP52rT2vAYGPmD9fgqIA6BwvqOreGVuepS6GEPkJftvf1InlIukmpmg7oMy
         Vn3HpDbDa7Jom8+1W3sshOOABs3q4YeyvTk+sDQ3JDGw5Xq59t6U3Wx2gPKREQvjqIYX
         DjV3n/m9LUOfKqzkKZf2sZE+T+eCHLpDgeXYr9c0CNZFiSuYDIYEdOXm0JGaNBINnrN2
         SLJseUITohtuoDfIs6tlgWd9MlEyBibDP5HN2fchMrVg35rkGI5qasGhEEUIbZOUCFTP
         JIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786433569; x=1787038369;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zik0MM+Spytg8wiKrAMNSNHAKxnc0Bb68YfojdbtMK8=;
        b=VBTmHfQwdLeRhGNgm4/FXmP2Obz6NpBRSwvYsQP336L4IpE+NdlCicUY8UtPbIAXCB
         tLVIUNF+o+ZZzFnayZ7TA1OEm/BuTTFbd1JUECS64KDs6ouMY+2F7V25LvU36Ggz3lD0
         WG67mSRj6kxtjIdqAmwnj1tiyT+0jhPW1lOLJUKjra9ddZ2UJLHIaUWbwBlqma2tJTJN
         rz/H0ADTmAT7VwbFY9HFGpY+gG4zygQmmy1f7YnqKI1yKh4ZGXHUsw0PcfyBlris7eKN
         kehmuAhSHHo1nHd1cIUwjtVwJfXigpbDWDpIGleMmiWzm8gz5ZAidzuQ2go7TUz6+rHX
         to/g==
X-Forwarded-Encrypted: i=1; AHgh+RrRkyi+aBy4FQT+apTxxU36Pbaeo/O+Xxu5GuE6sO1F7AogRuB2bq4qaVHyFAs/lbn/6lghxscENQu8rHEGkJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2bmcR9lNwSmdXuAzQDmx0+x0CBMSKtxO6GkRCkmp08ILnYFWb
	LCDddhd3kxZKLo3TNn78gUPBgF+05d1x/3mwX2cKOdzUBgH9CM6ra4qVVZXes8XhoQSb4e/CQ8H
	pMulZMKaSRoW94A7GedtD9HhWl+9o7lQ6kERnkCLohXL6lrj7/XOnGhwfsTY3hBDFtnkvRfg=
X-Gm-Gg: AR+sD13PP4tXQ9NPQtCURhniyaIVOra/ZhAYkoGnjzuJZT/RcWOD4RScWEh56tVx3Qz
	n1xHgP6pBoSb+321ANJDNe44Jsr13HyXo6DuFtqH7W8zkwI7kpZP0M3ni/wzC+/VnXizojctCV2
	7hqXbKj8Ah7+TsmwvFktgbPD+ntEfKfrF3U9Zs4NXL8qH5CZinFTr/DmEpX44sPZdjOfP1L66eb
	bZHkS+6GxrLZDE6LUrvR9pjcybhkgsCStjY74zfty9JAlm6S6IiDNe7C8U3zTh8441IV5qGl4N2
	qSdbOHg2QLcrW7LYwy5cAMSV+BxddjNPPVrnGUeZOLMJ6A3zgHQrHc9nIDzT1yuPTLvV79+2ffM
	s1WrQgWkyLslj8daVJuE/dwztyPvjJ7U6bgvEAK9beyVqZChefqAP63aBZTCjbteO6NUj0w508n
	E5kA88f1KIszYXvEnbed60nLwZCDh/Ni7eBVBnnI7f/zQYJGcC8OdhJER+2ugmNi920zM=
X-Received: by 2002:a05:620a:6482:b0:932:d9c4:3bec with SMTP id af79cd13be357-936a8f3d2cemr97740585a.38.1786433568644;
        Tue, 11 Aug 2026 00:32:48 -0700 (PDT)
X-Received: by 2002:a05:620a:6482:b0:932:d9c4:3bec with SMTP id af79cd13be357-936a8f3d2cemr97737685a.38.1786433568211;
        Tue, 11 Aug 2026 00:32:48 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20e40cc5c4sm22718566b.8.2026.08.11.00.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 00:32:47 -0700 (PDT)
Message-ID: <cb0d42dd-4755-49a8-8a05-297e4283914e@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 09:32:45 +0200
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Golle <daniel@makrotopia.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
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
Content-Language: en-US, nl
In-Reply-To: <2026081139-strenuous-greasily-f4e5@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: o6iLKpmqc0wGdF0BaI8newaOyOUFekSa
X-Authority-Analysis: v=2.4 cv=K8QS2SWI c=1 sm=1 tr=0 ts=6a7ad021 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=8OD1bfQqW12JbmighQMA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: o6iLKpmqc0wGdF0BaI8newaOyOUFekSa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA2MSBTYWx0ZWRfX3vneMU9bt6vu
 M8SQWeUWDEQRPIoL2HlbbWaCMSEobPso7sLdpy6Gndf97c6b1kte45d7cx2FWAvsy7Kj7jwl3Is
 z07JN+PjvUZqOjaE0iDBRDzbEkAlX3w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA2MSBTYWx0ZWRfX/nEI8oXPfFDA
 MY7zXfr8STClPyfzfz/2FZJjg8eQsVBI2rkXQl2lhoci+QF/V+sCtAmGMyjSKq6HuXBksSFcWos
 pMdE5GJ5QDvNcRj7lP8plAe824gBts5fhovG9RxznDqgRPPaHCk315P0LloQhqoZBx9Tn2e77dS
 xBugF702DyOw25peqm+SlmHfbt0btJfm+3uex9rogl+cint1hDHruK24faf1Ekt5uf904vy31tT
 me1Jt7YBIN8FACr9jpkjiuqUds96tOVkeup8DggzcBipdmV8QnKyvLUBeMSEVnGYH7MJa4N5l+B
 cUF/htM+R9cHq7eXZkph0SrMG4qlQy8UgwnDIm1pOVA/Qm8UHYn5MQbNz4+QqdMR7tGZ7UjE6UV
 tZS+jO606vuco1IgFpOSu4g0tBlcd58h890Me+3aNqZhN9SveR3+q667d5AeJcmw5e/nSU5HVBi
 ZTVCdbimztRsGQsxVFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110061

Hi Greg,

On 11-Aug-26 04:33, Greg Kroah-Hartman wrote:
> On Tue, Aug 11, 2026 at 01:47:17AM +0100, Daniel Golle wrote:
>> Three in-tree drivers (iwlwifi, hci_h5, btintel_pcie) schedule a
>> deferred re-probe of their own device from a work item in module
>> text.
> 
> That's a mess, why?  Why not fix that up to not do that?  Thousands of
> other kernel drivers do not do that, what makes these so special?

I can only speak for the hci_h5 driver where I added the reprobe code-path.

The problem is some of the Bluetooth HCI devices using hci_h5 loose all
state during system-suspend. This means that the HCI and the Bluetooth core
end up being out of sync.

So we basically need to tear down and re-build everything including
e.g. the firmware upload which happens at probe(). Doing a full reprobe
is by far the easiest way to do this.

I suspect the other 4 users + the pending driver which triggered
this are similar.

Sure we can do the whole tear-down + setup from some worker
scheduled at resume, while keep the driver attached but if we need
to duplicate that over 4 drivers + the pending driver which triggers
this then IMHO those 5 users are a pattern which deserves having
some helper to do this through the existing probe() + remove(),
rather then requiring those 5 drivers to open code this themselves.

Note that we already have device_reprobe(), which has 15 existing
users. This series just adds a helper to do a device_reprobe() from
a worker in a safe way.

Regards,

Hans




> 
>> The hand-rolled copies share two bug classes: the work function
>> ends with module_put(THIS_MODULE),
> 
> That's broken as-is.  a module should NEVER be calling
> module_get(THIS_MODULE) either.
> 
>> racing a concurrent rmmod freeing
>> the module text (the race module_put_and_kthread_exit() exists to
>> close for kthreads), and nothing synchronizes the deferred detach
>> against device_shutdown() or an administrative unbind.
> 
> yeah, that's a mess, don't do that.
> 
> Fix up the original drivers please, let's not encourage others to copy
> this broken scheme.
> 
> Also, your patches were not threaded properly :(
> 
> thanks,
> 
> greg k-h

