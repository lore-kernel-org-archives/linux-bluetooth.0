Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0F31AA7A6
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765545513; cv=none; b=rlUR7F9w+xw4dqKCdaztAHuJ9A+ax5/6mz6AIuIGT0V4GpDwNiAlZusKDPwqOlbqfcvDmS9X1ztaOYNQ+c2QwKufIFL4jLybJr/6pegZ8Bco04CA5ATkDzqiOB/wko/UgsrjksQY4MKT+1spsNgzAOb60QFX73vGys2Kw4YweEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765545513; c=relaxed/simple;
	bh=0z+jrAKV8xqPVRxNpMBCXWIzh6Ap815I/Ky7+voozG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mmCfukkYZ0++2oZAaXvmJv8oIdR5LvxpfUZqptRF/gUE+J66eNsRJjdanrUR9m2xwKvbAmZbvtJP+ghqUwLgwv4hIDzIDPX6ehWcB04azWG9/npnhVWEo//GCYmX6nJ4gNU+nTl3q7oVtPLowsyfJYkrgBHkeSdnmHteHT8BWU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ryTbaoRc; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ryTbaoRc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D/KQyD1u3a+66/0OhOkx8kJRVv4YELCkLe6a27qIabg=; b=ryTbaoRcwTXiEuuDu4J/wA8by1
	AzV0z51GCSvchBP1ZVawlpTWAIrGpbZkLP7koDjSIoUbwjKeWaaRhHBAlW5GkNfn0oKG1qGBikhO/
	INPGfBmGQs+lp7zU76W8lapOIQ1JcmT6jxq6PxS4KOofeRiRsUF5edtZoRn8d28h8CKFHUyfT7YYE
	+X6kBFxwfarpWxZ6Sz2kJCHuS1sYBPJuPSd5X4Ql0f3gh1pBN+2I8cNDiitI2vQoo0jc06fOXhpfh
	oQTVAl6S+EwJFEET0QFqqa10AjnsE2hLlSW7HKmqHuoXy+QjQ7mHYMmlegU0Jrf8czMS2RCmcwn9V
	EAaxI/Qg==;
Received: from 241.red-83-35-220.dynamicip.rima-tde.net ([83.35.220.241] helo=[192.168.1.65])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vU32R-00C10K-4S; Fri, 12 Dec 2025 14:18:27 +0100
Message-ID: <5b33a4b7-378d-42e9-83a4-fe5062a04eff@igalia.com>
Date: Fri, 12 Dec 2025 14:18:26 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 1/1] Support for config fragments (conf.d style
 dirs)
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20251211211356.3842264-1-mafm@igalia.com>
 <20251211211356.3842264-2-mafm@igalia.com>
 <CABBYNZKPn27zfKdRDSD2uChTB7eVaWiCKMdvbvvPGDwfBZmADg@mail.gmail.com>
Content-Language: en-US, en-GB
From: "Manuel A. Fernandez Montecelo" <mafm@igalia.com>
In-Reply-To: <CABBYNZKPn27zfKdRDSD2uChTB7eVaWiCKMdvbvvPGDwfBZmADg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz,

On 11/12/2025 23:15, Luiz Augusto von Dentz wrote:
> [...]
> Great work on the commit message, really helpful.

You're welcome, and thanks for the review.

The intention was, first of all, to highlight and explain the benefits 
of this feature in the case that some people are not familiar.  My main 
worry was if you would find this feature useful, or not at all and 
wanted to drop it.


>> diff --git a/acinclude.m4 b/acinclude.m4
>> index 8046c9a7d..560a5d44b 100644
>> --- a/acinclude.m4
>> +++ b/acinclude.m4
>> @@ -63,8 +63,8 @@ AC_DEFUN([COMPILER_FLAGS], [
>>                  with_cflags="$with_cflags -Wformat -Wformat-security"
>>                  with_cflags="$with_cflags -Wstringop-overflow"
>>                  with_cflags="$with_cflags -DG_DISABLE_DEPRECATED"
>> -               with_cflags="$with_cflags -DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_36"
>> -               with_cflags="$with_cflags -DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_36"
>> +               with_cflags="$with_cflags -DGLIB_VERSION_MIN_REQUIRED=GLIB_VERSION_2_76"
>> +               with_cflags="$with_cflags -DGLIB_VERSION_MAX_ALLOWED=GLIB_VERSION_2_76"
> 
> Hmm, I'd like to avoid upping the dependency if possible, what is the
> new function(s) that required such update?

There are two cases:

1) G_REGEX_DEFAULT and G_REGEX_MATCH_DEFAULT

src/conf_d.c:29:9: error: ‘G_REGEX_DEFAULT’ is deprecated: Not available 
before 2.74 [-Werror=deprecated-declarations]
    29 |         regex = g_regex_new(regex_pattern, G_REGEX_DEFAULT, 
G_REGEX_MATCH_DEFAULT, &error);

This can be easily substituted with constants (zero in both cases, IIRC.


2) g_ptr_array_sort_values()

src/conf_d.c:61:17: error: ‘g_ptr_array_sort_values’ is deprecated: Not 
available before 2.76 [-Werror=deprecated-declarations]

Sorting can be done more manually, I suppose.  Some kind of sorting is 
needed to sort the files in conf.d alphabetically, to have control over 
what-overrides-what.


Do you want me to iterate over these two things and provide a version 
that works on 2_36?


>> +static void confd_override_config(GKeyFile *keyfile, const gchar *new_conf_file_path, gboolean accept_new_groups, gboolean accept_new_keys)
 >
 > Pretty sure the above is over 80 columns.

Yes, sorry, this one and other lines go way over the limit, I'll review 
that in the next review.


Cheers.
-- 
Manuel A. Fernandez Montecelo <mafm@igalia.com>
