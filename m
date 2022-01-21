Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2440C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jan 2022 13:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380758AbiAUNaS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jan 2022 08:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380759AbiAUNaH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jan 2022 08:30:07 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12410C061401
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 05:30:07 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id c3so8176029qtc.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 05:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=jcQ7zU3ePyEoWcbSVBRDKUIOR57mtAGb6gLjAuy1OWw=;
        b=Da4RbKSp/mXHegq0bwB2BTtv67c/SfM6ARG6Y6t/2I0mMp4VKJShA4X+3uNGRA0xJR
         LwuZZclth9wiX+v3dxUZqGNizNwmyJ+QpwIV/FC3kbyB9tDzwJ9fYk1AX5E0bYgyfq3b
         6CAUN6wGZBFQWWmj7Sv0mlSB/s6kJAc3BUWRFzB3zv0qvETdEIPs6Phc8fK3l+cKA6wR
         /7C6gGSbgj8aOKqM9xhjUBuoRsjir90trQNrDXCROX9WxzXVRbT9EH5H7Xa/H1fG0PAl
         9hG8Ij+tF62ChC3NqisoAmhNw0iSkZ/QZsbWdrr9YzTLpRK6cqaMBRvxFsTTWjmT4F+z
         6ylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=jcQ7zU3ePyEoWcbSVBRDKUIOR57mtAGb6gLjAuy1OWw=;
        b=GV1EDPt2NS4Pdlp6P+TDfeNP4A1EH0/YOxtF1Kp9g9+B+i/rbIYP3qvxH81hpCxUJ/
         J/UbQmsUHimVx9nx0lcixl7ydeNl9ROheSG33J2UJmqySLonr5hF2robGqX9C7eaiMAr
         erO6qPvp9ZHOf+fsjkn8ImLYaitLZ1tom9TjjYTYaGSXT+WJDEuxWk77XGTLhvj2IXi+
         cw5uzMtnyMGT8L3TBSU/KNlH4WNwNWqH+bW8ccfc7UJtZhvh9vbJDLyxcBbrcBuJcQyg
         VlspBie7wUO3g1Znflnuyob9F8UNsIj2ZN1LjdDGilnF36XQ9FCmPhZ5Rj16LKTQp9AC
         JeuA==
X-Gm-Message-State: AOAM532bJI5huL0sKRYnfl7cn5mt+q7f/hkpFsh3BlEWvQ8pv3DvKWnJ
        Cktmv72vpH7tvmYeQ+UCyC8punqb8gw=
X-Google-Smtp-Source: ABdhPJzhde8o1f1GMjWxMEz0gghpl5og+hg37L+kUbmU2WHXKWGhSyJhEjX62X9Z7eXiwdS8E9S36A==
X-Received: by 2002:a05:622a:c3:: with SMTP id p3mr3118350qtw.21.1642771806035;
        Fri, 21 Jan 2022 05:30:06 -0800 (PST)
Received: from [172.17.0.2] ([20.69.255.211])
        by smtp.gmail.com with ESMTPSA id k22sm2974498qkh.44.2022.01.21.05.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 05:30:05 -0800 (PST)
Message-ID: <61eab55d.1c69fb81.ea4f1.2de3@mx.google.com>
Date:   Fri, 21 Jan 2022 05:30:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0589572665215455743=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, josephsih@chromium.org
Subject: RE: [BlueZ,v1,1/2] adapter: support AOSP MGMT_EV_QUALITY_REPORT
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220121192352.BlueZ.v1.1.Ie4d1be8ced51f0aa92ee6d8eacf9666a121a1292@changeid>
References: <20220121192352.BlueZ.v1.1.Ie4d1be8ced51f0aa92ee6d8eacf9666a121a1292@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0589572665215455743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=607234

---Test result---

Test Summary:
CheckPatch                    PASS      3.93 seconds
GitLint                       PASS      2.13 seconds
Prep - Setup ELL              PASS      47.63 seconds
Build - Prep                  PASS      0.70 seconds
Build - Configure             PASS      9.44 seconds
Build - Make                  PASS      1425.43 seconds
Make Check                    PASS      12.99 seconds
Make Check w/Valgrind         PASS      513.54 seconds
Make Distcheck                PASS      239.71 seconds
Build w/ext ELL - Configure   PASS      8.79 seconds
Build w/ext ELL - Make        PASS      1279.33 seconds
Incremental Build with patchesPASS      2864.90 seconds



---
Regards,
Linux Bluetooth


--===============0589572665215455743==--
