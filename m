Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51045EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Jul 2023 20:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjGBU5F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 Jul 2023 16:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGBU5E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 Jul 2023 16:57:04 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FCE1BB
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Jul 2023 13:57:03 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-765a7768f1dso403568385a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Jul 2023 13:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688331422; x=1690923422;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fztfSJ/BjVtsubt2fpMzyPsu6hwz8KuVYQY0Wq0ms04=;
        b=LgZlJT+DpUzwfXTFFL/FDQ9OwKqF8K3Hrlo9bGLSu8Rs+BvUZSNTYbPk30zmCTdaXB
         BvnNQn7ecN9jk+cwZb0FdOlneiRtesW3FzaEIz1BYaBC3e68yIoiPmORDjqX/fLZlzAy
         kjbMK3XtnxfTcb8sl/TLHvfScD39+EnedRdOXY+c/UWyIo5WGkNrMh3Tq1BwWIpaUyr0
         ofYUgrVKZqFqmvaRHgyPJUU77JK3fSxbDMMH3IhzvKso6IuLa+FvPwWWyBUu9rA5uClR
         o2ky9qY35rD62zKrPfWkZma6IqDbi38tEKxuovdu5Yr5ngn2Ill2AgDvuaozs2W/PijQ
         uZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688331422; x=1690923422;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fztfSJ/BjVtsubt2fpMzyPsu6hwz8KuVYQY0Wq0ms04=;
        b=VxGLTeYme1k0EUrLCNFDlH233YrFm8Ljq2hfWG0eFdMhLC7zqkxhycIFHZzg1biHaY
         90O2KZyPnTuw7Cg/11+EgHG6b7BUIxy6xlEAGqk+KAjNHhpA/qFT5uJpRGMp7r1k0LYJ
         ChOawd80KD6Kj8Vj1RKxwhlb9NF8yhO7hgISV6cf8+RkWqmKADwapSa2PWCBO3jfg9LA
         MFEasa+Cs9rZ2/1frIWv6JgHpxnoA6Qs/x7mp426k3vwujnaY74ENqe4r2DkjaprN6/D
         ZdF+IvCQgIy11r4Bb4kDdzqs8ydFA1XHBCDgVQbGEL8bVwy9iLG+di7Rg6KSnWTRxvwW
         m5ag==
X-Gm-Message-State: AC+VfDxxY58e1d3CKP95D1l1MLWIxdako5KBq4vlPN+IYgD4b7uvNO/o
        74JY2ZZwal6smUYiZ7ufqbNiIegc2TY=
X-Google-Smtp-Source: ACHHUZ4z6dSqB/upH5q65MOghe31g7YGlz9EtK0llWqLAdAirIz+28/IY0lCDaxTeaoDl9prYGeZvA==
X-Received: by 2002:ac8:7d46:0:b0:3f0:a426:5f29 with SMTP id h6-20020ac87d46000000b003f0a4265f29mr12497076qtb.11.1688331422075;
        Sun, 02 Jul 2023 13:57:02 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.106.103])
        by smtp.gmail.com with ESMTPSA id c22-20020ac81e96000000b0040338d69f51sm4134407qtm.80.2023.07.02.13.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 13:57:01 -0700 (PDT)
Message-ID: <64a1e49d.c80a0220.5befe.92b6@mx.google.com>
Date:   Sun, 02 Jul 2023 13:57:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6677703584125301028=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, trix@redhat.com
Subject: RE: Bluetooth: btmtk: fix handling of CONFIG_DEV_COREDUMP not being defined
In-Reply-To: <20230702202603.3442724-1-trix@redhat.com>
References: <20230702202603.3442724-1-trix@redhat.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6677703584125301028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NzYxODY0CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC42NyBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIEZB
SUwgICAgICAwLjU3IHNlY29uZHMKU3ViamVjdFByZWZpeCAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDAuMTEgc2Vjb25kcwpCdWlsZEtlcm5lbCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
MzIuMDcgc2Vjb25kcwpDaGVja0FsbFdhcm5pbmcgICAgICAgICAgICAgICBQQVNTICAgICAgMzQu
OTAgc2Vjb25kcwpDaGVja1NwYXJzZSAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMzkuMzkg
c2Vjb25kcwpDaGVja1NtYXRjaCAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTEwLjg3IHNl
Y29uZHMKQnVpbGRLZXJuZWwzMiAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDMwLjQ3IHNlY29u
ZHMKVGVzdFJ1bm5lclNldHVwICAgICAgICAgICAgICAgUEFTUyAgICAgIDQ0MC4xMiBzZWNvbmRz
ClRlc3RSdW5uZXJfbDJjYXAtdGVzdGVyICAgICAgIFBBU1MgICAgICAxMi44NSBzZWNvbmRzClRl
c3RSdW5uZXJfaXNvLXRlc3RlciAgICAgICAgIFBBU1MgICAgICAyMy42MiBzZWNvbmRzClRlc3RS
dW5uZXJfYm5lcC10ZXN0ZXIgICAgICAgIFBBU1MgICAgICA1LjQ4IHNlY29uZHMKVGVzdFJ1bm5l
cl9tZ210LXRlc3RlciAgICAgICAgUEFTUyAgICAgIDEyOS44MyBzZWNvbmRzClRlc3RSdW5uZXJf
cmZjb21tLXRlc3RlciAgICAgIFBBU1MgICAgICA4Ljk1IHNlY29uZHMKVGVzdFJ1bm5lcl9zY28t
dGVzdGVyICAgICAgICAgUEFTUyAgICAgIDEwLjQxIHNlY29uZHMKVGVzdFJ1bm5lcl9pb2N0bC10
ZXN0ZXIgICAgICAgUEFTUyAgICAgIDkuNzAgc2Vjb25kcwpUZXN0UnVubmVyX21lc2gtdGVzdGVy
ICAgICAgICBQQVNTICAgICAgNy4wMSBzZWNvbmRzClRlc3RSdW5uZXJfc21wLXRlc3RlciAgICAg
ICAgIFBBU1MgICAgICA4LjE1IHNlY29uZHMKVGVzdFJ1bm5lcl91c2VyY2hhbi10ZXN0ZXIgICAg
UEFTUyAgICAgIDUuODEgc2Vjb25kcwpJbmNyZW1lbnRhbEJ1aWxkICAgICAgICAgICAgICBQQVNT
ICAgICAgMjguNzMgc2Vjb25kcwoKRGV0YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMKVGVzdDogR2l0TGludCAtIEZBSUwKRGVzYzogUnVuIGdpdGxpbnQKT3V0cHV0OgpCbHVldG9v
dGg6IGJ0bXRrOiBmaXggaGFuZGxpbmcgb2YgQ09ORklHX0RFVl9DT1JFRFVNUCBub3QgYmVpbmcg
ZGVmaW5lZAoKV0FSTklORzogSTMgLSBpZ25vcmUtYm9keS1saW5lczogZ2l0bGludCB3aWxsIGJl
IHN3aXRjaGluZyBmcm9tIHVzaW5nIFB5dGhvbiByZWdleCAnbWF0Y2gnIChtYXRjaCBiZWdpbm5p
bmcpIHRvICdzZWFyY2gnIChtYXRjaCBhbnl3aGVyZSkgc2VtYW50aWNzLiBQbGVhc2UgcmV2aWV3
IHlvdXIgaWdub3JlLWJvZHktbGluZXMucmVnZXggb3B0aW9uIGFjY29yZGluZ2x5LiBUbyByZW1v
dmUgdGhpcyB3YXJuaW5nLCBzZXQgZ2VuZXJhbC5yZWdleC1zdHlsZS1zZWFyY2g9VHJ1ZS4gTW9y
ZSBkZXRhaWxzOiBodHRwczovL2pvcmlzcm9vdmVycy5naXRodWIuaW8vZ2l0bGludC9jb25maWd1
cmF0aW9uLyNyZWdleC1zdHlsZS1zZWFyY2gKNTogQjEgTGluZSBleGNlZWRzIG1heCBsZW5ndGgg
KDg0PjgwKTogImRyaXZlcnMvYmx1ZXRvb3RoL2J0bXRrLmM6Mzg2OjQ0OiBlcnJvcjog4oCYc3Ry
dWN0IGhjaV9kZXbigJkgaGFzIG5vIG1lbWJlciBuYW1lZCDigJhkdW1w4oCZIgoKCi0tLQpSZWdh
cmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============6677703584125301028==--
