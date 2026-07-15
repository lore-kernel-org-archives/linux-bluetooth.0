Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879D03806D5
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131190; cv=pass; b=YCnoqqZt1CyNwcFqO2pgp/BYvB+Qq2m9G8gBcS9zOT06Xjld/FkL3qGJ0e3qUZcR2cw6Y7PjdWlkY1n1DJXFtq8OCpeUpoFzLycPWGuFAQmrYrQknDipQJBbyykr8LheajaSfypBIvYWFF8ZiYfBJWo8bp+jet+Gv+PF203YVgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131190; c=relaxed/simple;
	bh=DPcB2TZSmBxPEC+8EyEBQrTR2/hcBQ+lzRbrXaGAZHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bM8iOsOgQ6v5pA771h7WxQsFYSwmz7bimka7SvE6xWwwUBzNBe7TNZhwEaaStHWf5Qwq4mjjdcBNwmoXHkjaYFZHlz//XkUxncbBCeTpQmWMFiC63asIem54iKWWxwNQMq4WeOh1aZI9Rx13MufYc9sjiZ3xCKSbX+pp1/KmNCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=EQVaeKZb; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="EQVaeKZb"
ARC-Seal: i=1; a=rsa-sha256; t=1784131185; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HcHA0vVEPAgzWTeNi45hRDUFO+1s18Kylc7p1FvTZsgBW5VvPWuLyCqFShNM0571IECfJEltYrytu2T/+Vplj8clfYYZmNj9835bx67IP3yhHcD92hEg/3Nk1XqopvKeVDwhSs6MvBtvCSYI05JRgTPqoDSH/pRexJLIYxAQcSw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784131185; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9Y1MFITtRyt71+dN05OoDHqiTJ0JdPA1NAsByV/1rBc=; 
	b=VScUIUvOQ6eSTkAEsErX8K6HcLhx/X7845TXAVikWJiHhhA+6w/iIyHJln/xFWkbHlfSbc6QjrA4cr4UzaBJIDJqjPzyU+wxTsdFMNR4pyc9B3MBDMbeSqDToXN9VW3Fm0/ZBCKwk5ymbPtQ0NE3JGrioXzMjVgLNzYJ/1IsRlU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784131185;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=9Y1MFITtRyt71+dN05OoDHqiTJ0JdPA1NAsByV/1rBc=;
	b=EQVaeKZba9V+jLr20E6i1+7mHs/opwFtNqdjm/ZQnTPuKyYhmyD/mIKO+V5UGlCL
	HwrFk4x0e7oz2PATbIthU/qKF2CDRzjhj17J45BMP5qHWJYz0/a67HPdc3m8Segx8ox
	09UxVU1tH0qJ05tcQDG2ju4e+rZ1WfStN5E0fsjY=
Received: by mx.zohomail.com with SMTPS id 1784131183304291.66613768209027;
	Wed, 15 Jul 2026 08:59:43 -0700 (PDT)
Message-ID: <a46d9fe9-a1cf-4767-9ba7-7c03f44228b9@collabora.com>
Date: Wed, 15 Jul 2026 17:59:40 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v2 3/8] doc: document admin.allow optional
 controller argument
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20260715090206.212130-1-frederic.danis@collabora.com>
 <20260715090206.212130-4-frederic.danis@collabora.com>
 <CABBYNZ+vttWK-2f8gJSATZ9pXBeg2Ncy-OreH+63ppiuQ0ricg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <CABBYNZ+vttWK-2f8gJSATZ9pXBeg2Ncy-OreH+63ppiuQ0ricg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Luiz,

On 15/07/2026 15:40, Luiz Augusto von Dentz wrote:
> Hi Frédéric,
>
> On Wed, Jul 15, 2026 at 5:03 AM Frédéric Danis
> <frederic.danis@collabora.com> wrote:
>> Update bluetoothctl usage to 'admin.allow [ctrl] [clear/uuid1 uuid2 ...]'
>> and add explicit controller examples.
>>
>> Refresh AdminPolicySet examples to include the controller-qualified
>> admin.allow form.
>>
>> Assisted-by: GPT:GPT-5.3-Codex
>> ---
>>   doc/bluetoothctl-admin.rst       | 13 +++++++++++--
>>   doc/org.bluez.AdminPolicySet.rst |  1 +
>>   2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/doc/bluetoothctl-admin.rst b/doc/bluetoothctl-admin.rst
>> index d4446ce95..ce15b8728 100644
>> --- a/doc/bluetoothctl-admin.rst
>> +++ b/doc/bluetoothctl-admin.rst
>> @@ -9,7 +9,7 @@ Admin Policy Submenu
>>   :Version: BlueZ
>>   :Copyright: Free use of this software is granted under the terms of the GNU
>>               Lesser General Public Licenses (LGPL).
>> -:Date: November 2022
>> +:Date: June 2026
>>   :Manual section: 1
>>   :Manual group: Linux System Administration
>>
>> @@ -30,15 +30,22 @@ allow
>>
>>   Allow service UUIDs and block rest of them.
>>
>> -:Usage: **> allow [clear/uuid1 uuid2 ...]**
>> +:Usage: **> allow [ctrl] [clear/uuid1 uuid2 ...]**
>> +:[ctrl]: Bluetooth controller address (optional; defaults to the selected controller)
>>   :Uses: **org.bluez.AdminPolicySet(5)** property **ServiceAllowList**
>>   :[clear/uuid1 uuid2 ...]: List of service UUIDs to allow, or "clear" to remove all restrictions
>>   :Example Get current allowed UUIDs list:
>>          | **> allow**
>> +:Example Get current allowed UUIDs list for a specific controller:
>> +       | **> allow 00:11:22:33:44:55**
>>   :Example Allow Serial Port Profile only:
>>          | **> allow 0x1101**
>> +:Example Allow Serial Port Profile on a specific controller:
>> +       | **> allow 00:11:22:33:44:55 0x1101**
>>   :Example Allow Serial Port Profile and LAN Access Profile:
>>          | **> allow 0x1101 0x1102**
>> +:Example Allow Serial Port Profile and LAN Access Profile on a specific controller:
>> +       | **> allow 00:11:22:33:44:55 0x1101 0x1102**
>>   :Example Allow Serial Port Profile, LAN Access Profile, and Dialup Networking Profile:
>>          | **> allow 0x1101 0x1102 0x1103**
>>   :Example Allow Advanced Audio Distribution Profile only:
>> @@ -51,6 +58,8 @@ Allow service UUIDs and block rest of them.
>>          | **> allow 00001101-0000-1000-8000-00805f9b34fb 00001102-0000-1000-8000-00805f9b34fb**
>>   :Example Remove all UUID restrictions:
>>          | **> allow clear**
>> +:Example Remove all UUID restrictions on a specific controller:
>> +       | **> allow 00:11:22:33:44:55 clear**
>>   :Example Allow SPP, LAP, and DUN using mixed UUID formats:
>>          | **> allow 0x1101 00001102-0000-1000-8000-00805f9b34fb 0x1103**
>>
>> diff --git a/doc/org.bluez.AdminPolicySet.rst b/doc/org.bluez.AdminPolicySet.rst
>> index db132b7de..29fe3bdf7 100644
>> --- a/doc/org.bluez.AdminPolicySet.rst
>> +++ b/doc/org.bluez.AdminPolicySet.rst
>> @@ -55,3 +55,4 @@ Possible errors:
>>   Examples:
>>
>>   :bluetoothctl: > admin.allow [clear/uuid1 uuid2 ...]
>> +:bluetoothctl: > admin.allow [ctrl] [clear/uuid1 uuid2 ...]
> Normally, the command should use the controller main menu aka.
> bluetoothctl> select so we probably need a environment variable to
> pass adapter currently in use.

The proposed implementation allows to pass or not the controller, 
allowing to change admin policy for another controller than the selected 
one.
If it is not present this command uses the selected one.

>
>> --
>> 2.43.0
>>
>>
>

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718


