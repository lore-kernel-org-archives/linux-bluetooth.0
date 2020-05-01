Return-Path: <SRS0=Zhcm=6P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A94C47253
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 16:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A12F2064C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 16:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgEAQ0o convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 May 2020 12:26:44 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:39513 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbgEAQ0o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 May 2020 12:26:44 -0400
Received: from [192.168.1.91] (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id B8FE7CED23;
        Fri,  1 May 2020 18:36:22 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [BlueZ PATCH v1] shared/gatt-client:Ignore orphaned
 characteristics
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200501144037.1684-1-alainm@chromium.org>
Date:   Fri, 1 May 2020 18:26:12 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <4195BFB9-1586-435F-8FC2-ED215959A591@holtmann.org>
References: <20200501144037.1684-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> The gatt discovery proceedure simplification to discover all
> characteristics at once has exposed a device side issue where some
> device implementation reports orphaned characteristics.  While this
> technically shouldn't be allowed, some instances of this were observed
> (namely on some Android phones).
> 
> The fix is to simply skip over orphaned characteristics and continue
> with everything else that is valid.
> 
> This has been tested as part of the Android CTS tests against an
> affected platform and was confirmed to have worked around the issue.
> ---
> 
> src/shared/gatt-client.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 963ad619f..d604c77a3 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -632,7 +632,10 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
> 			util_debug(client->debug_callback, client->debug_data,
> 				"Failed to insert characteristic at 0x%04x",
> 				chrc_data->value_handle);
> -			goto failed;
> +
> +			/* Skip over invalid characteristic */
> +			free(chrc_data);
> +			continue;
> 		}

should we add a warning here?

And I think it would be good to have a bit more verbose comment why this is done this way instead of aborting.

Regards

Marcel

