Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE44C2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 15:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7486161414
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Jun 2021 15:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbhF1PDr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Jun 2021 11:03:47 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:36083 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236344AbhF1PBm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Jun 2021 11:01:42 -0400
Received: (Authenticated sender: hadess@hadess.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 45B0560013;
        Mon, 28 Jun 2021 14:59:14 +0000 (UTC)
Message-ID: <363a48e3df83590ad4f53383830ca447c71939d7.camel@hadess.net>
Subject: Re: [PATCH BlueZ] doc/agent-api: Add AuthenticationFailed method
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Mon, 28 Jun 2021 16:59:13 +0200
In-Reply-To: <20210623184355.3685859-1-luiz.dentz@gmail.com>
References: <20210623184355.3685859-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, 2021-06-23 at 11:43 -0700, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This introduces AuthenticationFailed method which is used to indicate
> when there was an authentication failure with a remote device which is
> recommended by the core spec:
> 
> BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 3, Part C page 1314:
>  '5.2.2.3 Simple Pairing after authentication failure
>  When the link key is stored, subsequent connections to the same device
>  will use authentication but this may fail if the remote device has
>  deleted the link key. Table 5.2 defines what shall be done depending
>  on the type of the link key and whether bonding was performed or not.'
> 
> So following Table 5.2 recommendation the AuthenticationFailed method
> would be called when authentication fails with a bonded device.
> ---
>  doc/agent-api.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/doc/agent-api.txt b/doc/agent-api.txt
> index 0d9347cab..91d752b0a 100644
> --- a/doc/agent-api.txt
> +++ b/doc/agent-api.txt
> @@ -183,3 +183,8 @@ Methods             void Release()
>  
>                         This method gets called to indicate that the
> agent
>                         request failed before a reply was returned.
> +
> +               void AuthenticationFailed(object device, byte status)
> +
> +                       This method indicates that there was an
> authentication
> +                       failure with a remote device.

Is there a way that we could have some persistent storage for when the
last authentication error happened?

This would allow showing a /!\ icon in the device list even though we
don't have an agent running in the session, just when the settings are
open, in GNOME.

This would also allow the settings to get this information in the first
place, otherwise we'd need to have some side-channel to funnel that
information from the "desktop-wide" agent to the settings agent.

I've made the upstream bug[1] public now, can you reference it in the
commit message?

Cheers

[1]: https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/issues/91

