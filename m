Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B428F264FB9
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046259; cv=none; b=QSTQsAkTPGAeaiu3qpLCbPm57eGoCwCd6TceT5WHS95aC7Qlpu3eTZjXVMcV7TTpFWL1c/r/HTlBzv3KEfXOlrTIkkNl+hBh50KPTWBBsROlUy9bYmHEc6Gna67QxdzzUUdr3cs3SsAuBN1EyPcec5gJF29owexX7UH84C3IuCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046259; c=relaxed/simple;
	bh=Yr8kY2hsRRMsWgsIJ3niURyVY8YnB+4sSU4Rtu4GarU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=af3bVX0atjcQla0DhaLKhSUtfb8KCrtFARJYVHxWY4EEoEyorGB9Ta0YAasfEeM75taHN849wNJUUM8jZfKQqo1V7wwBPq9s0rLdf28onHg5roQfiMDkkLsTDLVI9dyz02gaTBL/6MNPYqJFLJK1cPEBloAyx3Jnf1CdiYjAsEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be; spf=pass smtp.mailfrom=essensium.com; dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b=Hcu4AzIh; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=essensium.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b="Hcu4AzIh"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3913d129c1aso236482f8f.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 13:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1746046254; x=1746651054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7EHb3hwMb+cyCY37d80Wt2GJvcVp3547pKADVWGbU18=;
        b=Hcu4AzIhmXc5IFdYXCOm5TiKFBBPqRyUXU+L3c7CwPvoPozdOYoRyfaU2+FfYLisNW
         FHlVB3BhQC15QboaYOH8X6fNxB/xAQq9LjdDcjafxW8w79pToTQwSlMkUyZD5VaxDBmd
         AWSrcVtBbzoPVqYk1xJf57hD0YO20oENIcaH8o18gNd+E96BvlclLLNiB8sIGyWGd9kt
         /tWfbrD+jfRu840PgAlC57ncveKHroDvmh2JQ8CyQ1S2Bxo4euODKhuMP7ObMre40PgJ
         acQfVr59mlqgbYu3u/BORlUlaIJ9I2SfWyoxxC0gurMPry/EiaXcLRmgHk7d0oU7YUme
         jn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746046254; x=1746651054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7EHb3hwMb+cyCY37d80Wt2GJvcVp3547pKADVWGbU18=;
        b=hqXScBk0wgB+5DmRtWS5sdN/5/SW/rORyRY3iV3+lFyDdpkWvwGwoc6HORxOsQeoWQ
         gPJQTCHPXOxBfp1jylwMnOywMgGhHt56am3nAjYLslPqfKShNpjmcYVWmRO0yWEZi4le
         ETibPyOqtWB7AlNwzx40poeTP3juYSMKJf/fTur3AiNGLQhxfsntBLFkNXmA31ActTp1
         9+UQoBuK4T1CDhRl1WolLlCqa1QTLZYcn9nRaDddF2NyyL8aLsT9TtJ72QCg+UpckoKv
         i/12lyHs+W3kdgDJgTIHRtoCO3KhzDOhOR7EfoMJTDh2Ec4f2ZOGKBBCmxJdmAkMhOpb
         ybbA==
X-Gm-Message-State: AOJu0YxHRk2XnWZgl+TPaA5u5i1g4vI4Kos1Mxg0nZPANFPUpnPjZY83
	5cjOL/7T/7imOAbZkGhffspsGoehu19Cg7o065w+6CP74dhw1DVKocqQbeBwuMOYK1t1ffbtwSU
	dXKw=
X-Gm-Gg: ASbGnctyns4CBrJF1YP9OuFDUorv1ljUPSE8QT2jg35DZqpGU13vSTgx/lC7mcpLXBA
	YyG+UX+bsjsCAHivogg/6KLdR7D5xmDnTb1F1qos7AdBaX230f4yoxXx9ekxI13LjVZFT0Tq88u
	CWSFLDFPJVSyrIb2f1IPD4O1w5zRcJ80EoNST+b2Vw750L8zTUMFuJv9RtKns276AWDCMWqcCG8
	ImSiPI1Lgxbi940HC7aS/IFEqgzCqUWVPYp8EWByFN6Tfsaq9zpm1xl9U6gixo8FL6R8JxxGtW1
	pD9ZgPGVzqY3bq5w4iCiIG2K102IunHSBZjS/6hJXd7jJw==
X-Google-Smtp-Source: AGHT+IE6VpmzE5RSy/fXwzmUWATf/xjXbbQKYx5Q6sk1u37UrNmFJLK+y00rFEsjfHgx5yMQS82ZKw==
X-Received: by 2002:a5d:4fce:0:b0:39f:cf7:2127 with SMTP id ffacd0b85a97d-3a092cf7d24mr797095f8f.14.1746046253861;
        Wed, 30 Apr 2025 13:50:53 -0700 (PDT)
Received: from [192.168.4.20] ([79.132.233.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ccb8e1sm18157329f8f.59.2025.04.30.13.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 13:50:53 -0700 (PDT)
Message-ID: <e741bb41-aa96-42c4-bad0-e3e256ac64bf@mind.be>
Date: Wed, 30 Apr 2025 22:50:52 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 2/2] input: fix HoG compilation w/o HID
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20250430143610.387300-1-thomas.perale@mind.be>
 <20250430143610.387300-3-thomas.perale@mind.be>
 <CABBYNZK8wTSAD=4A3Rvc59tLwr7JvC1wWZbSduQCUNonjhk68Q@mail.gmail.com>
Content-Language: en-US
From: Thomas Perale <thomas.perale@mind.be>
In-Reply-To: <CABBYNZK8wTSAD=4A3Rvc59tLwr7JvC1wWZbSduQCUNonjhk68Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz,

Thanks for your review

> This doesn't look correct, the input.conf is used to configure both
> HID and HOG, so why do you think it is a good idea to ignore it if HID
> has been disabled? What we probably should do is to move the portion
> of input_init that are HOG specific, e.g. LEAutoSecurity, which is
> what is being used above.
> This part we will probably have to duplicate the parsing of
> UserspaceHID from input_init.
My reasoning was that since I didn't saw the 'input.conf' file being 
read in the hog_init I thought it was for a reason. While for the 
'LEAutoSecurity' option it's indeed probably better to encapsulate the 
functions only in the HOG file. For the 'UserspaceHID' option as you 
said, reading the option will need to be duplicated in both input_init 
and hog_init. If this is OK for you to read this option two times then I 
can send a v2 of my patch.

Thomas

On 4/30/25 5:20 PM, Luiz Augusto von Dentz wrote:
> Hi Thomas,
>
> On Wed, Apr 30, 2025 at 10:42 AM Thomas Perale <thomas.perale@mind.be> wrote:
>> Commit [1] introduced a dependency with the HID plugin in the HoG code
>> As a result, building with --disable-hid --enable-hog caused linker
>> errors due to undefined references to HID-related functions:
>>
>> ```
>>> ./configure --disable-hid --enable-hog
>>> make
>> /usr/bin/ld: profiles/input/bluetoothd-hog.o: in function `hog_accept':
>> /home/../bluez/profiles/input/hog.c:184:(.text.hog_accept+0xbb): undefined reference to `input_get_auto_sec'
>> /usr/bin/ld: profiles/input/bluetoothd-hog.o: in function `hog_disconnect':
>> /home/../bluez/profiles/input/hog.c:205:(.text.hog_disconnect+0x12): undefined reference to `input_get_userspace_hid'
>> collect2: error: ld returned 1 exit status
>> make[1]: *** [Makefile:6344: src/bluetoothd] Error 1
>> make: *** [Makefile:4695: all] Error 2
>> ```
>>
>> This patch introduces the HAVE_HID symbol to conditionally call the
>> HID-related code in the HoG plugin only when HID is enabled.
>>
>> Additionally, hog_disconnect() reverts to its pre-[1] behavior when
>> the HID plugin is unavailable.
>>
>> [1] 1782bfd79 input: Add support for UserspaceHID=persist
>>
>> Fixes: https://github.com/bluez/bluez/issues/1228
>> ---
>>   configure.ac         |  3 +++
>>   profiles/input/hog.c | 11 ++++++++++-
>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index 1e089aaa7..aa56b7b81 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -194,6 +194,9 @@ AM_CONDITIONAL(NETWORK, test "${enable_network}" != "no")
>>   AC_ARG_ENABLE(hid, AS_HELP_STRING([--disable-hid],
>>                  [disable HID profile]), [enable_hid=${enableval}])
>>   AM_CONDITIONAL(HID, test "${enable_hid}" != "no")
>> +if test "${enable_hid}" != "no"; then
>> +       AC_DEFINE(HAVE_HID, 1, [Define to 1 if you have HID support.])
>> +fi
>>
>>   AC_ARG_ENABLE(hog, AS_HELP_STRING([--disable-hog],
>>                  [disable HoG profile]), [enable_hog=${enableval}])
>> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
>> index 97224f0d1..7ad94c474 100644
>> --- a/profiles/input/hog.c
>> +++ b/profiles/input/hog.c
>> @@ -40,13 +40,16 @@
>>   #include "src/shared/gatt-client.h"
>>   #include "src/plugin.h"
>>
>> -#include "device.h"
>>   #include "suspend.h"
>>   #include "attrib/att.h"
>>   #include "attrib/gattrib.h"
>>   #include "attrib/gatt.h"
>>   #include "hog-lib.h"
>>
>> +#ifdef HAVE_HID
>> +#include "device.h"
>> +#endif /* HAVE_HID */
>> +
>>   struct hog_device {
>>          struct btd_device       *device;
>>          struct bt_hog           *hog;
>> @@ -181,8 +184,10 @@ static int hog_accept(struct btd_service *service)
>>          if (!device_is_bonded(device, btd_device_get_bdaddr_type(device))) {
>>                  struct bt_gatt_client *client;
>>
>> +#ifdef HAVE_HID
>>                  if (!input_get_auto_sec())
>>                          return -ECONNREFUSED;
>> +#endif /* HAVE_HID */
> This doesn't look correct, the input.conf is used to configure both
> HID and HOG, so why do you think it is a good idea to ignore it if HID
> has been disabled? What we probably should do is to move the portion
> of input_init that are HOG specific, e.g. LEAutoSecurity, which is
> what is being used above.
>
>>                  client = btd_device_get_gatt_client(device);
>>                  if (!bt_gatt_client_set_security(client,
>> @@ -202,10 +207,14 @@ static int hog_disconnect(struct btd_service *service)
>>   {
>>          struct hog_device *dev = btd_service_get_user_data(service);
>>
>> +#ifdef HAVE_HID
>>          if (input_get_userspace_hid() == UHID_PERSIST)
>>                  bt_hog_detach(dev->hog, false);
>>          else
>>                  bt_hog_detach(dev->hog, true);
>> +#else
>> +       bt_hog_detach(dev->hog, false);
>> +#endif /* HAVE_HID */
> This part we will probably have to duplicate the parsing of
> UserspaceHID from input_init.
>
>>          btd_service_disconnecting_complete(service, 0);
>>
>> --
>> 2.49.0
>>
>>
>
