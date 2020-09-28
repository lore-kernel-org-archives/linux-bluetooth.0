Return-Path: <SRS0=BM5K=DF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB63C2D0A8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 08:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 973E621531
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 08:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQ2HCUC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgI1IeB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Sep 2020 04:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgI1IeB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Sep 2020 04:34:01 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21EAC0613CE
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 01:34:01 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f142so209739qke.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 01:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=zkt6WTVLHIwho2gQLFzvcaoXYSQJ+xyIXwtupE8E1+4=;
        b=cQ2HCUC4cKNgInvjOghkcyUulyis0m+y4uIlhiEH5M/9zj/LmVE6wleDG1mtpr+SjJ
         X16zFAaQlRqmXOmf2VAnULw11YioWQbsBNDQFtoOu55wMFOGbhb044sX3VNTQYW92KCi
         ngBt7yaZkh3QT92Xd8nbB0FXqIhUwsueRUq49CmPIRqiwymwS4tjVlJFMKeMx+bnbSAj
         8hQ3r+qVws0xSZWB42e6evTmQFQPPUm29OVo2lMZdqvlIY5vQVb8Ea+AmAmWw8njwul0
         j/0PZ37PoSgdZAtGAWzpYCCZKucl4gtdWUMpauLuGA8J5mmyrzIkbN29z0OOtDDGn/sR
         lTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=zkt6WTVLHIwho2gQLFzvcaoXYSQJ+xyIXwtupE8E1+4=;
        b=N1HFMr8990vESgMKoWqDJUsZjHGswO9zKnLsz3KbKlZy05YdrLD8Lo6AwkqN4vD8+3
         USbrgfY8QSGknzyc98HfbTp8eAnLHu3C5cXx3+FaPjqYJy0YvaRIu5sYmJ6qNcpvc65H
         hsnz6pM4ChkbWPEL2GTH5mNfeC37oT0WBjJXyGSu/M2GpQ4232oxQIIZl1MmXpuCwWD7
         oa65sMduKUlD85X8gLdBz6L9WhuM01u4/zwO0rqAE+K/Lwqo9DBFFh8Y2SIYidJM86Jk
         M1HimzKi27U2Aeigw/2reKsWlqi4DnoignGOrQ9xFNr3yXPafYx/lrar2YludF3OF683
         smIA==
X-Gm-Message-State: AOAM533er2oCMUw+F/Tq1TUhJ/RkmFwmxa3TljqA1BHKXhnzAgKAzUo2
        prvpBbI4QWczHpBMw51tTn34CU5xwpyr5w==
X-Google-Smtp-Source: ABdhPJzOFOfw/y2S8soJ62HMGtmKsbzeawsWyC7KGwsGAuAjLqFzsWPe/ZVtVODGTu9cOsvn8wEGEA==
X-Received: by 2002:a37:a113:: with SMTP id k19mr360075qke.306.1601282040581;
        Mon, 28 Sep 2020 01:34:00 -0700 (PDT)
Received: from [172.17.0.2] ([13.68.25.221])
        by smtp.gmail.com with ESMTPSA id s47sm475475qtb.13.2020.09.28.01.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 01:34:00 -0700 (PDT)
Message-ID: <5f719ff8.1c69fb81.5e17d.13ab@mx.google.com>
Date:   Mon, 28 Sep 2020 01:34:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0089905677918741531=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [BlueZ,v4,1/3] core: Add params to set interleaving durations
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200928154344.BlueZ.v4.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
References: <20200928154344.BlueZ.v4.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0089905677918741531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9MzU2MzczCgotLS1U
ZXN0IHJlc3VsdC0tLQoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
UGF0Y2ggLSBGQUlMCk91dHB1dDoKZG9jOiBBZGQgZGVmaW5pdGlvbiBvZiBhZHZtb24gcmVsYXRl
ZCBwYXJhbWV0ZXJzCldBUk5JTkc6VFlQT19TUEVMTElORzogJ2FkdmVydGlzbWVudCcgbWF5IGJl
IG1pc3NwZWxsZWQgLSBwZXJoYXBzICdhZHZlcnRpc2VtZW50Jz8KIzY6IApUaGlzIGFkZHMgZGVm
aW5pdGlvbiBvZiB0aGUgbmV3bHkgYWRkZWQgcGFyYW1ldGVycyBmb3IgYWR2ZXJ0aXNtZW50Cgot
IHRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgOSBsaW5lcyBjaGVja2VkCgpOT1RFOiBGb3Ig
c29tZSBvZiB0aGUgcmVwb3J0ZWQgZGVmZWN0cywgY2hlY2twYXRjaCBtYXkgYmUgYWJsZSB0bwog
ICAgICBtZWNoYW5pY2FsbHkgY29udmVydCB0byB0aGUgdHlwaWNhbCBzdHlsZSB1c2luZyAtLWZp
eCBvciAtLWZpeC1pbnBsYWNlLgoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuCgpOT1RFOiBJZ25vcmVkIG1lc3NhZ2UgdHlwZXM6IENPTU1JVF9NRVNTQUdFIENP
TVBMRVhfTUFDUk8gQ09OU1RfU1RSVUNUIEZJTEVfUEFUSF9DSEFOR0VTIE1JU1NJTkdfU0lHTl9P
RkYgUFJFRkVSX1BBQ0tFRCBTUExJVF9TVFJJTkcgU1NDQU5GX1RPX0tTVFJUTwoKTk9URTogSWYg
YW55IG9mIHRoZSBlcnJvcnMgYXJlIGZhbHNlIHBvc2l0aXZlcywgcGxlYXNlIHJlcG9ydAogICAg
ICB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUgQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
CgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tHaXRMaW50IC0gUEFT
UwoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrQnVpbGQgLSBGQUlM
Ck91dHB1dDoKYXI6IGB1JyBtb2RpZmllciBpZ25vcmVkIHNpbmNlIGBEJyBpcyB0aGUgZGVmYXVs
dCAoc2VlIGBVJykKYXI6IGB1JyBtb2RpZmllciBpZ25vcmVkIHNpbmNlIGBEJyBpcyB0aGUgZGVm
YXVsdCAoc2VlIGBVJykKYXI6IGB1JyBtb2RpZmllciBpZ25vcmVkIHNpbmNlIGBEJyBpcyB0aGUg
ZGVmYXVsdCAoc2VlIGBVJykKYXI6IGB1JyBtb2RpZmllciBpZ25vcmVkIHNpbmNlIGBEJyBpcyB0
aGUgZGVmYXVsdCAoc2VlIGBVJykKYXI6IGB1JyBtb2RpZmllciBpZ25vcmVkIHNpbmNlIGBEJyBp
cyB0aGUgZGVmYXVsdCAoc2VlIGBVJykKc3JjL21haW4uYzogSW4gZnVuY3Rpb24g4oCYcGFyc2Vf
Y29udHJvbGxlcl9jb25maWfigJk6CnNyYy9tYWluLmM6NDM2OjU6IGVycm9yOiBpbml0aWFsaXph
dGlvbiBvZiDigJh1aW50MTZfdCAq4oCZIHtha2Eg4oCYc2hvcnQgdW5zaWduZWQgaW50ICrigJl9
IGZyb20gaW5jb21wYXRpYmxlIHBvaW50ZXIgdHlwZSDigJh1aW50OF90ICrigJkge2FrYSDigJh1
bnNpZ25lZCBjaGFyICrigJl9IFstV2Vycm9yPWluY29tcGF0aWJsZS1wb2ludGVyLXR5cGVzXQog
IDQzNiB8ICAgICAmbWFpbl9vcHRzLmRlZmF1bHRfcGFyYW1zLmVuYWJsZV9hZHZtb25faW50ZXJs
ZWF2ZV9zY2FuLAogICAgICB8ICAgICBeCnNyYy9tYWluLmM6NDM2OjU6IG5vdGU6IChuZWFyIGlu
aXRpYWxpemF0aW9uIGZvciDigJhwYXJhbXNbMzBdLnZhbOKAmSkKY2MxOiBhbGwgd2FybmluZ3Mg
YmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo4OTQ4OiBzcmMv
Ymx1ZXRvb3RoZC1tYWluLm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0MDQ0OiBhbGxd
IEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZUNoZWNr
IC0gU0tJUFBFRApPdXRwdXQ6CmNoZWNrYnVpbGQgbm90IHN1Y2Nlc3MKCgoKLS0tClJlZ2FyZHMs
CkxpbnV4IEJsdWV0b290aAoK

--===============0089905677918741531==--
