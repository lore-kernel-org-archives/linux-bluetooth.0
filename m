Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C210E7AD77
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 16:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240393AbjJCQZi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 12:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240359AbjJCQZg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 12:25:36 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A119B7
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 09:25:33 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-578b407045bso867748a12.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Oct 2023 09:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696350333; x=1696955133; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mB5DnbVMVvsmqOXeOHS6pv/s2mas/66m1e6gn4RYHfo=;
        b=mCroM6ZzQ9+8TPc9U2g8R8LQ8dJ84ybFGa3IY+PIs8Gb8nLl+sj3xdyhJjx8gREslg
         bRhgX0wnrnsuNG2jedqn0rR6LoEjMu/J5f+vspZ3/bflXuuRJiiwKo6Iw70ZyLhci3Ia
         akzmaMQCIn9grd8HNvDdvyZUfjCEc7t4ds5of4i7twe1W6NgGM/Stk1tOO0Ej3OxZn2F
         tOT2sKHMtK6kalZF06dEi4F2hekNAApgBlv6Pt7cz3hPg6kQeB8gPPBOgWve/mUDUw2f
         HIafmn8emS9fzZ5mBrMX5Q1m8D8P58kZCC143qHvOJMfd8QPwseIvHoiugPFmLIUy43z
         J9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696350333; x=1696955133;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mB5DnbVMVvsmqOXeOHS6pv/s2mas/66m1e6gn4RYHfo=;
        b=tXVDDG6oqXLwCniIYoYqAc+q4W/HQDXckLesPulF7DRcdVBEuw960mttcTeYAe2Rgd
         GbsuYNEIuQnfr0TxVLFMEq8pEYau5KZO8HOOqrv38j8tBsnf+b4YihO1kAr+9KDwz1vg
         lUH6IlowXT8dR4rgFRmZTmCHn1XkaQWpBabSr45S5nDqsXj/1c4pPH/fxHSx4NAmWRW4
         XFmbcjccAvyapGvmFh3sGyHqHK4TzFZxpjfm9KRo+fZVQp9s3ocgqdUdg0oUfvCR9EWH
         eHN11KJLqox3i8Saq3U4xDcp1agNcpQmIz/pvZfnUd7ZzTyMJAINgQHrSm1JxlWFulrF
         AjNA==
X-Gm-Message-State: AOJu0YyoRtm/VKr51O408MLSdTkxnoUfi6umGq7gnEAIYV30H87xbpuo
        6PP4SlIqgohaFOGTe7f5rhUAwhduCFM=
X-Google-Smtp-Source: AGHT+IGbKpZiMrlEeZT5oSqpnL3dWdI/erYJKlfnx/saMhm3uwDKy0pceHrPMA7l/sMlI0UPsSbz2Q==
X-Received: by 2002:a05:6a20:158e:b0:15e:a653:fed5 with SMTP id h14-20020a056a20158e00b0015ea653fed5mr18468318pzj.16.1696350332832;
        Tue, 03 Oct 2023 09:25:32 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.61.183])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902bd0500b001b9f032bb3dsm1771884pls.3.2023.10.03.09.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:25:32 -0700 (PDT)
Message-ID: <651c407c.170a0220.a6004.4302@mx.google.com>
Date:   Tue, 03 Oct 2023 09:25:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1031686577883772781=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: iso-tester: Test bcast receiver with PA sync, no BIS
In-Reply-To: <20231003145754.3667-2-iulia.tanasescu@nxp.com>
References: <20231003145754.3667-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1031686577883772781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=789636

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      34.38 seconds
BluezMake                     PASS      993.30 seconds
MakeCheck                     PASS      13.51 seconds
MakeDistcheck                 PASS      195.92 seconds
CheckValgrind                 PASS      314.23 seconds
CheckSmatch                   PASS      418.35 seconds
bluezmakeextell               PASS      129.46 seconds
IncrementalBuild              PASS      811.25 seconds
ScanBuild                     PASS      1286.36 seconds



---
Regards,
Linux Bluetooth


--===============1031686577883772781==--
