Return-Path: <SRS0=iWKJ=BW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92743C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Aug 2020 12:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 733EC207F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Aug 2020 12:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgHLMNS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:13:18 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36496 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgHLMNS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Aug 2020 08:13:18 -0400
Received: from marcel-macbook.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id CD672CECDC;
        Wed, 12 Aug 2020 14:23:21 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [RFC PATCH v1 1/1] adapter - D-Bus API for querying the adapter's
 capability
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200803165804.RFC.v1.1.Ibaa1dfd49179a141c19a651f3c2132a28b71b344@changeid>
Date:   Wed, 12 Aug 2020 14:13:16 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Archie Pusaka <apusaka@chromium.org>, sonnysasaka@chromium.org
Content-Transfer-Encoding: 8BIT
Message-Id: <7D5EF527-14F0-42C2-B39B-50B55F01BE74@holtmann.org>
References: <20200803235811.2441774-1-yudiliu@google.com>
 <20200803165804.RFC.v1.1.Ibaa1dfd49179a141c19a651f3c2132a28b71b344@changeid>
To:     Yu Liu <yudiliu@google.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yu,

> Initially this is introduced to query whether WBS is supported by the adapter,
> the API is generic enough to be extended to support querying others in
> the future.
> 
> Reviewed-by: sonnysasaka@chromium.org
> 
> ---
> 
> Changes in v1:
> - Initial change
> 
> doc/adapter-api.txt | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)
> 
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index 1a7255750..250d0e9b3 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -204,6 +204,23 @@ Methods		void StartDiscovery()
> 					 org.bluez.Error.NotReady
> 					 org.bluez.Error.Failed
> 
> +		dict GetSupportedCapabilities()
> +
> +			This method returns a dictionary of supported
> +			capabilities that is populated when the adapter
> +			initiated.
> +
> +			The dictionary is following the format
> +			{capability : value}, where:
> +
> +			string capability:	The supported capability under
> +						discussion.
> +			variant value:		A more detailed description of
> +						the capability.
> +
> +			Possible errors: org.bluez.Error.NotReady
> +					 org.bluez.Error.Failed

can’t this be just an array{string} that lists the capabilities?

And if we introduce it, then lets introduce it also with the first user of it. Otherwise we end up forgetting to comment on the actual possible capabilities.

Regards

Marcel

