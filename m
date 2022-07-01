Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B14C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Jul 2022 06:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbiGAGx4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Jul 2022 02:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbiGAGxz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Jul 2022 02:53:55 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2482460510
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 23:53:54 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id n15so3202599qvh.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 23:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=7OcidsRBQESKKLHuF705LXgszYlvYGOO2IPiXmA2me4=;
        b=DI0Q0cvRqln8Vio4G6lJUJ+wf79NMu/rVAIUe5NvPBUpPoQdzzEZkG2pgAkKKhDIFN
         AxUf2ZLNYSHoy04ZVkX04PHhsFzFoBPL4OPDXeFTQ59JR5/IVR8/sd7thJcNlKKiJPB1
         PbXuKkQvK2BdV0Bu8S2kMsm3j3nvPqFuEfpcWiQM81dj7G8ml6XCQGUZ1mnYP4gesHtH
         z7cqVhoid8NyPGdw90qopWIXvoJzMSx8F4hofLyu3y8zo7vJtanWMGKGYBJ1y5fI6xgj
         Vvz2FV6VUcSZFJQjuoumqxO92Mon2ntP3kl3U73PsFRQIjEIWp35HFyDdL+Qi2ujXAL2
         H6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=7OcidsRBQESKKLHuF705LXgszYlvYGOO2IPiXmA2me4=;
        b=TILkooA9qGJ5EoiLbFi7e0C0kHTVBRNMhSciP1Wcz3iUMgjCQIe//DRQSIuPtXtgO4
         dx3Ggr01ie70MXOt9e3GhSgQQ01cLLfTMn85tK8NrmJK7Q3oQR65zp6RcoFneCFvAC9X
         dGMx4ijQy7QrrkwoUga5IVPepXmgRG2+hu3AKbQH7LrIl4I04W/q75YCHoD6gGoylZXj
         tvCDrRlOINGCI8PRkohtMbHD8wUlyccszWU+dm5GXhKgjsiesulm66ssyxNydfuza2/N
         628WdacMSerrAi3SAUpmyYEuSl6e0BaS+ZA5zuXjLMkytHJP5UbJzUtHAeT4/y8afsTT
         nLRA==
X-Gm-Message-State: AJIora/EQk9lvomgeMYXD3cLKwILORU69p8SA6nhfBitccI1lBlquV4k
        M8hmhCAFXqTdkSxVBMNup85WxC6y2Jc=
X-Google-Smtp-Source: AGRyM1uHh72A0N8Ls3j5LdLL0Entjqv9jI1cwbdkfm8j8Y/q4MPp3LqYuxpFcwpiD9i7yTZnPfnNkw==
X-Received: by 2002:a0c:a944:0:b0:470:85e2:dc1c with SMTP id z4-20020a0ca944000000b0047085e2dc1cmr16233408qva.8.1656658432941;
        Thu, 30 Jun 2022 23:53:52 -0700 (PDT)
Received: from [172.17.0.2] ([20.122.184.71])
        by smtp.gmail.com with ESMTPSA id i8-20020a05620a404800b006b24f49d06csm1936181qko.6.2022.06.30.23.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 23:53:51 -0700 (PDT)
Message-ID: <62be99ff.1c69fb81.d82c0.617e@mx.google.com>
Date:   Thu, 30 Jun 2022 23:53:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2992873069412497530=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@uniontech.com
Subject: RE: obexd: fix crashed after cancel the on-going transfer
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220701055237.2946-1-wangyouwan@uniontech.com>
References: <20220701055237.2946-1-wangyouwan@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2992873069412497530==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NjU1NjU0CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMS43MSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAxLjA3IHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDI3LjE0IHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuODAgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgOC41
MyBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIEZBSUwgICAgICA5Ni40MiBz
ZWNvbmRzCk1ha2UgQ2hlY2sgICAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAxNzMuNDYgc2Vj
b25kcwpNYWtlIENoZWNrIHcvVmFsZ3JpbmQgICAgICAgICBGQUlMICAgICAgNzcuMjUgc2Vjb25k
cwpNYWtlIERpc3RjaGVjayAgICAgICAgICAgICAgICBQQVNTICAgICAgMjI5LjM1IHNlY29uZHMK
QnVpbGQgdy9leHQgRUxMIC0gQ29uZmlndXJlICAgUEFTUyAgICAgIDguNTUgc2Vjb25kcwpCdWls
ZCB3L2V4dCBFTEwgLSBNYWtlICAgICAgICBGQUlMICAgICAgMzQuNjUgc2Vjb25kcwpJbmNyZW1l
bnRhbCBCdWlsZCB3LyBwYXRjaGVzICBQQVNTICAgICAgMC4wMCBzZWNvbmRzClNjYW4gQnVpbGQg
ICAgICAgICAgICAgICAgICAgIEZBSUwgICAgICA0NjYuNjEgc2Vjb25kcwoKRGV0YWlscwojIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgLSBNYWtlIC0gRkFJTApEZXNj
OiBCdWlsZCB0aGUgQmx1ZVogc291cmNlIHRyZWUKT3V0cHV0Ogp0b29scy9tZ210LXRlc3Rlci5j
OiBJbiBmdW5jdGlvbiDigJhtYWlu4oCZOgp0b29scy9tZ210LXRlc3Rlci5jOjEyNDI2OjU6IG5v
dGU6IHZhcmlhYmxlIHRyYWNraW5nIHNpemUgbGltaXQgZXhjZWVkZWQgd2l0aCDigJgtZnZhci10
cmFja2luZy1hc3NpZ25tZW50c+KAmSwgcmV0cnlpbmcgd2l0aG91dAoxMjQyNiB8IGludCBtYWlu
KGludCBhcmdjLCBjaGFyICphcmd2W10pCiAgICAgIHwgICAgIF5+fn4KZ29iZXgvZ29iZXgtdHJh
bnNmZXIuYzogSW4gZnVuY3Rpb24g4oCYdHJhbnNmZXJfY29tcGxldGXigJk6CmdvYmV4L2dvYmV4
LXRyYW5zZmVyLmM6OTc6MjogZXJyb3I6IElTTyBDOTAgZm9yYmlkcyBtaXhlZCBkZWNsYXJhdGlv
bnMgYW5kIGNvZGUgWy1XZXJyb3I9ZGVjbGFyYXRpb24tYWZ0ZXItc3RhdGVtZW50XQogICA5NyB8
ICBndWludCBpZCA9IHRyYW5zZmVyLT5pZDsKICAgICAgfCAgXn5+fn4KZ29iZXgvZ29iZXgtdHJh
bnNmZXIuYzogSW4gZnVuY3Rpb24g4oCYdHJhbnNmZXJfcmVzcG9uc2XigJk6CmdvYmV4L2dvYmV4
LXRyYW5zZmVyLmM6MTg3Ojg6IGVycm9yOiB1bnVzZWQgdmFyaWFibGUg4oCYaWTigJkgWy1XZXJy
b3I9dW51c2VkLXZhcmlhYmxlXQogIDE4NyB8ICBndWludCBpZDsKICAgICAgfCAgICAgICAgXn4K
Y2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtN
YWtlZmlsZTo4ODAxOiBnb2JleC9vYmV4ZC1nb2JleC10cmFuc2Zlci5vXSBFcnJvciAxCm1ha2Vb
MV06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCm1ha2U6ICoqKiBbTWFrZWZp
bGU6NDMyNDogYWxsXSBFcnJvciAyCgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRl
c3Q6IE1ha2UgQ2hlY2sgLSBGQUlMCkRlc2M6IFJ1biAnbWFrZSBjaGVjaycKT3V0cHV0Ogpnb2Jl
eC9nb2JleC10cmFuc2Zlci5jOiBJbiBmdW5jdGlvbiDigJh0cmFuc2Zlcl9jb21wbGV0ZeKAmToK
Z29iZXgvZ29iZXgtdHJhbnNmZXIuYzo5NzoyOiBlcnJvcjogSVNPIEM5MCBmb3JiaWRzIG1peGVk
IGRlY2xhcmF0aW9ucyBhbmQgY29kZSBbLVdlcnJvcj1kZWNsYXJhdGlvbi1hZnRlci1zdGF0ZW1l
bnRdCiAgIDk3IHwgIGd1aW50IGlkID0gdHJhbnNmZXItPmlkOwogICAgICB8ICBefn5+fgpnb2Jl
eC9nb2JleC10cmFuc2Zlci5jOiBJbiBmdW5jdGlvbiDigJh0cmFuc2Zlcl9yZXNwb25zZeKAmToK
Z29iZXgvZ29iZXgtdHJhbnNmZXIuYzoxODc6ODogZXJyb3I6IHVudXNlZCB2YXJpYWJsZSDigJhp
ZOKAmSBbLVdlcnJvcj11bnVzZWQtdmFyaWFibGVdCiAgMTg3IHwgIGd1aW50IGlkOwogICAgICB8
ICAgICAgICBefgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtl
WzFdOiAqKiogW01ha2VmaWxlOjczMDA6IGdvYmV4L2dvYmV4LXRyYW5zZmVyLm9dIEVycm9yIDEK
bWFrZTogKioqIFtNYWtlZmlsZToxMTMyMDogY2hlY2tdIEVycm9yIDIKCgojIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZSBDaGVjayB3L1ZhbGdyaW5kIC0gRkFJTApEZXNj
OiBSdW4gJ21ha2UgY2hlY2snIHdpdGggVmFsZ3JpbmQKT3V0cHV0Ogp0b29scy9tZ210LXRlc3Rl
ci5jOiBJbiBmdW5jdGlvbiDigJhtYWlu4oCZOgp0b29scy9tZ210LXRlc3Rlci5jOjEyNDI2OjU6
IG5vdGU6IHZhcmlhYmxlIHRyYWNraW5nIHNpemUgbGltaXQgZXhjZWVkZWQgd2l0aCDigJgtZnZh
ci10cmFja2luZy1hc3NpZ25tZW50c+KAmSwgcmV0cnlpbmcgd2l0aG91dAoxMjQyNiB8IGludCBt
YWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAgICAgIHwgICAgIF5+fn4KZ29iZXgvZ29iZXgt
dHJhbnNmZXIuYzogSW4gZnVuY3Rpb24g4oCYdHJhbnNmZXJfY29tcGxldGXigJk6CmdvYmV4L2dv
YmV4LXRyYW5zZmVyLmM6OTc6MjogZXJyb3I6IElTTyBDOTAgZm9yYmlkcyBtaXhlZCBkZWNsYXJh
dGlvbnMgYW5kIGNvZGUgWy1XZXJyb3I9ZGVjbGFyYXRpb24tYWZ0ZXItc3RhdGVtZW50XQogICA5
NyB8ICBndWludCBpZCA9IHRyYW5zZmVyLT5pZDsKICAgICAgfCAgXn5+fn4KZ29iZXgvZ29iZXgt
dHJhbnNmZXIuYzogSW4gZnVuY3Rpb24g4oCYdHJhbnNmZXJfcmVzcG9uc2XigJk6CmdvYmV4L2dv
YmV4LXRyYW5zZmVyLmM6MTg3Ojg6IGVycm9yOiB1bnVzZWQgdmFyaWFibGUg4oCYaWTigJkgWy1X
ZXJyb3I9dW51c2VkLXZhcmlhYmxlXQogIDE4NyB8ICBndWludCBpZDsKICAgICAgfCAgICAgICAg
Xn4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioq
IFtNYWtlZmlsZTo4ODAxOiBnb2JleC9vYmV4ZC1nb2JleC10cmFuc2Zlci5vXSBFcnJvciAxCm1h
a2VbMV06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCm1ha2U6ICoqKiBbTWFr
ZWZpbGU6NDMyNDogYWxsXSBFcnJvciAyCgoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
ClRlc3Q6IEJ1aWxkIHcvZXh0IEVMTCAtIE1ha2UgLSBGQUlMCkRlc2M6IEJ1aWxkIEJsdWVaIHNv
dXJjZSB3aXRoICctLWVuYWJsZS1leHRlcm5hbC1lbGwnIGNvbmZpZ3VyYXRpb24KT3V0cHV0Ogpn
b2JleC9nb2JleC10cmFuc2Zlci5jOiBJbiBmdW5jdGlvbiDigJh0cmFuc2Zlcl9jb21wbGV0ZeKA
mToKZ29iZXgvZ29iZXgtdHJhbnNmZXIuYzo5NzoyOiBlcnJvcjogSVNPIEM5MCBmb3JiaWRzIG1p
eGVkIGRlY2xhcmF0aW9ucyBhbmQgY29kZSBbLVdlcnJvcj1kZWNsYXJhdGlvbi1hZnRlci1zdGF0
ZW1lbnRdCiAgIDk3IHwgIGd1aW50IGlkID0gdHJhbnNmZXItPmlkOwogICAgICB8ICBefn5+fgpn
b2JleC9nb2JleC10cmFuc2Zlci5jOiBJbiBmdW5jdGlvbiDigJh0cmFuc2Zlcl9yZXNwb25zZeKA
mToKZ29iZXgvZ29iZXgtdHJhbnNmZXIuYzoxODc6ODogZXJyb3I6IHVudXNlZCB2YXJpYWJsZSDi
gJhpZOKAmSBbLVdlcnJvcj11bnVzZWQtdmFyaWFibGVdCiAgMTg3IHwgIGd1aW50IGlkOwogICAg
ICB8ICAgICAgICBefgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwpt
YWtlWzFdOiAqKiogW01ha2VmaWxlOjg4MDE6IGdvYmV4L29iZXhkLWdvYmV4LXRyYW5zZmVyLm9d
IEVycm9yIDEKbWFrZVsxXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KbWFr
ZTogKioqIFtNYWtlZmlsZTo0MzI0OiBhbGxdIEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMKVGVzdDogU2NhbiBCdWlsZCAtIEZBSUwKRGVzYzogUnVuIFNjYW4gQnVpbGQg
d2l0aCBwYXRjaGVzCk91dHB1dDoKZ29iZXgvZ29iZXgtdHJhbnNmZXIuYzogSW4gZnVuY3Rpb24g
4oCYdHJhbnNmZXJfY29tcGxldGXigJk6CmdvYmV4L2dvYmV4LXRyYW5zZmVyLmM6OTc6MjogZXJy
b3I6IElTTyBDOTAgZm9yYmlkcyBtaXhlZCBkZWNsYXJhdGlvbnMgYW5kIGNvZGUgWy1XZXJyb3I9
ZGVjbGFyYXRpb24tYWZ0ZXItc3RhdGVtZW50XQogICA5NyB8ICBndWludCBpZCA9IHRyYW5zZmVy
LT5pZDsKICAgICAgfCAgXn5+fn4KZ29iZXgvZ29iZXgtdHJhbnNmZXIuYzogSW4gZnVuY3Rpb24g
4oCYdHJhbnNmZXJfcmVzcG9uc2XigJk6CmdvYmV4L2dvYmV4LXRyYW5zZmVyLmM6MTg3Ojg6IGVy
cm9yOiB1bnVzZWQgdmFyaWFibGUg4oCYaWTigJkgWy1XZXJyb3I9dW51c2VkLXZhcmlhYmxlXQog
IDE4NyB8ICBndWludCBpZDsKICAgICAgfCAgICAgICAgXn4KY2MxOiBhbGwgd2FybmluZ3MgYmVp
bmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo3MzAwOiBnb2JleC9n
b2JleC10cmFuc2Zlci5vXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6NDMyNDogYWxsXSBF
cnJvciAyCgoKCgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============2992873069412497530==--
