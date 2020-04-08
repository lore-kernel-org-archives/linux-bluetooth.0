Return-Path: <SRS0=PsJ4=5Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52201C2D0F4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 22:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A38F2082F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 22:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EL9YSX9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgDHWLK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Apr 2020 18:11:10 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43448 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgDHWLK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Apr 2020 18:11:10 -0400
Received: by mail-il1-f195.google.com with SMTP id z12so287707ilb.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2020 15:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Jjs829oM0lP+dihiHLTzBTdnFCx2MpHfJCJFaOxKlg4=;
        b=EL9YSX9Ld+Jn3ibLMlqp0qAJbae1U0lZjvQ/abDX/lqg6+DWih9fkXZazndFTjvqgJ
         ZCtbZup0d51bRHjHsg19kDXDDvDbs5ejjgdKoR18LhcOK2xSAQmrC3cJmiDwfkAB11YF
         Mdc4GzjE6YIcmCLjHbQZX9oEd1rr9fiBpSNgxu6e/yzjPoimkcXkLZCsO0//HsQBj0la
         RDbqTN5xZqv9WlOQ906CD0c0XLfPYDnaJi5RIJRp319R08hR2rqFWigY5Q715gPUhuBR
         Zkeoo+UBMx3wcU9I5AbqO4cPDxbn+Fn5Bb0tpe2xBjvbbwIwwdKYNKyP4nYl6MZBq0iD
         uDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Jjs829oM0lP+dihiHLTzBTdnFCx2MpHfJCJFaOxKlg4=;
        b=A1mLs7hbotg4Hn6Iwili4qJ9BGoqsA20L3XfGIxLWD3J9AGEEbmz11D0Z2Htfgtn/p
         rtvHaOxQBHEKhscmblEl4i26cYFYBRvFPdRGb3+GunHsbYLaNz1nmB4Krjxrd81BqUag
         ektHmOmSBLO4UUYSDHS2PFVnsUXwL+MjrcinIH2iYtpaaIfb9HTinwABxP435JH8G5Mo
         6dAB9szW6xar3d+ERwHW4xqozYXlXzmSKwK3lJgmWTqP8c8ShJq5C4hgsX7MpxwhKjws
         lZDmU3i2gxtq1KfPZJDRXZv968ImukGlZLE+yatmWjhLJO3iA+DOlqA9diKfTP9+5nCH
         CZbQ==
X-Gm-Message-State: AGi0PuZ1LQN1AithUOqc77Zzcnfgv3oycyAHpK3SJeaLx1DPp3Lcd7jG
        REr1H9nPQyEz1fWRN6vnQH8LC6ICoIDD1s9sEQQjvQHJ
X-Google-Smtp-Source: APiQypIb4Br+dkWS3MfUIAytOI4E5geNDMzQ3psUqdpLV5cPhXCb2+CtLWO+s79Yu/p03+haP/rcx/IiLrWFZol6Jb0=
X-Received: by 2002:a92:c00e:: with SMTP id q14mr9566116ild.124.1586383869146;
 Wed, 08 Apr 2020 15:11:09 -0700 (PDT)
MIME-Version: 1.0
From:   James Dickinson <james.n.dickinson@gmail.com>
Date:   Wed, 8 Apr 2020 23:10:58 +0100
Message-ID: <CAJi+TYXrfJRFVgWucrUVHQP39edq-F_W-aZF=i2D7wnafpWMvw@mail.gmail.com>
Subject: "DisplayOnly" IO capability does not work with BR/EDR connections
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Using Bluez 5.50 on Raspbian 10

I've noticed that when using the "DisplayOnly" IO capability on a
receiving device running Bluetooth 4.1 and an initiation device with
"DisplayKeyboard" IO capability (android phone), the pairing seems to
change to a Request Confirmation and requests a yes/no confirmation on
the receiving device. This is obviously a problem when the receiving
device is only able to display and not input.

I assume that this is likely caused by the conversion of
DisplayKeyboard to DisplayYesNo on BR/EDR connections.

This appears like a bug to me but, if it isn't, is there any way to
change the conversion to KeyboardOnly instead of DisplayYesNo? Or
could someone point out where this conversion is made so I could
change it myself and build from source?

-- 
Thanks a lot,
James
