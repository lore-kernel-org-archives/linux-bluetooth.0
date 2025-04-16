Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E401C27
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 17:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826188; cv=none; b=Q7Bsj4RuQYRNIKUimmxuGt+9kNbkIxKu/R66YoN6Bi8Bl7Rs8Eh4jpasoTUfEoa+5DmRodojcG+fvhwKNPhk5mApuxhd5tMoHsAIMp35NgHptfPfo+7UDs9JwjSBDEYI8tc98ioz/S2+s+aIuldVpNWLRee/8r5AlGUPsVLItac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826188; c=relaxed/simple;
	bh=Iu7cIEbX0+E1gvaP6omapnU4mVli9zg1DmU1vbIk6Qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uwAaPoRB6IGmZDZ3fq5rSupIeLGfOdJRFmmk7u7SH/2V2AfXm3ngtRdDWi+yygzDKQLc5ow/tLDT0oYztRG68RzERER2PR0e6SQTwhWwx4yzX0SODIlMNVJkTI+iTZ+uA1bXvrGBltk8Q3po9aud6ntaY9EC8FfypWwa/GuKPt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from 1.b.9.e.f.d.5.5.7.e.f.c.1.f.7.2.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:27f1:cfe7:55df:e9b1] helo=[IPV6:fd34:5ae5:dfe:ae11::1])
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u56zl-009mxM-1r;
	Wed, 16 Apr 2025 18:56:21 +0100
Message-ID: <d6936cb9-c246-46b6-bdb8-95429147c6e3@pileofstuff.org>
Date: Wed, 16 Apr 2025 18:56:20 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 1/2] build: add bluez.tmpfiles
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20250416152039.971257-1-kernel.org@pileofstuff.org>
 <20250416152039.971257-2-kernel.org@pileofstuff.org>
 <CABBYNZLULgM_9DPvbD-Vf-_h3nQvTNsnYK4b-6X4BkaHO1T0_w@mail.gmail.com>
Content-Language: en-GB
From: Andrew Sayers <kernel.org@pileofstuff.org>
In-Reply-To: <CABBYNZLULgM_9DPvbD-Vf-_h3nQvTNsnYK4b-6X4BkaHO1T0_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/04/2025 16:31, Luiz Augusto von Dentz wrote:
> Hi Andrew,
>
> On Wed, Apr 16, 2025 at 11:21 AM Andrew Sayers
> <kernel.org@pileofstuff.org> wrote:
>> Systemd tmpfiles ensure the status of particular files.
>> Add a file that bluez can use in future.
>>
>> Distributors should install the new "tools/bluez.tmpfiles" file, e.g. by
>> moving it to `debian/bluez.tmpfile` or using Fedora's `%{_tmpfilesdir}`
>> variable.
> Not really following the purpose of this one, it just in order to tell
> the packages to create this file? Is this specific to obexd lock file?
> If it is then we probably should have it somewhere under obexd folder.
We need a directory for the lock file that's guaranteed to be 
world-writable,
but in some distributions (e.g. Fedora), /run/lock is only writable by root.
systemd-tmpfiles is systemd's solution to this problem - config files 
like this
go in /usr/lib/tmpfiles.d and tell systemd to create files at boot time.
In this case, patch 2/2 adds an instruction to create `/run/lock/bluez`.

Distro's need to install this in some distro-specific way, so I split
it out into its own commit to make it easier for them to spot.  As
that's a bit of extra work for them, I've proposed creating a more
general file that can be reused in the (plausible but not probable)
case another temporary file is required some time in the future.
Happy to make the file obex-specific instead if that's better, in
which case I'll call the temp directory /run/lock/obex.
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
