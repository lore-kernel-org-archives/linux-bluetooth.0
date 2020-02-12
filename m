Return-Path: <SRS0=IUpk=4A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2AFC352A4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Feb 2020 21:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845DB20848
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Feb 2020 21:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khVlyjgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgBLV6K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:58:10 -0500
Received: from mail-vs1-f49.google.com ([209.85.217.49]:46977 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbgBLV6K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Feb 2020 16:58:10 -0500
Received: by mail-vs1-f49.google.com with SMTP id t12so2235653vso.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2020 13:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=J0hK2t4cfvLN5Y7lwfLiuNgEpYGtJB+yyy7jKlB2QJQ=;
        b=khVlyjglZpaIsQJh5apfOHjrm/qsFnXsCMDSjvNzgDGRtuwO6TlczwdHW5dY0dddLB
         iLxSjQXX6BuNsSlGys9jTb0a8l3+Nb44zYQRe9wrFYR0LnVUODXRiE5M2OVf/kozwBuz
         9idQTOaYlhBHyHb8MMgGUeqZnpeWyq9A6sxFCcf7X/I4OH68ZuseDtD3S/Tu19nx+qen
         s7ck9nNsykyWR4ly08hlihhHW893uRp4BkmheP1fh5li/gesm3TwzWc2Wz6/UjCnhEeU
         w881fsYGKvNZujN0hoSiDGkvu30eRA/GzRuMGdWyJwTGcfPnMn1ZI/xc4qLiEnmvSAei
         +GXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=J0hK2t4cfvLN5Y7lwfLiuNgEpYGtJB+yyy7jKlB2QJQ=;
        b=KNorWbz2SX5XC2aXmyzvW8wB2pYqS5rtpSF6i9qrwEHdPUUYGiU2mZKf9ULxzvo/jc
         FtNqXyHXw7AxUHEV0z9CznYaK0RcpPYSbxfmJrwtp8zwdzYE5M3Rsyn4cPHetSfabBZm
         zfcaag3AYKR6AcAUr64aRFokCNXbPfawdbs2PXASL2Kte5s/fekCXTPspRXMp8hIGWtB
         D3xhCNpHEQIowDVg+lEY71PP3Aqbxgz96FtXCiXdtXqEIZPQ6OPoEQNim72q967AHI4a
         TolqHgGTnw1IwLjyuOVeOvy5NV2TMuHt2uDNOtrvvOI5g8eZQLrVDv61oMoJb1xryZ2P
         ZX3A==
X-Gm-Message-State: APjAAAU7vPbTo4VsxxYBGEIc+t/hDMYPGyGpZiOQuENWYUh1RGBbv9lX
        FcbONB/gJzqt5i7godwtm0ARyp+m9QwSS88vRum+bWEs
X-Google-Smtp-Source: APXvYqz6kaVEJuoFEO/rrqsuWK2uuhyY2UhV5/2/HJT5NLOTmmqFQQlawwerc6dkdGig/PQ5rWWQANV1phghZpjacH0=
X-Received: by 2002:a67:f541:: with SMTP id z1mr442008vsn.70.1581544687539;
 Wed, 12 Feb 2020 13:58:07 -0800 (PST)
MIME-Version: 1.0
References: <CAP6wrbWGcAh2yjwWQZvjjVReH3gMFLK9yPbp20QvqBDAdZSBgw@mail.gmail.com>
 <CAMCGoNwT=FjtN+N+koed2=buvdDUF1-Uk7BywdrUtbzLdP=8NA@mail.gmail.com>
In-Reply-To: <CAMCGoNwT=FjtN+N+koed2=buvdDUF1-Uk7BywdrUtbzLdP=8NA@mail.gmail.com>
From:   Marcin Kozlowski <marcinguy@gmail.com>
Date:   Wed, 12 Feb 2020 22:57:56 +0100
Message-ID: <CAP6wrbUTij0K=LBmdbYw-DfV8G19CvONvOJ-C_eEOzpZ8kE8xQ@mail.gmail.com>
Subject: Re: GAP ACL L2CAP Data Packets fragmentation over HCI in Android Bluetooth
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

OK, I think I got it the condition

Below is Mobile (Android) Bluetooth subsystem log:


02-12 22:33:26.928  2416  2461 W bt_hci_packet_fragmenter:
reassemble_and_dispatch reassemble_and_dispatch
02-12 22:33:26.928  2416  2461 W bt_hci_packet_fragmenter:
reassemble_and_dispatch partial_packet->offset 21 packet->len 683
HCI_ACL_PREAMBLE_SIZE 4
02-12 22:33:26.928  2416  2461 W bt_hci_packet_fragmenter:
reassemble_and_dispatch projected_offset 700 partial_packet->len 209
02-12 22:33:26.928  2416  2461 W bt_hci_packet_fragmenter:
reassemble_and_dispatch got packet which would exceed expected length
of 209. Truncating.
02-12 22:33:26.928  2416  2461 W bt_hci_packet_fragmenter:
reassemble_and_dispatch memcpy packet->len 188 packet->offset 4 expr
184
02-12 22:33:26.929  2416  2460 W bt_hci_packet_fragmenter:
fragment_and_dispatch fragment_and_dispatch

Still working on crashing the process, maybe this is due to memory
allocator (possibly jemalloc)

Thanks,
Marcin


On Wed, Feb 12, 2020 at 12:20 PM Matias Karhumaa
<matias.karhumaa@gmail.com> wrote:
>
> Hi Marcin,
>
> Most obvious question first: are you testing against device that does not have the fix for this vulnerability yet?
>
> There are still huge amount of devices out there without access to the fix. This is why full technical report has not been published yet.
>
> Best regards,
> Matias Karhumaa
>
> ke 12. helmik. 2020 klo 12.38 Marcin Kozlowski <marcinguy@gmail.com> kirjoitti:
>>
>> Hi list,
>>
>> Hope is ok to ask here. Can somebody give some insight when this can
>> happen: https://android.googlesource.com/platform/system/bt/+/3cb7149d8fed2d7d77ceaa95bf845224c4db3baf/hci/src/packet_fragmenter.cc#220
>>
>> Tried sending fragmented GAP ACL L2CAP packets via HCI, but I cannot
>> imagine how this condition (in packet_fragmenter.cc#220) can be met:
>>
>> https://stackoverflow.com/questions/60116790/sending-gap-acl-l2cap-data-packets
>>
>> Anybody knows? Can shed some more light on this?
>>
>> Thanks,
