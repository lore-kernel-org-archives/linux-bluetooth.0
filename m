Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA23C433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 05:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DFDA20738
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 05:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVD2vjMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgHRFvC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 01:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgHRFu6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 01:50:58 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD68C061389
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 22:50:57 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id b2so8994351qvp.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 22:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=s/ew5157WXW/O2ljhcPBm7BPYHN8LWGFuoDx/C2Hqwk=;
        b=WVD2vjMBc9zoPmGPdyjP6ks+cQ1vijCKWhMsvmsqhALgsuybIWusb5TBaSr4Gv0yfh
         Hn/Z0RWyJWU4V2crvDePIwSaQC8Vkt3CwtzvC10DdBfCHxvjKx+zGGLXTEjQV5RBRm+Y
         KoOjeKb/OaOa0NULjIT9SheLsQhbVt/cfYFTqq8xDPJ/gqxjMvcTP+JvH+STHhvVQQX7
         2PJg3zBaRKThBQF9THrSgf69iGuzKnepd4/6veonPDnfmZ+SoykM8ShfnR28tZiPM0tD
         BCGNa/n7nBX6lwU84W7Fb6XJaMLhP3uFJdShh6bmyM5Ae+f/ASItWBfy/nAQr5KZ+PHa
         i+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=s/ew5157WXW/O2ljhcPBm7BPYHN8LWGFuoDx/C2Hqwk=;
        b=tfKwvqY3sAtvDljC1LH1rxaPmxiQOye6FWGl1qbwV4KZH1S/nHNflcbyCWlb2jYb6/
         iCk9unh5prN/54QWU2uswIA2mWUZvOUFc0Z27qBtKoI/W3OQQFBAugqa4gDDzOUlPtSd
         aSwCj9wxfPa5k4lFSW7Fzye04cdYnKy3L2t2MqDpHw3QZIxYlmgLw0t3Gpc8O9NNUonc
         yl828XUGGtsLX5qVoBEl+3OHoz7CNlBv7AJEvnyJuwF1TR9O0TSyysiLG2JUvF2XmAZ4
         pGZNWNQalbsi6wxjeM5viUALT9dDkeLaZBcThKP4mnsoX4ctME1uTGbrgpCnOZa6iV4v
         jkYg==
X-Gm-Message-State: AOAM532yGXMfQ7LdGTHdHAg0/HaHXOzqG6E3CkHD2UTbxLNiDklAXU6f
        wvaZA9zIOoyrXCEPiUOMbpUXfv0CJNRE9w==
X-Google-Smtp-Source: ABdhPJwZYmC3aLLlLnpE1uWQUmfWP20wRc90uUiD3q/kpeNLYiB7/AHdb4dZFeaRwIhxGVihFs5I4A==
X-Received: by 2002:a0c:f6cb:: with SMTP id d11mr17977608qvo.84.1597729856777;
        Mon, 17 Aug 2020 22:50:56 -0700 (PDT)
Received: from [172.17.0.2] ([40.123.37.4])
        by smtp.gmail.com with ESMTPSA id y7sm22448111qta.36.2020.08.17.22.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 22:50:56 -0700 (PDT)
Message-ID: <5f3b6c40.1c69fb81.6b14.bd16@mx.google.com>
Date:   Mon, 17 Aug 2020 22:50:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3896547742367780485=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v2] shared/ad: move MAX_ADV_DATA_LEN macro to the header
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200817222717.BlueZ.v2.1.I716fc87b0c97e5349a04766a61ecad1f5b0fd28e@changeid>
References: <20200817222717.BlueZ.v2.1.I716fc87b0c97e5349a04766a61ecad1f5b0fd28e@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3896547742367780485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

ClRoaXMgaXMgYXV0b21hdGVkIGVtYWlsIGFuZCBwbGVhc2UgZG8gbm90IHJlcGx5IHRvIHRoaXMg
ZW1haWwhCgpEZWFyIHN1Ym1pdHRlciwKClRoYW5rIHlvdSBmb3Igc3VibWl0dGluZyB0aGUgcGF0
Y2hlcyB0byB0aGUgbGludXggYmx1ZXRvb3RoIG1haWxpbmcgbGlzdC4KV2hpbGUgd2UgYXJlIHBy
ZXBhcmluZyBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaGVzLCB3ZSBmb3VuZCB0aGUgZm9sbG93aW5n
Cmlzc3VlL3dhcm5pbmcuCgpUZXN0IFJlc3VsdDoKY2hlY2tidWlsZCBGYWlsZWQKCk91dHB1dHM6
CmFyOiBgdScgbW9kaWZpZXIgaWdub3JlZCBzaW5jZSBgRCcgaXMgdGhlIGRlZmF1bHQgKHNlZSBg
VScpCnNyYy9zaGFyZWQvYWQuYzogSW4gZnVuY3Rpb24g4oCYbmFtZV9sZW5ndGjigJk6CnNyYy9z
aGFyZWQvYWQuYzoyNTg6MTI6IGVycm9yOiDigJhNQVhfQURWX0RBVEFfTEVO4oCZIHVuZGVjbGFy
ZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQogIDI1OCB8ICBpZiAobGVuID4gTUFYX0FE
Vl9EQVRBX0xFTiAtICpwb3MpCiAgICAgIHwgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+CnNy
Yy9zaGFyZWQvYWQuYzoyNTg6MTI6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlz
IHJlcG9ydGVkIG9ubHkgb25jZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCnNyYy9z
aGFyZWQvYWQuYzogSW4gZnVuY3Rpb24g4oCYc2VyaWFsaXplX25hbWXigJk6CnNyYy9zaGFyZWQv
YWQuYzo0Mjc6MTI6IGVycm9yOiDigJhNQVhfQURWX0RBVEFfTEVO4oCZIHVuZGVjbGFyZWQgKGZp
cnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQogIDQyNyB8ICBpZiAobGVuID4gTUFYX0FEVl9EQVRB
X0xFTiAtICgqcG9zICsgMikpIHsKICAgICAgfCAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn4K
c3JjL3NoYXJlZC9hZC5jOiBJbiBmdW5jdGlvbiDigJhidF9hZF9nZW5lcmF0ZeKAmToKc3JjL3No
YXJlZC9hZC5jOjQ3OToxNjogZXJyb3I6IOKAmE1BWF9BRFZfREFUQV9MRU7igJkgdW5kZWNsYXJl
ZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCiAgNDc5IHwgIGlmICgqbGVuZ3RoID4gTUFY
X0FEVl9EQVRBX0xFTikKICAgICAgfCAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+CnNy
Yy9zaGFyZWQvYWQuYzogSW4gZnVuY3Rpb24g4oCYYnRfYWRfYWRkX21hbnVmYWN0dXJlcl9kYXRh
4oCZOgpzcmMvc2hhcmVkL2FkLmM6NTg3OjEzOiBlcnJvcjog4oCYTUFYX0FEVl9EQVRBX0xFTuKA
mSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikKICA1ODcgfCAgaWYgKGxl
biA+IChNQVhfQURWX0RBVEFfTEVOIC0gMiAtIHNpemVvZih1aW50MTZfdCkpKQogICAgICB8ICAg
ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn4Kc3JjL3NoYXJlZC9hZC5jOiBJbiBmdW5jdGlvbiDi
gJhidF9hZF9hZGRfc2VydmljZV9kYXRh4oCZOgpzcmMvc2hhcmVkL2FkLmM6NzI0OjEzOiBlcnJv
cjog4oCYTUFYX0FEVl9EQVRBX0xFTuKAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBm
dW5jdGlvbikKICA3MjQgfCAgaWYgKGxlbiA+IChNQVhfQURWX0RBVEFfTEVOIC0gMiAtIChzaXpl
X3QpYnRfdXVpZF9sZW4odXVpZCkpKQogICAgICB8ICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+
fn4Kc3JjL3NoYXJlZC9hZC5jOiBJbiBmdW5jdGlvbiDigJhidF9hZF9hZGRfZGF0YeKAmToKc3Jj
L3NoYXJlZC9hZC5jOjk0MzoxMzogZXJyb3I6IOKAmE1BWF9BRFZfREFUQV9MRU7igJkgdW5kZWNs
YXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCiAgOTQzIHwgIGlmIChsZW4gPiAoTUFY
X0FEVl9EQVRBX0xFTiAtIDIpKQogICAgICB8ICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn4K
bWFrZVsxXTogKioqIFtNYWtlZmlsZTo2ODA3OiBzcmMvc2hhcmVkL2FkLmxvXSBFcnJvciAxCm1h
a2U6ICoqKiBbTWFrZWZpbGU6NDAxMDogYWxsXSBFcnJvciAyCgoKCi0tLQpSZWdhcmRzLApMaW51
eCBCbHVldG9vdGgK

--===============3896547742367780485==--
