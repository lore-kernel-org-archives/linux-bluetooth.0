Return-Path: <SRS0=Vaj6=7Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58569C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 14:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E86206A2
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 14:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sz8AMdDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgFCOEW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFCOEW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 10:04:22 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6B8C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 07:04:22 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id k11so2289009ejr.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 07:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=NZ6dOJJHuwK9cUIB8XV0gWGLAPOtvUoYd7NP06AHxTI=;
        b=Sz8AMdDIhurzxYzZYP43jMKRn3ogzaEUG5iLv//140mjIfkp/LBh47rvx+gzP9EI76
         IZETuzGdPPTIH9+lYjpdUcVYxmG3SAXA0pySLAncPFyaembyv88E+JNDG0I/hOL2A3Mf
         85F7/LcoW6m9+Cd/5HUWAfEspIiqEIbWwMXQuTIa8cBzj9QfFigAMIoZkDMBmpZPQ7vi
         Sa7xYs8OwqOzvO5vo/mqJaPRd2wQOsZvhr5Pa7vhamgkgTqoS0/FAgVKvdQK29YSDPGM
         VTBfcQAoJe4AemNPFGNOaFA37oLDRXBeBgDo6U6S4ELkwIj6S7MnaIlVngMDxiaUEeYA
         bHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=NZ6dOJJHuwK9cUIB8XV0gWGLAPOtvUoYd7NP06AHxTI=;
        b=OFMB5o6n5M2NVLxzKIiMC6Cy+uQ9PlTrrVo/+FabbiV5caf2QQ1g1LetaXbABayYbW
         DXGAwR8WRAPZyJpem8tMb4r/iJCjOZF/t1omX76+CM4DGh8V4cyFbmG6eWeNRRf6z2zZ
         65wBk8MyXREHcdfeOd15LF5aFzN8Ap0Fe1Yr+7lfVo5zUHExZpXhH0nc39HFyDB8e0Vl
         aQGVo1bTuVjE7U8SCAzWgHe1vaIZl4YIrPDGwX5MUfdRoEGxjh8rrXtmHsCuK5IYXrjl
         E++v5eciJM3g5JtJOqBgyvr3vBAiSQvwMShAw2OWG3EkM+UImDNB05PDUqO51blDLZ4b
         SrNA==
X-Gm-Message-State: AOAM532sLG90ilwlUIRi12YBLJtASNaVI0SNCXxZnlklSqDBZnc4LLWJ
        H2Hr6FI4s4tVINANur68tJu+YUvMGQcGly0vTHDrpN61CPQ=
X-Google-Smtp-Source: ABdhPJzAvuwVs/IJSaUqWt324KiOcjIuYByIfTOsxKOOs78Cy+5cblip3RCPooYNFilfHv6cdHSD27C5E1QPqabqtW0=
X-Received: by 2002:a17:906:9a02:: with SMTP id ai2mr26955480ejc.97.1591193060186;
 Wed, 03 Jun 2020 07:04:20 -0700 (PDT)
MIME-Version: 1.0
From:   Yun-hao Chung <howardchung@google.com>
Date:   Wed, 3 Jun 2020 22:04:08 +0800
Message-ID: <CAPHZWUe9sLt8jsD57i3=PQxMfjODP7dUYLBm2qpSXFdgd9cvAQ@mail.gmail.com>
Subject: Should we disable ERTM as default?
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Cc:     ChromeOS BT Qualification <chromeos-bt-qual@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Linux-bluetooth,

When I ran the following tests in PTS qualification on Chrome OS, I
couldn=E2=80=99t pass all of them because they all failed to create an AVDT=
P
connection with channel type as =E2=80=98Streaming=E2=80=99 or =E2=80=98Enh=
anced
Retransmission=E2=80=99.

- MPS/AG-SRC-TG/HFAV/CLH/SD/BV-03-I
- MPS/AG-SRC-TG/HFAV/CLH/SD/BV-04-I
- MPS/AG-SRC-TG/HFAV/CLH/SD/BV-05-I
- MPS/AG-SRC-TG/HFAV/CLH/SD/BV-06-I

It looks like bluez doesn=E2=80=99t want to change its mode even though it
claims it supports them. Our question is do we still want to enable
this feature as default?

Thanks.
