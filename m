Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E7FC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Nov 2022 19:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiKITk4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Nov 2022 14:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiKITkz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Nov 2022 14:40:55 -0500
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F2318B2A
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Nov 2022 11:40:54 -0800 (PST)
Received: by mail-qk1-f172.google.com with SMTP id z30so11567601qkz.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Nov 2022 11:40:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:message-id
         :in-reply-to:mime-version:cc:to:subject:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oGuDGJjbkCkBfndaZcptYi0ax06GwQ+ekpkzivboL4k=;
        b=rlKAKTrrOfbYVpmp0C6b2LL0gi4wYbSG/9HR4OWF7m/OOr/QXPNPErL+Zl8zXgLTLQ
         sYA/ZHWAFy2304lh4rIQGRa3YbG35yqbBqdgSWWzOtaWOnYm34Ckc+HX+XYUGZGx85Eh
         Ul2ZLhs2Tpz/uqsMMPuDtRoqYCkAfwjUig1tmY27xA/Yusn8uUBx1vuZ3L5mGY3Ztl9z
         qCOWW7Q1vCIMJ3RpdyH1rha8P17ZMJfoCFbfn0F8kJZyh+WdbnIZ1U2xjy+dTv3C408V
         fL/MQtJ6C8NCwI3/UYNbocZ/ehddPE+s580IW0bPTVkiTosHFs3G5HTOny05vQm4CUm9
         H2Jw==
X-Gm-Message-State: ACrzQf0b59wa5Kv5rU/qDt7FY0ytxv74iJpZLAgqkDHS3andPRs6CPm+
        BDUH8R5TDJBkJbEl+qRyJSMzqkQzw4qVqA==
X-Google-Smtp-Source: AMsMyM5w499RYKd4atTRYhOltSqxws7gzQZ2KP2P4xeZ4e1qaS/GhN72P/hoguspy5mIdTmGEHxKOA==
X-Received: by 2002:ae9:e608:0:b0:6fa:1662:653b with SMTP id z8-20020ae9e608000000b006fa1662653bmr42940700qkf.276.1668022853593;
        Wed, 09 Nov 2022 11:40:53 -0800 (PST)
Received: from ffortso9 (c-73-238-129-126.hsd1.ma.comcast.net. [73.238.129.126])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a0b8b00b006fab68c7e87sm5003513qkh.70.2022.11.09.11.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:40:53 -0800 (PST)
Date:   Wed, 09 Nov 2022 14:40:51 -0500
From:   Jack <ostroffjh@users.sourceforge.net>
Subject: Re: [Regression] Cambridge Silicon Radio, Ltd Bluetooth Dongle
To:     linux-bluetooth@vger.kernel.org
Cc:     Swyter <swyterzone@gmail.com>, luiz.dentz@gmail.com,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Hans de Goede <hdegoede@redhat.com>
MIME-Version: 1.0
In-Reply-To: <76cd4547-a68d-9d52-1d87-8299e29406ff@gmail.com>
X-Mailer: Balsa 2.6.4
Message-Id: <LWPL3AC7.RRTERTU2.B5FO44IX@4YQH7VT3.DY2DZPQX.S6LIZ6VV>
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2022.11.09 14:12, Swyter wrote:
> >> Correct hci_set_event_mask_page_2_sync() event mask
> >> git bisect good 0feb8af0275d196a29e321bedc15319673923cb6
> >> # bad: [1172c59f451f524a14bac5e7b047781883dfe441] Bluetooth: btusb:
> >> Remove HCI_QUIRK_BROKEN_ERR_DATA_REPORTING for QCA
> >> git bisect bad 1172c59f451f524a14bac5e7b047781883dfe441
> >> # bad: [766ae2422b4312a73510ebee9266bc23b466fbbb] Bluetooth:  
> hci_sync:
> >> Check LMP feature bit instead of quirk
> >> git bisect bad 766ae2422b4312a73510ebee9266bc23b466fbbb
> >> # first bad commit: [766ae2422b4312a73510ebee9266bc23b466fbbb]
> >> Bluetooth: hci_sync: Check LMP feature bit instead of quirk
> >>
> >> And 766ae2422b4312a73510ebee9266bc23b466fbbb does make sense as a
> >> likely culprit.
> >
> > Looks like we will need to reintroduce the quirk then since it  
> appears
> > the LMP feature bit is probably set in those controllers but the
> > command doesn't work.
> 
> It is. I already mentioned it in the Bugzilla thread and that's
> what the patch series I submitted the other day fixes:
> 
> > Bluetooth: btusb: Fix Chinese CSR dongles again by re-adding  
> ERR_DATA_REPORTING quirk
> >  
> https://patchwork.kernel.org/project/bluetooth/patch/20221029202454.25651-1-swyterzone@gmail.com/
> 
> Hans de Goede gave it a Reviewed-by, but it has been ignored even  
> since.
> 
> Keep in mind that I'm an occasional contributor and I can barely use  
> a mailing list,
> but this goes back to the patch that Zijun Hu sent back in July and I  
> was pinged.
> 
> 
> I took a look back then, it looked suspect, but I imagined you guys  
> knew what you were
> doing. Fast-forward three months and the code arrives at most  
> mainstream distros.
> 
> Every single cheap Bluetooth dongle on Earth broke again. Just like  
> that.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=60824#c242
> 
> I just came across this thread archive by pure chance, this isn't  
> very user friendly.
> Please CC me if you talk about this, I'm not subscribed to any list.
> 
In case it helps any, I have applied Swyter's patch referenced at  
comment #243 of the bug referenced above, and it does restore function  
to my particular dongle (Gentoo linux, with gentoo-sources kernel  
6.0.6.)  (I believe I provided the git bisect quoted at the top of this  
message.)

Jack
