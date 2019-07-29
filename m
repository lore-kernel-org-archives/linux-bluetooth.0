Return-Path: <SRS0=/vUS=V2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5C0C433FF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jul 2019 13:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E94120578
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jul 2019 13:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.in header.i=@phytec.in header.b="ctvbV5Gc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfG2N4Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:56:16 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:42472 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfG2N4Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Jul 2019 09:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.in; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.in; t=1564408574; x=1567000574;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PZDw04ahFnlQOKiOZsW+Sz9sY6A+1CqlINOorT0zpnE=;
        b=ctvbV5GcR8P15EUsP6BiqJLd+TVqCQ6sw3c3eJ7UlJj+f4/1PCiZUBDiB3EEBBL2
        SYZEHouwfq06Y7DWE44AEh9fRT9/3jdFPZQRr0RhB/iuMx9aXCXPNi00WjMh4gQa
        0Jo2mWZ1/uTrsbu5hxs7x6s9B3MBUuI5nvJqOBBi18k=;
X-AuditID: c39127d2-e31ff70000001af2-32-5d3efafec426
Received: from tumirnix.phytec.de (tumirnix.phytec.de [172.16.0.38])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id C1.20.06898.EFAFE3D5; Mon, 29 Jul 2019 15:56:14 +0200 (CEST)
X-Disclaimed: 1
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
In-Reply-To: 
References: 
Subject: No default controller available error
From:   Mahaboob Nazeer SK <nazeer.m@phytec.in>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-ID: <OF16744CA5.5F3760DC-ONC1258446.004C8E8D-C1258446.004C8E8E@phytec.de>
Date:   Mon, 29 Jul 2019 15:56:12 +0200
X-Mailer: Lotus Domino Web Server Release 9.0.1FP7 August  17, 2016
X-MIMETrack: Serialize by http on Tumirnix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 29.07.2019 15:56:12,
        Serialize complete at 29.07.2019 15:56:12,
        Serialize by Router on Tumirnix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 29.07.2019 15:56:12
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsWyRoBBTfffL7tYg6YGM4s51/qYHRg9Pm+S
        C2CM4rJJSc3JLEst0rdL4MrYM/cDa8E57orpH/IaGA9ydjFyckgImEi0vrnB3MXIxSEksIdR
        oun4TxaIBL/Epz+tbCA2r4CgxMmZT8DiwgK8EpvezmYEsTkFhCQ6rnayQtSLSUxY9wtoEAdQ
        nFdiwj9rkLCQAI/Eqw37GSFa9ST2/l4BNpJNQFdi5YWHYHERAXeJPftvM0KsCpS4tH4hE4jN
        IqAqMaltIxvEeGeJxX8usIDcKSHQwCRx7NJxNpBdzALqEuvnCYHUMAtoSyxb+Jp5AqPQLCRX
        z0KomoWkagEj8ypGodzM5OzUosxsvYKMypLUZL2U1E2MwCA9PFH90g7GvjkehxiZOBgPMUpw
        MCuJ8G5Rso4V4k1JrKxKLcqPLyrNSS0+xCjNwaIkzruBtyRMSCA9sSQ1OzW1ILUIJsvEwSnV
        wJhhJPh9xvc7s06cr551SWiW55tL2j5x+X5dDjtKfyk7xExsavPdrPHQKXqzpEuTbYmjuP9y
        tZ2H9ItsHlyzd1ELP51lsvvM4pfHVSTWKTCyMBowS067dJ6tTvdg3vXlixJYAv8trJ8c+DHu
        SFKXyrVdV3hTDnYmVa+d4cC/8Mwc4/Jjuzx+zFNiKc5INNRiLipOBAB46piIQAIAAA==
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I just cloned the latest Bluez and tried to install it with mesh enabled. T=
he installation was
successful. But when i run the mesh control and try to do discover-unprovis=
ioned,i am facing below error.I also get same error when i tried with bluet=
oothctl.

$ meshctl=20
Waiting to connect to bluetoothd...Reading prov=5Fdb.json and local=5Fnode.=
json from /home/nazeer/.config/meshctl directory
[meshctl]# discover-unprovisioned on
No default controller available
[meshctl]#

I checked weather the service was running. And found it was running fine

sudo systemctl status bluetooth
=E2=97=8F bluetooth.service - Bluetooth service
   Loaded: loaded (/lib/systemd/system/bluetooth.service; enabled; vendor p=
reset: enabled)
   Active: active (running) since Mon 2019-07-29 19:06:39 IST; 1min 18s ago
     Docs: man:bluetoothd(8)
 Main PID: 18612 (bluetoothd)
    Tasks: 1 (limit: 4489)
   Memory: 708.0K
   CGroup: /system.slice/bluetooth.service
           =E2=94=94=E2=94=8018612 /usr/libexec/bluetooth/bluetoothd

Jul 29 19:06:39 nazeer systemd[1]: Starting Bluetooth service...
Jul 29 19:06:39 nazeer bluetoothd[18612]: Bluetooth daemon 5.50
Jul 29 19:06:39 nazeer systemd[1]: Started Bluetooth service.
Jul 29 19:06:39 nazeer bluetoothd[18612]: Starting SDP server
Jul 29 19:06:39 nazeer bluetoothd[18612]: Bluetooth management interface 1.=
14 initialized

I request to please provide me a solution.

Regards,
Nazeer.=20





