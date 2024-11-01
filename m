Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E75486252
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462593; cv=none; b=fDODwSXosYNIfcff60bVY37tu5+0aR1uMOCV3yowSPu6BSZjDp0PatQivq8iAZYIpOM9Td7ORNi1Ob3jd/6C7sSuYSyN7RQCK5Wg5Pgjgp9//fHQP9ZIwGHJoLui/MjDPFbnlx+qW7ncHnw8vC+zBEvI6DZErD9Z3AT9QX2z+SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462593; c=relaxed/simple;
	bh=7D0Li+zQtATWHgPLMePZxlstS5zGEJnnDXcCwMkY4y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DvkWPBa+cCPXAJrTeUpwMEkebDwP57i9dHLyImukQjUS4qZutTm35rg1BflKFhgteKLaFhJfE1UiEC6OZ88wS+8ZOo3/w3RNWq3avAwHdUORY91FVwMiuCSl/zh57Yw5ddVu3XrxkhwgbS9heIvSkpPQjH2qw6rboOLeArDjFJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1A89B61E5FE05;
	Fri, 01 Nov 2024 13:03:01 +0100 (CET)
Message-ID: <7c112267-b566-44ad-834e-e15b8fb39505@molgen.mpg.de>
Date: Fri, 1 Nov 2024 13:03:00 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] obex : Fix for PBAP GET request in PTS testing
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <20241101093304.1631217-1-quic_amisjain@quicinc.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241101093304.1631217-1-quic_amisjain@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Amisha,


Thank you for your patch. For the commit message summary, it’d be great 
if you made it a statement by using a verb in imperative mood, and 
removed the space before the colon:

obex: Fix PBAP GET request in PTS testing

Am 01.11.24 um 10:33 schrieb Amisha Jain:
> This change is required for passing below PTS testcases -

I’d use a colon instead of a hyphen.

> 1. PBAP/PSE/PBD/BV-02-C
> 2. PBAP/PSE/PBD/BV-03-C
> 3. PBAP/PSE/PBD/BI-01-C
> 4. PBAP/PSE/PBD/BV-13-C
> 5. PBAP/PSE/PBD/BV-14-C
> 6. PBAP/PSE/PBD/BV-17-C
> 
> For all the GET phonebook request sent by PTS has no extra params
> added in it, therefore PBAP server is rejecting the request

Maybe: PTS sends all the GET phonebook requests without extra params. 
Therefore, the PBAP server is rejecting the requests with a `Bad 
Request` response.

> by sending 'Bad Request' as response.
> So appending few default params in GET request to avoid

s/appending/append/

> testcase failure.
> This params are already added for Vcardlisting and Vcardentry

s/This/These/

> operations.
> 
> ---
>   obexd/plugins/pbap.c | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
> index 4175f9de8..f70a17cdf 100644
> --- a/obexd/plugins/pbap.c
> +++ b/obexd/plugins/pbap.c
> @@ -511,7 +511,23 @@ static int pbap_get(struct obex_session *os, void *user_data)
>   		rsize = 0;
>   	}
>   
> -	/* Workaround for PTS client not sending mandatory apparams */
> +	/*
> +	 * Workaround for PTS client not sending mandatory apparams
> +	 *
> +	 * Add MaxListCount attribute, description as per PBAP spec
> +	 *
> +	 * 5.1.4.3 MaxListCount :
> +	 * This header is used to indicate the maximum number of
> +	 * entries of the <x-bt/phonebook> object that the PCE
> +	 * can handle. The value 65535 means that the number of
> +	 * entries is not restricted. The maximum number of entries
> +	 * shall be 65,535 if this header is not specified.
> +	 *
> +	 * 0x04 - Tag id
> +	 * 0x02 - length
> +	 * next 2 bytes are value - 0xffff
> +	 */
> +
>   	if (!rsize && g_ascii_strcasecmp(type, VCARDLISTING_TYPE) == 0) {
>   		static const uint8_t default_apparams[] = {
>   			0x04, 0x02, 0xff, 0xff
> @@ -524,6 +540,11 @@ static int pbap_get(struct obex_session *os, void *user_data)
>   		};
>   		buffer = default_apparams;
>   		rsize = sizeof(default_apparams);
> +	} else if (!rsize && g_ascii_strcasecmp(type, PHONEBOOK_TYPE) == 0) {
> +		static const uint8_t default_apparams[] = {
> +			0x04, 0x02, 0xff, 0xff };

Above in the existing code, the curly brace seems to go on a separate line.

> +		buffer = default_apparams;
> +		rsize = sizeof(default_apparams);
>   	}
>   
>   	params = parse_aparam(buffer, rsize);

