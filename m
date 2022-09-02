Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D7DC6FA82
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Sep 2022 18:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiIBSyh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Sep 2022 14:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiIBSy1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Sep 2022 14:54:27 -0400
X-Greylist: delayed 217 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Sep 2022 11:54:16 PDT
Received: from b224-6.smtp-out.eu-central-1.amazonses.com (b224-6.smtp-out.eu-central-1.amazonses.com [69.169.224.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508E21166ED
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Sep 2022 11:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=b4y2oqd7fm2lugxzudc3kdvc4wctgrpv; d=ubports.com; t=1662144637;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=3M8Enbg7xlRdSc3xt3yfJTuOo9pTnnQvCgTDmCxwtns=;
        b=K9xIFT+8fVmBPx4gR3kTcwOWg5ixYYvDPIc4bssL00TlexTylx36pgSFOz0eda/T
        hfMt986V8vzxaj53EliaJ2RQU/bMHryFZaV2XCjTOp0lnniHp5FxlWNEz60YH9bMolr
        LJ/jkzpybuDSHFnuqA007zUsWY3cmLG+B9y2Kl5PwRj6BVx6hHY8zB+216kvMz6vaFE
        2H3pq7RjWE1xEJjFEhsqQ3/jIUdFUJXcITmtZMITwdMhUu/RgFZfGwxPPLYx9Dbx+YY
        gV6IMUWjvJdxhDf5CD6RIjaNfZzyDScMIITFG/xVTmQHh2XnNhbw76d9zGIcnqlIRW9
        msHHLHOKZw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=54ecsf3zk7z4mwxwwox7z7bg6e5gwjsz; d=amazonses.com; t=1662144637;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=3M8Enbg7xlRdSc3xt3yfJTuOo9pTnnQvCgTDmCxwtns=;
        b=Ym+zdqZiktubdX43rbET9jUed174W9UPo0UhKFBCYamkaXnOM7gKLtHcUp2SOscw
        jnrRx1YYAyZSZGTIErwjTNuv9+qeiTtzvt8aqvHQ+7doBlNg7IWJK2en4L8YsQQkBt7
        c8mhrVG8q/bIhbkMktmC9nzumR5mIxSP06yHMcJI=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ubports.com; s=mail;
        t=1662144637; bh=3M8Enbg7xlRdSc3xt3yfJTuOo9pTnnQvCgTDmCxwtns=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pThn2nUS1Obk9qLEaaEfwx/r18UipbkCXhtJ2IJKIswlDvaERgv6mrcL1GOnUqbMR
         Xq6isl5hIjY0AOcn6LoMP+RQPIBXDRkXJudzcbvYKYjyow9WKsw8PBe/NsHtkTaL4r
         nYfz5pFyVn3HBtjrTv2vK1/ZosHq1r8vavml4UUavJWx9VzQeU8iuWjWESvm+6EyuV
         RrnO91M4uor/PtPCKijXXfVDjCw8KG45Li+C7kS1m6N4pD24ocY9vPX0JVmsApI438
         XVRNtKMbwLmIaN8mtLTJAmD+S0i8t0eKT+1Ob+62E4aT24CrORSSMjN5vJCXnka8ah
         F5BMUBL1Ox/qw==
Message-ID: <01070182ff8a6a80-5f310555-44b8-463f-9519-040c7cb28021-000000@eu-central-1.amazonses.com>
Date:   Fri, 2 Sep 2022 18:50:37 +0000
MIME-Version: 1.0
Subject: Re: [PATCH] plugins: Do not try to autopair with Nissan Connect
 devices
Content-Language: de-DE
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
 <CABBYNZJGc2Y3UULighw95un9mb8khLM2dfTOB3jRV8D3ksVDXg@mail.gmail.com>
 <1ef5e51d2103b6f02826777ebf5415f74018e317.camel@hadess.net>
 <01070182fa3f5ac6-66cb5385-fab0-4916-9e97-bdf54ef3a3f6-000000@eu-central-1.amazonses.com>
 <CABBYNZ+An68giBXb=6c-W3+-8tpvSHsWtV_GGJMXMQwUWbhh-w@mail.gmail.com>
From:   Florian Leeber <florian@ubports.com>
In-Reply-To: <CABBYNZ+An68giBXb=6c-W3+-8tpvSHsWtV_GGJMXMQwUWbhh-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: 1.eu-central-1.U71sxic/3tmi0U3T+Ze2hDyqoN46zyPgdCO+zEPT6YQ=:AmazonSES
X-SES-Outgoing: 2022.09.02-69.169.224.6
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Am 02.09.2022 um 01:56 schrieb Luiz Augusto von Dentz:
> Hi Florian,
>
> On Thu, Sep 1, 2022 at 11:10 AM Florian Leeber <florian@ubports.com> wrote:
>> Am 01.09.2022 um 12:46 schrieb Bastien Nocera:
>>> On Wed, 2022-08-31 at 13:18 -0700, Luiz Augusto von Dentz wrote:
>>>> Hi Florian,
>>>>
>>>>
> Can't you solve the problem in the agent thought? Or does the current
> logic make the pairing fail right away?
>
The problem seems to be that the carkit allows only one try. After a 
failed code it cancels the pairing (Seems they violate the specs?). So I 
could either resort the list to make 1234 being the first to try. But I 
think this would maybe affect other stuff and 0000 is probably the most 
used default code.


