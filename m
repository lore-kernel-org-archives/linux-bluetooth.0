Return-Path: <SRS0=u1pM=5S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC77C43331
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 07:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F1F2080C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 07:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bshg.com header.i=@bshg.com header.b="ATAzmvQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgDBHiG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:38:06 -0400
Received: from de-deferred1.bosch-org.com ([139.15.180.216]:33240 "EHLO
        de-deferred1.bosch-org.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727012AbgDBHiG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Apr 2020 03:38:06 -0400
Received: from de-out1.bosch-org.com (unknown [139.15.180.215])
        by si0vms0224.rbdmz01.com (Postfix) with ESMTPS id 48tFKN58Whz539;
        Thu,  2 Apr 2020 09:38:00 +0200 (CEST)
Received: from fe0vm1649.rbesz01.com (unknown [139.15.230.188])
        by si0vms0217.rbdmz01.com (Postfix) with ESMTPS id 48tFKM0t84z4f3lwd;
        Thu,  2 Apr 2020 09:37:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bshg.com;
        s=key3-intmail; t=1585813079;
        bh=XNFfS5jms1z9gpiLaUnDXSiK+sc5Z01/Kn4OzkUOIsE=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=ATAzmvQQla7Kf8Y92r7qR4xtMj1+ovte2JeDBW1/8iifPwK954vMzTDVtOifZkCmS
         MNlzCWrqPxwWiB7L8iibE1AN6hEeE3N+q4XRkUtlw2xsEVnbdS5+OfWtQDBQ19ptdv
         2Eb4Pldtkj3zeUYpOKigIlzPisnI3ap4X4jO13ig=
Received: from fe0vm1740.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1649.rbesz01.com (Postfix) with ESMTPS id 48tFKM0ZFwz1K4;
        Thu,  2 Apr 2020 09:37:59 +0200 (CEST)
X-AuditID: 0a3aad14-035ff70000000c3a-ac-5e859656c21c
Received: from si0vm1950.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm1740.rbesz01.com (SMG Outbound) with SMTP id 95.BC.03130.656958E5; Thu,  2 Apr 2020 09:37:58 +0200 (CEST)
Received: from FE0SWIEXHC04.bsh.corp.bshg.com (unknown [10.49.78.142])
        by si0vm1950.rbesz01.com (Postfix) with ESMTPS id 48tFKL5GdBzW7V;
        Thu,  2 Apr 2020 09:37:58 +0200 (CEST)
Received: from FE0SWIEXMB2D.bsh.corp.bshg.com (10.49.78.132) by
 FE0SWIEXHC04.bsh.corp.bshg.com (10.49.78.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 2 Apr 2020 09:37:58 +0200
Received: from FE0SWIEXMB1D.bsh.corp.bshg.com (10.49.78.130) by
 FE0SWIEXMB2D.bsh.corp.bshg.com (10.49.78.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1913.5; Thu, 2 Apr 2020 09:37:58 +0200
Received: from FE0SWIEXMB1D.bsh.corp.bshg.com ([fe80::886f:21d:19aa:52cd]) by
 FE0SWIEXMB1D.bsh.corp.bshg.com ([fe80::886f:21d:19aa:52cd%4]) with mapi id
 15.01.1913.010; Thu, 2 Apr 2020 09:37:58 +0200
From:   "Klein, Thorsten (GED-SDD2)" <Thorsten.Klein@bshg.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-bluetooth-owner@vger.kernel.org" 
        <linux-bluetooth-owner@vger.kernel.org>,
        "marcel.holtmann@intel.com" <marcel.holtmann@intel.com>
CC:     "Ryll, Jan (GED-SDD2)" <Jan.Ryll@bshg.com>
Subject: Contribution of bluez patches
Thread-Topic: Contribution of bluez patches
Thread-Index: AdYIwYSQZyENZRRjTuWYsv6pUf7hGw==
Date:   Thu, 2 Apr 2020 07:37:57 +0000
Message-ID: <eb4ab11691754213884ff0891780176f@bshg.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.49.87.35]
Content-Type: multipart/mixed;
        boundary="_003_eb4ab11691754213884ff0891780176fbshgcom_"
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: fd782ad6-06f5-4690-bfdd-57c58a3839e9
X-Brightmail-Tracker: H4sIAAAAAAAAA21TW1BTVxTl3Dy4RC5eQgKbIAoZip0iD0GEKQzS1g/b6rTTohWq2FCuJAUS
        JgEGX0iK6CAtoEVEipGApaCiSAgSLBV5CJZWwVGklYoE6AhKgQEqVh5NuEHy0b+1195r7cec
        gzO4GVYCXCJNpORSUZyQzWFy3q509tyRnxHpU3rZN1D99R9YYFF3NiOw4WwbCmVsKf1pGNsy
        Wb36YyyCExxNxUmSKbl3yBcccV9HJTMhbVNKd14GMw01Bx1HVjiQG0Cn6WIdRxycSxZgcK1Y
        bUkHGgST6RpToMRAo65h08EsgsbcNGTUc8kOQ9Bha8RsMhjuNOoXvXjkQwQna6qYxgSD9IIf
        BmowI7Yj3UH1dHSR55EecF55lE1jL6ieyFg0ZZJu0HW3jmHEBBkA3zWXWxoxIp2hquoug/Z0
        gOq/XrDoJXjQ39XBpjEfhgfmTfwayLm8wKLrw6G//SqiPW3h9plBJl0TBD9qnqBcZF9oZlto
        Jik0kxSa1uk5lcemsQeUqZ8xaCyGq5XVGI23wre9SkM9x4C7EbzStpkErpCX1W9J4wTQF/Wa
        moVBWUUaRgv+RFCUlc8yFxQj4gLi76V8kuPXB2zw8ZJHUYr9Puu9vpTFVyP6VfDq0O1vxr2a
        EIajJuSPY0I+IT6ZEcm1iZJF7xOLFOI98qQ4SiEUEIefZ+7m2r2mFUlR8RKFQiKTNiE3Q0t9
        1cVOJGBKZVJKyCO+33wkkktEi/btp+Qy2qIJOeFMoQPB5xyI5JIxokQqlqISKPlSNgjHhUC8
        k2dobiunYqiUvZK4xKW00JlAFhYWXHvzjPkIGG7VhPxwa0Nv61yDBaFIEMUrJDEmuSMt5y6x
        y9Jf0Pt47vDZEgZ+s1VVwuAubiBwIJxOGVxIY704Sfp6DsEqIqdDGcnlmyWWvUZQN8KR0I7w
        N25hbfiByxMAkWY8oK2JXBb5lhg0pJqEx2NOoKrfBo9vfQaqumkEupYmDNp/1TKg5Xo+C670
        tbPg6dQLFkzoMi3hXn2hJTyZOobDQnolDufP5XBAV36fA/Uva1fAyIsbK0DVU0RA+5zGBuZr
        S0noaUy3g9lJDQ8uDmr4UJA9bQ+XHmUKoL1d6Qy9J6adoWD6+mqYz+tfDb1jx1xBV3vHFS6d
        fuQ6YrgtZrjtg5R0420TRYn/c1sTu7yaIA2La4jojU5N0aYf0rfWJn/+kaf+q52ZbWuGPtA+
        9E84M1TkMXbgWYX7iCPKj3V82fVzyG87Nx1R6DlhNcP854E+r6J9d1OhydPbtie96RF349C5
        jZMBLkNK9Vre6DW/noWiiuKKcmnYzIfrdpyQaIW6ufB6UuEe8UnBrtZ72ry1qWqblUzPZFlZ
        i3qDanyPf5194wCR36m2LXZbqQKXkvqgd3Vv6KepqdmVVMyCzeS/7sGfqm71bdll1xIwFdl6
        9eDWvuwcpcvmgM77G1Ozy0edvGX/NFzBJlbxH2a57Q73ljg0z70X+vfM7+xBD8/x2HVWD/qP
        Ds3cPHj4dNuFEL9q1+3akAkhUyEWrX+LIVeI/gMXTHGCmAUAAA==
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--_003_eb4ab11691754213884ff0891780176fbshgcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,
attached you can find two patches, which we want to contribute to bluez. I =
created the patches based on current master.
If you need any further information please don't hesitate to contact me.

Kind regards,
Thorsten Klein=20

BSH Hausger=E4te GmbH
Software-Developer

Im Gewerbepark B10
93059 Regensburg
Tel.: +49 (941) 8994-2490=20
www.bsh-group.com

BSH Hausger=E4te GmbH, Carl-Wery-Str. 34, 81739 Munich, Germany
Chairman of the Supervisory Board: Prof. Dr. Stefan Asenkerschbaumer
Board of Management: Uwe Raschke (Chairman), Dr. Gerhard Dambach, Matthias =
Ginthum, Dr. Silke Maurer
Registered Office: Munich; Registry Court: Amtsgericht M=FCnchen, HRB 75534=
=20
WEEE-Reg.-No. DE 57986696

This message is for the sole use of the intended recipient(s) and may conta=
in trade secrets or other confidential and privileged information. Any unau=
thorized use, copy, disclosure or distribution is prohibited. If you are no=
t the intended recipient, please inform us immediately by reply email and d=
elete this message, including any attachment or copies thereof, from your s=
ystem.


--_003_eb4ab11691754213884ff0891780176fbshgcom_
Content-Type: application/octet-stream;
	name="0002-ManufacturerData-field-added-to-ScanResponse.patch"
Content-Description: 0002-ManufacturerData-field-added-to-ScanResponse.patch
Content-Disposition: attachment;
	filename="0002-ManufacturerData-field-added-to-ScanResponse.patch";
	size=3214; creation-date="Thu, 02 Apr 2020 07:34:21 GMT";
	modification-date="Thu, 02 Apr 2020 07:34:21 GMT"
Content-Transfer-Encoding: base64

RnJvbSA5MzQyMjBiODc0OTc4ZWY5ZmYwZDEwYTQxMWQ5YzY5MDlhM2QxOTk1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8OTM0MjIwYjg3NDk3OGVmOWZmMGQxMGE0MTFkOWM2
OTA5YTNkMTk5NS4xNTg1ODEyODAwLmdpdC50aG9yc3Rlbi5rbGVpbkBic2hnLmNvbT4KRnJvbTog
IlNjaGFjaHNjaGFsLCBNYXhpbWlsaWFuIChCU0gpIiA8bWF4aW1pbGlhbi5zY2hhY2hzY2hhbEBi
c2hnLmNvbT4KRGF0ZTogVGh1LCAyIEFwciAyMDIwIDA5OjMzOjExICswMjAwClN1YmplY3Q6IFtQ
QVRDSF0gTWFudWZhY3R1cmVyRGF0YSBmaWVsZCBhZGRlZCB0byBTY2FuUmVzcG9uc2UKCktleXMg
YXJlIHRoZSBNYW51ZmFjdHVyZXIgSUQgdG8gYXNzb2NpYXRlIHdpdGggdGhlIGRhdGEuCi0tLQog
ZG9jL2FkdmVydGlzaW5nLWFwaS50eHQgfCAgNiArKysrKysKIHNyYy9hZHZlcnRpc2luZy5jICAg
ICAgIHwgMjUgKysrKysrKysrKysrKysrKysrKy0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAyNSBp
bnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RvYy9hZHZlcnRpc2lu
Zy1hcGkudHh0IGIvZG9jL2FkdmVydGlzaW5nLWFwaS50eHQKaW5kZXggYjA1NjVlYS4uMTRjY2Fl
MiAxMDA2NDQKLS0tIGEvZG9jL2FkdmVydGlzaW5nLWFwaS50eHQKKysrIGIvZG9jL2FkdmVydGlz
aW5nLWFwaS50eHQKQEAgLTUxLDYgKzUxLDEyIEBAIFByb3BlcnRpZXMJc3RyaW5nIFR5cGUKIAkJ
CXRoZSBBZHZlcnRpc2luZyBEYXRhLiAgS2V5cyBhcmUgdGhlIE1hbnVmYWN0dXJlciBJRAogCQkJ
dG8gYXNzb2NpYXRlIHdpdGggdGhlIGRhdGEuCiAKKwkJZGljdCBNYW51ZmFjdHVyZXJEYXRhU2Nh
blJlc3BvbnNlIFtFeHBlcmltZW50YWxdCisKKwkJCU1hbnVmYWN0dWVyIERhdGEgZmllbGRzIHRv
IGluY2x1ZGUgaW4KKwkJCXRoZSBTY2FuIFJlc3BvbnNlLiAgS2V5cyBhcmUgdGhlIE1hbnVmYWN0
dXJlciBJRAorCQkJdG8gYXNzb2NpYXRlIHdpdGggdGhlIGRhdGEuCisKIAkJYXJyYXl7c3RyaW5n
fSBTb2xpY2l0VVVJRHMKIAogCQkJQXJyYXkgb2YgVVVJRHMgdG8gaW5jbHVkZSBpbiAiU2Vydmlj
ZSBTb2xpY2l0YXRpb24iCmRpZmYgLS1naXQgYS9zcmMvYWR2ZXJ0aXNpbmcuYyBiL3NyYy9hZHZl
cnRpc2luZy5jCmluZGV4IDQ1ZmYxOWYuLjBlMWEzZjEgMTAwNjQ0Ci0tLSBhL3NyYy9hZHZlcnRp
c2luZy5jCisrKyBiL3NyYy9hZHZlcnRpc2luZy5jCkBAIC0zMjgsMTIgKzMyOCwxMiBAQCBmYWls
OgogfQogCiBzdGF0aWMgYm9vbCBwYXJzZV9tYW51ZmFjdHVyZXJfZGF0YShEQnVzTWVzc2FnZUl0
ZXIgKml0ZXIsCi0JCQkJCXN0cnVjdCBidGRfYWR2X2NsaWVudCAqY2xpZW50KQorCQkJCQlzdHJ1
Y3QgYnRkX2FkICphZCkKIHsKIAlEQnVzTWVzc2FnZUl0ZXIgZW50cmllczsKIAogCWlmICghaXRl
cikgewotCQlidF9hZF9jbGVhcl9tYW51ZmFjdHVyZXJfZGF0YShjbGllbnQtPmRhdGEpOworCQli
dF9hZF9jbGVhcl9tYW51ZmFjdHVyZXJfZGF0YShhZCk7CiAJCXJldHVybiB0cnVlOwogCX0KIApA
QCAtMzQyLDcgKzM0Miw3IEBAIHN0YXRpYyBib29sIHBhcnNlX21hbnVmYWN0dXJlcl9kYXRhKERC
dXNNZXNzYWdlSXRlciAqaXRlciwKIAogCWRidXNfbWVzc2FnZV9pdGVyX3JlY3Vyc2UoaXRlciwg
JmVudHJpZXMpOwogCi0JYnRfYWRfY2xlYXJfbWFudWZhY3R1cmVyX2RhdGEoY2xpZW50LT5kYXRh
KTsKKwlidF9hZF9jbGVhcl9tYW51ZmFjdHVyZXJfZGF0YShhZCk7CiAKIAl3aGlsZSAoZGJ1c19t
ZXNzYWdlX2l0ZXJfZ2V0X2FyZ190eXBlKCZlbnRyaWVzKQogCQkJCQkJPT0gREJVU19UWVBFX0RJ
Q1RfRU5UUlkpIHsKQEAgLTM3Myw3ICszNzMsNyBAQCBzdGF0aWMgYm9vbCBwYXJzZV9tYW51ZmFj
dHVyZXJfZGF0YShEQnVzTWVzc2FnZUl0ZXIgKml0ZXIsCiAKIAkJREJHKCJBZGRpbmcgTWFudWZh
Y3R1cmVyRGF0YSBmb3IgJTA0eCIsIG1hbnVmX2lkKTsKIAotCQlpZiAoIWJ0X2FkX2FkZF9tYW51
ZmFjdHVyZXJfZGF0YShjbGllbnQtPmRhdGEsIG1hbnVmX2lkLAorCQlpZiAoIWJ0X2FkX2FkZF9t
YW51ZmFjdHVyZXJfZGF0YShhZCwgbWFudWZfaWQsCiAJCQkJCQkJbWFudWZfZGF0YSwgbGVuKSkK
IAkJCWdvdG8gZmFpbDsKIApAQCAtMzgzLDEwICszODMsMjIgQEAgc3RhdGljIGJvb2wgcGFyc2Vf
bWFudWZhY3R1cmVyX2RhdGEoREJ1c01lc3NhZ2VJdGVyICppdGVyLAogCXJldHVybiB0cnVlOwog
CiBmYWlsOgotCWJ0X2FkX2NsZWFyX21hbnVmYWN0dXJlcl9kYXRhKGNsaWVudC0+ZGF0YSk7CisJ
YnRfYWRfY2xlYXJfbWFudWZhY3R1cmVyX2RhdGEoYWQpOwogCXJldHVybiBmYWxzZTsKIH0KIAor
c3RhdGljIGJvb2wgcGFyc2VfbWFudWZhY3R1cmVyX2RhdGFfYWR2KERCdXNNZXNzYWdlSXRlciAq
aXRlciwKKwkJCQkJc3RydWN0IGJ0ZF9hZHZfY2xpZW50ICpjbGllbnQpCit7CisJcmV0dXJuIHBh
cnNlX21hbnVmYWN0dXJlcl9kYXRhKGl0ZXIsIGNsaWVudC0+ZGF0YSk7Cit9CisKK3N0YXRpYyBi
b29sIHBhcnNlX21hbnVmYWN0dXJlcl9kYXRhX3NjYW4oREJ1c01lc3NhZ2VJdGVyICppdGVyLAor
CQkJCQlzdHJ1Y3QgYnRkX2Fkdl9jbGllbnQgKmNsaWVudCkKK3sKKwlyZXR1cm4gcGFyc2VfbWFu
dWZhY3R1cmVyX2RhdGEoaXRlciwgY2xpZW50LT5zY2FuKTsKK30KKwogc3RhdGljIGJvb2wgcGFy
c2Vfc2VydmljZV9kYXRhKERCdXNNZXNzYWdlSXRlciAqaXRlciwKIAkJCQkJc3RydWN0IGJ0ZF9h
ZHZfY2xpZW50ICpjbGllbnQpCiB7CkBAIC05NDEsNyArOTUzLDggQEAgc3RhdGljIHN0cnVjdCBh
ZHZfcGFyc2VyIHsKIAl7ICJUeXBlIiwgcGFyc2VfdHlwZSB9LAogCXsgIlNlcnZpY2VVVUlEcyIs
IHBhcnNlX3NlcnZpY2VfdXVpZHMgfSwKIAl7ICJTb2xpY2l0VVVJRHMiLCBwYXJzZV9zb2xpY2l0
X3V1aWRzIH0sCi0JeyAiTWFudWZhY3R1cmVyRGF0YSIsIHBhcnNlX21hbnVmYWN0dXJlcl9kYXRh
IH0sCisJeyAiTWFudWZhY3R1cmVyRGF0YSIsIHBhcnNlX21hbnVmYWN0dXJlcl9kYXRhX2FkdiB9
LAorCXsgIk1hbnVmYWN0dXJlckRhdGFTY2FuUmVzcG9uc2UiLCBwYXJzZV9tYW51ZmFjdHVyZXJf
ZGF0YV9zY2FuIH0sCiAJeyAiU2VydmljZURhdGEiLCBwYXJzZV9zZXJ2aWNlX2RhdGEgfSwKIAl7
ICJJbmNsdWRlcyIsIHBhcnNlX2luY2x1ZGVzIH0sCiAJeyAiTG9jYWxOYW1lIiwgcGFyc2VfbG9j
YWxfbmFtZSB9LAotLSAKMi43LjQKCg==

--_003_eb4ab11691754213884ff0891780176fbshgcom_
Content-Type: application/octet-stream;
	name="0001-fix-dbus-error-code-in-case-of-invalid-offset-org.bl.patch"
Content-Description: 0001-fix-dbus-error-code-in-case-of-invalid-offset-org.bl.patch
Content-Disposition: attachment;
	filename="0001-fix-dbus-error-code-in-case-of-invalid-offset-org.bl.patch";
	size=974; creation-date="Thu, 02 Apr 2020 07:34:34 GMT";
	modification-date="Thu, 02 Apr 2020 07:34:34 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiMjY4MTA4YmJkOTFiYmIyNGM3MzJkOWVjMTI1ZDMxY2MzZWRiMjUwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8YjI2ODEwOGJiZDkxYmJiMjRjNzMyZDllYzEyNWQz
MWNjM2VkYjI1MC4xNTg1ODEyMzc2LmdpdC50aG9yc3Rlbi5rbGVpbkBic2hnLmNvbT4KRnJvbTog
IlJ5bGwsIEphbiAoQlNIKSIgPGphbi5yeWxsQGJzaGcuY29tPgpEYXRlOiBUaHUsIDIgQXByIDIw
MjAgMDk6MjY6MTAgKzAyMDAKU3ViamVjdDogW1BBVENIXSBmaXggZGJ1cyBlcnJvciBjb2RlIGlu
IGNhc2Ugb2YgaW52YWxpZCBvZmZzZXQKIChvcmcuYmx1ZXouRXJyb3IuSW52YWxpZE9mZnNldCkK
Ci0tLQogY2xpZW50L2dhdHQuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL2NsaWVudC9nYXR0LmMgYi9jbGllbnQvZ2F0dC5jCmluZGV4IDQx
NmVkYTkuLmNmMmNiMTcgMTAwNjQ0Ci0tLSBhL2NsaWVudC9nYXR0LmMKKysrIGIvY2xpZW50L2dh
dHQuYwpAQCAtMjI3Niw2ICsyMjc2LDEwIEBAIHN0YXRpYyBEQnVzTWVzc2FnZSAqY2hyY193cml0
ZV92YWx1ZShEQnVzQ29ubmVjdGlvbiAqY29ubiwgREJ1c01lc3NhZ2UgKm1zZywKIAlpZiAocHJl
cF9hdXRob3JpemUpCiAJCXJldHVybiBnX2RidXNfY3JlYXRlX3JlcGx5KG1zZywgREJVU19UWVBF
X0lOVkFMSUQpOwogCisgICAgaWYgKG9mZnNldCA+PSAoY2hyYy0+bWF4X3ZhbF9sZW4pKQorICAg
ICAgICByZXR1cm4gZ19kYnVzX2NyZWF0ZV9lcnJvcihtc2csCisJCQkJIm9yZy5ibHVlei5FcnJv
ci5JbnZhbGlkT2Zmc2V0IiwgTlVMTCk7CisKIAlpZiAod3JpdGVfdmFsdWUoJmNocmMtPnZhbHVl
X2xlbiwgJmNocmMtPnZhbHVlLCB2YWx1ZSwgdmFsdWVfbGVuLAogCQkJCQkJb2Zmc2V0LCBjaHJj
LT5tYXhfdmFsX2xlbikpCiAJCXJldHVybiBnX2RidXNfY3JlYXRlX2Vycm9yKG1zZywKLS0gCjIu
Ny40Cgo=

--_003_eb4ab11691754213884ff0891780176fbshgcom_--
