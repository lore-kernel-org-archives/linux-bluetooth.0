Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B5D213E71
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994426; cv=none; b=KW0j7It3IfLb3R5aNJnVCHdlWQfEobQd8piYr5X0Veg9vf+OAgDv5uLBn+fi1ummH8HCOyzIFEJ1plG9uVJm1QBSTGhdNZW7lQuRQUsXi1kLEMc5uBRH0I79RiHS0FICzpSncxILDxgvrTC0fr+yovcF1MzgMrqrKX0UZrPcRMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994426; c=relaxed/simple;
	bh=M0J4Mgn9F9irsN2m6mpYfviUnacvHSomHWFxoE3sCzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edAi2ZgwEkUAOXxtsiEkINmzpEBG7OkLPqIfvMDK0ghml6WTlc2AbI3pK4pX4bMP6Z1GCIfRlsZI6mwkWnCn5jMBMLmW75sgfEpbVucvE+4RArRvu356Jf2p6aEsGoz8c8NfqD84k0XnV1gsuKXj2AuEXmmtkpoO1vRpknZeKwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from 5.b.4.c.0.b.6.8.4.c.5.9.d.5.9.8.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:895d:95c4:86b0:c4b5] helo=[IPV6:fd34:5ae5:dfe:ae11::1])
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u5olJ-0010bQ-0R;
	Fri, 18 Apr 2025 17:40:20 +0100
Message-ID: <71a14d3e-7625-4414-9873-9105c991684d@pileofstuff.org>
Date: Fri, 18 Apr 2025 17:40:12 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v2 1/2] build: add bluez.tmpfiles
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Pauli Virtanen <pav@iki.fi>
References: <20250418153115.1714964-1-kernel.org@pileofstuff.org>
 <20250418153115.1714964-2-kernel.org@pileofstuff.org>
 <CABBYNZ+ig2=VWOwFQvkmZB4WebtY03C9AYktSXLmz6XZHXppMg@mail.gmail.com>
Content-Language: en-GB
From: Andrew Sayers <kernel.org@pileofstuff.org>
In-Reply-To: <CABBYNZ+ig2=VWOwFQvkmZB4WebtY03C9AYktSXLmz6XZHXppMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/04/2025 16:35, Luiz Augusto von Dentz wrote:
> Hi Andrew,
>
> On Fri, Apr 18, 2025 at 11:31 AM Andrew Sayers
> <kernel.org@pileofstuff.org> wrote:
>> Systemd tmpfiles ensure the status of particular files.
>> Add a file that bluez can use in future.
>>
>> Distributors should install the new "tools/bluez.tmpfiles" file, e.g. by
>> moving it to `debian/bluez.tmpfile` or using Fedora's `%{_tmpfilesdir}`
>> variable.
> I thought we would not be adding this anymore with the addition to '-'
> prefix and the added comments that should be left to distros to figure
> it out.

Ah sorry, I thought you meant to add the comment *instead of* the '-'.
Leaving it to distro's feels a bit dangerous, but Pauli Virtanen's idea
seems like a better approach anyway (thanks Pauli!).

I'll take a look at that and should be back with a v3 next week.

>
>> Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
>> ---
>>   .gitignore              | 1 +
>>   configure.ac            | 1 +
>>   tools/bluez.tmpfiles.in | 0
>>   3 files changed, 2 insertions(+)
>>   create mode 100644 tools/bluez.tmpfiles.in
>>
>> diff --git a/.gitignore b/.gitignore
>> index 108c3b820..e4431443f 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -157,6 +157,7 @@ obexd/src/obex.service
>>   obexd/src/org.bluez.obex.service
>>   tools/obex-client-tool
>>   tools/obex-server-tool
>> +tools/bluez.tmpfiles
>>   unit/test-gobex
>>   unit/test-gobex-apparam
>>   unit/test-gobex-header
>> diff --git a/configure.ac b/configure.ac
>> index 1e089aaa7..4ebd513d6 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -530,5 +530,6 @@ AC_CONFIG_FILES(
>>          src/bluetooth.service
>>          tools/bluetooth-logger.service
>>          tools/mpris-proxy.service
>> +       tools/bluez.tmpfiles
>>   )
>>   AC_OUTPUT
>> diff --git a/tools/bluez.tmpfiles.in b/tools/bluez.tmpfiles.in
>> new file mode 100644
>> index 000000000..e69de29bb
>> --
>> 2.49.0
>>
>>
>
