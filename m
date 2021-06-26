Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B240C49EA6
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jun 2021 05:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7281561482
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jun 2021 05:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFZFrg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Jun 2021 01:47:36 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:53167 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhFZFrf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Jun 2021 01:47:35 -0400
Received: from smtpclient.apple (p5b3d2eb8.dip0.t-ipconnect.de [91.61.46.184])
        by mail.holtmann.org (Postfix) with ESMTPSA id C8D5FCED1E;
        Sat, 26 Jun 2021 07:45:12 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH BlueZ] doc/agent-api: Add AuthenticationFailed method
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210623184355.3685859-1-luiz.dentz@gmail.com>
Date:   Sat, 26 Jun 2021 07:44:52 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <0571E549-AFD1-4EB4-90E9-F2825F1CAA86@holtmann.org>
References: <20210623184355.3685859-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This introduces AuthenticationFailed method which is used to indicate
> when there was an authentication failure with a remote device which is
> recommended by the core spec:
> 
> BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 3, Part C page 1314:
> '5.2.2.3 Simple Pairing after authentication failure
> When the link key is stored, subsequent connections to the same device
> will use authentication but this may fail if the remote device has
> deleted the link key. Table 5.2 defines what shall be done depending
> on the type of the link key and whether bonding was performed or not.'
> 
> So following Table 5.2 recommendation the AuthenticationFailed method
> would be called when authentication fails with a bonded device.
> ---
> doc/agent-api.txt | 5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/doc/agent-api.txt b/doc/agent-api.txt
> index 0d9347cab..91d752b0a 100644
> --- a/doc/agent-api.txt
> +++ b/doc/agent-api.txt
> @@ -183,3 +183,8 @@ Methods		void Release()
> 
> 			This method gets called to indicate that the agent
> 			request failed before a reply was returned.
> +
> +		void AuthenticationFailed(object device, byte status)
> +
> +			This method indicates that there was an authentication
> +			failure with a remote device.

you are forgetting to describe what status is for.

Also if we follow the language from the previous agent method, then this should be IndicateAuthenticationFailure. I know it is a mouthful, but we always phrased the method names as action or information targeting a user or UI to do something.

Regards

Marcel

