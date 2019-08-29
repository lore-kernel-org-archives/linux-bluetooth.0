Return-Path: <SRS0=q5Cw=WZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80009C3A59F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Aug 2019 20:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D0721726
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Aug 2019 20:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfH2UH2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:07:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:64632 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbfH2UH1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Aug 2019 16:07:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 13:07:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,444,1559545200"; 
   d="scan'208";a="197874188"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga001.fm.intel.com with ESMTP; 29 Aug 2019 13:07:26 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.221]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.66]) with mapi id 14.03.0439.000;
 Thu, 29 Aug 2019 13:07:26 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Log D-Bus method call errors
Thread-Topic: [PATCH BlueZ] mesh: Log D-Bus method call errors
Thread-Index: AQHVVy2bkXDzmW+5gESx2fBstT1SHacRQJeAgAEnZYCAAJELAIAAFZEA//+NzbA=
Date:   Thu, 29 Aug 2019 20:07:26 +0000
Message-ID: <38E88E55-4291-47AF-B502-47922E9FBA56@intel.com>
References: <20190820075654.2195-1-michal.lowas-rzechonek@silvair.com>
 <685bc703108f5329b861f5c5f87301b44bddd8e0.camel@intel.com>
 <20190829095951.nzzqqhgvblhogf4e@mlowasrzechonek2133>
 <145b9b726c45fd37592b5a7a3504c911cd848409.camel@intel.com>,<20190829195610.a6dwgxabq3d2g3bp@kynes>
In-Reply-To: <20190829195610.a6dwgxabq3d2g3bp@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="windows-1250"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Micha³,

> On Aug 29, 2019, at 12:56 PM, "michal.lowas-rzechonek@silvair.com" <michal.lowas-rzechonek@silvair.com> wrote:
> 
> Hi Brian,
> 
>> On 08/29, Gix, Brian wrote:
>> That is true, and we *expect* applications that are attached to handle
>> the socket-signals (that drive d-bus) in a timely manner...  But I am
>> not sure we have a way to enforce it.
>> 
>> Certainly, we can simulate a disconnection if an App ignores it's DBus
>> socket signal, but again, we won't know about that for 30 seconds
>> which seems like forever...  And an App could potentially have a large
>> enough backlog of messages negatively affecting the daemon before it
>> and corrects it.
> 
> This seems like a limitation of ELL:
> 1. There doesn't seem to be an explicit API to set timeouts on method
>   calls, so if the application takes too long to handle method calls,
>   message_list hashmap in l_dbus struct would indeed grow quite large.
> 2. There doesn't seem to be a way to set an upper limit of pending
>   messages (or maybe even message rate?) in l_dbus connection.
> 
> Still, looking at ell/dbus.c, it seems it should be possible to manually
> call l_dbus_cancel after obtaining serial number of the method call
> message, using _dbus_message_get_serial from dbus-private.h (yeah, I
> know).
> 
> Anyway, I think a better approach would be to submit patches to ELL
> implementing these two features, and then use these additions in meshd.
> Does that sound acceptable from your POV?

I’m not sure I agree with you on the need to expose and adjust  DBus message timeouts, however, I think you are probably correct that the correct place to have that conversation is on the ELL reflector, which can be accessed here:

https://lists.01.org/mailman/listinfo/ell

I still feel though, that you are trying to solve a pre-deployment “debugging” issue by requiring DBus responses for messages that don’t require them.


> 
> By the way, it seems that bluetoothd suffers from the same problem with
> regards to external GATT services/characteristics/descriptors.
> 
> regards
> -- 
> Micha³ Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
> Silvair http://silvair.com
> Jasnogórska 44, 31-358 Krakow, POLAND
