Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A273DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Feb 2022 20:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbiBRUzy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Feb 2022 15:55:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbiBRUzx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Feb 2022 15:55:53 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A678189A94
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 12:55:35 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id v186so21929902ybg.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 12:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wdrITIRPGhheRsCvOPbNN2ZSR+pWJZF8/0wzdyoGoZk=;
        b=MUWQZ6j212lc+YhDS0QSLZePwGY7CPmlfcAC3ZcARU58gzMaOrlHiG0LgI3JQWRErB
         1rmvLL0hkBJv6v5N/0vRNgNHPDTc1jbdgrMjDYrY8GkQk3+a47xBn0+7k7YsPFIzv7Nh
         7f2ULcQDfwoVNckclEkQJ6x/WFzSbBTnixHc7uee3yYTwgPZu7rWvjUUMFBXlLe4UJc9
         GjEiHSj1L0iWGu4HHK//1k+KKTPZVrtGW4TTQBSDxYokGZZBzHFyTZc3kxqH66X4Piny
         o7sk8/uRlUt2yXNljvSyuxrNF2Rl8ZeeTbPmhpGo6o8JKV/1lbqnJEJNl+lfFuSg17Me
         7/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdrITIRPGhheRsCvOPbNN2ZSR+pWJZF8/0wzdyoGoZk=;
        b=22fhQeHMruJtrycAnSwwiQ/SAIaEMd9nkhJdEvTzY5p3L9HUEktrg1u7TkJJrs7OpC
         G9wZMt709VqT/J1KVbYxKrEN40fnc+m1ds9fMlxoiLA/ooMb8a/drpbKeKgO7rNPWIrD
         B459GUFyxbC9kYkotZwx9cfDUbEW4zOCyor+d1HzkCedx/UMd6jZggpdHls82I01KCX+
         dzs8cfVOjB1iCU8arDsEx0g2UoysM9nrNhoZEMnToV9BNuJwv9ckpBb34ZwDswVSJ7iH
         obnTxaqYlX60h5GBMMfgEoel5yPrqR9YI17UumPHBzZj9HoIg7d06CytkcWlbk3TbnYJ
         rOqQ==
X-Gm-Message-State: AOAM531LCCezQqjhIwXjYZx0A1b97we3QwU4dJbEozip86BSnK2DQcAe
        2mL3IGm5NqfDzIMdGCAzRyV6s7WgmBtD1Owv2OQ=
X-Google-Smtp-Source: ABdhPJxlY2G8jg1VdaJ9jSyTh+2rk/LfDeuyAqeVHn18Y6BEqNg9PxoQ8el8bMeuGbu+q9Ny3DD2Hw+QgvVh68VAl84=
X-Received: by 2002:a25:8546:0:b0:61e:1d34:ec71 with SMTP id
 f6-20020a258546000000b0061e1d34ec71mr8799189ybn.259.1645217734532; Fri, 18
 Feb 2022 12:55:34 -0800 (PST)
MIME-Version: 1.0
References: <bug-215576-62941@https.bugzilla.kernel.org/> <bug-215576-62941-mgAUSJWfs5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215576-62941-mgAUSJWfs5@https.bugzilla.kernel.org/>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 18 Feb 2022 12:55:23 -0800
Message-ID: <CABBYNZKgKw3dkJe1vzN40Dfc+3iATVnf=MwVYyU_GxQwhCr1=w@mail.gmail.com>
Subject: Re: [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
To:     bugzilla-daemon@kernel.org, Kiran K <kiran.k@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Fri, Feb 18, 2022 at 6:35 AM <bugzilla-daemon@kernel.org> wrote:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=215576
>
> The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leemhuis.info) changed:
>
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>                  CC|                            |marcel@holtmann.org,
>                    |                            |regressions@leemhuis.info
>
> --- Comment #3 from The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leemhuis.info) ---
> hey bluetooth maintainers, what the status here? This regression was reported
> more than ten days ago, it was bisected, and a second person roughly confirms
> it, nevertheless there wasn't a single reply yet. Is somebody looking into
> this?
>
> --
> You may reply to this email to add a comment.
>
> You are receiving this mail because:
> You are the assignee for the bug.

Looks like a regression introduced by:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=b2af264ad3af437238c9500aa830ebcafb180e05

It seems BT_VOICE sets BT_CODEC_TRANSPARENT when perhaps should be
setting BT_CODEC_MSBC:

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 8eabf41b2993..b35c772efc7e 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -879,15 +879,9 @@ static int sco_sock_setsockopt(struct socket
*sock, int level, int optname,
                }

                sco_pi(sk)->setting = voice.setting;
-               hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src,
-                                    BDADDR_BREDR);
-               if (!hdev) {
-                       err = -EBADFD;
-                       break;
-               }
-               if (enhanced_sco_capable(hdev) &&
-                   voice.setting == BT_VOICE_TRANSPARENT)
-                       sco_pi(sk)->codec.id = BT_CODEC_TRANSPARENT;
+               if (voice.setting == BT_VOICE_TRANSPARENT)
+                       sco_pi(sk)->codec.id = BT_CODEC_MSBC;
+
                hci_dev_put(hdev);
                break;
-- 
Luiz Augusto von Dentz
