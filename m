Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD4DAD23
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 07:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754810554; cv=none; b=cOdAl4kSXsza+H80vtxSSQxPZYNyuTDty/X+Umo+ztvOsof4Ifq6b11NTGaHWEzWr4HYxQHDLIE8J46cV8YMVqYGlZB3zoa3RhcbhtrecrACz9/jhxNydcptXw5AuwYUDtzTRFO0zK8tCG5AbVUWIrCRrk7vNlOpKIfoRHScqAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754810554; c=relaxed/simple;
	bh=+KnmKRQW9oDHlQfqtEtixkLDq8FuVXnb/fN1HrmHFt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5fh1C8St7A5MEBhcCK21fTBHhqFyr14T6FgpPeu4a1oJKtHCOgC7fqbyQ9lWbjj9ZqJ5Ktl3zb0FToUYfQDrvu801sftJwBnh9KeumkJzEauxRiritV0sN0Tu1f3uOXp9uC2TNDNYeb0NL6GiAwR1dGfMoLr2VGmGYm5+LEyzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7e1.dynamic.kabel-deutschland.de [95.90.247.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8D1D261E647BA;
	Sun, 10 Aug 2025 09:22:23 +0200 (CEST)
Message-ID: <42be480f-d301-4963-b5f6-73811586e857@molgen.mpg.de>
Date: Sun, 10 Aug 2025 09:22:22 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 1/1] Fixed heap-buffer-overflow in
 `compute_seq_size`.
To: Oliver Chang <ochang@google.com>
Cc: hadess@hadess.net, linux-bluetooth@vger.kernel.org
References: <20250810064656.1810093-2-ochang@google.com>
 <20250810064656.1810093-4-ochang@google.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250810064656.1810093-4-ochang@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Oliver,


Thank you for the patch. For the summary, I’d use imperative mood and do 
not add a dot/period at the end:

Fix heap-buffer-overflow in `compute_seq_size`

Am 10.08.25 um 08:46 schrieb Oliver Chang:
> By adding checks for sequence/alternate types in element_end to avoid a
> type confusion.
> 
> This issue was found by OSS-Fuzz.
> 
> This can be triggered by using an input of
> `<sequence><foo/><text/></sequence>` against the harness in
> https://github.com/google/oss-fuzz/blob/master/projects/bluez/fuzz_xml.c
> 
> https://issues.oss-fuzz.com/issues/42516062

The last comment says:

> This issue was migrated from crbug.com/oss-fuzz/51480?no_tracker_redirect=1

But that URL gives *Page Not Found*.

> https://oss-fuzz.com/testcase-detail/5896441415729152

I am unable to access this without logging in.

With your patch and the test case, what error is logged now?

> ---
>   src/sdp-xml.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/src/sdp-xml.c b/src/sdp-xml.c
> index 5efa62ab8..81bd11140 100644
> --- a/src/sdp-xml.c
> +++ b/src/sdp-xml.c
> @@ -545,6 +545,13 @@ static void element_end(GMarkupParseContext *context,
>   	}
>   
>   	if (!strcmp(element_name, "sequence")) {
> +		if (!SDP_IS_SEQ(ctx_data->stack_head->data->dtd)) {
> +			g_set_error(err, G_MARKUP_ERROR, G_MARKUP_ERROR_INVALID_CONTENT,
> +					"Unexpected data type %d for sequence",
> +					ctx_data->stack_head->data->dtd);
> +			return;
> +		}
> +
>   		ctx_data->stack_head->data->unitSize = compute_seq_size(ctx_data->stack_head->data);
>   
>   		if (ctx_data->stack_head->data->unitSize > USHRT_MAX) {
> @@ -557,6 +564,13 @@ static void element_end(GMarkupParseContext *context,
>   			ctx_data->stack_head->data->unitSize += sizeof(uint8_t);
>   		}
>   	} else if (!strcmp(element_name, "alternate")) {
> +		if (!SDP_IS_ALT(ctx_data->stack_head->data->dtd)) {
> +			g_set_error(err, G_MARKUP_ERROR, G_MARKUP_ERROR_INVALID_CONTENT,
> +					"Unexpected data type %d for alternate",
> +					ctx_data->stack_head->data->dtd);
> +			return;
> +		}
> +
>   		ctx_data->stack_head->data->unitSize = compute_seq_size(ctx_data->stack_head->data);
>   
>   		if (ctx_data->stack_head->data->unitSize > USHRT_MAX) {


Thank you again and kind regards,

Paul
