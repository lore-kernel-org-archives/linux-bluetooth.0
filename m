Return-Path: <SRS0=KJgL=4R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2596C3F2C6
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Feb 2020 23:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A048222C2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Feb 2020 23:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="Gaf1Bhl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgB2XZe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Feb 2020 18:25:34 -0500
Received: from mail-io1-f44.google.com ([209.85.166.44]:45898 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgB2XZe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Feb 2020 18:25:34 -0500
Received: by mail-io1-f44.google.com with SMTP id w9so7572599iob.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Feb 2020 15:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=E1TA8XMS+MCxYIS9zYVTV9kJtZj5TRj6cnr+rrj/Uz4=;
        b=Gaf1Bhl8avevHFdr2HA7Dltui3smf/09iKJx3sTXPSI8sP7xbXceyaTxNHTnawPAfQ
         WNKvdKMFZ0sfbpkJ8ha9C69SeKhRFSh6QEuwqFss4SEQvRS+nVGSOAcZELpRQcwaVmqt
         3o8pKJsuNimknHYxfgWMa4byx4Wz3UMY+owIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=E1TA8XMS+MCxYIS9zYVTV9kJtZj5TRj6cnr+rrj/Uz4=;
        b=QrETKkDhdbzYKWabm3hNTSkQFKyydBvkY5AYNCBAWHUrR3qxos++m4iXiW0mJAw3Vd
         qbiBXPTkW0hYlW10yfvrisUFH5bFXBQfm2xMK+JsFhUNUhVFKjZAqo3NJNYTMsc6QMhd
         GD+hWfMrb2qm/zrVjl9sGpuaJX4gLr808UwIwGg62CMSE2kKAtbZNFCLZ7KvaN0OjvWo
         JwtnMfAQ1Fwr0KG8BqGkpCO2oCluLgf55NPq/SpuSJMeALxztmJDGEKPPvfFg9kBVMm7
         SAq7arxphlzaDyaNKV/CM17al38GIAMgIGKpHjkJlAbBtkVu66lv1FHyP6uTgi2UpxAB
         yj5A==
X-Gm-Message-State: APjAAAWofw4dhK+31+PTihkWvr3X0OSfUkskF4aQCJR5miNtcgExmBTd
        OVq4cDFOr67F9QYPZjQNZUMfcAzEIe0bdglV8mnGMk9ihlFRBw==
X-Google-Smtp-Source: APXvYqwa6O4J3YVTb3aQF4NAGItcINPe9e+2xaeH2m3pqKW6YRf4xkX+ngsB38wb+j85qENNxhR4S87xeMzrZYWWHXU=
X-Received: by 2002:a02:9203:: with SMTP id x3mr8367367jag.62.1583018732497;
 Sat, 29 Feb 2020 15:25:32 -0800 (PST)
MIME-Version: 1.0
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sat, 29 Feb 2020 15:25:20 -0800
Message-ID: <CAJCx=gmje04sxBAeK+xcEpf7vZ5tbWxkrrd-_ZbgOA72PPXzFw@mail.gmail.com>
Subject: OBEX PBAP + iOS timeout
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently having some issues with OBEX + iOS transferring the entire
contacts list via PBAP.
Looking at btmon output with Wireshark, and noticed the iOS device
timeouts out the data transfer before it completes. However on a Pixel
it transfers completely and without the timeout issue.

Note this is rather large transfer since all the contacts have base64
contact image data.

However we have a workaround/hack that increases the ACL MTU to 930
versus 310 and the data transfers complete every single time. But is
there some known issue with iOS + PBAP, and some better long term
solution possible?

Ref: https://gerrit.automotivelinux.org/gerrit/c/AGL/meta-agl/+/24130

Thanks,

Matt
