Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ACBC2BA19
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 10:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4902A2063A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 10:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bshg.com header.i=@bshg.com header.b="NQDUVc7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgDFKHP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 06:07:15 -0400
Received: from de-deferred2.bosch-org.com ([139.15.180.217]:50520 "EHLO
        de-deferred2.bosch-org.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726856AbgDFKHP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 06:07:15 -0400
X-Greylist: delayed 496 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Apr 2020 06:07:11 EDT
Received: from de-out1.bosch-org.com (unknown [139.15.180.215])
        by fe0vms0193.rbdmz01.com (Postfix) with ESMTPS id 48wmG61cdCz3sw
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2020 11:58:54 +0200 (CEST)
Received: from fe0vm1650.rbesz01.com (unknown [139.15.230.188])
        by fe0vms0187.rbdmz01.com (Postfix) with ESMTPS id 48wmG50ylGz1XLDR7;
        Mon,  6 Apr 2020 11:58:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bshg.com;
        s=key3-intmail; t=1586167133;
        bh=tF3Iaog7iytoGaxAknjdxA+N7vcyg4dkRoAgB/KBIfc=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=NQDUVc7xpOUkJcBqTaT57TxvVMmv/AbFGzZBmKWS5FHaqqI5kJ6dLongiJd4ktMzc
         Y/l68WkCXUXaulf2GYc621fK5t7jvwXkNjpTT1rJngozXKRf5GQbiKQKaG9xlhkoOx
         gP9txHGwGf5SO1RHwNF+D9NF8x6WZKoQKNZ9149c=
Received: from si0vm2083.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1650.rbesz01.com (Postfix) with ESMTPS id 48wmG50dzCz1Cv;
        Mon,  6 Apr 2020 11:58:53 +0200 (CEST)
X-AuditID: 0a3aad17-dbbff70000002f83-38-5e8afd5c1d90
Received: from fe0vm1651.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by si0vm2083.rbesz01.com (SMG Outbound) with SMTP id 30.19.12163.C5DFA8E5; Mon,  6 Apr 2020 11:58:52 +0200 (CEST)
Received: from SI0SWIEXHC01.bsh.corp.bshg.com (si0swiexhc01.bsh.corp.bshg.com [10.49.76.137])
        by fe0vm1651.rbesz01.com (Postfix) with ESMTPS id 48wmG463xvzvl2;
        Mon,  6 Apr 2020 11:58:52 +0200 (CEST)
Received: from SI0SWIEXMB4A.bsh.corp.bshg.com (10.49.76.135) by
 SI0SWIEXHC01.bsh.corp.bshg.com (10.49.76.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 6 Apr 2020 11:58:52 +0200
Received: from SI0SWIEXMB4B.bsh.corp.bshg.com (10.49.76.136) by
 SI0SWIEXMB4A.bsh.corp.bshg.com (10.49.76.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1913.5; Mon, 6 Apr 2020 11:58:52 +0200
Received: from SI0SWIEXMB4B.bsh.corp.bshg.com ([fe80::69c4:2636:172d:d682]) by
 SI0SWIEXMB4B.bsh.corp.bshg.com ([fe80::69c4:2636:172d:d682%6]) with mapi id
 15.01.1913.010; Mon, 6 Apr 2020 11:58:52 +0200
From:   "Schachschal, Maximilian (GED-SDD2)" 
        <Maximilian.Schachschal@bshg.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "Klein, Thorsten (BSH)" <kleinkastel@googlemail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH BlueZ] ManufacturerData field added to ScanResponse
Thread-Topic: [PATCH BlueZ] ManufacturerData field added to ScanResponse
Thread-Index: AQHWCYsUqipTvfs5XUKhwcpS7AIZe6hnzLqAgAQRMrA=
Date:   Mon, 6 Apr 2020 09:58:52 +0000
Message-ID: <93524ce444664fcebf6fcdc51ac0416f@bshg.com>
References: <1585899591-14623-1-git-send-email-thorsten.klein@bshg.com>
 <1585899591-14623-2-git-send-email-thorsten.klein@bshg.com>
 <CABBYNZLOjT7bp=M+P1QDLh2pAB0rBwjnbG5zvfaVKh_ZqQkMkQ@mail.gmail.com>
In-Reply-To: <CABBYNZLOjT7bp=M+P1QDLh2pAB0rBwjnbG5zvfaVKh_ZqQkMkQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.49.87.32]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: fd782ad6-06f5-4690-bfdd-57c58a3839e9
X-Brightmail-Tracker: H4sIAAAAAAAAA22Tf1CTdRzH990zxsOOBx4Gcx82wWPmFVzyM09Ay9AOuMs/suOqMySGPMEO
        2GgDQpAEDJHxIzx+tmAQjAjRE6F0I4uaiMFhhpUgzoUphfwQEBYliD1jQ/ZH/3zu+3l/Pq/P
        r+ceHOMO4AJcIk2j5FJxsojNYXFCz3psj36ijPGf/zok+NK3ZSi47mYZFjy+UGn3KhapU92x
        jxwvr7CPXOj0fAM7yNkdTyVLMii53yuxnMT5n40o9Y/QzOrJaygXNYYokQMO5EugfqRhKxEH
        55K1TJj6ZAFZnAEEDY9u2FmcPCY80d5mWZwVBKvnaq3ONQTj50vtzcXY5H6Y661ae7uREjhz
        5SmdhOMYGQEjD7lm2ZV+6vIW2ZaUSGgpGLKmh0LzZ1rM/GaRz0Hdw1V7M0qQO6GgwzreIILh
        8WamOceBPACP2xrW6iDSAzo6rq+xGMmHzj+X7Cy7kaC5ZNGB5MGDe6tWfQsMGkfZltG84Vy3
        nwX1gsriu2vjEKQL9H96n2VJ3wWtXWOoHLmrbDqoNmiVDa2yoRsR6zTiKST+GSmB/sFBvvI4
        SpHlH+B7WJbSiSxfk69FT0/O+eoRE0d6tANninhE1YQyhusUJ4s/kihWJL4nT0+mFCIBcWy6
        6BDX9ZmsSI9LkSgUEplUjwDHRG6EoLQohkvEi49kUXKZBdMjIc4S8QkeJzuGSyaI06gkikql
        5OvRXTguAkK7TDd0kVMJVOb7kuS09bDIg0AMBoO7yTZi25aJO+hREO5I91Y8pksQilRxikKS
        YMXdLTh3Xd1AB5AYL39Q34ThP1xR07Zvzf51VkPb3voW2uYa7zRhXJZUJqUEfKLSXJ0010lM
        lz6bT7CZeOsCvTLPJrDRYxINIxyJXIlj5u0c6b9oYzIgcs3HdLGKG1BgM82QPQQYZ4Vg7Hsb
        /u0ZQ6DWmhDoevVM0JxqZYFhqMkOJhaX7OBGt8oeDOe/48CIspcDui9/5cDE4I+OoB6pI6Ck
        dNUJRr4/7grLpkJXWFnocoP2+1080PboeGBcHOVBbZlpE6w09Auh4jfjZjCcMnmAWp/nCbWm
        bzxhtfKuJ3RU5XuBYbbQC87U3PYCtUG3dZI+OpM+OltaaD56mjjtf45uVTd2E+Qyb7GmTrbz
        GuuPVofPJ3mm95UF7lveum2HnziivX48bqb6g8F/xNGc8EwfrxpXzUzQ8di/vxrBlC4f1Rg4
        0z+1Nnu1OPd5zxqod+GA+4da7l4fp5cTPtY2UQPCi4c0SYHzvzPuNbnvCTn8QrT7mylqGbtv
        b6pjw/aV2MsX/U887xym2pO+b7EgJ6ei4OpB5y2Xr3tLctqKsndywnRazyjtUHnb/ndkzqZg
        qtDJ6Ovj3z3Wf7WlsTgjf+Zm7WjUFwHdJaX43LDy82xgnB5lZO2T/zKFlwijMOWcn1CzFB52
        QpW7O8ZQ8dqLr98KPcq4MD27LYVfHVG34Mgvzg9NCxc49WRjIpYiURzgg8kV4v8ADlo2QF0F
        AAA=
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KPiBEb24ndCByZWFsbHkgbGlrZSB0byBkbyB0aGlzLCBiZXNpZGUgaXQgc2Vl
bXMgdG8gYmUgb3B0aW9uYWwgdG8gZW50ZXIgZWl0aGVyIG9uIEFEIG9yIG9uIFNSRCBzbyB0aGUg
c2Nhbm5lciBpcyByZWFsbHkgYXQgZmF1bHQgaGVyZSBpZiBpdCBvbmx5IGFibGUgdG8gcGFyc2Ug
dGhlIGRhdGEgaWYgcGxhY2VkIG9uIFNSRCwgdGhhdCBzYWlkIHdlIGNvdWxkIGhhdmUgc29tZSBs
b2dpYyB0aGF0IGRldGVjdHMgaWYgbWFudWZhY3R1cmVyIGRvbid0IGZpdCBvbiB0aGUgQUQgcHVz
aCBpdCB0byBTUkQgaWYgdGhhdCBoYXMgbW9yZSBzcGFjZSBpZiB0aGUgYWR2ZXJ0aXNlbWVudCBp
cyBkaXNjb3ZlcmFibGUuDQoNCkkgYWdyZWUgb24gdGhhdCwgdGhhdCBtYXkgYmUgdGhlIGJlc3Qg
c29sdXRpb24uDQpXZSBhbHJlYWR5IHRob3VnaHQgYWJvdXQgdGhhdC4gSG93ZXZlciBpdCBsb29r
ZWQgbGlrZSBzb21lIG1ham9yIGNoYW5nZXMgaW4gc2hhcmVkIHBhcnQgd291bGQgYmUgbmVjZXNz
YXJ5IGZvciB0aGF0IGFuZCB3ZSBkaWRuJ3Qgd2FudCB0byBjaGFuZ2UgdG9vIG11Y2ggaGVyZS4N
ClNvIHRoaXMgd2FzIHRoZSBlYXNpZXN0IChhbHRob3VnaCBsaXR0bGUgZGlydHkpIHNvbHV0aW9u
IGZvciB1cyB0byBzdGFydCB3aXRoLiBXZSB3YW50ZWQgdG8gc2hhcmUgaXQgaGVyZSBhbmQgc3Rh
cnQgZGlzY3Vzc2lvbiBvbiB0aGF0Lg0KV2hhdCBuZWVkcyB0byBiZSBjb25zaWRlcmVkIGZvciBj
aGFuZ2VzIHRvIHNoYXJlZCBwYXJ0Pw0KDQpCUg0KTWF4DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNv
bT4gDQpTZW50OiBGcmlkYXksIEFwcmlsIDMsIDIwMjAgMTE6NDIgUE0NClRvOiBLbGVpbiwgVGhv
cnN0ZW4gKEJTSCkgPGtsZWlua2FzdGVsQGdvb2dsZW1haWwuY29tPg0KQ2M6IGxpbnV4LWJsdWV0
b290aEB2Z2VyLmtlcm5lbC5vcmc7IFNjaGFjaHNjaGFsLCBNYXhpbWlsaWFuIChHRUQtU0REMikg
PE1heGltaWxpYW4uU2NoYWNoc2NoYWxAYnNoZy5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIEJs
dWVaXSBNYW51ZmFjdHVyZXJEYXRhIGZpZWxkIGFkZGVkIHRvIFNjYW5SZXNwb25zZQ0KDQpIaSBU
aG9yc3RlbiwNCg0KT24gRnJpLCBBcHIgMywgMjAyMCBhdCAxMjo0MiBBTSBLbGVpbiwgVGhvcnN0
ZW4gKEJTSCkgPGtsZWlua2FzdGVsQGdvb2dsZW1haWwuY29tPiB3cm90ZToNCj4NCj4gRnJvbTog
IlNjaGFjaHNjaGFsLCBNYXhpbWlsaWFuIChCU0gpIiANCj4gPG1heGltaWxpYW4uc2NoYWNoc2No
YWxAYnNoZy5jb20+DQo+DQo+IEtleXMgYXJlIHRoZSBNYW51ZmFjdHVyZXIgSUQgdG8gYXNzb2Np
YXRlIHdpdGggdGhlIGRhdGEuDQo+IC0tLQ0KPiAgZG9jL2FkdmVydGlzaW5nLWFwaS50eHQgfCAg
NiArKysrKysNCj4gIHNyYy9hZHZlcnRpc2luZy5jICAgICAgIHwgMjUgKysrKysrKysrKysrKysr
KysrKy0tLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCA2IGRlbGV0
aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZG9jL2FkdmVydGlzaW5nLWFwaS50eHQgYi9kb2Mv
YWR2ZXJ0aXNpbmctYXBpLnR4dCBpbmRleCANCj4gYjA1NjVlYS4uMTRjY2FlMiAxMDA2NDQNCj4g
LS0tIGEvZG9jL2FkdmVydGlzaW5nLWFwaS50eHQNCj4gKysrIGIvZG9jL2FkdmVydGlzaW5nLWFw
aS50eHQNCj4gQEAgLTUxLDYgKzUxLDEyIEBAIFByb3BlcnRpZXMgICBzdHJpbmcgVHlwZQ0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICB0aGUgQWR2ZXJ0aXNpbmcgRGF0YS4gIEtleXMgYXJlIHRo
ZSBNYW51ZmFjdHVyZXIgSUQNCj4gICAgICAgICAgICAgICAgICAgICAgICAgdG8gYXNzb2NpYXRl
IHdpdGggdGhlIGRhdGEuDQo+DQo+ICsgICAgICAgICAgICAgICBkaWN0IE1hbnVmYWN0dXJlckRh
dGFTY2FuUmVzcG9uc2UgW0V4cGVyaW1lbnRhbF0NCj4gKw0KPiArICAgICAgICAgICAgICAgICAg
ICAgICBNYW51ZmFjdHVlciBEYXRhIGZpZWxkcyB0byBpbmNsdWRlIGluDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIHRoZSBTY2FuIFJlc3BvbnNlLiAgS2V5cyBhcmUgdGhlIE1hbnVmYWN0dXJl
ciBJRA0KPiArICAgICAgICAgICAgICAgICAgICAgICB0byBhc3NvY2lhdGUgd2l0aCB0aGUgZGF0
YS4NCj4gKw0KDQpEb24ndCByZWFsbHkgbGlrZSB0byBkbyB0aGlzLCBiZXNpZGUgaXQgc2VlbXMg
dG8gYmUgb3B0aW9uYWwgdG8gZW50ZXIgZWl0aGVyIG9uIEFEIG9yIG9uIFNSRCBzbyB0aGUgc2Nh
bm5lciBpcyByZWFsbHkgYXQgZmF1bHQgaGVyZSBpZiBpdCBvbmx5IGFibGUgdG8gcGFyc2UgdGhl
IGRhdGEgaWYgcGxhY2VkIG9uIFNSRCwgdGhhdCBzYWlkIHdlIGNvdWxkIGhhdmUgc29tZSBsb2dp
YyB0aGF0IGRldGVjdHMgaWYgbWFudWZhY3R1cmVyIGRvbid0IGZpdCBvbiB0aGUgQUQgcHVzaCBp
dCB0byBTUkQgaWYgdGhhdCBoYXMgbW9yZSBzcGFjZSBpZiB0aGUgYWR2ZXJ0aXNlbWVudCBpcyBk
aXNjb3ZlcmFibGUuDQoNCj4gICAgICAgICAgICAgICAgIGFycmF5e3N0cmluZ30gU29saWNpdFVV
SURzDQo+DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEFycmF5IG9mIFVVSURzIHRvIGluY2x1
ZGUgaW4gIlNlcnZpY2UgU29saWNpdGF0aW9uIg0KPiBkaWZmIC0tZ2l0IGEvc3JjL2FkdmVydGlz
aW5nLmMgYi9zcmMvYWR2ZXJ0aXNpbmcuYyBpbmRleCANCj4gNDVmZjE5Zi4uMGUxYTNmMSAxMDA2
NDQNCj4gLS0tIGEvc3JjL2FkdmVydGlzaW5nLmMNCj4gKysrIGIvc3JjL2FkdmVydGlzaW5nLmMN
Cj4gQEAgLTMyOCwxMiArMzI4LDEyIEBAIGZhaWw6DQo+ICB9DQo+DQo+ICBzdGF0aWMgYm9vbCBw
YXJzZV9tYW51ZmFjdHVyZXJfZGF0YShEQnVzTWVzc2FnZUl0ZXIgKml0ZXIsDQo+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgYnRkX2Fkdl9jbGllbnQgKmNs
aWVudCkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBi
dGRfYWQgKmFkKQ0KPiAgew0KPiAgICAgICAgIERCdXNNZXNzYWdlSXRlciBlbnRyaWVzOw0KPg0K
PiAgICAgICAgIGlmICghaXRlcikgew0KPiAtICAgICAgICAgICAgICAgYnRfYWRfY2xlYXJfbWFu
dWZhY3R1cmVyX2RhdGEoY2xpZW50LT5kYXRhKTsNCj4gKyAgICAgICAgICAgICAgIGJ0X2FkX2Ns
ZWFyX21hbnVmYWN0dXJlcl9kYXRhKGFkKTsNCj4gICAgICAgICAgICAgICAgIHJldHVybiB0cnVl
Ow0KPiAgICAgICAgIH0NCj4NCj4gQEAgLTM0Miw3ICszNDIsNyBAQCBzdGF0aWMgYm9vbCANCj4g
cGFyc2VfbWFudWZhY3R1cmVyX2RhdGEoREJ1c01lc3NhZ2VJdGVyICppdGVyLA0KPg0KPiAgICAg
ICAgIGRidXNfbWVzc2FnZV9pdGVyX3JlY3Vyc2UoaXRlciwgJmVudHJpZXMpOw0KPg0KPiAtICAg
ICAgIGJ0X2FkX2NsZWFyX21hbnVmYWN0dXJlcl9kYXRhKGNsaWVudC0+ZGF0YSk7DQo+ICsgICAg
ICAgYnRfYWRfY2xlYXJfbWFudWZhY3R1cmVyX2RhdGEoYWQpOw0KPg0KPiAgICAgICAgIHdoaWxl
IChkYnVzX21lc3NhZ2VfaXRlcl9nZXRfYXJnX3R5cGUoJmVudHJpZXMpDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID09IA0KPiBEQlVTX1RZUEVfRElD
VF9FTlRSWSkgeyBAQCAtMzczLDcgKzM3Myw3IEBAIHN0YXRpYyBib29sIA0KPiBwYXJzZV9tYW51
ZmFjdHVyZXJfZGF0YShEQnVzTWVzc2FnZUl0ZXIgKml0ZXIsDQo+DQo+ICAgICAgICAgICAgICAg
ICBEQkcoIkFkZGluZyBNYW51ZmFjdHVyZXJEYXRhIGZvciAlMDR4IiwgbWFudWZfaWQpOw0KPg0K
PiAtICAgICAgICAgICAgICAgaWYgKCFidF9hZF9hZGRfbWFudWZhY3R1cmVyX2RhdGEoY2xpZW50
LT5kYXRhLCBtYW51Zl9pZCwNCj4gKyAgICAgICAgICAgICAgIGlmICghYnRfYWRfYWRkX21hbnVm
YWN0dXJlcl9kYXRhKGFkLCBtYW51Zl9pZCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtYW51Zl9kYXRhLCBsZW4pKQ0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICBnb3RvIGZhaWw7DQo+DQo+IEBAIC0zODMsMTAgKzM4MywyMiBAQCBz
dGF0aWMgYm9vbCBwYXJzZV9tYW51ZmFjdHVyZXJfZGF0YShEQnVzTWVzc2FnZUl0ZXIgKml0ZXIs
DQo+ICAgICAgICAgcmV0dXJuIHRydWU7DQo+DQo+ICBmYWlsOg0KPiAtICAgICAgIGJ0X2FkX2Ns
ZWFyX21hbnVmYWN0dXJlcl9kYXRhKGNsaWVudC0+ZGF0YSk7DQo+ICsgICAgICAgYnRfYWRfY2xl
YXJfbWFudWZhY3R1cmVyX2RhdGEoYWQpOw0KPiAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gIH0N
Cj4NCj4gK3N0YXRpYyBib29sIHBhcnNlX21hbnVmYWN0dXJlcl9kYXRhX2FkdihEQnVzTWVzc2Fn
ZUl0ZXIgKml0ZXIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
dHJ1Y3QgYnRkX2Fkdl9jbGllbnQgKmNsaWVudCkgDQo+ICt7DQo+ICsgICAgICAgcmV0dXJuIHBh
cnNlX21hbnVmYWN0dXJlcl9kYXRhKGl0ZXIsIGNsaWVudC0+ZGF0YSk7IH0NCj4gKw0KPiArc3Rh
dGljIGJvb2wgcGFyc2VfbWFudWZhY3R1cmVyX2RhdGFfc2NhbihEQnVzTWVzc2FnZUl0ZXIgKml0
ZXIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgYnRk
X2Fkdl9jbGllbnQgKmNsaWVudCkgDQo+ICt7DQo+ICsgICAgICAgcmV0dXJuIHBhcnNlX21hbnVm
YWN0dXJlcl9kYXRhKGl0ZXIsIGNsaWVudC0+c2Nhbik7IH0NCj4gKw0KPiAgc3RhdGljIGJvb2wg
cGFyc2Vfc2VydmljZV9kYXRhKERCdXNNZXNzYWdlSXRlciAqaXRlciwNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBidGRfYWR2X2NsaWVudCAqY2xpZW50
KSAgDQo+IHsgQEAgLTk0MSw3ICs5NTMsOCBAQCBzdGF0aWMgc3RydWN0IGFkdl9wYXJzZXIgew0K
PiAgICAgICAgIHsgIlR5cGUiLCBwYXJzZV90eXBlIH0sDQo+ICAgICAgICAgeyAiU2VydmljZVVV
SURzIiwgcGFyc2Vfc2VydmljZV91dWlkcyB9LA0KPiAgICAgICAgIHsgIlNvbGljaXRVVUlEcyIs
IHBhcnNlX3NvbGljaXRfdXVpZHMgfSwNCj4gLSAgICAgICB7ICJNYW51ZmFjdHVyZXJEYXRhIiwg
cGFyc2VfbWFudWZhY3R1cmVyX2RhdGEgfSwNCj4gKyAgICAgICB7ICJNYW51ZmFjdHVyZXJEYXRh
IiwgcGFyc2VfbWFudWZhY3R1cmVyX2RhdGFfYWR2IH0sDQo+ICsgICAgICAgeyAiTWFudWZhY3R1
cmVyRGF0YVNjYW5SZXNwb25zZSIsIHBhcnNlX21hbnVmYWN0dXJlcl9kYXRhX3NjYW4gDQo+ICsg
fSwNCj4gICAgICAgICB7ICJTZXJ2aWNlRGF0YSIsIHBhcnNlX3NlcnZpY2VfZGF0YSB9LA0KPiAg
ICAgICAgIHsgIkluY2x1ZGVzIiwgcGFyc2VfaW5jbHVkZXMgfSwNCj4gICAgICAgICB7ICJMb2Nh
bE5hbWUiLCBwYXJzZV9sb2NhbF9uYW1lIH0sDQo+IC0tDQo+IDIuNy40DQo+DQoNCg0KLS0NCkx1
aXogQXVndXN0byB2b24gRGVudHoNCg==
