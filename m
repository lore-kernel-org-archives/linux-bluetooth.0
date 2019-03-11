Return-Path: <SRS0=ax5w=RO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7739C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 14:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61792084F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 14:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="TtTa3lbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfCKOgh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:36:37 -0400
Received: from aer-iport-3.cisco.com ([173.38.203.53]:49363 "EHLO
        aer-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfCKOgg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Mar 2019 10:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1476; q=dns/txt; s=iport;
  t=1552314996; x=1553524596;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=rB79kjUCGYW7up2HF26FtA0RE135ZiXixxkRds0q9BE=;
  b=TtTa3lbbJE0PR5EfI0CUFbFuwl9dfw0S3QUjQdORwyfk1dQnZBmqOk1W
   SBqDoO23rP9HtquWndvjoRE2yzB5pGFrvHr7J/Os0ZxOWiVcBI86pVSap
   Wk3FoT2M9E4L6Dp0zwf5jxijHIZdcDyBNPimdLqV2ztIfnYb59gpjYC+Z
   4=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DuAADcboZc/xbLJq1kGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBZYNpEoQwiHmMMppODYRsAoRcOBIBAQMBAQcBAwJtHQuFSwYjFVE?=
 =?us-ascii?q?LGgImAgJXBg0IAQGDHoF2r1uBL4VFg1OBDYELJItEgX+BOII9LoFBAYZJglc?=
 =?us-ascii?q?DkTySZQmTBgYZiwKIOIp4km+BXiGBVnAVgyiCFQwLjh8+A5BwAQE?=
X-IronPort-AV: E=Sophos;i="5.58,468,1544486400"; 
   d="scan'208";a="10617275"
Received: from aer-iport-nat.cisco.com (HELO aer-core-4.cisco.com) ([173.38.203.22])
  by aer-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 14:26:52 +0000
Received: from [10.47.79.134] ([10.47.79.134])
        by aer-core-4.cisco.com (8.15.2/8.15.2) with ESMTP id x2BEQq2v029375
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Mar 2019 14:26:52 GMT
Subject: Re: [PATCH] sbc: Fix off-by-one error in index check when unpacking
 frame
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20190311142535.92501-1-pwaago@cisco.com>
From:   =?UTF-8?Q?Per_Waag=c3=b8?= <pwaago@cisco.com>
Message-ID: <d1930fe4-070d-df7e-b5a8-027748710df8@cisco.com>
Date:   Mon, 11 Mar 2019 15:26:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190311142535.92501-1-pwaago@cisco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Outbound-SMTP-Client: 10.47.79.134, [10.47.79.134]
X-Outbound-Node: aer-core-4.cisco.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The problem can be demonstrated with the program below. Valgrind will 
fail when running this program for values of short_packet_size from 12 
through 113.
--
#include <sbc/sbc.h>

#include <stdlib.h>
#include <string.h>

static void encode_and_truncate_frame(uint8_t * dest, size_t dest_size)
{
     sbc_t enc;
     sbc_init(&enc, 0);
     enc.frequency = SBC_FREQ_48000;
     enc.blocks = SBC_BLK_16;
     enc.subbands = SBC_SB_8;
     enc.mode = SBC_MODE_STEREO;
     enc.allocation = SBC_AM_LOUDNESS;
     enc.bitpool = 51;
     enc.endian = SBC_LE;

     const size_t input_frame_size = sbc_get_codesize(&enc);
     const size_t output_frame_size = sbc_get_frame_length(&enc);
     uint8_t * input_frame = calloc(1, input_frame_size);
     uint8_t * output_frame = calloc(1, input_frame_size);

     ssize_t produced;
     sbc_encode(&enc, input_frame, input_frame_size,
         output_frame, output_frame_size,
         &produced);

     memcpy(dest, output_frame, dest_size);

     free(input_frame);
     free(output_frame);
     sbc_finish(&enc);
}

int main(int argc, char * argv[])
{
     const size_t short_packet_size = 12;
     uint8_t * short_packet = malloc(short_packet_size);
     encode_and_truncate_frame(short_packet, short_packet_size);

     sbc_t dec;
     sbc_init(&dec, 0);

     sbc_parse(&dec, short_packet, short_packet_size);

     sbc_finish(&dec);
     free(short_packet);
     return 0;
}
