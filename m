Return-Path: <SRS0=LpJm=NT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1AFECDE4B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Nov 2018 13:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CD82081C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Nov 2018 13:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niy7tOEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CD82081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeKHXDC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:03:02 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:33895 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeKHXDB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Nov 2018 18:03:01 -0500
Received: by mail-io1-f53.google.com with SMTP id d80-v6so14604834iof.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Nov 2018 05:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=nggJBHLwIH8IBoTGYZy+T875kISDLK5LA0r5gwbsbjA=;
        b=niy7tOEql5uunsSj/AnTdssEDbGER/PpkSiyeJmyiN93Ul8KJqZDSkGRFs574956d1
         dTnstj6erCLNiQjh8YqXHtwuKa0i4ZmgkWoIoQr/fzUJ++kAEDUpOY216Ay5rx/xoWPH
         7hpJZT84Fdga5z5wSnzWYZ1XImljkCRUI/X0yD5eaaDR7RLk2h5dGuHNmt/MSnOAMWOL
         vpQa5CHbAYB2yiki+Fv01x20G4991G4FO7+683HZEtbLpTNT9EtGCXm0kbz2+peUbkS+
         38CvrkqZivLopeiucdVe8Sr3/CwJwm8sIhndRQaRZqsrnzpc+CKhqmEDdGSsrNmv/epu
         DqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nggJBHLwIH8IBoTGYZy+T875kISDLK5LA0r5gwbsbjA=;
        b=ELRTGmjNuIbPeuhkQAIGEduKYNazU1MpSHTsvDK8zckNglqqvToYF5Pyt6kW3mippy
         TnSN2GGsWLtoyJWh8zDZae/+lkbOZPGxJIaL+wbu4A0CfMmVKxMRiTdAgqod27SpcN+e
         pQW9zEANEUq5Bir0okkhn4mcpjPmbixOe/23Pi66F6JJtj2kzslOzGNeRtxHoQ5vo4e5
         sveKgEGOLIh7kMMdlx6/jQDU72e/TbhbEK2fGe2Wta6jXXkn/baYcVCGNrkTQP8kb/HL
         JIrO4CLTPjmyw7Q03ssbfqJnP1BIRpY8CK+nOYBQgma6VKEcwSjCGvDfVMRFqhD7gVkh
         zc3g==
X-Gm-Message-State: AGRZ1gLv2l9PcqbzJeR7twIexDOkeIEtaIQ2y9DgPlC2zhNMSLko/t+U
        Qk5fDK08CzCKulxdNfMH67xkwMUKjf8Q/lF992VrzJ1bpdY=
X-Google-Smtp-Source: AJdET5cE8CL6vDfDM2NyPQFpHphp4WIUfJuvVLymUe4l07Rx8ie0Pv9URw7j5oBd9tOCgZrX7pEPW1ajpcDkfHU+W3k=
X-Received: by 2002:a6b:d50d:: with SMTP id m13-v6mr2705859iog.152.1541683651390;
 Thu, 08 Nov 2018 05:27:31 -0800 (PST)
MIME-Version: 1.0
From:   Robbert Hofman <hofman.robbert@gmail.com>
Date:   Thu, 8 Nov 2018 14:27:18 +0100
Message-ID: <CADZhEUBeTf0-muEdXg0f_-nq3udgj2ZiSzRgg68Yp8GRywmZeQ@mail.gmail.com>
Subject: Improving error messages in BlueZ
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I am not familiar with the way pull requests work on git.kernel.org,
so I'm trying to make my proposal via email. Excuse me if I'm doing
something wrong here.

I wanted to improve the error messages that gatttool prints, a.o. when
not specifying a value to write to a certain characteristic. See
https://github.com/pauloborges/bluez/pull/8/commits/745e8308bacb0e60e39237c821b08960cf0aba55
where I made a commit that would do so.

When following the tutorial on how to make a pull request
(https://www.kernel.org/doc/html/v4.17/maintainer/pull-requests.html),
upon trying to push my commit to a new branch, I got an "access
denied" error message from git. So I guess not everyone can just make
a pull request? Can I get any help on how to make this work?

Kind regards,
Robbert
