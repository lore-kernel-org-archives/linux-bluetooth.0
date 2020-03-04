Return-Path: <SRS0=QCqs=4V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522BDC3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 14:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1946320732
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 14:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xaou4yQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgCDOwP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:52:15 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36499 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgCDOwP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Mar 2020 09:52:15 -0500
Received: by mail-lf1-f66.google.com with SMTP id s1so1761548lfd.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Mar 2020 06:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PdIEInuRnFWAet7Rbg6b7+xHDblel1LCE8hUbr8M2qg=;
        b=Xaou4yQvP96gTaxMbvxEPxCDkV9KxTKgOm3aa8s5RVwVQSrqPbqYs/IQoVWkpVTDXl
         ANXEZrwPB32For5qL4Btz+ExQfjHhCQijLsBUFhYMNMZyuDC2FeP1g0IbEjFW8dvheoj
         ufjzKc/zud1xycd7FJbnO38xUhVgZzMRqi9+o+TIHbicQkaFISxSLo6Klj7XA0B747ah
         HiWtbzKRqdI1MPNM9oeUnawZFksZz5hkaa56BTdpZub5QMuANFbbhFG8u5fTPbcKyhGF
         RsKY0a1xDQbwVlHVqrGeSZV+8bpnxF0sCg/ivBtxBmyXtxG+NsBjH6ptgS7yZPCE4xl2
         6BQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PdIEInuRnFWAet7Rbg6b7+xHDblel1LCE8hUbr8M2qg=;
        b=TT3DzmLrvIqlBjzEoI8Y0wmvGB4A2c+hmpA4RqUxJesaSHS+utx75TiqKiufYxgRLe
         z4BdzjW/r5vDLHsXwqy40O8pEfSVVRPRncWACj3RxRXoLVXIzvvV2pHYTvbAAW0nd0S6
         S1k3M4cxDr97eGTdjcAVr2OQ93v+XmmDJrzDWVo/tAw7IL9kGNLPg1WF5ZsGBySt6Ry0
         D+8BwVPtzR9aDs+wucJMR1V4FafSOU5nr0AYscL0BCS2ef1KCgJWM+lkYNo82XloNBKs
         9EUlnD+p9vwfhSLh6lv+ZamxBe8erjI7yHFBoUa1tJCFWW78csb18j8v8+do8ygICGNz
         z9qA==
X-Gm-Message-State: ANhLgQ1FeJW4ENonNTRQv6tipouxIFNlpkS1nvlhYWO7R/rhlH2McJuc
        Wge7eLMnEg2ngQUmbN9zWhGN53rzuhaZzt+ZGV64Sg==
X-Google-Smtp-Source: ADFU+vvSOrI+wcQMIAxgFOH2YRs3VGigvhX6xhTp+CMNWvSstvvsi9zNAE/CnZQRpokG/Ydf8rgtUXrnmWytax6sxt4=
X-Received: by 2002:ac2:5c5d:: with SMTP id s29mr2284678lfp.191.1583333532822;
 Wed, 04 Mar 2020 06:52:12 -0800 (PST)
MIME-Version: 1.0
References: <20200303155534.127645-1-alainm@chromium.org> <3F146946-8F93-4541-B2EC-9EAE4262176F@holtmann.org>
In-Reply-To: <3F146946-8F93-4541-B2EC-9EAE4262176F@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 4 Mar 2020 09:52:01 -0500
Message-ID: <CALWDO_Xyw1ggpy4Ant0ZGdkRfZdN5SfmgxERoPiKC0TxFO_t2w@mail.gmail.com>
Subject: Re: [PATCH v3] bluetooth: guard against controllers sending zero'd events
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Marcel.


On Wed, Mar 4, 2020 at 2:28 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> > Some controllers have been observed to send zero'd events under some
> > conditions.  This change guards against this condition as well as adding
> > a trace to facilitate diagnosability of this condition.
> >
> > Signed-off-by: Alain Michaud <alainm@chromium.org>
> > ---
> >
> > net/bluetooth/hci_event.c | 6 ++++++
> > 1 file changed, 6 insertions(+)
>
> patch has been applied to bluetooth-next tree.
>
> Regards
>
> Marcel
>
