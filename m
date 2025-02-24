Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC91221F31
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405834; cv=none; b=fZdzrg2XApfwBm2wtZdhTwJnoftdFVp11TjUswrm6xnMqSLNXu0lHYi7qYFkYpTR5cr63NyNA6UGaMpd1rhTzSltOdk1t9jwzwna4hXEy+63uO/be6DZowEnohvt/zbdB9JvwVqviYPzaHSfwpgPfYZPLBghnlGvmRwHkV1yZZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405834; c=relaxed/simple;
	bh=0X4GY4CzTa9KBawDcPnaaeOBJ5iWoEbb4UQcadeH5Ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iWaiV3TCSn3p+E/sR3VHs33R2PbGIms4IAndpDgW3F5O2rIQblqt1tjnHN/orDWGZ2iUNBSs70wWoda/E9PZ/ELtqfOQ9MRT7VcNbSo5ZSl03lnhDbBEG3r7jf9/gF6eIQh/5e+FDhndrPvaKOttRvBrKNLAkJAjp11JSJMxyeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CC8AD61E647A3;
	Mon, 24 Feb 2025 15:03:43 +0100 (CET)
Message-ID: <98149822-8ac9-4099-bb44-16f79419ddc3@molgen.mpg.de>
Date: Mon, 24 Feb 2025 15:03:43 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2] obex: Add messages_get_message() implementation
 for MAP plugin
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <20250224111056.3255513-1-quic_amisjain@quicinc.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250224111056.3255513-1-quic_amisjain@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Amisha,


Am 24.02.25 um 12:10 schrieb Amisha Jain:
> GET Message() operation should be supported for passing below PTS
> testcases -
> 
> 1.MAP/MSE/MMB/BV-12-C
> Verify that the MSE can return an email message to the MCE.
> 2.MAP/MSE/MMB/BV-13-C
> Verify that the MSE can return a SMS message in native format to the MCE.

a*n* SMS

> 3.MAP/MSE/MMB/BV-14-C
> Verify that the MSE can return a SMS message with text trans-coded to UTF-8

a*n*

> to the MCE.

I’d add a space after the bullet points (the dot).

> Currently get message operation is not implemented, hence above
> testcases are failing.
> Added code to send the complete bmessage in response

Should this be *message* or is *bmessage* some terminology?

> to the get request for the requested message handle.
> 
> ---
>   obexd/plugins/mas.c            |  4 ++--
>   obexd/plugins/messages-dummy.c | 27 ++++++++++++++++++++++++++-
>   2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
> index 10b972d65..f63fcf6c6 100644
> --- a/obexd/plugins/mas.c
> +++ b/obexd/plugins/mas.c
> @@ -612,11 +612,11 @@ static void *message_open(const char *name, int oflag, mode_t mode,
>   		return NULL;
>   	}
>   
> +	mas->buffer = g_string_new("");
> +
>   	*err = messages_get_message(mas->backend_data, name, 0,
>   			get_message_cb, mas);
>   
> -	mas->buffer = g_string_new("");
> -
>   	if (*err < 0)
>   		return NULL;
>   	else
> diff --git a/obexd/plugins/messages-dummy.c b/obexd/plugins/messages-dummy.c
> index e313c6163..665face3f 100644
> --- a/obexd/plugins/messages-dummy.c
> +++ b/obexd/plugins/messages-dummy.c
> @@ -516,7 +516,32 @@ int messages_get_message(void *session, const char *handle,
>   					messages_get_message_cb callback,
>   					void *user_data)
>   {
> -	return -ENOSYS;
> +	struct session *s =  session;
> +	FILE *fp;
> +	char *path;
> +	char buffer[1024];
> +
> +	DBG(" ");
> +	path = g_build_filename(s->cwd_absolute, handle, NULL);
> +	fp = fopen(path, "r");
> +	if (fp == NULL) {
> +		DBG("fopen() failed");
> +		return -EBADR;
> +	}
> +
> +	/* 1024 is the maximum size of the line which is calculated to be more
> +	 * sufficient*/

I do not fully grok this sentence. Could you please rephrase?

> +	while (fgets(buffer, 1024, fp)) {
> +		if (callback)
> +			callback(session, 0, 0, (const char*)buffer, user_data);
> +	}
> +
> +	if (callback)
> +		callback(session, 0, 0, NULL, user_data);
> +
> +	g_free(path);
> +	fclose(fp);
> +	return 0;
>   }
>   
>   int messages_update_inbox(void *session, messages_status_cb callback,


Kind regards,

Paul
