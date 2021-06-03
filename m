Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863B0C47096
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 19:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A2CE61361
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 19:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhFCTkd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jun 2021 15:40:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:31792 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhFCTkd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jun 2021 15:40:33 -0400
IronPort-SDR: m+SjC8WqfJvwOC1xUEkEWdRAcK2GTyZ5fjxIKECAqrOXXb+e14pHL4GU9Uaq4McHT4I/BmMMK7
 VWqT6uvIwjaA==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="183816857"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="183816857"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 12:38:44 -0700
IronPort-SDR: Ae4Pp99ixCZ7We6HXO3PhzdABBnVYpyksXLqj/KtzBAv1zzr2HsLCRPWrl0YYePSU+pj+CnQzs
 fTTUl2hDxsEg==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="447988580"
Received: from amlendup-mobl.amr.corp.intel.com ([10.252.138.74])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 12:38:44 -0700
Message-ID: <358e08e9ef4c4e9a0cf21dcf02dda74755384b76.camel@linux.intel.com>
Subject: Re: [PATCH BlueZ 1/2] tools/mgmt-tester: Adjust test setup complete
 check
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com
Date:   Thu, 03 Jun 2021 12:38:42 -0700
In-Reply-To: <20210603000416.171392-1-inga.stotland@intel.com>
References: <20210603000416.171392-1-inga.stotland@intel.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On Wed, 2021-06-02 at 17:04 -0700, Inga Stotland wrote:
> This changes check for setup complete in client_cmd_complete() callback
> from tester_setup_complete() to test_setup_condition_complete(). This
> allows for combining setup conditions when setup_bthost() is called.

Reviewed-by: Tedd Ho-Jeong An <tedd.an@intel.com>

> ---
>  tools/mgmt-tester.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
> index 4dd3490c2..657b7aaa0 100644
> --- a/tools/mgmt-tester.c
> +++ b/tools/mgmt-tester.c
> @@ -5831,7 +5831,7 @@ static void client_cmd_complete(uint16_t opcode, uint8_t status,
>  	if (status)
>  		tester_setup_failed();
>  	else
> -		tester_setup_complete();
> +		test_setup_condition_complete(data);
>  }
>  
>  static void setup_bthost(void)
> @@ -5842,6 +5842,7 @@ static void setup_bthost(void)
>  
>  	bthost = hciemu_client_get_host(data->hciemu);
>  	bthost_set_cmd_complete_cb(bthost, client_cmd_complete, data);
> +	test_add_setup_condition(data);
>  
>  	if (data->hciemu_type == HCIEMU_TYPE_LE ||
>  		test->client_enable_adv) {

Regards,
Tedd

