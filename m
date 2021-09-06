Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9FCC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 03:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB8360F45
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 03:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238545AbhIFD4i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Sep 2021 23:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhIFD4h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Sep 2021 23:56:37 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4DCC061575
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Sep 2021 20:55:33 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g184so5421793pgc.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Sep 2021 20:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=h/UXB2MzVBUeynE343CK7mc29ojsn3gGUsvfUYS8VmE=;
        b=ksJXAxpZoUQirJEprt0K9A+Y5dEDZ8I3MYRIxFkKm0Af7LKukJjjkof1TGCyR09OL7
         JRLM8JjdZIt02nURkfvA9gRDorXqmFa8BJuEMHFEytucTvAsbglGoKcMRIS9stt2Hlei
         UPNmpDd9mxDeOtfiVh0f7UOS/u12BbUX0FqGtz6rVaUYa0fiuA2Ui+SLR0SuFEMxLXJ7
         VnfLfHhv0UODgklbqkciEJ8cMhX+6iGZ9mUg0KgWDK5epYdsYRzAxsK1ALoqXgIwheAS
         hKFPKnEkJFY3TLBAYKEPXkrUO/knoFPbCTt6tLSqGh1oiR+6TqrmFmoBofke1+ISJeqs
         4ZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=h/UXB2MzVBUeynE343CK7mc29ojsn3gGUsvfUYS8VmE=;
        b=I4KGqb7iK9dvuqzkQ+GuXXkX0Qhto+VcndMJB9/3+dy0bfWk+L4K6qqqe/1ILYc3S4
         lSXPmfGYnILmavhgoMZhJpevgUjLQdWYcsKVdANnSV9HDrrTlIHM+JSVCld4umRJpM+U
         HRYtD9ktQDNoMBvqpTzKmHbVirwRBaIVFQKUdNVBt/OAkhffQr107TKhdgCtNqYe6vqY
         uwuvNcukul12XQyoeRUXwF0KBBKqt6Yt5oHcOT2bG1n4AuEc35f4vWnotQE76p/27T4R
         BIFGWceQhSKlIWvyaVlyAsPjeGMXv8SggOa9p7MCKoTJQngaqKc4likHCpLdz4GNeNX2
         jpJQ==
X-Gm-Message-State: AOAM530mFJzEJG1JZaUYIC/KQqw5W0KSct2AYCSLcAnbCBhmFoY5Zxop
        O5FYPL8DmCHJzOg2vhMVHFs3tcD4FVc=
X-Google-Smtp-Source: ABdhPJzSaJ1yvt9KAirE8qtks8TJ6mZ9LvePhdA7f73gifxdBoxhCkN/NQlxEizChL7fKVBvQ0c55w==
X-Received: by 2002:a63:7517:: with SMTP id q23mr10250149pgc.15.1630900533046;
        Sun, 05 Sep 2021 20:55:33 -0700 (PDT)
Received: from [172.17.0.2] ([52.148.189.246])
        by smtp.gmail.com with ESMTPSA id 143sm5731781pfx.1.2021.09.05.20.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 20:55:32 -0700 (PDT)
Message-ID: <61359134.1c69fb81.bce23.147f@mx.google.com>
Date:   Sun, 05 Sep 2021 20:55:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8264031909967464011=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v1,1/2] plugins/admin: add adapter_remove handler
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210906113953.Bluez.v1.1.Id597e5ae87e680e6a744a8ed08d5000aacfce867@changeid>
References: <20210906113953.Bluez.v1.1.Id597e5ae87e680e6a744a8ed08d5000aacfce867@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8264031909967464011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NTQyMzA1CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC42MCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjIyIHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDQzLjc1IHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuMTMgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgNy43
NSBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAxNDMuNjgg
c2Vjb25kcwpNYWtlIENoZWNrICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAgMC40NCBzZWNv
bmRzCk1ha2UgRGlzdGNoZWNrICAgICAgICAgICAgICAgIFBBU1MgICAgICAyMjcuMTIgc2Vjb25k
cwpCdWlsZCB3L2V4dCBFTEwgLSBDb25maWd1cmUgICBQQVNTICAgICAgNy42MiBzZWNvbmRzCkJ1
aWxkIHcvZXh0IEVMTCAtIE1ha2UgICAgICAgIEZBSUwgICAgICAxMzIuMTAgc2Vjb25kcwoKRGV0
YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tQYXRjaCAtIFBB
U1MKRGVzYzogUnVuIGNoZWNrcGF0Y2gucGwgc2NyaXB0IHdpdGggcnVsZSBpbiAuY2hlY2twYXRj
aC5jb25mCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogR2l0TGludCAtIFBB
U1MKRGVzYzogUnVuIGdpdGxpbnQgd2l0aCBydWxlIGluIC5naXRsaW50CgojIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogUHJlcCAtIFNldHVwIEVMTCAtIFBBU1MKRGVzYzogQ2xv
bmUsIGJ1aWxkLCBhbmQgaW5zdGFsbCBFTEwKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IwpUZXN0OiBCdWlsZCAtIFByZXAgLSBQQVNTCkRlc2M6IFByZXBhcmUgZW52aXJvbm1lbnQgZm9y
IGJ1aWxkCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgLSBDb25m
aWd1cmUgLSBQQVNTCkRlc2M6IENvbmZpZ3VyZSB0aGUgQmx1ZVogc291cmNlIHRyZWUKCiMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZCAtIE1ha2UgLSBGQUlMCkRlc2M6
IEJ1aWxkIHRoZSBCbHVlWiBzb3VyY2UgdHJlZQpPdXRwdXQ6CnBsdWdpbnMvYWRtaW4uYzogSW4g
ZnVuY3Rpb24g4oCYYWRtaW5fcG9saWN5X2Rlc3Ryb3nigJk6CnBsdWdpbnMvYWRtaW4uYzo5MDox
NTogZXJyb3I6IGluaXRpYWxpemF0aW9uIGRpc2NhcmRzIOKAmGNvbnN04oCZIHF1YWxpZmllciBm
cm9tIHBvaW50ZXIgdGFyZ2V0IHR5cGUgWy1XZXJyb3I9ZGlzY2FyZGVkLXF1YWxpZmllcnNdCiAg
IDkwIHwgIGNoYXIgKnBhdGggPSBhZGFwdGVyX2dldF9wYXRoKGFkbWluX3BvbGljeS0+YWRhcHRl
cik7CiAgICAgIHwgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+CnBsdWdpbnMvYWRtaW4u
Yzo5Nzo3OiBlcnJvcjog4oCYTU9DS19BRE1JTl9QT0xJQ1lfSU5URVJGQUNF4oCZIHVuZGVjbGFy
ZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKTsgZGlkIHlvdSBtZWFuIOKAmEFETUlOX1BP
TElDWV9TRVRfSU5URVJGQUNF4oCZPwogICA5NyB8ICAgICAgIE1PQ0tfQURNSU5fUE9MSUNZX0lO
VEVSRkFDRSk7CiAgICAgIHwgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CiAgICAg
IHwgICAgICAgQURNSU5fUE9MSUNZX1NFVF9JTlRFUkZBQ0UKcGx1Z2lucy9hZG1pbi5jOjk3Ojc6
IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkgb25jZSBm
b3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCnBsdWdpbnMvYWRtaW4uYzogQXQgdG9wIGxl
dmVsOgpwbHVnaW5zL2FkbWluLmM6NjAzOjEyOiBlcnJvcjogaW5pdGlhbGl6YXRpb24gb2Yg4oCY
dm9pZCAoKikoc3RydWN0IGJ0ZF9hZGFwdGVyICop4oCZIGZyb20gaW5jb21wYXRpYmxlIHBvaW50
ZXIgdHlwZSDigJh2b2lkICgqKSh2b2lkKeKAmSBbLVdlcnJvcj1pbmNvbXBhdGlibGUtcG9pbnRl
ci10eXBlc10KICA2MDMgfCAgLnJlbW92ZSA9IGFkbWluX3BvbGljeV9yZW1vdmUsCiAgICAgIHwg
ICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+CnBsdWdpbnMvYWRtaW4uYzo2MDM6MTI6IG5v
dGU6IChuZWFyIGluaXRpYWxpemF0aW9uIGZvciDigJhhZG1pbl9wb2xpY3lfZHJpdmVyLnJlbW92
ZeKAmSkKY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTog
KioqIFtNYWtlZmlsZTo4NDU2OiBwbHVnaW5zL2JsdWV0b290aGQtYWRtaW4ub10gRXJyb3IgMQpt
YWtlOiAqKiogW01ha2VmaWxlOjQxNTE6IGFsbF0gRXJyb3IgMgoKCiMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlIENoZWNrIC0gRkFJTApEZXNjOiBSdW4gJ21ha2UgY2hl
Y2snCk91dHB1dDoKcGx1Z2lucy9hZG1pbi5jOiBJbiBmdW5jdGlvbiDigJhhZG1pbl9wb2xpY3lf
ZGVzdHJveeKAmToKcGx1Z2lucy9hZG1pbi5jOjkwOjE1OiBlcnJvcjogaW5pdGlhbGl6YXRpb24g
ZGlzY2FyZHMg4oCYY29uc3TigJkgcXVhbGlmaWVyIGZyb20gcG9pbnRlciB0YXJnZXQgdHlwZSBb
LVdlcnJvcj1kaXNjYXJkZWQtcXVhbGlmaWVyc10KICAgOTAgfCAgY2hhciAqcGF0aCA9IGFkYXB0
ZXJfZ2V0X3BhdGgoYWRtaW5fcG9saWN5LT5hZGFwdGVyKTsKICAgICAgfCAgICAgICAgICAgICAg
IF5+fn5+fn5+fn5+fn5+fn4KcGx1Z2lucy9hZG1pbi5jOjk3Ojc6IGVycm9yOiDigJhNT0NLX0FE
TUlOX1BPTElDWV9JTlRFUkZBQ0XigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVu
Y3Rpb24pOyBkaWQgeW91IG1lYW4g4oCYQURNSU5fUE9MSUNZX1NFVF9JTlRFUkZBQ0XigJk/CiAg
IDk3IHwgICAgICAgTU9DS19BRE1JTl9QT0xJQ1lfSU5URVJGQUNFKTsKICAgICAgfCAgICAgICBe
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KICAgICAgfCAgICAgICBBRE1JTl9QT0xJQ1lfU0VU
X0lOVEVSRkFDRQpwbHVnaW5zL2FkbWluLmM6OTc6Nzogbm90ZTogZWFjaCB1bmRlY2xhcmVkIGlk
ZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBvbmNlIGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVh
cnMgaW4KcGx1Z2lucy9hZG1pbi5jOiBBdCB0b3AgbGV2ZWw6CnBsdWdpbnMvYWRtaW4uYzo2MDM6
MTI6IGVycm9yOiBpbml0aWFsaXphdGlvbiBvZiDigJh2b2lkICgqKShzdHJ1Y3QgYnRkX2FkYXB0
ZXIgKinigJkgZnJvbSBpbmNvbXBhdGlibGUgcG9pbnRlciB0eXBlIOKAmHZvaWQgKCopKHZvaWQp
4oCZIFstV2Vycm9yPWluY29tcGF0aWJsZS1wb2ludGVyLXR5cGVzXQogIDYwMyB8ICAucmVtb3Zl
ID0gYWRtaW5fcG9saWN5X3JlbW92ZSwKICAgICAgfCAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+
fn5+fn4KcGx1Z2lucy9hZG1pbi5jOjYwMzoxMjogbm90ZTogKG5lYXIgaW5pdGlhbGl6YXRpb24g
Zm9yIOKAmGFkbWluX3BvbGljeV9kcml2ZXIucmVtb3Zl4oCZKQpjYzE6IGFsbCB3YXJuaW5ncyBi
ZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjg0NTY6IHBsdWdp
bnMvYmx1ZXRvb3RoZC1hZG1pbi5vXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTA0NDM6
IGNoZWNrXSBFcnJvciAyCgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1h
a2UgRGlzdGNoZWNrIC0gUEFTUwpEZXNjOiBSdW4gZGlzdGNoZWNrIHRvIGNoZWNrIHRoZSBkaXN0
cmlidXRpb24KCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZCB3L2V4
dCBFTEwgLSBDb25maWd1cmUgLSBQQVNTCkRlc2M6IENvbmZpZ3VyZSBCbHVlWiBzb3VyY2Ugd2l0
aCAnLS1lbmFibGUtZXh0ZXJuYWwtZWxsJyBjb25maWd1cmF0aW9uCgojIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgdy9leHQgRUxMIC0gTWFrZSAtIEZBSUwKRGVzYzog
QnVpbGQgQmx1ZVogc291cmNlIHdpdGggJy0tZW5hYmxlLWV4dGVybmFsLWVsbCcgY29uZmlndXJh
dGlvbgpPdXRwdXQ6CnBsdWdpbnMvYWRtaW4uYzogSW4gZnVuY3Rpb24g4oCYYWRtaW5fcG9saWN5
X2Rlc3Ryb3nigJk6CnBsdWdpbnMvYWRtaW4uYzo5MDoxNTogZXJyb3I6IGluaXRpYWxpemF0aW9u
IGRpc2NhcmRzIOKAmGNvbnN04oCZIHF1YWxpZmllciBmcm9tIHBvaW50ZXIgdGFyZ2V0IHR5cGUg
Wy1XZXJyb3I9ZGlzY2FyZGVkLXF1YWxpZmllcnNdCiAgIDkwIHwgIGNoYXIgKnBhdGggPSBhZGFw
dGVyX2dldF9wYXRoKGFkbWluX3BvbGljeS0+YWRhcHRlcik7CiAgICAgIHwgICAgICAgICAgICAg
ICBefn5+fn5+fn5+fn5+fn5+CnBsdWdpbnMvYWRtaW4uYzo5Nzo3OiBlcnJvcjog4oCYTU9DS19B
RE1JTl9QT0xJQ1lfSU5URVJGQUNF4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1
bmN0aW9uKTsgZGlkIHlvdSBtZWFuIOKAmEFETUlOX1BPTElDWV9TRVRfSU5URVJGQUNF4oCZPwog
ICA5NyB8ICAgICAgIE1PQ0tfQURNSU5fUE9MSUNZX0lOVEVSRkFDRSk7CiAgICAgIHwgICAgICAg
Xn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CiAgICAgIHwgICAgICAgQURNSU5fUE9MSUNZX1NF
VF9JTlRFUkZBQ0UKcGx1Z2lucy9hZG1pbi5jOjk3Ojc6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBp
ZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkgb25jZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBl
YXJzIGluCnBsdWdpbnMvYWRtaW4uYzogQXQgdG9wIGxldmVsOgpwbHVnaW5zL2FkbWluLmM6NjAz
OjEyOiBlcnJvcjogaW5pdGlhbGl6YXRpb24gb2Yg4oCYdm9pZCAoKikoc3RydWN0IGJ0ZF9hZGFw
dGVyICop4oCZIGZyb20gaW5jb21wYXRpYmxlIHBvaW50ZXIgdHlwZSDigJh2b2lkICgqKSh2b2lk
KeKAmSBbLVdlcnJvcj1pbmNvbXBhdGlibGUtcG9pbnRlci10eXBlc10KICA2MDMgfCAgLnJlbW92
ZSA9IGFkbWluX3BvbGljeV9yZW1vdmUsCiAgICAgIHwgICAgICAgICAgICBefn5+fn5+fn5+fn5+
fn5+fn5+CnBsdWdpbnMvYWRtaW4uYzo2MDM6MTI6IG5vdGU6IChuZWFyIGluaXRpYWxpemF0aW9u
IGZvciDigJhhZG1pbl9wb2xpY3lfZHJpdmVyLnJlbW92ZeKAmSkKY2MxOiBhbGwgd2FybmluZ3Mg
YmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo4NDU2OiBwbHVn
aW5zL2JsdWV0b290aGQtYWRtaW4ub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQxNTE6
IGFsbF0gRXJyb3IgMgoKCgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============8264031909967464011==--
