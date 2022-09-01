Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EA4ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 18:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbiIASRN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 14:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbiIASRI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 14:17:08 -0400
X-Greylist: delayed 391 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Sep 2022 11:17:05 PDT
Received: from b224-2.smtp-out.eu-central-1.amazonses.com (b224-2.smtp-out.eu-central-1.amazonses.com [69.169.224.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC4A7A745
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 11:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=b4y2oqd7fm2lugxzudc3kdvc4wctgrpv; d=ubports.com; t=1662055832;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=u2epQu66JMSZ2WSj/RR3SsXoVF1FXgny9XIgc2laMro=;
        b=SW79U1jePjG+mEg2p+pH4jfqEsfyPlT3P92DoPxKhFVNACc+Lw+4DyrdxONywBR/
        Rq9B3e+4CMO6toBXWF/0KuUWSOetrGCcBOg9wYxYklKNHapTNLcT9hC+gc5xxv34d0f
        E4vQaiJ9PnU5Xuz1iPlq+kRrWnTeT2g0tYqYZcJv0CMLJzQIEOFu6y1IFire3qFHSxH
        R7UXnSN3dgfrPTM4EgTYebpKoKFmDjSJ/iXcD3SPqm/odpb/2865zTIdsZQtfAOf3v6
        nhzr1lAR7kVEdyrq9b5HCZIoZV3bGgPLRKu2XtkEGsrfJKKDFYijxqUrWDpkPCvjgeL
        DJkW6oHEfw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=54ecsf3zk7z4mwxwwox7z7bg6e5gwjsz; d=amazonses.com; t=1662055832;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=u2epQu66JMSZ2WSj/RR3SsXoVF1FXgny9XIgc2laMro=;
        b=SZBDeo8xwaxwqUCWpPNLc81Ss/ewLftQ7GDjwyj84h1sDvGhhe201/Mq12TX3DPB
        YUmr2EVfNQP4CofVXdRhgqIjfJsNt3cIRzVuwTFYyRfHklhj8voB4FLlBG+iVpgOeM3
        0N9DJyk52J8Z/2jhRfWS4bGQemepF2hN57ZKOL8E=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ubports.com; s=mail;
        t=1662055831; bh=u2epQu66JMSZ2WSj/RR3SsXoVF1FXgny9XIgc2laMro=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rh4tFv6OJH+FfoClGGzR3kBB7XebrRHUGKsJQFQIEZ09AgMu/8Q+uRDYllM/CNq+/
         ut1IPrGfqdEqj2iyXTRqXwvSQvFJY6z+ZPWsWNBMdRiViZemlLMPzzZgnUIfDnfpSV
         BOR4eWwE0i8zkglkylhdAVl6brnLHF/Ur3pjNty8Q1rl6AG+dJz+IF/dKO0A0vT4Qd
         ProvFVkGtDPQMs4I7ot3CQVU+gHIf6wcmPWmDv1PG8Y9obkMdh7XtVnP3OkHA25psU
         8VRERL30f9FQevSYg6uCc2wNY1hE+7H3tenQ5Y6GLNymtvuiXfKEodUgxTRmsqZ2aJ
         22Ugl+EF8zRmA==
Message-ID: <01070182fa3f5ac6-66cb5385-fab0-4916-9e97-bdf54ef3a3f6-000000@eu-central-1.amazonses.com>
Date:   Thu, 1 Sep 2022 18:10:32 +0000
MIME-Version: 1.0
Subject: Re: [PATCH] plugins: Do not try to autopair with Nissan Connect
 devices
Content-Language: de-DE
To:     Bastien Nocera <hadess@hadess.net>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
 <CABBYNZJGc2Y3UULighw95un9mb8khLM2dfTOB3jRV8D3ksVDXg@mail.gmail.com>
 <1ef5e51d2103b6f02826777ebf5415f74018e317.camel@hadess.net>
From:   Florian Leeber <florian@ubports.com>
In-Reply-To: <1ef5e51d2103b6f02826777ebf5415f74018e317.camel@hadess.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: 1.eu-central-1.U71sxic/3tmi0U3T+Ze2hDyqoN46zyPgdCO+zEPT6YQ=:AmazonSES
X-SES-Outgoing: 2022.09.01-69.169.224.2
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Am 01.09.2022 um 12:46 schrieb Bastien Nocera:
> On Wed, 2022-08-31 at 13:18 -0700, Luiz Augusto von Dentz wrote:
>> Hi Florian,
>>
>> On Wed, Aug 31, 2022 at 12:44 PM Florian Leeber <florian@ubports.com>
>> wrote:
>> gs as default). 
> FWIW, gnome-bluetooth has its own database on top of bluez, which we
> prefer to the code in bluez. I'd be happy getting rid of it.
>
> Loads of devices that need pairing despite their class and Bluetooth
> version, and devices that need special handling like the Navman GPS
> that expects a non-numerical PIN.
>
> The database:
> https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/blob/master/lib/pin-code-database.xml
> The code to parse it:
> https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/blob/master/lib/pin.c

Oh my, this escalated quickly ;) - tbh implementing this as a fully 
fledged config-based feature might be over my head. I am not proficient 
with the Bluez code at all, and my main work currently is being the OTA 
release manager for Ubuntu Touch. I could only work on this with some 
support to get the basics established.

Thanks for the hint with the database, we did not know about this.


