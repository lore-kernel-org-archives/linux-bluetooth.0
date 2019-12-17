Return-Path: <SRS0=Cjqc=2H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E2BC43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 15:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7832146E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 15:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ygsoftware.com.au header.i=@ygsoftware.com.au header.b="rwlfgZha";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="cSYxHN5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfLQPA4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:00:56 -0500
Received: from a27-40.smtp-out.us-west-2.amazonses.com ([54.240.27.40]:59994
        "EHLO a27-40.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728074AbfLQPA4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Dec 2019 10:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=vl7dyoqhfh6isglrlfucb4hjwred72dq; d=ygsoftware.com.au;
        t=1576594855;
        h=Subject:From:To:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id;
        bh=DYwIdWTvg++u5fE8PtG4OOFq6xi74xthIB2m9IvKeUE=;
        b=rwlfgZhawWgRaJRxXADE0ojBixOf++zJI8jtq+OUZ9uxyvJIEeaBwYbdW3V9LTLP
        Foo7HRLGbSzMZuFPJabm8G7LEYNl3gwfEl0d6Gw0laWwZW2ogymEjCtRMxnTexSkunt
        QCl2FephkObN8tKmy+c3Ntqre2tuYqSlzf0I3f2I=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1576594855;
        h=Subject:From:To:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id:Feedback-ID;
        bh=DYwIdWTvg++u5fE8PtG4OOFq6xi74xthIB2m9IvKeUE=;
        b=cSYxHN5IyvrkFxK4YsQbW/ZiQHNSZrjyhof0T/zdhOshiCwwD+w+6sFwTSBdmegt
        qJ+mrAHCSvvbCVg6pN7ex4sQvurUp/id/oB3QJfhkM9fqPzKhgB/aNwmti84UMmGdfE
        t7+DoJ2VD94cy9U1Xs763I4z3NB0D3zthN3cpD78=
Subject: meshctl fails with 'Failed to AcquireWrite'
From:   =?UTF-8?Q?Yury_Galustov?= <yury@ygsoftware.com.au>
To:     =?UTF-8?Q?linux-bluetooth=40vger=2Ekernel=2Eorg?= 
        <linux-bluetooth@vger.kernel.org>
Date:   Tue, 17 Dec 2019 15:00:55 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <mail.64efb14f-e4e1-4c80-87cc-4be3dc523401@storage.wm.amazon.com> 
 <mail.64efb14f-e4e1-4c80-87cc-4be3dc523401@storage.wm.amazon.com>
X-Priority: 3 (Normal)
X-Mailer: Amazon WorkMail
Thread-Index: AdW06sdZRplUsJ2nTb+VN0IYvnkKAQ==
Thread-Topic: meshctl fails with 'Failed to AcquireWrite'
Message-ID: <0101016f14605796-116b8ce0-8cf1-447d-92a6-4549587b23fe-000000@us-west-2.amazonses.com>
X-SES-Outgoing: 2019.12.17-54.240.27.40
Feedback-ID: 1.us-west-2.An468LAV0jCjQDrDLvlZjeAthld7qrhZr+vow8irkvU=:AmazonSES
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,=0D=0AI=E2=80=99m trying to use BlueZ 5.52 installed on Raspberry Pi 4=
 to provision mesh network.=0D=0A=0D=0AThe initial provisioning works fin=
e and I=E2=80=99m able to provision and control device, but if I close me=
shctl and then open it again then all commands related to data transmissi=
on fail with =E2=80=98Failed to AcquireWrite=E2=80=99 error here gatt.c:3=
67=0D=0A=0D=0AI=E2=80=99ve googled a lot and checked the source code and =
see that the problem might be somehow related to the OS itself and file d=
escriptor lock, but I haven=E2=80=99t found any solution yet.=0D=0ACurren=
tly digging into g_dbus_proxy_call with no luck =E2=80=A6=0D=0A=0D=0AStep=
s to reproduce:=0D=0A=0D=0A1. run meshctl=0D=0A2. discover-unprovisioned =
on=0D=0A3. provision <uuid>=0D=0A4. menu config=0D=0A5. target 0101 (newl=
y added device unicast address)=0D=0A6. ttl-get=0D=0ASteps 1-6 work fine=0D=
=0A=0D=0A7.=09exit meshctl and launch it again=0D=0A8.=09connect  <newly =
added device unicast address>=0D=0A9.=09target <newly added device unicas=
t address>=0D=0A10.=09ttl-get (or any command that transmits data) fails =
with =E2=80=98Failed to AcquireWrite=E2=80=99=0D=0A=0D=0AI've also tried =
the latest code from master branch but got the same error.=0D=0AAny ideas=
 where I need to look )=3F=0D=0A=0D=0AThanks,=0D=0AYury=0D=0A=0D=0A=0D=0A=
