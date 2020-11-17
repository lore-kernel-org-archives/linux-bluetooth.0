Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955C6C56202
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 15:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4532624631
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 15:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbgKQPad (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Nov 2020 10:30:33 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:57721 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbgKQPad (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Nov 2020 10:30:33 -0500
Received: from [192.168.0.8] ([81.173.168.73]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M9nAB-1kbUA61IWL-005rYP; Tue, 17 Nov 2020 16:30:31 +0100
Subject: Re: [PATCH] tools/hcitool.c
To:     Bastien Nocera <hadess@hadess.net>,
        linux-bluetooth@vger.kernel.org, marcel@holtmann.org
References: <96d6eb8d-cf31-7cae-3e78-6761cb74961a@bisseling.de>
 <38dcad476ea9efa71eff2065cdd7d57c184bd6b6.camel@hadess.net>
From:   Bisseling <spam@bisseling.de>
Message-ID: <24eb6e46-0563-92fc-5394-f1de9d9e0135@bisseling.de>
Date:   Tue, 17 Nov 2020 16:30:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <38dcad476ea9efa71eff2065cdd7d57c184bd6b6.camel@hadess.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:4AOXqA1KLmAo7gdF/S136NRh2v3ct7yXwBADtzorYCk5/2PXFtO
 Wx+/EvBeB74yF3yI3clQqcRX42NdF69Z2pGgTkFDS3at+PPO6jb1/ggbKesKkAybB+tSa2q
 3sStiI++Jt2aIGNuxz8zNmgBZWLtY48AgBRtByfgZoAYkLinuzwnddrSVnkXdUAsdog61CQ
 rpF0tibkmG4NgHxRC6Jaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i+dcY96slug=:sCi5VxdV1szvyQe7Tvz1Om
 LcZlTLdNogNwza02VBnbuqYt18RTiHZ8nBsi0A7qzX7oe0VqyMbYFvnmq+kJQsjvchu8mejcI
 xdTj7eRxqloRgsE5goYIL+TnNFBtVaT272ggbW6IIM5VAMRefCkg3rFxZXTYFL1616dUJFHZx
 KvQOqGcIAt7oNNC3B319sKfi2x8DVaL+udOnIvohiiTe5AEViaYP6+EHQ0hY98gkxA8v2L478
 KCcgi5E1G14wwrn+ZLpSZkicYNPkTaNf4KDn7TzGy7InstKFIrGjC3J8qTNIpmUje/8Cm5Our
 NKOjimtKbmk4MVClZLsaG4o06KHiB8YgNEWbGdxpkvb+LwmSi/fOpMVq9w9js3CQWsgA7isT7
 DasrAatS207o4k54U2h5oDsABlCqcUuYjO0iPGN2lNDE5ZJk8sEpBGCEFmdsj
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hope I got that pull request right.

Thanks

On 13.11.20 18:00, Bastien Nocera wrote:
> On Fri, 2020-11-13 at 17:54 +0100, Bisseling wrote:
>> Please review and pull:
>>
>> https://github.com/GeorgBisseling/bluez/commit/69b61d7c71d08ddfd1b5b0f1862e456601264a01
>>
>>
> You can create a pull request against:
> https://github.com/bluez/bluez/pulls
>
> Otherwise you'll need to use git-sendemail to send the patch itself to
> the list.
>
