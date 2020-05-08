Return-Path: <SRS0=6WQ0=6W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A914EC38A2A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 May 2020 07:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58ADD206B8
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 May 2020 07:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bshg.com header.i=@bshg.com header.b="Q7FRLMEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgEHH7I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 May 2020 03:59:08 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:45324 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgEHH7H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 May 2020 03:59:07 -0400
Received: from fe0vm1650.rbesz01.com (unknown [139.15.230.188])
        by fe0vms0187.rbdmz01.com (Postfix) with ESMTPS id 49JN525MDPz1XLDR8;
        Fri,  8 May 2020 09:59:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bshg.com;
        s=key3-intmail; t=1588924742;
        bh=tF3Iaog7iytoGaxAknjdxA+N7vcyg4dkRoAgB/KBIfc=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=Q7FRLMEnlo0fRNcMjyXMUldZ17mjcNNBfxsyKk7x/NFyD33/SjN8oOTnHEKQbhH9b
         a5onAaBXr7cRagXdu/obA0uTAehulQICqBbtvDpjPafMcnNxfbwgM+e6d1xVNx7s86
         1Oi5sincLplt3O2rdSleZOTEUoomoP8tDy4B10X4=
Received: from si0vm02576.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1650.rbesz01.com (Postfix) with ESMTPS id 49JN5256Z5z1WV;
        Fri,  8 May 2020 09:59:02 +0200 (CEST)
X-AuditID: 0a3aad0d-b3fff70000005eae-69-5eb511461950
Received: from fe0vm1651.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by si0vm02576.rbesz01.com (SMG Outbound) with SMTP id F2.18.24238.64115BE5; Fri,  8 May 2020 09:59:02 +0200 (CEST)
Received: from SI0SWIEXHC01.bsh.corp.bshg.com (si0swiexhc01.bsh.corp.bshg.com [10.49.76.137])
        by fe0vm1651.rbesz01.com (Postfix) with ESMTPS id 49JN521G7Dzvl0;
        Fri,  8 May 2020 09:59:02 +0200 (CEST)
Received: from SI0SWIEXMB2A.bsh.corp.bshg.com (10.49.76.131) by
 SI0SWIEXHC01.bsh.corp.bshg.com (10.49.76.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 8 May 2020 09:59:01 +0200
Received: from SI0SWIEXMB2B.bsh.corp.bshg.com (10.49.76.132) by
 SI0SWIEXMB2A.bsh.corp.bshg.com (10.49.76.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1913.5; Fri, 8 May 2020 09:59:01 +0200
Received: from SI0SWIEXMB2B.bsh.corp.bshg.com ([fe80::5154:c3ab:d4e0:8272]) by
 SI0SWIEXMB2B.bsh.corp.bshg.com ([fe80::5154:c3ab:d4e0:8272%5]) with mapi id
 15.01.1913.010; Fri, 8 May 2020 09:59:01 +0200
From:   "Ryll, Jan (GED-SDD2)" <Jan.Ryll@bshg.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "Karim, Hafiz Abdul" <HafizAbdul_Karim@mentor.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Incorrect advertise flags in bluetooth beacon using BlueZ
Thread-Topic: Incorrect advertise flags in bluetooth beacon using BlueZ
Thread-Index: AQHWJFl8xZEjmBN2EUOuRCCmrHEgo6ic8LWAgADiF6A=
Date:   Fri, 8 May 2020 07:59:01 +0000
Message-ID: <dfb4035a86d24ffdb80b1c5b3eb52896@bshg.com>
References: <1588847119436.26848@mentor.com>
 <CABBYNZ+a3Br71ExTi1XUa7UnDry2dNBaomz-+z7sVtVH_5toCQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+a3Br71ExTi1XUa7UnDry2dNBaomz-+z7sVtVH_5toCQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.49.87.14]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: fd782ad6-06f5-4690-bfdd-57c58a3839e9
X-Brightmail-Tracker: H4sIAAAAAAAAA22Te1BUdRTH+d27LHe3vXC5vA4UOG3UTKSADx4CNqCGTOOMRDg5WhtLXGFz
        WWgXGFSoFTJxDYSFCFcEJMQHGchLHpW6LCSCgwqsOMAGRSRI5oCgOULdZRfhj/45c37fcz7n
        decSOH2VcCEksiRGLhNLhVw+hx9w0XVNqG2DyLsql/L/2tCC+xfrc3D/P2YKLIPxsGbNsFVY
        62wGCpupdQvHd/ODYhipJIWRe70dxY/LMui5iQNbUi/1K3ElehqiQjwCqA3w+HSXlQrxCZo6
        gcHdcZ2l6XEDQUPRN+bIIQxGlWO46fEcgWG20fy4ieDk/GWOsRiX8ga9agg3+vZULNzprWNr
        EQRObYOBh7RRtqNCIa+jETOlbIOeuWfm9ADI0YxyjT6HcodSfcciSlJ+cL6NZ5RpSgGZygeL
        6TzqPVBWzix2RZQr1NT0LOo45QS1408sTatRUPGjSQfKASZ+XzDrq6D0bB0yTfYmVLd4mdBX
        oeDYqJXRJylb6DwxxjGlB8LZuhGUi5w1KzpolmnNClqzgi5DnAvIUSHxTon3Xufj5+spj2YU
        B7zXen6SEF+LTF+TbELNqkeeWoQRSIt8CEzoQG4w1Ito6+iEmP1xYkXcx/JkKaMQupBfTB39
        iLZ7ISuSo+MlCoUkQaZFQOBCezIvleXIGPH+A4w8wYRp0csER+hEugsuiWgqVpzE7GOYREa+
        FA0kCCGQt2waRLStnIllUvdKpElLYaEriSwsLGjHlZGVbTGCp0XrCQHbu9eaLUEqEsXxCkms
        GXc24fSSuozeQDuJ3IlT5TjR3F7C2muLVnfqTDlOc2QJMsbFidxurEgZ2bhk2YuZXF4hnXew
        uzisCCzXnUT3EIGEdmS3cSMB++csTwOk0nhAW7O4DK07wzLUSWdQ/12KwT9HbmFQX3Ubg/sj
        d1nTMYRDSfEhDqg72zhQPTbBgYGpTC58+aSQC/dKDFwYKPuTC+pZ1uSoKvgwoNLxoW+u9CU4
        d75aAP+2XhZAU3EmCd3PVSTUqXUk5A9ft4aW1m9toKb/Owo0x3+m4EpzNg2zD7U0ZGn7WC+j
        n4bOxxM03H/aZQeG/Az7SfbUGHvqmela46mTxEn/c2qzurydixIL4aVPB6Svbl3ou1n1GRGs
        j9BtrazGchMjg7PjD3/A/d7xV49HvnMHr2U2rbF3ZwoTi/YMX9h91fWvNEvRTzbdB6t/EWt4
        USJpROPFyZ0BeYVp232OEM82NZW75d7OiNG9ltOkQerkDhiMaNqR5hHSW711VVCK7t2eOT/f
        6cr2zsTN4V9R9esFb3nlFxRtiUzxcsxe7V4ieN1xfuOVO717p7z155i4rHcC3TKyBy2L36/o
        bK3ktTNRh9M37dJv/lTNcy44PbTHxv03adQ+0YepG4/NXF9oN5ChI9rKz5uDxnt+KMNDBwNx
        ny7SOdJOGvxgPqNYPDj9xvGjw1Ntu8IbA6ocLIQcRZx4rQcuV4j/A+Hz5oJTBQAA
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0Kd2hhdCBJIHVuZGVyc3Rvb2QgaXMgdGhhdCBhdCBmaXJzdCBzdGFydCBvZiBi
bHVleiBibHVldG9vdGggc2VydmljZSB0aGUgYWR2ZXJ0aXNlbWVudCBmbGFncyBmb3IgIm1vZGUi
IGFyZSBub3Qgc2V0IHRvIHRoZSBjb3JyZWN0IHZhbHVlLCBhcyBkZWZpbmVkIChDb250cm9sbGVy
TW9kZSA9IGxlKSBpbiBtYWluLmNvbmYuDQpJZiB5b3Ugc3RhcnQgdGhlIHNlcnZpY2UgYSBzZWNv
bmQgdGltZSB0aGlzIGZsYWcgaXMgY29ycmVjdC4gRm9yIHRoZSBmaXJzdCB0aW1lIGl0IGlzIGFs
d2F5cyB3cm9uZy4NClRoaXMgaXMgdGhlIHNhbWUgd2UgZGlkIHNlZSBoZXJlIHdpdGggb3VyIGVx
dWlwbWVudC4NCg0KUmVnYXJkcw0KSmFuDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IGxpbnV4LWJsdWV0b290aC1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWJsdWV0
b290aC1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFsZiBPZiBMdWl6IEF1Z3VzdG8gdm9u
IERlbnR6DQpTZW50OiBUaHVyc2RheSwgTWF5IDcsIDIwMjAgMTA6MjQgUE0NClRvOiBLYXJpbSwg
SGFmaXogQWJkdWwgPEhhZml6QWJkdWxfS2FyaW1AbWVudG9yLmNvbT4NCkNjOiBsaW51eC1ibHVl
dG9vdGhAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogSW5jb3JyZWN0IGFkdmVydGlzZSBm
bGFncyBpbiBibHVldG9vdGggYmVhY29uIHVzaW5nIEJsdWVaDQoNCkhpIEhhZml6IEFiZHVsLA0K
DQoNCk9uIFRodSwgTWF5IDcsIDIwMjAgYXQgMzozNiBBTSBLYXJpbSwgSGFmaXogQWJkdWwgPEhh
Zml6QWJkdWxfS2FyaW1AbWVudG9yLmNvbT4gd3JvdGU6DQo+DQo+DQo+IFVzaW5nIG5SRiBDb25u
ZWN0IGFuZHJvaWQgYXBwbGljYXRpb24sIEknbSBnZXR0aW5nIGluY29ycmVjdCBhZHZlcnRpc2Ug
DQo+IGZsYWdzIGluIGJsdWV0b290aCBiZWFjb24gdXNpbmcgQmx1ZVogSSBoYXZlIHRyaWVkIG9u
IHR3byBibHVleiB2ZXJzaW9ucyBpLmUgNS40OCBhbmQgNS41Mi4NCj4NCj4gSSBoYXZlIHNldCBD
b250cm9sbGVyTW9kZSB0byAibGUiIGluIG1haW4uY29uZi4gVXNpbmcgYmx1ZXRvb3RjdGwsIHdo
ZW4gSSB0dXJuIG9uIHRoZSBhZHZlcnRpc2VtZW50IHVzaW5nIGNvbW1hbmQgImFkdmVydGlzZSBv
biIsIEkgZ2V0IDB4MDIgYWR2ZXJ0aXNlbWVudCBmbGFnLiBXaGljaCBtZWFucyAiQlIvRURSIE5v
dCBTdXBwb3J0ZWQiIChCaXQgMikgaXMgbm90IHNldC4NCj4gTm93LCBpZiBpIHJlc3RhcnQgdGhl
IGJsdWV0b290aCBzZXJ2aWNlLCBhbmQgdHVybiBvbiB0aGUgYWR2ZXJ0aXNlbWVudCBhZ2Fpbiwg
SSBnZXQgMHgwNiBhZHZlcnRpc2VtZW50IGZsYWdzLg0KDQpBcmUgeW91IHNheWluZyB3ZSBhcmUg
bm90IHVwZGF0aW5nIHRoZSBzZXJ2aWNlIG9uY2UgbWFpbi5jb25mIGhhcyBjaGFuZ2VkPyBXZSBk
b24ndCBkbyB0aGF0IGF1dG9tYXRpY2FsbHkgaWYgdGhhdCBpcyB3aGF0IHlvdSBhcmUgcmVmZXJy
aW5nIHRvLCBhbHNvIGlmIHlvdSB3YW50IHRvIGFkdmVydGlzZSBhcyBhIGJlYWNvbi9icm9hZGNh
c3RlciBhbmQgbm90IGFzIHBlcmlwaGVyYWwgdGhlYW4gdXMgeW91IHNob3VsZCB1c2UgYWR2ZXJ0
aXNlIGJyb2FkY2FzdC4NCg0KPiBIZXJlIGlzIG15IG1haW4uY29uZg0KPg0KPiBbR2VuZXJhbF0j
IERlZmF1bHQgYWRhcGVyIG5hbWUNCj4gIyBEZWZhdWx0cyB0byAnQmx1ZVogWC5ZWicNCj4gI05h
bWUgPSBCbHVlWiMgRGVmYXVsdCBkZXZpY2UgY2xhc3MuIE9ubHkgdGhlIG1ham9yIGFuZCBtaW5v
ciBkZXZpY2UgDQo+IGNsYXNzIGJpdHMgYXJlICMgY29uc2lkZXJlZC4gRGVmYXVsdHMgdG8gJzB4
MDAwMDAwJy4NCj4gQ2xhc3MgPSAweDAwMDEwMCMgSG93IGxvbmcgdG8gc3RheSBpbiBkaXNjb3Zl
cmFibGUgbW9kZSBiZWZvcmUgZ29pbmcgDQo+IGJhY2sgdG8gbm9uLWRpc2NvdmVyYWJsZSAjIFRo
ZSB2YWx1ZSBpcyBpbiBzZWNvbmRzLiBEZWZhdWx0IGlzIDE4MCwgaS5lLiAzIG1pbnV0ZXMuDQo+
ICMgMCA9IGRpc2FibGUgdGltZXIsIGkuZS4gc3RheSBkaXNjb3ZlcmFibGUgZm9yZXZlciANCj4g
RGlzY292ZXJhYmxlVGltZW91dCA9IDAjIEhvdyBsb25nIHRvIHN0YXkgaW4gcGFpcmFibGUgbW9k
ZSBiZWZvcmUgDQo+IGdvaW5nIGJhY2sgdG8gbm9uLWRpc2NvdmVyYWJsZSAjIFRoZSB2YWx1ZSBp
cyBpbiBzZWNvbmRzLiBEZWZhdWx0IGlzIDAuDQo+ICMgMCA9IGRpc2FibGUgdGltZXIsIGkuZS4g
c3RheSBwYWlyYWJsZSBmb3JldmVyICNQYWlyYWJsZVRpbWVvdXQgPSAwIyANCj4gQXV0b21hdGlj
IGNvbm5lY3Rpb24gZm9yIGJvbmRlZCBkZXZpY2VzIGRyaXZlbiBieSBwbGF0Zm9ybS91c2VyIGV2
ZW50cy4NCj4gIyBJZiBhIHBsYXRmb3JtIHBsdWdpbiB1c2VzIHRoaXMgbWVjaGFuaXNtLCBhdXRv
bWF0aWMgY29ubmVjdGlvbnMgd2lsbCANCj4gYmUgIyBlbmFibGVkIGR1cmluZyB0aGUgaW50ZXJ2
YWwgZGVmaW5lZCBiZWxvdy4gSW5pdGlhbGx5LCB0aGlzIA0KPiBmZWF0dXJlICMgaW50ZW5kcyB0
byBiZSB1c2VkIHRvIGVzdGFibGlzaCBjb25uZWN0aW9ucyB0byBBVFQgY2hhbm5lbHMuIERlZmF1
bHQgaXMgNjAuDQo+ICNBdXRvQ29ubmVjdFRpbWVvdXQgPSA2MCMgVXNlIHZlbmRvciBpZCBzb3Vy
Y2UgKGFzc2lnbmVyKSwgdmVuZG9yLCANCj4gcHJvZHVjdCBhbmQgdmVyc2lvbiBpbmZvcm1hdGlv
biBmb3IgIyBESUQgcHJvZmlsZSBzdXBwb3J0LiBUaGUgdmFsdWVzIA0KPiBhcmUgc2VwYXJhdGVk
IGJ5ICI6IiBhbmQgYXNzaWduZXIsIFZJRCwgUElEICMgYW5kIHZlcnNpb24uDQo+ICMgUG9zc2li
bGUgdmVuZG9yIGlkIHNvdXJjZSB2YWx1ZXM6IGJsdWV0b290aCwgdXNiIChkZWZhdWx0cyB0byB1
c2IpIA0KPiAjRGV2aWNlSUQgPSBibHVldG9vdGg6MTIzNDo1Njc4OmFiY2QjIERvIHJldmVyc2Ug
c2VydmljZSBkaXNjb3ZlcnkgZm9yIA0KPiBwcmV2aW91c2x5IHVua25vd24gZGV2aWNlcyB0aGF0
IGNvbm5lY3QgdG8gIyB1cy4gVGhpcyBvcHRpb24gaXMgcmVhbGx5IA0KPiBvbmx5IG5lZWRlZCBm
b3IgcXVhbGlmaWNhdGlvbiBzaW5jZSB0aGUgQklURSB0ZXN0ZXIgIyBkb2Vzbid0IGxpa2UgdXMg
DQo+IGRvaW5nIHJldmVyc2UgU0RQIGZvciBzb21lIHRlc3QgY2FzZXMgKHRob3VnaCB0aGVyZSBj
b3VsZCBpbiAjIHRoZW9yeSBiZSBvdGhlciB1c2VmdWwgcHVycG9zZXMgZm9yIHRoaXMgdG9vKS4g
RGVmYXVsdHMgdG8gJ3RydWUnLg0KPiAjUmV2ZXJzZVNlcnZpY2VEaXNjb3ZlcnkgPSB0cnVlIyBF
bmFibGUgbmFtZSByZXNvbHZpbmcgYWZ0ZXIgaW5xdWlyeS4gDQo+IFNldCBpdCB0byAnZmFsc2Un
IGlmIHlvdSBkb24ndCBuZWVkICMgcmVtb3RlIGRldmljZXMgbmFtZSBhbmQgd2FudCBzaG9ydGVy
IGRpc2NvdmVyeSBjeWNsZS4gRGVmYXVsdHMgdG8gJ3RydWUnLg0KPiAjTmFtZVJlc29sdmluZyA9
IHRydWUjIEVuYWJsZSBydW50aW1lIHBlcnNpc3RlbmN5IG9mIGRlYnVnIGxpbmsga2V5cy4gDQo+
IERlZmF1bHQgaXMgZmFsc2Ugd2hpY2ggIyBtYWtlcyBkZWJ1ZyBsaW5rIGtleXMgdmFsaWQgb25s
eSBmb3IgdGhlIA0KPiBkdXJhdGlvbiBvZiB0aGUgY29ubmVjdGlvbiAjIHRoYXQgdGhleSB3ZXJl
IGNyZWF0ZWQgZm9yLg0KPiAjRGVidWdLZXlzID0gZmFsc2UjIFJlc3RyaWN0cyBhbGwgY29udHJv
bGxlcnMgdG8gdGhlIHNwZWNpZmllZCANCj4gdHJhbnNwb3J0LiBEZWZhdWx0IHZhbHVlICMgaXMg
ImR1YWwiLCBpLmUuIGJvdGggQlIvRURSIGFuZCBMRSBlbmFibGVkICh3aGVuIHN1cHBvcnRlZCBi
eSB0aGUgSFcpLg0KPiAjIFBvc3NpYmxlIHZhbHVlczogImR1YWwiLCAiYnJlZHIiLCAibGUiDQo+
IENvbnRyb2xsZXJNb2RlID0gbGUjIEVuYWJsZXMgTXVsdGkgUHJvZmlsZSBTcGVjaWZpY2F0aW9u
IHN1cHBvcnQuIFRoaXMgDQo+IGFsbG93cyB0byBzcGVjaWZ5IGlmICMgc3lzdGVtIHN1cHBvcnRz
IG9ubHkgTXVsdGlwbGUgUHJvZmlsZXMgU2luZ2xlIA0KPiBEZXZpY2UgKE1QU0QpIGNvbmZpZ3Vy
YXRpb24gIyBvciBib3RoIE11bHRpcGxlIFByb2ZpbGVzIFNpbmdsZSBEZXZpY2UgDQo+IChNUFNE
KSBhbmQgTXVsdGlwbGUgUHJvZmlsZXMgTXVsdGlwbGUgIyBEZXZpY2VzIChNUE1EKSBjb25maWd1
cmF0aW9ucy4NCj4gIyBQb3NzaWJsZSB2YWx1ZXM6ICJvZmYiLCAic2luZ2xlIiwgIm11bHRpcGxl
Ig0KPiAjTXVsdGlQcm9maWxlID0gb2ZmIyBQZXJtYW5lbnRseSBlbmFibGVzIHRoZSBGYXN0IENv
bm5lY3RhYmxlIHNldHRpbmcgDQo+IGZvciBhZGFwdGVycyB0aGF0ICMgc3VwcG9ydCBpdC4gV2hl
biBlbmFibGVkIG90aGVyIGRldmljZXMgY2FuIGNvbm5lY3QgDQo+IGZhc3RlciB0byB1cywgIyBo
b3dldmVyIHRoZSB0cmFkZW9mZiBpcyBpbmNyZWFzZWQgcG93ZXIgY29uc3VtcHRpb25zLiANCj4g
VGhpcyBmZWF0dXJlICMgd2lsbCBmdWxseSB3b3JrIG9ubHkgb24ga2VybmVsIHZlcnNpb24gNC4x
IGFuZCBuZXdlci4gDQo+IERlZmF1bHRzIHRvICMgJ2ZhbHNlJy4NCj4gI0Zhc3RDb25uZWN0YWJs
ZSA9IGZhbHNlW1BvbGljeV0jIFRoZSBSZWNvbm5lY3RVVUlEcyBkZWZpbmVzIHRoZSBzZXQgDQo+
IG9mIHJlbW90ZSBzZXJ2aWNlcyB0aGF0IHNob3VsZCB0cnkgIyB0byBiZSByZWNvbm5lY3RlZCB0
byBpbiBjYXNlIG9mIGEgDQo+IGxpbmsgbG9zcyAobGluayBzdXBlcnZpc2lvbiAjIHRpbWVvdXQp
LiBUaGUgcG9saWN5IHBsdWdpbiBzaG91bGQgDQo+IGNvbnRhaW4gYSBzYW5lIHNldCBvZiB2YWx1
ZXMgYnkgIyBkZWZhdWx0LCBidXQgdGhpcyBsaXN0IGNhbiBiZSANCj4gb3ZlcnJpZGRlbiBoZXJl
LiBCeSBzZXR0aW5nIHRoZSBsaXN0IHRvICMgZW1wdHkgdGhlIHJlY29ubmVjdGlvbiBmZWF0dXJl
IGdldHMgZGlzYWJsZWQuDQo+ICNSZWNvbm5lY3RVVUlEcz0wMDAwMTExMi0wMDAwLTEwMDAtODAw
MC0wMDgwNWY5YjM0ZmIsIA0KPiAwMDAwMTExZi0wMDAwLTEwMDAtODAwMC0wMDgwNWY5YjM0ZmIs
IDAwMDAxMTBhLTAwMDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYiMgUmVjb25uZWN0QXR0ZW1wdHMg
ZGVmaW5lIHRoZSBudW1iZXIgb2YgYXR0ZW1wdHMgdG8gcmVjb25uZWN0IGFmdGVyIGEgbGluayAj
IGxvc3QuIFNldHRpbmcgdGhlIHZhbHVlIHRvIDAgZGlzYWJsZXMgcmVjb25uZWN0aW5nIGZlYXR1
cmUuDQo+ICNSZWNvbm5lY3RBdHRlbXB0cz03IyBSZWNvbm5lY3RJbnRlcnZhbHMgZGVmaW5lIHRo
ZSBzZXQgb2YgaW50ZXJ2YWxzIA0KPiBpbiBzZWNvbmRzIHRvIHVzZSBpbiBiZXR3ZWVuICMgYXR0
ZW1wdHMuDQo+ICMgSWYgdGhlIG51bWJlciBvZiBhdHRlbXB0cyBkZWZpbmVkIGluIFJlY29ubmVj
dEF0dGVtcHRzIGlzIGJpZ2dlciANCj4gdGhhbiB0aGUgIyBzZXQgb2YgaW50ZXJ2YWxzIHRoZSBs
YXN0IGludGVydmFsIGlzIHJlcGVhdGVkIHVudGlsIHRoZSBsYXN0IGF0dGVtcHQuDQo+ICNSZWNv
bm5lY3RJbnRlcnZhbHM9MSwgMiwgNCwgOCwgMTYsIDMyLCA2NCMgQXV0b0VuYWJsZSBkZWZpbmVz
IG9wdGlvbiB0byBlbmFibGUgYWxsIGNvbnRyb2xsZXJzIHdoZW4gdGhleSBhcmUgZm91bmQuDQo+
ICMgVGhpcyBpbmNsdWRlcyBhZGFwdGVycyBwcmVzZW50IG9uIHN0YXJ0IGFzIHdlbGwgYXMgYWRh
cHRlcnMgdGhhdCBhcmUgDQo+IHBsdWdnZWQgIyBpbiBsYXRlciBvbi4gRGVmYXVsdHMgdG8gJ2Zh
bHNlJy4NCj4gQXV0b0VuYWJsZT10cnVlDQo+DQo+DQo+IEFuZCBibHVldG9vdGguc2VydmljZQ0K
Pg0KPg0KPiBbVW5pdF0NCj4gRGVzY3JpcHRpb249Qmx1ZXRvb3RoIHNlcnZpY2UNCj4gRG9jdW1l
bnRhdGlvbj1tYW46Ymx1ZXRvb3RoZCg4KQ0KPiBDb25kaXRpb25QYXRoSXNEaXJlY3Rvcnk9L3N5
cy9jbGFzcy9ibHVldG9vdGhbU2VydmljZV0NCj4gVHlwZT1kYnVzDQo+IEJ1c05hbWU9b3JnLmJs
dWV6DQo+IEV4ZWNTdGFydD0vdXNyL2xpYmV4ZWMvYmx1ZXRvb3RoL2JsdWV0b290aGQgLWQgLW4g
LS1jb25maWdmaWxlIA0KPiAvZXRjL2JsdWV0b290aC9tYWluLmNvbmYgTm90aWZ5QWNjZXNzPW1h
aW4NCj4gI1dhdGNoZG9nU2VjPTEwDQo+ICNSZXN0YXJ0PW9uLWZhaWx1cmUNCj4gQ2FwYWJpbGl0
eUJvdW5kaW5nU2V0PUNBUF9ORVRfQURNSU4gQ0FQX05FVF9CSU5EX1NFUlZJQ0UNCj4gTGltaXRO
UFJPQz0xDQo+IFByb3RlY3RIb21lPXRydWUNCj4gUHJvdGVjdFN5c3RlbT1mdWxsW0luc3RhbGxd
DQo+IFdhbnRlZEJ5PWJsdWV0b290aC50YXJnZXQNCj4gQWxpYXM9ZGJ1cy1vcmcuYmx1ZXouc2Vy
dmljZQ0KPg0KPiBBbnkgZ3VpZGFuY2UvcG9pbnRlcnM/DQo+DQo+DQo+IFRoYW5rcywNCj4gQWJk
dWwgS2FyaW0NCj4NCj4NCj4NCj4NCj4NCj4NCg0KDQotLQ0KTHVpeiBBdWd1c3RvIHZvbiBEZW50
eg0K
