Return-Path: <SRS0=Cjqc=2H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470E5C43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 15:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140F12146E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 15:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ygsoftware.com.au header.i=@ygsoftware.com.au header.b="FutmIgGL";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="a2MRlmrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfLQPK4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:10:56 -0500
Received: from a58-62.smtp-out.us-west-2.amazonses.com ([54.240.58.62]:48960
        "EHLO a58-62.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727241AbfLQPK4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Dec 2019 10:10:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=vl7dyoqhfh6isglrlfucb4hjwred72dq; d=ygsoftware.com.au;
        t=1576595455;
        h=Subject:From:To:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id;
        bh=jHVTDgwLjb3XBZJrC/KLiDJjlfx4CRH5B8EbI4fa0NY=;
        b=FutmIgGL8CN2v9oED2Mnt5gDAMmW8m37jYWbbZ/x8BLeizXfpdOih3326PjE2w38
        Bl774qlp8H+zuEvGHml06uXF4Wqqnf36UQ/M28VjrCUjNxOzyNZdsOZXdxoTroaiqMS
        uAgBqbZ4G9Yl7eBA1IEUI/dQJ+Z4fgW5ROefqSM0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1576595455;
        h=Subject:From:To:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id:Feedback-ID;
        bh=jHVTDgwLjb3XBZJrC/KLiDJjlfx4CRH5B8EbI4fa0NY=;
        b=a2MRlmrdBmSD02WHG/448ij4Nu3DKTSezXAcKY4Uu3xDzN7bTCfmgDVx+tIP2+Ow
        +/EKAT6SHuRf9elMa5++MIOdpQfb6aLLDwUTFhBb8FtmhVjmSOYHtOtVPEopIrLNAlZ
        45P++IMTctsGh5zqp4wO93yfzy7wGZe9WlHSYsPg=
Subject: mesh-cfgclient fails with 'Segmentation fault'
From:   =?UTF-8?Q?Yury_Galustov?= <yury@ygsoftware.com.au>
To:     =?UTF-8?Q?linux-bluetooth=40vger=2Ekernel=2Eorg?= 
        <linux-bluetooth@vger.kernel.org>
Date:   Tue, 17 Dec 2019 15:10:55 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <mail.950b9bbe-7735-4634-bbe9-de9ff9bc7bd4@storage.wm.amazon.com> 
 <mail.950b9bbe-7735-4634-bbe9-de9ff9bc7bd4@storage.wm.amazon.com>
X-Priority: 3 (Normal)
X-Mailer: Amazon WorkMail
Thread-Index: AdW07CI9akHkPeGZRIeoVtfEhG5axg==
Thread-Topic: mesh-cfgclient fails with 'Segmentation fault'
Message-ID: <0101016f14697e81-b2b4716b-65b2-47c1-949b-36193e42ecf7-000000@us-west-2.amazonses.com>
X-SES-Outgoing: 2019.12.17-54.240.58.62
Feedback-ID: 1.us-west-2.An468LAV0jCjQDrDLvlZjeAthld7qrhZr+vow8irkvU=:AmazonSES
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,=0D=0AJust trying to use mesh-cfgclient to provision devices using PB-=
ADV using Raspberry Pi4.=0D=0A=0D=0AKernel has these options enabled:=0D=0A=
#   Hash Modes =E2=86=92 CMAC support=0D=0A#   Random Number Generation =E2=
=86=92 User-space interface for hash algorithms=0D=0A#   Random Number Ge=
neration =E2=86=92 User-space interface for symmetric key cipher algorith=
ms=0D=0A#   Random Number Generation =E2=86=92 User-space interface for A=
EAD cipher algorithms=0D=0A=0D=0A`bluetooth-meshd --nodetach --debug --db=
us-debug` runs with no issues and showing some binary data when I launch =
mesh-cfgclient.=0D=0ABut when I run 'create' command, it fails with 'Segm=
entation fault':=0D=0A=0D=0A=0D=0Api@raspberrypi:~/bluez-master $ ./tools=
/mesh-cfgclient=0D=0AWarning: config file "/home/pi/.config/meshcfg/confi=
g_db.json" not found=0D=0A=0D=0A[mesh-cfgclient]# create=0D=0ASegmentatio=
n fault=0D=0A=0D=0AHappy to debug the code if somebody would explain how =
)=0D=0A=0D=0AAny ideas=3F=0D=0A=0D=0AThanks,=0D=0AYury=0D=0A
