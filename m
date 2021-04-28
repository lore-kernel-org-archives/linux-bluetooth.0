Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D72C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Apr 2021 14:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB2B6142A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Apr 2021 14:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239032AbhD1OuU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Apr 2021 10:50:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:37853 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237717AbhD1OuT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Apr 2021 10:50:19 -0400
Received: from smtpclient.apple (p4fefc624.dip0.t-ipconnect.de [79.239.198.36])
        by mail.holtmann.org (Postfix) with ESMTPSA id 57F2BCECC3;
        Wed, 28 Apr 2021 16:57:22 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [PATCH v3 3/3] Bluetooth: cache local supported codec
 capabilities
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <DM8PR11MB55739D629FCFD9BD7174C51EF5409@DM8PR11MB5573.namprd11.prod.outlook.com>
Date:   Wed, 28 Apr 2021 16:49:33 +0200
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <700CFB19-FE68-4B77-B8AD-97E20433E8A1@holtmann.org>
References: <20210422141449.25155-1-kiran.k@intel.com>
 <20210422141449.25155-3-kiran.k@intel.com>
 <349C0A6B-5E9C-4171-BFB5-C86AF4E8D698@holtmann.org>
 <DM8PR11MB55739D629FCFD9BD7174C51EF5409@DM8PR11MB5573.namprd11.prod.outlook.com>
To:     "K, Kiran" <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

>>> +int hci_codec_list_add(struct list_head *list, struct
>> hci_rp_read_local_codec_caps *rp,
>>> +		       __u32 len,
>>> +		       struct hci_op_read_local_codec_caps *sent);
>> 
>> I think you need to redo the whole patch series, since 1/3 should have
>> hci_codec_list_add in that it adds the codec id from reading the codec list.
>> 
> Ack
> 
>> And then reading the capabilities just updates the codec.
>> 
> With async calls converted to sync,  can we add codec details to the list on reading codec caps as same codec can be supported on multiple transport types ?
> 
>> Our problem is that the whole init phase is rather async than sync in it
>> procedure. And the reason for that is purely historic from the times when
>> Linus had no work queues and we had to process everything in tasklets or
>> spawn kthreads.
>> 
>> Frankly if we moved the whole init procedure to use __hci_cmd_sync we
>> could fold the complete init{1-4} phases into one. And there is no reason we
>> don’t do that. However one problem at a time.
>> 
> Ack. I will define init5 for reading codecs and codec caps  using __hci_cmd_sync  calls.

I think this is too early. I only looked at the intermingling of hci_update_background_scan. I have not gotten the whole init handling. I suspect some looking issues that would have to be cleaned up first.

Regards

Marcel

