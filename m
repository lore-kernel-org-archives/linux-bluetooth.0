Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E68DC77B7F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Apr 2023 06:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjDTG5Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Apr 2023 02:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbjDTG5O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Apr 2023 02:57:14 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E599DB
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 23:57:10 -0700 (PDT)
Received: from [192.168.0.2] (unknown [95.90.232.80])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 21CBC61CC40F9;
        Thu, 20 Apr 2023 08:57:07 +0200 (CEST)
Message-ID: <c78e25ba-9cfa-9032-0cd8-3dc6c265558c@molgen.mpg.de>
Date:   Thu, 20 Apr 2023 08:57:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH BlueZ v4] obexd: support to reply folder name to store
 file
Content-Language: en-US
To:     Guiting Shen <aarongt.shen@gmail.com>
References: <20230420022554.14159-1-aarongt.shen@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230420022554.14159-1-aarongt.shen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Guiting,


Thank you for sending the fourth iteration. In the summary, I’d use also 
*return* instead of *reply*. Maybe:

obexd: AuthorizePush: Support to return folder name for file storage


Am 20.04.23 um 04:25 schrieb Guiting Shen:
> The obex agent usually returns the full path by getting the default
> folder and filename from the Filename property of the transfer object
> which is not convenient.

Just a minor thing for the future, I’d add a blank line between paragraphs.

> The patch helps that the obex agent can return the folder name suffixed
> with '/' or new full path or even null which will use the default name
> if new_name is NULL and the default folder if the new_folder is NULL in
> opp_chkput().
> ---
>   doc/obex-agent-api.txt |  9 +++++----
>   obexd/src/manager.c    | 10 ++++++----
>   2 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/doc/obex-agent-api.txt b/doc/obex-agent-api.txt
> index 3923da6df..5a9c6d417 100644
> --- a/doc/obex-agent-api.txt
> +++ b/doc/obex-agent-api.txt
> @@ -46,10 +46,11 @@ Methods		void Release()
>   			This method gets called when the service daemon
>   			needs to accept/reject a Bluetooth object push request.
>   
> -			Returns the full path (including the filename) where
> -			the object shall be stored. The tranfer object will
> -			contain a Filename property that contains the default
> -			location and name that can be returned.
> +			Returns the full path (including the filename) or
> +			folder name suffixed with '/' where the object shall
> +			be stored. The transfer object will contain a Filename
> +			property that contains the default location and name
> +			that can be returned.
>   
>   			Possible errors: org.bluez.obex.Error.Rejected
>   			                 org.bluez.obex.Error.Canceled
> diff --git a/obexd/src/manager.c b/obexd/src/manager.c
> index 849928603..73fd6b9af 100644
> --- a/obexd/src/manager.c
> +++ b/obexd/src/manager.c
> @@ -632,8 +632,7 @@ static void agent_reply(DBusPendingCall *call, void *user_data)
>   
>   		if (dbus_error_has_name(&derr, DBUS_ERROR_NO_REPLY))
>   			agent_cancel();
> -
> -		if (dbus_error_has_name(&derr, OBEX_ERROR_REJECT))
> +		else if (dbus_error_has_name(&derr, OBEX_ERROR_REJECT))
>   			agent->auth_reject = TRUE;

By the way, this looks like an unrelated change? I would do such changes 
in separate commits.


Kind regards,

Paul


>   
>   		dbus_error_free(&derr);
> @@ -651,7 +650,10 @@ static void agent_reply(DBusPendingCall *call, void *user_data)
>   			agent->new_name = g_strdup(name);
>   			agent->new_folder = NULL;
>   		} else {
> -			agent->new_name = g_strdup(slash + 1);
> +			if (strlen(slash) == 1)
> +				agent->new_name = NULL;
> +			else
> +				agent->new_name = g_strdup(slash + 1);
>   			agent->new_folder = g_strndup(name, slash - name);
>   		}
>   	}
> @@ -722,7 +724,7 @@ int manager_request_authorization(struct obex_transfer *transfer,
>   
>   	dbus_pending_call_unref(call);
>   
> -	if (!agent || !agent->new_name || agent->auth_reject)
> +	if (!agent || agent->auth_reject)
>   		return -EPERM;
>   
>   	*new_folder = agent->new_folder;
