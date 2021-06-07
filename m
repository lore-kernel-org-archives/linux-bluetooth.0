Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F951C47094
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jun 2021 20:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CA6B61073
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Jun 2021 20:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhFGUSY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Jun 2021 16:18:24 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:45789 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhFGUSX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Jun 2021 16:18:23 -0400
Received: by mail-qt1-f178.google.com with SMTP id l17so9447834qtq.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jun 2021 13:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Qqv/SeXIp8/PdXO+khYVe73e/5fF4wFYHpf9iwNazKw=;
        b=c9fMle6CmZE/ETbaObnYBnEH6C2Ng/YPJH+BlE4CfKAI/CVx+knrGncLkP8ZMCq3SY
         3QnPQA0gQKdk/j6X0YQa3/+fPi5tnqTYf1ebZ6AzrnD8d2j965oTDHVtHl1Pc6LsltKI
         R93ZQfZaaXUzYkJwRkLdvYM+IBL3VxTR2P3XPhMSQj2vnafUxGM0QFSOPfY5WaK2t6Yk
         vkwErvbYZ1BSoPzdHKMDifnQCBmoY8VcQbpNTP2X09jC/nX9a3Ss4ggqO2j2Waa1sBvP
         91widVrXeEWBRiQTKRDIJmBiEtuNv0KAHBORK+XX7AiBvt0se4O1yCYHppPBMoZuP+Et
         SPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Qqv/SeXIp8/PdXO+khYVe73e/5fF4wFYHpf9iwNazKw=;
        b=pDymU3H2ILR/+xzxmj33KBdOzIARvzyiESWrPQYje9JaVQiNJWcoLs+1wvYdnl/q1+
         T8hdDO5YQ6K73u+aNvG3EYiCla3jWX7fxsMnmWy7fltEnR9wczfzpoqikR8JW0c63UIu
         jUDVOEgMuzprcLzxp0SZseNIyHI6HlRsl+uE/LJtT0Lp2gLKibRQrwF7nC7fk85+jbJV
         hvhNKbg6mEeWPwkp6tv3lYb8pdhlP/0cufbY/QI9MA5nOskARlBg+d2dNBOIuuEEuq/9
         Um5XtCghx2KcVZ7EpxcrHk5jY5DWF8QHGz56j32mTSbswb57vCKQvVJ9DOBn1WB0zAAp
         FS+g==
X-Gm-Message-State: AOAM5322pSO0CSRC9ZwsTfG1EWeONX1LT91R805fqfXPcvwNfPb0h4Hw
        nhfalgRoJpMY5zcmE5soEuXZMeAJgv8=
X-Google-Smtp-Source: ABdhPJzXDGSBAqde7kb20RZKC/l2nuEQyzGx1oQ4GIlZEt6or+n45sM+xi33CE84Huvl17xiOHGciA==
X-Received: by 2002:ac8:588e:: with SMTP id t14mr18173189qta.39.1623096931703;
        Mon, 07 Jun 2021 13:15:31 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.199.46])
        by smtp.gmail.com with ESMTPSA id 80sm9192158qkd.38.2021.06.07.13.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 13:15:31 -0700 (PDT)
Message-ID: <60be7e63.1c69fb81.1c029.ca93@mx.google.com>
Date:   Mon, 07 Jun 2021 13:15:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3787764715045167000=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ] Queue SetAbsoluteVolume if there is an in-progress one.
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210607184616.22051-1-sonnysasaka@chromium.org>
References: <20210607184616.22051-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3787764715045167000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NDk1NjA1CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMC4zNCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIEZB
SUwgICAgICAwLjEwIHNlY29uZHMKUHJlcCAtIFNldHVwIEVMTCAgICAgICAgICAgICAgUEFTUyAg
ICAgIDQyLjY0IHNlY29uZHMKQnVpbGQgLSBQcmVwICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDAuMTAgc2Vjb25kcwpCdWlsZCAtIENvbmZpZ3VyZSAgICAgICAgICAgICBQQVNTICAgICAgNy40
MCBzZWNvbmRzCkJ1aWxkIC0gTWFrZSAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAxMzguNjUg
c2Vjb25kcwpNYWtlIENoZWNrICAgICAgICAgICAgICAgICAgICBGQUlMICAgICAgMS4yOCBzZWNv
bmRzCk1ha2UgRGlzdGNoZWNrICAgICAgICAgICAgICAgIFBBU1MgICAgICAyMDguNzggc2Vjb25k
cwpCdWlsZCB3L2V4dCBFTEwgLSBDb25maWd1cmUgICBQQVNTICAgICAgOC4yMCBzZWNvbmRzCkJ1
aWxkIHcvZXh0IEVMTCAtIE1ha2UgICAgICAgIEZBSUwgICAgICAxMjYuNTIgc2Vjb25kcwoKRGV0
YWlscwojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tQYXRjaCAtIFBB
U1MKRGVzYzogUnVuIGNoZWNrcGF0Y2gucGwgc2NyaXB0IHdpdGggcnVsZSBpbiAuY2hlY2twYXRj
aC5jb25mCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogR2l0TGludCAtIEZB
SUwKRGVzYzogUnVuIGdpdGxpbnQgd2l0aCBydWxlIGluIC5naXRsaW50Ck91dHB1dDoKUXVldWUg
U2V0QWJzb2x1dGVWb2x1bWUgaWYgdGhlcmUgaXMgYW4gaW4tcHJvZ3Jlc3Mgb25lLgoxOiBUMyBU
aXRsZSBoYXMgdHJhaWxpbmcgcHVuY3R1YXRpb24gKC4pOiAiUXVldWUgU2V0QWJzb2x1dGVWb2x1
bWUgaWYgdGhlcmUgaXMgYW4gaW4tcHJvZ3Jlc3Mgb25lLiIKCgojIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMKVGVzdDogUHJlcCAtIFNldHVwIEVMTCAtIFBBU1MKRGVzYzogQ2xvbmUsIGJ1
aWxkLCBhbmQgaW5zdGFsbCBFTEwKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0
OiBCdWlsZCAtIFByZXAgLSBQQVNTCkRlc2M6IFByZXBhcmUgZW52aXJvbm1lbnQgZm9yIGJ1aWxk
CgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQnVpbGQgLSBDb25maWd1cmUg
LSBQQVNTCkRlc2M6IENvbmZpZ3VyZSB0aGUgQmx1ZVogc291cmNlIHRyZWUKCiMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBCdWlsZCAtIE1ha2UgLSBGQUlMCkRlc2M6IEJ1aWxk
IHRoZSBCbHVlWiBzb3VyY2UgdHJlZQpPdXRwdXQ6CnByb2ZpbGVzL2F1ZGlvL2F2cmNwLmM6NDI2
Njo2OiBlcnJvcjogbm8gcHJldmlvdXMgZGVjbGFyYXRpb24gZm9yIOKAmHVwZGF0ZV9xdWV1ZWRf
c2V0X3ZvbHVtZeKAmSBbLVdlcnJvcj1taXNzaW5nLWRlY2xhcmF0aW9uc10KIDQyNjYgfCB2b2lk
IHVwZGF0ZV9xdWV1ZWRfc2V0X3ZvbHVtZShzdHJ1Y3QgYXZyY3AgKnNlc3Npb24sIHVpbnQ4X3Qg
dm9sdW1lLAogICAgICB8ICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CnByb2ZpbGVzL2F1
ZGlvL2F2cmNwLmM6NDI3Njo2OiBlcnJvcjogbm8gcHJldmlvdXMgZGVjbGFyYXRpb24gZm9yIOKA
mGNsZWFyX3F1ZXVlZF9zZXRfdm9sdW1l4oCZIFstV2Vycm9yPW1pc3NpbmctZGVjbGFyYXRpb25z
XQogNDI3NiB8IHZvaWQgY2xlYXJfcXVldWVkX3NldF92b2x1bWUoc3RydWN0IGF2cmNwICpzZXNz
aW9uKQogICAgICB8ICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KY2MxOiBhbGwgd2Fybmlu
Z3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtNYWtlZmlsZTo4NjE1OiBw
cm9maWxlcy9hdWRpby9ibHVldG9vdGhkLWF2cmNwLm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtl
ZmlsZTo0MTM0OiBhbGxdIEVycm9yIDIKCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMK
VGVzdDogTWFrZSBDaGVjayAtIEZBSUwKRGVzYzogUnVuICdtYWtlIGNoZWNrJwpPdXRwdXQ6CnBy
b2ZpbGVzL2F1ZGlvL2F2cmNwLmM6NDI2Njo2OiBlcnJvcjogbm8gcHJldmlvdXMgZGVjbGFyYXRp
b24gZm9yIOKAmHVwZGF0ZV9xdWV1ZWRfc2V0X3ZvbHVtZeKAmSBbLVdlcnJvcj1taXNzaW5nLWRl
Y2xhcmF0aW9uc10KIDQyNjYgfCB2b2lkIHVwZGF0ZV9xdWV1ZWRfc2V0X3ZvbHVtZShzdHJ1Y3Qg
YXZyY3AgKnNlc3Npb24sIHVpbnQ4X3Qgdm9sdW1lLAogICAgICB8ICAgICAgXn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+CnByb2ZpbGVzL2F1ZGlvL2F2cmNwLmM6NDI3Njo2OiBlcnJvcjogbm8gcHJl
dmlvdXMgZGVjbGFyYXRpb24gZm9yIOKAmGNsZWFyX3F1ZXVlZF9zZXRfdm9sdW1l4oCZIFstV2Vy
cm9yPW1pc3NpbmctZGVjbGFyYXRpb25zXQogNDI3NiB8IHZvaWQgY2xlYXJfcXVldWVkX3NldF92
b2x1bWUoc3RydWN0IGF2cmNwICpzZXNzaW9uKQogICAgICB8ICAgICAgXn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsx
XTogKioqIFtNYWtlZmlsZTo4NjE1OiBwcm9maWxlcy9hdWRpby9ibHVldG9vdGhkLWF2cmNwLm9d
IEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZToxMDQwNjogY2hlY2tdIEVycm9yIDIKCgojIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogTWFrZSBEaXN0Y2hlY2sgLSBQQVNTCkRl
c2M6IFJ1biBkaXN0Y2hlY2sgdG8gY2hlY2sgdGhlIGRpc3RyaWJ1dGlvbgoKIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IEJ1aWxkIHcvZXh0IEVMTCAtIENvbmZpZ3VyZSAtIFBB
U1MKRGVzYzogQ29uZmlndXJlIEJsdWVaIHNvdXJjZSB3aXRoICctLWVuYWJsZS1leHRlcm5hbC1l
bGwnIGNvbmZpZ3VyYXRpb24KCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBC
dWlsZCB3L2V4dCBFTEwgLSBNYWtlIC0gRkFJTApEZXNjOiBCdWlsZCBCbHVlWiBzb3VyY2Ugd2l0
aCAnLS1lbmFibGUtZXh0ZXJuYWwtZWxsJyBjb25maWd1cmF0aW9uCk91dHB1dDoKcHJvZmlsZXMv
YXVkaW8vYXZyY3AuYzo0MjY2OjY6IGVycm9yOiBubyBwcmV2aW91cyBkZWNsYXJhdGlvbiBmb3Ig
4oCYdXBkYXRlX3F1ZXVlZF9zZXRfdm9sdW1l4oCZIFstV2Vycm9yPW1pc3NpbmctZGVjbGFyYXRp
b25zXQogNDI2NiB8IHZvaWQgdXBkYXRlX3F1ZXVlZF9zZXRfdm9sdW1lKHN0cnVjdCBhdnJjcCAq
c2Vzc2lvbiwgdWludDhfdCB2b2x1bWUsCiAgICAgIHwgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn4KcHJvZmlsZXMvYXVkaW8vYXZyY3AuYzo0Mjc2OjY6IGVycm9yOiBubyBwcmV2aW91cyBk
ZWNsYXJhdGlvbiBmb3Ig4oCYY2xlYXJfcXVldWVkX3NldF92b2x1bWXigJkgWy1XZXJyb3I9bWlz
c2luZy1kZWNsYXJhdGlvbnNdCiA0Mjc2IHwgdm9pZCBjbGVhcl9xdWV1ZWRfc2V0X3ZvbHVtZShz
dHJ1Y3QgYXZyY3AgKnNlc3Npb24pCiAgICAgIHwgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+
fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiog
W01ha2VmaWxlOjg2MTU6IHByb2ZpbGVzL2F1ZGlvL2JsdWV0b290aGQtYXZyY3Aub10gRXJyb3Ig
MQptYWtlOiAqKiogW01ha2VmaWxlOjQxMzQ6IGFsbF0gRXJyb3IgMgoKCgoKLS0tClJlZ2FyZHMs
CkxpbnV4IEJsdWV0b290aAoK

--===============3787764715045167000==--
