Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA6FC433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Feb 2021 07:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53FD564DCD
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Feb 2021 07:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhBMHJN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 Feb 2021 02:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhBMHJN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 Feb 2021 02:09:13 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC81C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Feb 2021 23:08:32 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id f14so2880534ejc.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Feb 2021 23:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yysTP06vE9lc4TtsBcWuNTHkRWE24GE+rw1xwBCApSI=;
        b=DltRnHBthH1bEdx2hba554zjN5nGybf9AU+pkDCHUM8o0FoQmDiM7kZVgJyCF9XEQk
         XqWYCgrcKWx3Kr20XprvUJ5lLzK8cDxK9E/zTH9JBBPc526zAC4+k7Wbi2QvLN/HTcBM
         g1+ye4p5F+s49hxQPwioZ4XYEY6DSpGpwgzy8AKYBfekwGFTJLLgQRj5m7MOo5gkuhoC
         CpnHe3cm+rCOrhcLjLIj697kow9zAq5bzxk/a2WEz5tuDeCnX4Qg0lKrzt03yCWbLWiL
         48N3AxQCAi4tuwE7VIveunAvzxuESd5ELCxsWCsqPU5zdpYu73+jwNzcwwvkh+tpW7r6
         KJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=yysTP06vE9lc4TtsBcWuNTHkRWE24GE+rw1xwBCApSI=;
        b=rk6gSI9f+YqGKRdfA3yoarC5TY4750AqgbUiS9R7YT+q5UNoaFZtwN6z4mhtZW67BN
         0RhdqBlg1UMcSKs+iISc6RFt/hqSEUL/h7n3vOF3f5nlyuuwUMf59tszTxorI+IsjzPg
         2d1tB9VjBe+zz2qU128fA7jwwrGtLHV2gbG+Wr7NMweSaFu+nnPalleFCL8dmha+JAGK
         /+k8DpfA2Tny+SLFd3fzjKQkFxP4UK+AnZy8j5T8jRvbKS64h2ANrWmH40Ebp8Yvk0sT
         19u2PKoJmK8XhMJMXNvowVthP8tk7aS2Kh3KGqIYmi258qNxi0jOkpjJ1Xgrup4O5FGz
         CYRw==
X-Gm-Message-State: AOAM531jUy/7fBPm8McuNL9jaFlZJl9cQV6QgzUZDXiI29cyUmkryW+h
        l55j5DBBfybCFx9Q7Lhd0Pk=
X-Google-Smtp-Source: ABdhPJxlbnGYdKrT9LAIKtMD19taeyeQPTF5B7aDOHow4Fi6EE+t+SUjF0Wejjmfcb6TBmokezZvAg==
X-Received: by 2002:a17:906:c00a:: with SMTP id e10mr6523883ejz.501.1613200111224;
        Fri, 12 Feb 2021 23:08:31 -0800 (PST)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id s14sm1755227ejx.60.2021.02.12.23.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 23:08:30 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Sat, 13 Feb 2021 08:08:29 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     linux-bluetooth@vger.kernel.org, Rocky Liao <rjliao@codeaurora.org>
Cc:     bugzilla-daemon@bugzilla.kernel.org, jwrdegoede@fedoraproject.org,
        brad@pocketinnovations.com.au, 981005@bugs.debian.org,
        moreno.giussani@protonmail.com, hui.wang@canonical.com
Subject: Re: [Bug 210681] kernel: Bluetooth: hci0: don't support firmware
 rome 0x31010000
Message-ID: <YCd67R0gtSoWCu82@eldamar.lan>
References: <bug-210681-62941@https.bugzilla.kernel.org/>
 <bug-210681-62941-pQZx4HWyOB@https.bugzilla.kernel.org/>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-210681-62941-pQZx4HWyOB@https.bugzilla.kernel.org/>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi 

On Tue, Dec 29, 2020 at 10:50:10AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=210681
> 
> Bradley Jarvis (brad@pocketinnovations.com.au) changed:
> 
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>                  CC|                            |brad@pocketinnovations.com.
>                    |                            |au
> 
> --- Comment #10 from Bradley Jarvis (brad@pocketinnovations.com.au) ---
> Created attachment 294393
>   --> https://bugzilla.kernel.org/attachment.cgi?id=294393&action=edit
> fix hci0: don't support firmware rome error
> 
> Avoid returning error code when bluetooth version match is not made from
> qca_devices_table and version high is set.
> 
> This reverts an error check that was removed to support WCN6855 which does have
> the high version set. The fix is to move the check after the table is scanned
> and no version match is made.
> 
> This fix will still produce the error message for example (for ATK3K 13d3:3402
> IMC Networks Bluetooth USB Host Controller)
> 
> Bluetooth: hci0: don't support firmware rome 0x1020200
> 
> But the bluetooth hardware still works as it used to

Several people have reported that since b40f58b97386 ("Bluetooth:
btusb: Add Qualcomm Bluetooth SoC WCN6855 support") they have issues
with their Bluetooth adapter stopping working. It was reported at
bugzilla[1].

Bradley Jarvis posted/attached a patch which seems to resolve the
issue, Moreno has added an alternative patch.

 [1] https://bugzilla.kernel.org/show_bug.cgi?id=210681

But there is another report at

 [2] https://bugzilla.kernel.org/show_bug.cgi?id=211571

and that last one was applied to bluetooth-next tree according to
https://lore.kernel.org/linux-bluetooth/CA2C8796-11CA-4E6F-A603-AE764516C850@holtmann.org/

Regards,
Salvatore
