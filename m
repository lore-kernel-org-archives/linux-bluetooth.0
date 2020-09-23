Return-Path: <SRS0=ZvEB=DA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D0EC4363D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Sep 2020 07:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4ED723600
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Sep 2020 07:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgIWHv4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Sep 2020 03:51:56 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52155 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgIWHv4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Sep 2020 03:51:56 -0400
Received: from [192.168.0.8] ([78.35.53.233]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MF39S-1kEKfL080O-00FTJi for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep
 2020 09:51:55 +0200
From:   Bisseling <spam@bisseling.de>
Subject: [BUG] in tools/hcitool.c:cmd_scan
To:     linux-bluetooth@vger.kernel.org
Message-ID: <ec38f619-0785-7814-8f68-11526b59d9a5@bisseling.de>
Date:   Wed, 23 Sep 2020 09:51:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:FyxajrrV/xT9UNTbJYEEK8cuG6lPGDD0c8gGQDnbH9CqSW0n+Ok
 gOjMODWkfaAWlR2kMhjNA7cVjEA9kYCztKpUDso8/uyiNHQ4F+vkWS1IWHB1S0EQ96ZShnH
 JSs3GFKoL8rl8xpnrWPdIn+rBeYT6fKDeme3bzVh3eefENDOriiUlZU5gD7DEZNvoiJdPlf
 Debp3Kf85cjVcNi0gKLfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:64IWVAXJEZs=:uAsn9/biWf9yEBEuwS1VGS
 /upwfn3Bt8GfOlYc/hrUfTN3M/l7zSxx+M3sH8Ek7YQ744MtL/ugaZkWUTGJciDMhE6NY+hmL
 Tk5yDka3e1V39qKyZ0hL7f2ByXQTYQ6s5fiEne9K2rvDpHcQbbzzpI9riSsi0RXR74W3dJo1h
 7/lm9JUlPkYDBL/ByXMzHI8nWPSEOeXjw2V/pmy9/vXjnHt8AI3huMxILKT1MXIFeZd3aBTek
 ooBLksaYe1VmKXP2FvQFSdRTjSEbQt103L2+/ifRHjeq9yRpY2Hvu3kt6BSq5+zDueD/BvyXY
 ae4R3cYPlPg7SK9JcvxR8UvG34RHsYCKfMddsipqlvFkbl9ngKQQo0bcuy2s8dsRm1/JKS6gP
 5j22dH/Ss/FIgCApboEGi8Ss6eFR1QbtI9DHtpj26jnA1zu3W/6OvOngCiZoyenDw1DtEyJQz
 puXnhl9B/ORPLAGukea+Oj1kiqHH+nqi3RU+oMJdIHkd4G3tS97X+7qz75QLEcpMNPo3ba8bN
 9RS35/A4Tipaa9E4srUXuULW0x5pEhU2fNmaZXBWzLwsHwqIbrkvM8b1aaMT/6HHxV23LdY9o
 cAYcRxlWFlg1UKIDi2cx5qhj0cvVcTEXvc43g/nkFBjGwwa5vlhiLxre4Fia9Ux2M7t+07yG0
 ir0oqYA1sg3Hvq4k7v5QBuZ1wzQNgrFoTDxBydG4JkXR7EmVqugER4wz3LhrK20TT8zHnQs3q
 iJV7sie+fLMwzbUvZTXBKhs3DVCVCUyQ58faYYSbi7tdrMve1isFrjZjoWeUNxXwVjFaj5ub6
 DxLPvDoCvqKwqBNtPa4voKOzeYCnQ4NXae0urWx/9Bs/YR5zK2oeY5kTE5EubU12j7fTSES
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

[BUG] in tools/hcitool.c:cmd_scan

Hi guys and gals,

I found a little bug in the above function and would like to have it fixed.
I could not find any other way to submit a bug than this mailing list.

The function contains the following code:

|

for  (n  =  0;  n  <  248  &&  name[n];  n++)  {
	if  ((unsigned  char)  name[i]  <  32  ||  name[i]  ==  127)
		name[i]  =  '.';
} |

||

||

|It is pretty obvious that the loop should use the index variable n 
instead of i in all three places. The variable i is the index variable 
of the outer loop running over all responses. This mistake leads to 
garbled names and sometimes even to SIGSEGV on x86_AMD64. How would I 
fork your project and commit a pull request like on github? Thanks in 
advance Georg |

||

