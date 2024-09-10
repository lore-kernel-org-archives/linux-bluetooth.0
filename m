Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045061F956
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725980430; cv=pass; b=gfpWjqNYg+qEEIcOCerOEX9UtFO00Oq21gCPB116wGCheodefn5WRXumFO8DGC2TiZivoXeDYmQtk3A2pHwZmXC5SoTo4StDGhv+owfg0IekDHCRufi17TyBsQJKVMKCyfBcdY4Lm+ueG1No4QCp0HyhVxHwVTGskbmbw7+PvRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725980430; c=relaxed/simple;
	bh=kcluJTzPLIuA4M1lFPnAkXwYhgNxyxAr8Dn6/p/faVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jeb5WN5Ng82js7p5Nsnui8YzHgcX3orVM8AicDme3AIn9atjWprtAJUcu1XydnbA1Q4zlNnfKvNEBCz7xNhH8InkVn50+T/Mt0hAkEBA7NRIg9Vjw88tGX/1FC7UY1+SdvjZ+om1UuAQz11UJ6CcRX1bdZxb2ZpgQhbbD3dzw9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=WZJrsg0q; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="WZJrsg0q"
ARC-Seal: i=1; a=rsa-sha256; t=1725980424; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j/+emjlLkpidymKvOsoGvpFUPNOJzOCuCm1tRXJSX2Jl+D19SS8VeVN2fCbO4IL2XNqBHiwhbqDkLLbAHvELzcASM7udpk+hfr4VgWubGSjezMaRgbMKn5AbQUsYBZYMDJwBJKEnCQ/P5xYlPPmICG5qI7PCLtHPtTRrDLL0V5M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725980424; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZQITvjRX7sO5KN6diCfSwnDv8CSdUutfjemkY3xuRSg=; 
	b=delcTNdOedG0MGLHK4XXFxz4VHO2PsuC/PtB41ojFRVppnkqz/SfRqLPdaqEGlp1uXAiRAweJeq0Ak5C3rvjoOXEVbHz/hBujRhiRA1ctl2uMIOzCEciftGleHGhNNxqV3BtOghf9HnntEXmql+waEEoGBlkHtCkiY27m/LTZjU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725980424;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ZQITvjRX7sO5KN6diCfSwnDv8CSdUutfjemkY3xuRSg=;
	b=WZJrsg0qXOyU2KiPEhl9XRDlkXLymGaheRW4E4dWxkLbq0uGc74xjJDiM8X8EVT0
	SkxHv+UNtzJ6IRkh3GrHs9B/7oZEehLV7AIhRj7NA+aO+pWc/NsrmP+18EVUYz7QFE6
	CVo7/bjTz4xj1OIFGm+PW0r1RUD+zuXa6Z8S6rZc=
Received: by mx.zohomail.com with SMTPS id 1725980420032790.6908929473415;
	Tue, 10 Sep 2024 08:00:20 -0700 (PDT)
Message-ID: <3ae7ef27-e5d0-4b62-8a05-9f8b34d9e9c3@collabora.com>
Date: Tue, 10 Sep 2024 17:00:17 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v3] gobex: Replace g_convert by utf16_to_utf8
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20240910090201.115557-1-frederic.danis@collabora.com>
 <CABBYNZJoamaMNUaAmj00N+ubdYcdeYzoPO-i4kOGbeiVP4r7Rg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <CABBYNZJoamaMNUaAmj00N+ubdYcdeYzoPO-i4kOGbeiVP4r7Rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Luiz,

On 10/09/2024 16:48, Luiz Augusto von Dentz wrote:
> Hi Frédéric,
>
> On Tue, Sep 10, 2024 at 5:03 AM Frédéric Danis
> <frederic.danis@collabora.com> wrote:
>> The glibc's iconv implementation is based around plug in modules
>> for specific translations which may not been built on the platform
>> and prevent to use g_convert().
>> This commit replaces it by a function similar to the existing
>> utf8_to_utf16() function.
>> ---
>> v1 -> v2: Fix missing g_free
>> v2 -> v3: Replace g_malloc0 by alloca
>>            Fix UTF-16 buffer size allocation
>>            Ensure that UTF-16 buffer is terminated by '\0'
>>
>>   gobex/gobex-header.c | 41 +++++++++++++++++++++++++++++++++++------
>>   1 file changed, 35 insertions(+), 6 deletions(-)
>>
>> diff --git a/gobex/gobex-header.c b/gobex/gobex-header.c
>> index 002ba8861..889c794df 100644
>> --- a/gobex/gobex-header.c
>> +++ b/gobex/gobex-header.c
>> @@ -62,6 +62,34 @@ static glong utf8_to_utf16(gunichar2 **utf16, const char *utf8) {
>>          return utf16_len;
>>   }
>>
>> +static glong utf16_to_utf8(char **utf8, const gunichar2 *utf16, guint16 len,
>> +                               GError **err)
>> +{
>> +       glong utf8_len;
>> +       guint16 utf16_len, i;
>> +       gunichar2 *buf;
>> +
>> +       if (*utf16 == '\0') {
>> +               *utf8 = NULL;
>> +               return 0;
>> +       }
>> +
>> +       /* OBEX requires network byteorder (big endian) UTF-16
>> +        * but g_utf16_to_utf8 expects host-byteorder UTF-8
>> +        */
>> +       utf16_len = len / sizeof(gunichar2);
>> +       buf = alloca(sizeof(gunichar2) * utf16_len);
>> +       for (i = 0; i < utf16_len; i++)
>> +               (buf)[i] = g_ntohs(utf16[i]);
>> +       buf[utf16_len] = '\0';
> You will need to allocate one extra index if you want it to be NULL
> terminated otherwise you will be accessing past allocated area, that
> said can't you just pass the utf16_len to g_utf16_to_utf8 instead of
> -1?

iiuc g_utf16_to_utf8() doc, if the source len is passed the dest string 
may include embedded NUL characters or none, while when passing -1 it 
will stop at the first NUL character.I will update allocation length.
>> +
>> +       *utf8 = g_utf16_to_utf8(buf, -1, NULL, &utf8_len, err);
>> +       if (*utf8 == NULL)
>> +               utf8_len = -1;
>> +
>> +       return utf8_len;
>> +}
>> +
>>   static guint8 *put_bytes(guint8 *to, const void *from, gsize count)
>>   {
>>          memcpy(to, from, count);
>> @@ -130,7 +158,7 @@ GObexHeader *g_obex_header_decode(const void *data, gsize len,
>>          GObexHeader *header;
>>          const guint8 *ptr = data;
>>          guint16 hdr_len;
>> -       gsize str_len;
>> +       glong str_len;
>>          GError *conv_err = NULL;
>>
>>          if (len < 2) {
>> @@ -177,13 +205,14 @@ GObexHeader *g_obex_header_decode(const void *data, gsize len,
>>                          goto failed;
>>                  }
>>
>> -               header->v.string = g_convert((const char *) ptr, hdr_len - 5,
>> -                                               "UTF-8", "UTF-16BE",
>> -                                               NULL, &str_len, &conv_err);
>> -               if (header->v.string == NULL) {
>> +               str_len = utf16_to_utf8(&header->v.string,
>> +                                       (const gunichar2 *) ptr,
>> +                                       hdr_len - 5,
>> +                                       &conv_err);
>> +               if (str_len < 0) {
>>                          g_set_error(err, G_OBEX_ERROR,
>>                                          G_OBEX_ERROR_PARSE_ERROR,
>> -                                       "Unicode conversion failed: %s",
>> +                                       "UTF16 to UTF8 conversion failed: %s",
>>                                          conv_err->message);
>>                          g_error_free(conv_err);
>>                          goto failed;
>> --
>> 2.34.1
>>
>>
>

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718

