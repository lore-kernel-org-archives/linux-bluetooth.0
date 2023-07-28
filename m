Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9402C001DE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 06:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjG1G0l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 02:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjG1G0k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 02:26:40 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23702D76
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 23:26:34 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso1042251a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 23:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690525594; x=1691130394;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FyUHrT5UtqLz9MR+CyOpyRRB4teak/Oe8gENBLYfiyI=;
        b=q0j1ONeTQMBvhciN2V9LHArUBI4GYZ+S5o3SAn2FhjeU+UxYsMwb6tKjAaf1R0ig/0
         kgEj4PjDQ7kHcb99wxJivwUlNuz6hwa3xLYf4izO+DuXBY5JStCTP8bILJ8Urh7l3s5T
         t4HAnSb7ZQNuQWWVYgiUnlNo46pOyYEanjclWNjXVk3OL1d/o8TnD08XqkLPZ9s+WEug
         oIrp7YS7Zy0X2XgIcO+X2lRO9x5eg3zZ3vKZrGo3ztfmh+oQJoZWAYYub4OeYRy/gBeN
         QDzkTWLWjvkh6NiQ5PN3rnQv1cYnas9SX2T1gtxTbB+feS4ZnSOeJkpd+QjLW1KxdwS/
         GEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690525594; x=1691130394;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FyUHrT5UtqLz9MR+CyOpyRRB4teak/Oe8gENBLYfiyI=;
        b=SOw1y5dwHhwhoK7Pj5C6NlLMTvJ53RI5RFotY4ZIHWaB4vTzRBtwDmLhH4Nt2svI66
         osduV54a5fdgCTLA3ZZuBuDrubvrjOBrF4Bh3Uwul8+no7CxLUnLp9/SlU3Op6NhBMly
         RydV2hxrntkXOwv03hTt7F96exABDVAY8D1fLcR4QB15s4wIRcfXwOoJ1qzug4kK9BLh
         2LFxDrd6eqv8kKP55Tu1LxaORyVVLLp4S/OqMBYVkkm6z0jS0NGpYHhCFNLT8P+6RAfv
         bYdSbRgYddxULpsuPkF8fww/dzvjsMioYL64DIlHdAeUQkwLnv4EWKW+tmtXTR569v6s
         tdig==
X-Gm-Message-State: ABy/qLZK5HkCC5tuMxjwy+ou4CnOfblgENdabz+9RtFVR6HMEafT/ric
        M9mhmLZYuaBtLB3b/yeiHrxcj4DDP7Y=
X-Google-Smtp-Source: APBJJlHv5PzkaxKGB2xIat5SRrctWvyvD5Cb3VdUxi0EG0nBDhA9KVMAcIWUi/MGMP8DNoAwQTfHTA==
X-Received: by 2002:a05:6a20:431b:b0:129:b68b:92db with SMTP id h27-20020a056a20431b00b00129b68b92dbmr930132pzk.42.1690525593923;
        Thu, 27 Jul 2023 23:26:33 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.182.145])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm2472170pli.217.2023.07.27.23.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 23:26:33 -0700 (PDT)
Message-ID: <64c35f99.170a0220.12516.4cc3@mx.google.com>
Date:   Thu, 27 Jul 2023 23:26:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1087700640169063093=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] adapter: Fix generating IRK for adapter with privacy enabled
In-Reply-To: <20230728044556.575664-1-simon.mikuda@streamunlimited.com>
References: <20230728044556.575664-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1087700640169063093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NzcwMzkwCgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBGQUlMICAgICAgMC42NyBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIEZB
SUwgICAgICAwLjU0IHNlY29uZHMKQnVpbGRFbGwgICAgICAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDM0Ljk4IHNlY29uZHMKQmx1ZXpNYWtlICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDEwNjEuMzcgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
MTMuOTEgc2Vjb25kcwpNYWtlRGlzdGNoZWNrICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTk4
LjYyIHNlY29uZHMKQ2hlY2tWYWxncmluZCAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDMyMC43
MyBzZWNvbmRzCkNoZWNrU21hdGNoICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICA0MjMuNTcg
c2Vjb25kcwpibHVlem1ha2VleHRlbGwgICAgICAgICAgICAgICBQQVNTICAgICAgMTMyLjI0IHNl
Y29uZHMKSW5jcmVtZW50YWxCdWlsZCAgICAgICAgICAgICAgUEFTUyAgICAgIDg2MC44NiBzZWNv
bmRzClNjYW5CdWlsZCAgICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAxMzY4LjAxIHNlY29u
ZHMKCkRldGFpbHMKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrUGF0
Y2ggLSBGQUlMCkRlc2M6IFJ1biBjaGVja3BhdGNoLnBsIHNjcmlwdApPdXRwdXQ6CltCbHVlWl0g
YWRhcHRlcjogRml4IGdlbmVyYXRpbmcgSVJLIGZvciBhZGFwdGVyIHdpdGggcHJpdmFjeSBlbmFi
bGVkCldBUk5JTkc6U1lNQk9MSUNfUEVSTVM6IFN5bWJvbGljIHBlcm1pc3Npb25zICdTX0lSVVNS
IHwgU19JV1VTUicgYXJlIG5vdCBwcmVmZXJyZWQuIENvbnNpZGVyIHVzaW5nIG9jdGFsIHBlcm1p
c3Npb25zICcwNjAwJy4KIzkxOiBGSUxFOiBzcmMvYWRhcHRlci5jOjQxNTE6CisJY3JlYXRlX2Zp
bGUoZmlsZW5hbWUsIFNfSVJVU1IgfCBTX0lXVVNSKTsKCi9naXRodWIvd29ya3NwYWNlL3NyYy9z
cmMvMTMzMzExODAucGF0Y2ggdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA3IGxpbmVzIGNo
ZWNrZWQKCk5PVEU6IEZvciBzb21lIG9mIHRoZSByZXBvcnRlZCBkZWZlY3RzLCBjaGVja3BhdGNo
IG1heSBiZSBhYmxlIHRvCiAgICAgIG1lY2hhbmljYWxseSBjb252ZXJ0IHRvIHRoZSB0eXBpY2Fs
IHN0eWxlIHVzaW5nIC0tZml4IG9yIC0tZml4LWlucGxhY2UuCgovZ2l0aHViL3dvcmtzcGFjZS9z
cmMvc3JjLzEzMzMxMTgwLnBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4K
Ck5PVEU6IElnbm9yZWQgbWVzc2FnZSB0eXBlczogQ09NTUlUX01FU1NBR0UgQ09NUExFWF9NQUNS
TyBDT05TVF9TVFJVQ1QgRklMRV9QQVRIX0NIQU5HRVMgTUlTU0lOR19TSUdOX09GRiBQUkVGRVJf
UEFDS0VEIFNQRFhfTElDRU5TRV9UQUcgU1BMSVRfU1RSSU5HIFNTQ0FORl9UT19LU1RSVE8KCk5P
VEU6IElmIGFueSBvZiB0aGUgZXJyb3JzIGFyZSBmYWxzZSBwb3NpdGl2ZXMsIHBsZWFzZSByZXBv
cnQKICAgICAgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlIENIRUNLUEFUQ0ggaW4gTUFJTlRB
SU5FUlMuCgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEdpdExpbnQgLSBG
QUlMCkRlc2M6IFJ1biBnaXRsaW50Ck91dHB1dDoKW0JsdWVaXSBhZGFwdGVyOiBGaXggZ2VuZXJh
dGluZyBJUksgZm9yIGFkYXB0ZXIgd2l0aCBwcml2YWN5IGVuYWJsZWQKCldBUk5JTkc6IEkzIC0g
aWdub3JlLWJvZHktbGluZXM6IGdpdGxpbnQgd2lsbCBiZSBzd2l0Y2hpbmcgZnJvbSB1c2luZyBQ
eXRob24gcmVnZXggJ21hdGNoJyAobWF0Y2ggYmVnaW5uaW5nKSB0byAnc2VhcmNoJyAobWF0Y2gg
YW55d2hlcmUpIHNlbWFudGljcy4gUGxlYXNlIHJldmlldyB5b3VyIGlnbm9yZS1ib2R5LWxpbmVz
LnJlZ2V4IG9wdGlvbiBhY2NvcmRpbmdseS4gVG8gcmVtb3ZlIHRoaXMgd2FybmluZywgc2V0IGdl
bmVyYWwucmVnZXgtc3R5bGUtc2VhcmNoPVRydWUuIE1vcmUgZGV0YWlsczogaHR0cHM6Ly9qb3Jp
c3Jvb3ZlcnMuZ2l0aHViLmlvL2dpdGxpbnQvY29uZmlndXJhdGlvbi8jcmVnZXgtc3R5bGUtc2Vh
cmNoCjQ6IEIxIExpbmUgZXhjZWVkcyBtYXggbGVuZ3RoICgyMTU+ODApOiAic3JjL2FkYXB0ZXIu
YzpnZW5lcmF0ZV9hbmRfd3JpdGVfaXJrKCkgVW5hYmxlIHNldCBjb250ZW50cyBmb3IgL3Zhci9s
aWIvYmx1ZXRvb3RoLzAwOjAwOjAwOjAwOjAwOjAwL2lkZW50aXR5OiAoRmFpbGVkIHRvIGNyZWF0
ZSBmaWxlIOKAnC92YXIvbGliL2JsdWV0b290aC8wMDowMDowMDowMDowMDowMC9pZGVudGl0eS5F
S1E1ODHigJ06IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkpIgoKCi0tLQpSZWdhcmRzLApMaW51
eCBCbHVldG9vdGgKCg==

--===============1087700640169063093==--
