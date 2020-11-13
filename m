Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22F8C55ABD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Nov 2020 16:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6491C21D1A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Nov 2020 16:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgKMQy7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Nov 2020 11:54:59 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:42507 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgKMQy6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Nov 2020 11:54:58 -0500
Received: from [192.168.0.8] ([87.78.178.235]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MG9Pg-1kVrW02U3Q-00Gd57; Fri, 13 Nov 2020 17:54:56 +0100
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
From:   Bisseling <spam@bisseling.de>
Subject: [PATCH] tools/hcitool.c
Message-ID: <96d6eb8d-cf31-7cae-3e78-6761cb74961a@bisseling.de>
Date:   Fri, 13 Nov 2020 17:54:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:G72Kcs+41o+DNPN4TEpQcJI5+P/uAZo6Yx1ZUaMGQEKq+ffbr6M
 Y4QQpSD2iwh036qtSqOlQFj+gW1+IK/ZX/5jGKXAxfjfXGJKLat/DAod/hQHRmjZk3AHcDE
 WRk3J7d3ltTShc9P8cVQ8wVQj8jrVMc20iFwoUdg3gvCcwRpjY6NfPE2RX9tamDrH8cKaAD
 RuR2+p8BwczHeIbLVzn+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pgX1QTVrfSw=:6BgJiyF5xPdENWpRqS+qgv
 hYnJ52rPZXtyYDPRAI8RVRuQ8pLtr/UmqQkiP6fJG8oFYDL1sEldS1G8bQuyLNYFjd+34auZK
 YTGH6fAJE4+rmm0q1D1hEHcY9jlNOEPqZS0RaRoDQMzvjbumvqq+woYo6bLGhoLmEFiVWztCy
 oS4jtCPn15yp38x8OhNqZelzcGH5Ppi27HoXjf9p9sXjNmNIPj/Dt9RNDELFeLav1xmo7AkKy
 FftF1Xa2ochYEBi/MqhDU1vU0/A8i1n3C+8Sok90H4m5ep0hA0ywyUU+MRZREJUyScj72Mqxz
 jV5KuS8cev3c3q58YBzhobwCT8Qz7Skf1RvNBXqWuBpkDZIX65BTnbXI/5csbJXNVGfxoSplT
 A4rKVpIQgCZiJ9Li5ZnaYo1FP7ECqtSCly034kFfi+aCsAYa2S+qzC4RjPLUBTxhW2E0HaSbN
 ym1Lkst96A==
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Please review and pull:

https://github.com/GeorgBisseling/bluez/commit/69b61d7c71d08ddfd1b5b0f1862e456601264a01


