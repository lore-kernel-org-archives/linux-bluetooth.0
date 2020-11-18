Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FE6C5519F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Nov 2020 16:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E532482C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Nov 2020 16:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgKRQfK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Nov 2020 11:35:10 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:44715 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgKRQfJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Nov 2020 11:35:09 -0500
Received: from [192.168.0.8] ([81.173.168.73]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MMnnm-1kvqqV0zki-00Iokq; Wed, 18 Nov 2020 17:35:07 +0100
Subject: Re: [PATCH] tools/hcitool.c
From:   Bisseling <spam@bisseling.de>
To:     Bastien Nocera <hadess@hadess.net>,
        linux-bluetooth@vger.kernel.org, marcel@holtmann.org
References: <96d6eb8d-cf31-7cae-3e78-6761cb74961a@bisseling.de>
 <38dcad476ea9efa71eff2065cdd7d57c184bd6b6.camel@hadess.net>
 <24eb6e46-0563-92fc-5394-f1de9d9e0135@bisseling.de>
Message-ID: <1a8fb695-c92d-03fe-3347-6e98480be830@bisseling.de>
Date:   Wed, 18 Nov 2020 17:35:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <24eb6e46-0563-92fc-5394-f1de9d9e0135@bisseling.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:fzHjsytPmq5ScxMWQqstk8U09He1AMDVl+5GyPaA4FQvWLjh+6v
 b2vXzhbDX/9NPj+Xi4u17rpDyrux3y+IuZPkn5WAB4E2d4Y+QgzOLT7DNEtBvSZwaMvyl3t
 s/1d/fNhpnA52YSVwXjPHnwUn17ryG5aBPuEHqcEBTuTZ6EA1q7H9dNe8d2RniKCD2sGMLV
 kSccUHkwcchAQxtgWQqwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+u6bULUrIyo=:9xeIOnggtSchbdMylyR99N
 auv/smU99aho52LywlfwJxiWtYjKJbzXlNdBIO78TK0YWwKYQXYSAD4eXfV1tsnbGairtR/1w
 cIczWizXlZmfkwXlnwm3cUxfy1/0XGM82WumP37Y56xn6RrBSDk6NN3c64cnzW+sNGKqm4ZhZ
 ch2Lf5SL8jUnd+SE9BP46VrwK+AkgFC9DB9zfe8JJWv0qyryGCMDzX6YP2gsyfAuD4oGghzNU
 fzAndh4jwOxZUl/eVK8yNN//iADKpVpAush0Y9ork04ubqhn576lhzqqCI8zT5zwsT+38qIi2
 4qku3k/Ihv/EVoLh4xIkPdLTEH0uWOWTTFewDEhD0FPcb9vic1aOAzi3TY42NP8GlObpIPQf5
 zifofGVm/DP1O2cflRP5hrl7DdkAzk9TJwNdRsu8glwqamS7H7QMd0E3aC3yX
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Now a robot tells me to do offer my patch via email to this mailing 
list. How very frustrating.

On 17.11.20 16:30, Bisseling wrote:
> Hope I got that pull request right.
>
> Thanks
>
> On 13.11.20 18:00, Bastien Nocera wrote:
>> On Fri, 2020-11-13 at 17:54 +0100, Bisseling wrote:
>>> Please review and pull:
>>>
>>> https://github.com/GeorgBisseling/bluez/commit/69b61d7c71d08ddfd1b5b0f1862e456601264a01 
>>>
>>>
>>>
>> You can create a pull request against:
>> https://github.com/bluez/bluez/pulls
>>
>> Otherwise you'll need to use git-sendemail to send the patch itself to
>> the list.
>>
