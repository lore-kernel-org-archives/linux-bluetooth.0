Return-Path: <SRS0=Uexg=X7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649DCECE58E
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 15:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B93C20835
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Oct 2019 15:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hxvNdN3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfJFP3R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Oct 2019 11:29:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:48441 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbfJFP3R (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Oct 2019 11:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570375742;
        bh=8nLmfY08cK6Zl55bjH7dTnmxZSguSgPLd5QV3TA7wYk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hxvNdN3cgWjB8KXsNL3AJA/h0HrMQsxNVgxkn67YX9P3O85yaK66Xg4GDkyujhquG
         r+Q5rtxnyyE5AzoMXDqR1zuRAp4gTh8HzyZsyPf8wWlnF1IZM9umWu+2phyoyFDGkI
         oScytdho8IAXwbtOZfkH8Yafsu9kQjvKjwJqiM4M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.116]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MuUjC-1hzCD13IIs-00rV5A; Sun, 06 Oct 2019 17:29:01 +0200
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V4 10/10] MAINTAINERS: Add BCM2711 to BCM2835 ARCH
Date:   Sun,  6 Oct 2019 17:28:28 +0200
Message-Id: <1570375708-26965-11-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
References: <1570375708-26965-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:ho7aodY28Mw+u3YaTMCbHrrwJViCpFvXzIPn5PuSWIG7Bbv2UTu
 OR1+pZrBOm6bV5ikYjEeedAIsyfTNMfwEoqprQ+l3qbioT6oLRKnF4fEVMGIj9izfLmYXaf
 WX9PqoYLlF4TjOHooNRW1R27Xp1IDE4QoX9UooVWKGccxHn5AjpoSgfOuaALqItuyuNa4zi
 Cb/cOv6M7GGQ3c2ANavew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tkgwn1bGI14=:Z/hUYUhFbB+/CWHlJtJhjy
 64j4o8dKT8/CpDRcbmWeUJeSORRlq5SUdvNpgM0XkF9RY2t3m/NyQmoLgKfR3NwSaktxB2yFN
 1+/Kw+S2NFHQU1t6w2VDYeu1HHuREdL8/mLOZgoLaUT/NvAZkKx8+FM0WwtC7mKxN9xUpcAmH
 0tJBUfY/zvyN0j1m1yNY3tqNqSQuNssUtNoTdyeFTI+t2toibKcVToo/xUat8X6J1PAP+MGiv
 ap7mPq987SFy03eVoEY3KRLlkMBn6ybJi7YqEA+JqojUPC5tqbjnlJcA6sX4m3cZsbu1p3Vs3
 Tq/XMkTbMhMRvejd+vmIRH7Am85+zGBQdPSv1Wk6XVPyX6LxnnZdy/tz53CHfbdYxB3qtGJyB
 ZstGSRKXh5rlNC3t0A38SYDaxLD00Eu16VahKZYncxeO8JzTD8Cnqp5KJsGYzh1cJAxjshB0P
 0/UtDt2Tz7zenal/IZFCbLLKCJwpE3u3w//rh6eCliMH9EhcqZwvqVTGMP1Azx1zJSy+9Lmys
 hho/syv7XoGoYzVFFP2lvE1ffF7mbxkFxOWsTJrx3Adjnh0zo6l/Dw9BSBDbYbxNao/8jehZK
 XTD2vxf3f/md7Kb+ZU+kkWM5dXMZZZPC2+OLkPPLDcdfF9OH5NLkwOiseyH4NyOJFID4oTer3
 hl/WF4Dpn63BJrCtwuOI9FF8Wz4UFNXJ18cY9TDAJrW7b21d1qQkRdXtHw5DLjrYTrxKsWM8d
 lx4wS+Uo7ZPSYqpVi60pcIynaGyOJlFmmISd3ggqtv+S/ez/zBQ09QZDgsX11blkFyMTIfM89
 X7ptvFmOYSD/4LsmvLpfGipY/uL5J1FxfkmgRNWTKrbbpqkU2FTvo6pRoSwWt5l167o9sVnAv
 3PVZGUA8pq79Cr+ywDGV9t5n4u2UGXG01+/YXfmrITq166pWaY/CJ+FeUS3USh/FsWfOzpbup
 x//TWUiq44S6qdt1IdnmBp5fHyN930wYa+qwVfzDPqmrG5EsH19qu0PonzgJC8o/w9yZBVJKd
 XoZLfzajSojeDLI5OcSgQuCvggp8Q/TvIQppRi78sLqmFb5iPOr3BrB7i8rH26JKwYqW4vM2w
 oXypXu7CXaJgvW+1773xMm+WaDoQYraMEGKsA+bdwCdW3dSHz/XSo9F63SqPAk56XGC6OVuPu
 OSNp3MycHkjJk+TiypOg/AVuEhj/YzzFmV4uitB9okYN4uasf1i9Mzk+7lDhe9cpyZikSiTF7
 RCVmcqpazxXs1bSyl4xe1Ocot5jmkHwyNUN/oTA==
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Clarify that BCM2711 belongs to the BCM2835 ARCH.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Eric Anholt <eric@anholt.net>
=2D--
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 296de2b..14a939a 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3187,7 +3187,7 @@ N:	bcm216*
 N:	kona
 F:	arch/arm/mach-bcm/

-BROADCOM BCM2835 ARM ARCHITECTURE
+BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE
 M:	Eric Anholt <eric@anholt.net>
 M:	Stefan Wahren <wahrenst@gmx.net>
 L:	bcm-kernel-feedback-list@broadcom.com
@@ -3195,6 +3195,7 @@ L:	linux-rpi-kernel@lists.infradead.org (moderated f=
or non-subscribers)
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 T:	git git://github.com/anholt/linux
 S:	Maintained
+N:	bcm2711
 N:	bcm2835
 F:	drivers/staging/vc04_services

=2D-
2.7.4

