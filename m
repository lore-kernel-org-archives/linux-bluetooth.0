Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E6D2AF1B
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jun 2025 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294120; cv=none; b=d+63GcPC60zgBjEeEWZc1oiCVd3BRdSXSlLRCBOCWCyntGEoFqmClUkOGKkVhpTxZzmzy2eU+IWcQBN42uoRpxCG7VT6F39LaH30dkNXQHXhjFnzK1XW/cqp6IfZfoQNVWWoDa7DiwsqqdmVIWo7xOix0VJDCcEEAhOPdCNGtMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294120; c=relaxed/simple;
	bh=yMsRlDYU0Slyzd86pWCzc1LQasub4rDD5B74noCEiz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1kM7piLSCRCuij1MtqJNu3ob2ZTMmCcZ7u7bWSdpicHQTaZ1MCxDJzcuUz+WEmoJ+EdEycsEV1TZHsbaQ4YZ56N+p8bOv64iLGop0hRhZUiIndltzP9c2GrjavynyYwaryNizx2d7urhEK0/SXvMHEJo92Iu1Kih9sQdcfIG8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7fe.dynamic.kabel-deutschland.de [95.90.247.254])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E9ED061DB0C02;
	Mon, 30 Jun 2025 16:35:08 +0200 (CEST)
Message-ID: <3f6297ee-5953-4835-a1e3-26642dfa1df7@molgen.mpg.de>
Date: Mon, 30 Jun 2025 16:35:07 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] obexd: reject to accept file when replying any error
 message
To: Chengyi Zhao <zhaochengyi@uniontech.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20250630135421.740-1-zhaochengyi@uniontech.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250630135421.740-1-zhaochengyi@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[Cc: -stable@, as obexd is not part of the Linux kernel]

Dear Chengyi,


Thank you for your patch.

Am 30.06.25 um 15:54 schrieb Chengyi Zhao:
> For security reasons, it will reject the file when the obex

Could you please elaborate on the attack?

> agent replies with any error message, and accept the file
> when the obex agent replies with the new file name.
> ---
>   obexd/src/manager.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)


Kind regards,

Paul


> 
> diff --git a/obexd/src/manager.c b/obexd/src/manager.c
> index 5a6fd9b4b..cecf9f90a 100644
> --- a/obexd/src/manager.c
> +++ b/obexd/src/manager.c
> @@ -658,6 +658,8 @@ static void agent_reply(DBusPendingCall *call, void *user_data)
>   				agent->new_name = g_strdup(slash + 1);
>   			agent->new_folder = g_strndup(name, slash - name);
>   		}
> +
> +		agent->auth_reject = FALSE;
>   	}
>   
>   	dbus_message_unref(reply);
> @@ -703,7 +705,7 @@ int manager_request_authorization(struct obex_transfer *transfer,
>   	dbus_message_unref(msg);
>   
>   	agent->auth_pending = TRUE;
> -	agent->auth_reject  = FALSE;
> +	agent->auth_reject  = TRUE;
>   	got_reply = FALSE;
>   
>   	/* Catches errors before authorization response comes */
