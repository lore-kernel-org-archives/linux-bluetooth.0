Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81634C43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 12:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4803C208E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 12:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547816026;
	bh=cHlwGoadeoMyHENy19foncABGgPqBsYRue6A3hzrvzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kA2q9OvMWH8XQgKgW5eKvADOd51hjOC3Xz4Ki/oL8RdyhaevYaHaSkb+e8LOKr8PY
	 Htz3NfhadhBtNkE9Q53p6uZJf+g7+NTU+MOBRntbC7rXeKmHEKNHjfFvv9z6ZtiBrB
	 PUtNOODDEvC0yFINmiWE4Pf6PwwjR+35p+G+CJ9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfARMxp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:53:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfARMxp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 07:53:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B95A820896;
        Fri, 18 Jan 2019 12:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547816025;
        bh=cHlwGoadeoMyHENy19foncABGgPqBsYRue6A3hzrvzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ob9Mj7K5ONPpkDAhM9d5gQSZZSHLbpSXHh+LnQpfB744LNA6qQQUvg7oEoeIhLaQ+
         LW09avPSNfCi9YV7Xy9uQnIYw1W4HrpKchJ+ST0g924N24oxXKFgNoSQrHJ5NdvVw8
         0j2ksdAP+IJkwky6kAZyK+HiKRQxKet6nvmyMG2w=
Date:   Fri, 18 Jan 2019 13:53:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Verify that l2cap_get_conf_opt provides large
 enough buffer
Message-ID: <20190118125342.GA31025@kroah.com>
References: <20190118124319.12187-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118124319.12187-1-marcel@holtmann.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Jan 18, 2019 at 01:43:19PM +0100, Marcel Holtmann wrote:
> The function l2cap_get_conf_opt will return L2CAP_CONF_OPT_SIZE + opt->len
> as length value. The opt->len however is in control over the remote user
> and can be used by an attacker to gain access beyond the bounds of the
> actual packet.
> 
> To prevent any potential leak of heap memory, it is enough to check that
> the resulting len calculation after calling l2cap_get_conf_opt is not
> below zero. A well formed packet will always return >= 0 here and will
> end with the length value being zero after the last option has been
> parsed. In case of malformed packets messing with the opt->len field the
> length value will become negative. If that is the case, then just abort
> and ignore the option.
> 
> In case an attacker uses a too short opt->len value, then garbage will
> be parsed, but that is protected by the unknown option handling and also
> the option parameter size checks.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 77799e7d5a34..ccdc5c67d22a 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3337,6 +3337,8 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
>  
>  	while (len >= L2CAP_CONF_OPT_SIZE) {
>  		len -= l2cap_get_conf_opt(&req, &type, &olen, &val);
> +		if (len < 0)
> +			break;

<snip>

Patch looks good to me, thanks for fixing this all up:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
