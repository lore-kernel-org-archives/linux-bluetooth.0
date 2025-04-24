Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AAE284670
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512338; cv=pass; b=YPSgxkvFuyRmOgcATj/t0S5OwyriCjKXcyK8RZMA7k+3Zsq3viJ+d77/NnvzkekLX+zIrwrCF9ogEEMWnk/7lsICgkEAfHaQ13PW/z9ZD8MD64kP4TNM1GdEpwIOy5ukDqNq+DSOpyulu2EidGFlMlosDOC+fd3PqgMXdETbZ8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512338; c=relaxed/simple;
	bh=EFeZtfM79JvEhUrbqIGGnna3hRelxbspI896dxz9Evc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W8v4lkAIp609Ap8YKGx7vTW8fGMRNczhNGbmrhzWhlx44Uf9bSFT2UzMZxQzdk63vAMMgmZuoUSwQHRLFsjzUUgrcfXs0DSq3vRkAsy3UZcWiqFj79SJ3AwlJeRDHJPLPJxsuGhDp7mSfUWhQPfAYr+Fa7w7w1HHtjCs1tSuXjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ludovico.denittis@collabora.com header.b=GrxoWUtn; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ludovico.denittis@collabora.com header.b="GrxoWUtn"
ARC-Seal: i=1; a=rsa-sha256; t=1745512331; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NbNZF9IJ2LQ5UZbKSJ/JFtQYmSZWOUt7cqnh3ou8ctpeNLodamixQowXY6UgFbGVwH7TpRaNuOC6NFGtvQLk5qKlNI4WOXH8IawanA0i5KgZL4x8U2PN7Kur7FnZVIiEgD0a1LbgeDGJNcnhttpql0GzaLb40myL57fMBLbi/Gk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745512331; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cUpdiRHu6xj95GibiL2cgCzfrIGaLthQbFsVAAYJmyA=; 
	b=jJhYBCuQgC3vLKHfXv/nlCzA9gPrDm3twLbtpPdAkyM5OHX/4MGjTtO8rwWSrqAnC4KomCLt5wHtXlMvvrEjoRLL8mtFgBFdKv1zp+iD+Fqd4Av48RSFvBom2xW4O7DWLJjvu8O7HAti6/ptGBaMWXi8+8cYtOxE1a6vCV3ykww=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ludovico.denittis@collabora.com;
	dmarc=pass header.from=<ludovico.denittis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745512331;
	s=zohomail; d=collabora.com; i=ludovico.denittis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=cUpdiRHu6xj95GibiL2cgCzfrIGaLthQbFsVAAYJmyA=;
	b=GrxoWUtnRjjqrUGz+82XA2sItygtbwPCpq49Hgh5oD6pcV9jIqR+2uf6uHdwYIsT
	2sNviWPsyHLJLozUCeAD5MNTBdQCcMGQsydNObsOoeoxi1rDOfTIIgh1UenrHLuMyUy
	hlKZny08ETQOrAdSaWACzJROmQjlz7pNX2AFi1w8=
Received: by mx.zohomail.com with SMTPS id 1745512328298518.0830631884635;
	Thu, 24 Apr 2025 09:32:08 -0700 (PDT)
Message-ID: <b3a66041-dce3-45db-8410-c67223151ce7@collabora.com>
Date: Thu, 24 Apr 2025 18:32:05 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v4 0/6] Support Sixaxis gamepad with classic bonded
 only
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20250424160236.179982-1-ludovico.denittis@collabora.com>
 <CABBYNZKFmW8a3MggGHp23d5SYotGQKDZBzn4Q2EB-xUToAUhDQ@mail.gmail.com>
Content-Language: en-US
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
In-Reply-To: <CABBYNZKFmW8a3MggGHp23d5SYotGQKDZBzn4Q2EB-xUToAUhDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Luiz,

On 4/24/25 6:18 PM, Luiz Augusto von Dentz wrote:
> Hi Ludovico,
>
> On Thu, Apr 24, 2025 at 12:03 PM Ludovico de Nittis
> <ludovico.denittis@collabora.com> wrote:
>> This series adds a new "CablePairing" property to allow us to
>> indentify devices that have been paired using a custom USB cable
>> cable method and that don't support the canonical bonding with
>> encryption. With that information, we can dynamically enforce
>> encryption to drastically reduce the attack surface, compared to just
>> disabling the "ClassicBondedOnly" property.
>>
>> The "CablePairing" property is exposed via D-Bus to allow
>> clients to potentually show this information to end users.
>>
>> As far as I can tell, starting the listening input server with
>> BT_IO_SEC_LOW and then bumping it in `hidp_add_connection()` should not
>> have any negative effect regarding the overall security. However,
>> please let me know if it turns out not being the case.
>>
>> Addresses https://github.com/bluez/bluez/issues/1165
>>
>> Changes in v2:
>>   - Start the listening input server with BT_IO_SEC_LOW only if we
>>     actually have a known sixaxis device
>>
>> Changes in v3:
>>    - Change the property from being sixaxis specific to a generic
>>      "CablePairing"
>>    - Remove the manual validation of Sixaxis HID report descriptor
>>      because we already replace it with a pre-dermined SDP record
>>      in `sixaxis.c`
>>
>> Changes in v4:
>>    - Instead of setting the server security level in adapter.c, we
>>      do it when registering the input devices, during probing
>>
>> Ludovico de Nittis (6):
>>    src: Add new CablePairing property
>>    client: Print CablePairing property
>>    sixaxis: Set CablePairing when pairing a Sixaxis with USB
>>    adapter: Add btd_adapter_has_cable_pairing_devices()
>>    input: Automatically use sec level low when using a cable paired
>>      device
>>    sixaxis: Set security level when adding a sixaxis device
>>
>>   client/main.c            |  1 +
>>   doc/org.bluez.Device.rst |  7 +++++
>>   plugins/sixaxis.c        |  8 ++++-
>>   profiles/input/device.c  | 20 +++++++++++--
>>   profiles/input/manager.c |  3 +-
>>   profiles/input/server.c  | 63 ++++++++++++++++++++++++++++++++++++++--
>>   profiles/input/server.h  |  3 +-
>>   src/adapter.c            | 17 +++++++++++
>>   src/adapter.h            |  1 +
>>   src/device.c             | 40 +++++++++++++++++++++++++
>>   src/device.h             |  2 ++
>>   11 files changed, 157 insertions(+), 8 deletions(-)
>>
>> --
>> 2.49.0
>>
> Looks like CI has found something not quite right still:
>
> https://github.com/bluez/bluez/pull/1191#issuecomment-2828175923
>

Oops, it should be fixed in the v5.

