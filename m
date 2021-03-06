Return-Path: <SRS0=qbbT=IE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD71C433E6
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Mar 2021 10:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A42864FED
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Mar 2021 10:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhCFKKv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Mar 2021 05:10:51 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:41577 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhCFKKi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Mar 2021 05:10:38 -0500
X-Originating-IP: 78.199.60.242
Received: from [192.168.1.150] (unknown [78.199.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 6C4AC240007;
        Sat,  6 Mar 2021 10:10:31 +0000 (UTC)
Message-ID: <2e29061ee96d62e4d744f9d71c8c4802aa782b6d.camel@hadess.net>
Subject: Re: [BlueZ,1/2] adapter: Fix not using the correct setting
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Sat, 06 Mar 2021 11:10:30 +0100
In-Reply-To: <CABBYNZL8wBc8OQvrRMXuqP=tB4ug2AAU0Ov3uCMvCcJUAz_Kiw@mail.gmail.com>
References: <20210304222448.3769100-1-luiz.dentz@gmail.com>
         <6041615f.1c69fb81.ffcdc.51a4@mx.google.com>
         <CABBYNZL8wBc8OQvrRMXuqP=tB4ug2AAU0Ov3uCMvCcJUAz_Kiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, 2021-03-05 at 17:17 -0800, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Thu, Mar 4, 2021 at 2:38 PM <bluez.test.bot@gmail.com> wrote:
> > 
> > This is automated email and please do not reply to this email!
> > 
> > Dear submitter,
> > 
> > Thank you for submitting the patches to the linux bluetooth mailing
> > list.
> > This is a CI test results with your patch series:
> > PW Link:
> > https://patchwork.kernel.org/project/bluetooth/list/?series=442263
> > 
> > ---Test result---
> > 
> > ##############################
> > Test: CheckPatch - PASS
> > 
> > ##############################
> > Test: CheckGitLint - PASS
> > 
> > ##############################
> > Test: CheckBuild - PASS
> > 
> > ##############################
> > Test: MakeCheck - PASS
> > 
> > 
> > 
> > ---
> > Regards,
> > Linux Bluetooth
> 
> Applied.

You didn't reply to my question about the patch.

I can't wait until we don't have to use mailing-lists to submit
patches.

Sigh.


