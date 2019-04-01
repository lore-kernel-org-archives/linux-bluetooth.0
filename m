Return-Path: <SRS0=YUNQ=SD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C808C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Apr 2019 21:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D721120857
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Apr 2019 21:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C/Hl6nvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfDAVaF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:30:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34712 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfDAVaF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Apr 2019 17:30:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so5216718pfd.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Apr 2019 14:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZQeUjUJ75hyV0LvmNestfM/OIj7Zji+CivzKLWnsuF8=;
        b=C/Hl6nvAwzjOA0sSD7bkz7dVqF3w4QMp/iGTJSfondBNHCUZ1n+NHLkS3zCdnKBZXZ
         l+Bsb5H7Wsh62dtWHTpGMduBIyyl3iJz/BiVaU9U7V8Xmp42/DALGSx3pJSwSo+OWa+l
         HElkydD94EbYM7/dTfWh6dwMXPRK4poQZwt/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZQeUjUJ75hyV0LvmNestfM/OIj7Zji+CivzKLWnsuF8=;
        b=KNNldgifIJS7bXDrVRi0GC6NFDLN6GmIKPVueTakLKIHfiC67YiJcGNwMSZZ4+kDPx
         ht9ycQMg4hkVC3sb/pUUYaoVoUFa3Fu+nvHGWieQ3JYevcrjA7EOScUH/bRyB09pXFa7
         sd7LjgMQI4ZQPaMUMyVpViy2VpL4zfJppsf81jrtahD2HiXOO5/BZlU8ao3JwS38c++9
         qydM3kcgi0J+kLRRtLCXRkTeqVuVyxz6vmI/tURPNj50G2eH5ryhCIDDX9yvxg9wGGA6
         tiyWdBKsBPZuZKAv7DczVdIBw0IWePea9tXt3EBbWo85jailZdGb5yXK8PDKM2ihpcNN
         idkA==
X-Gm-Message-State: APjAAAUGwiN0XFSoMkGZ9S9r/Cq0ejLGJKzcZmhfCL3cCk8pO+C2Qz+S
        PtFE8QkNNyodPyURj+9FCm90iw==
X-Google-Smtp-Source: APXvYqwSIsI0+TnKRFMVnJu7bIsTkPl85NNTHN9greyx7q6+d1Lxxl0hkmLCRwHBsLpxwW9rFeJPbQ==
X-Received: by 2002:a63:6c43:: with SMTP id h64mr60977972pgc.22.1554154204539;
        Mon, 01 Apr 2019 14:30:04 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f1sm15891612pgl.35.2019.04.01.14.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 14:30:03 -0700 (PDT)
Date:   Mon, 1 Apr 2019 14:30:03 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hemantg <hemantg@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>
Subject: Re: [PATCH v2 1/2] Bluetooth: hci_qca: Rename STATE_<flags> to
 QCA_<flags>
Message-ID: <20190401213003.GI112750@google.com>
References: <20190312204217.73296-1-mka@chromium.org>
 <CAG5bF+RLTaYbrn8uSpoU+W=PBmNawR6Ov0EOEcfuSymzuini5w@mail.gmail.com>
 <96ea2aaad3d9ff631a621498a6c12a35@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <96ea2aaad3d9ff631a621498a6c12a35@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Apr 01, 2019 at 01:16:07PM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> On 2019-03-13 02:12, Matthias Kaehlcke wrote:
> > Rename STATE_IN_BAND_SLEEP_ENABLED to QCA_IN_BAND_SLEEP_ENABLED.
> > The constant represents a flag (multiple flags can be set at once),
> > not a unique state of the controller or driver.
> > 
> > Also make the flag an enum value instead of a pre-processor constant
> > (more flags will be added to the enum group by another patch).
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v2:
> > - don't use BIT()
> > - change to enum type
> > - updated commit message
> > ---
> >  drivers/bluetooth/hci_qca.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index 237aea34b69f..1b7ba9e9e08a 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -54,9 +54,6 @@
> >  #define HCI_IBS_WAKE_ACK	0xFC
> >  #define HCI_MAX_IBS_SIZE	10
> > 
> > -/* Controller states */
> > -#define STATE_IN_BAND_SLEEP_ENABLED	1
> > -
> >  #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
> >  #define IBS_TX_IDLE_TIMEOUT_MS		2000
> >  #define CMD_TRANS_TIMEOUT_MS		100
> > @@ -67,6 +64,10 @@
> >  /* Controller debug log header */
> >  #define QCA_DEBUG_HANDLE	0x2EDC
> > 
> > +enum qca_flags {
> > +	QCA_IN_BAND_SLEEP_ENABLED,
> > +};
> > +
> 
> [Bala]: I would recommend to go with QCA_IBS_ENABLED as IBS is abbreviated
> as In band sleep.

Sounds good, thanks for the suggestion!
