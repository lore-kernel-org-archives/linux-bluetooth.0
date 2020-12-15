Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1331C2BB48
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 14:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1FB522518
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 14:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgLOOio (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Dec 2020 09:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729500AbgLOOi0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Dec 2020 09:38:26 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E39C06179C
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 06:37:45 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id e25so18712275wme.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 06:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language;
        bh=qe3vzI93AGH7t0K88R7Lr+IS3g2/PIbTZtmvoE7O/hw=;
        b=T4U6eRx6jh+XLYk+CKFeCvq91o791dTxH8IwZdvNsnlFys7ogf1gcmy/7JoeDo6E2C
         HEA70cj/WHSfr1R2FHFcjkRX0aVsXyawi4hNp2lETZA0Em+GUeMzr+NsOThtsxngO9R9
         CnnAka0qIRdyqQnsZgoIC5nFDGBmVzbjWTCL+bEY+RhFGlcaX8bZnCvHRhWmjb9eZmSM
         VeePV1t51gzTXb/el+0M4+e4FYzSiQIdoKTG7gQ2D5TPjTvX7HWwVuBDeE504FP/VM8s
         DdLQENzgKTuuE+8JJ1yIltfhWzqiA+QcGXbA/p/KxVg65AwiuT9XF3LQu7ZIBNuj7Ott
         woVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language;
        bh=qe3vzI93AGH7t0K88R7Lr+IS3g2/PIbTZtmvoE7O/hw=;
        b=BfBqfDpNu709nK60Xn7ObgxgNHJoXe4Ds9qejJzOEQZfsJDF98h8j00bX60rRvRcGx
         FqaxloNZbgdM++QiN4VBV+p4kWbJTsDb+5XtaU7mT4lHZMVwY2CVc8KrzW6tOi0q1jQE
         hDuU2FnW39vl16cOtgf2RKpKaB6raQBUBPIpmiV3p5n0cFHZ9KOY9tFXh/iq9ZPkaxPe
         bo3eFc2t5m3aTYH1kx8zV5VJs6bZMbUtpVD8oQPQ9zqtytdCPuYZ8nuLqQs3ANlnuu2u
         J3Hk2wWRx9iZ3Hbn0xgPqAXNX2bvcW0fJ0Tx0TKeH0eBgIbjBDkqExRrffV/Snlu0hW6
         sX+A==
X-Gm-Message-State: AOAM531E71DfEjrNlyp+Jmoo3m3Sae4qHfg4MD8Ytk/PiG8iDS9AE2Xw
        PdBIlHlAbTXddiDnBGxmboNOSeT5gXfj+A==
X-Google-Smtp-Source: ABdhPJwvrQ7oTXu6ex1NhPHzJavC/ZX049DBjfXEZGrVU17co+nSAM8y4h4wnWeV/bEGcUplQ+T4Kw==
X-Received: by 2002:a7b:c3d6:: with SMTP id t22mr7802328wmj.134.1608043064413;
        Tue, 15 Dec 2020 06:37:44 -0800 (PST)
Received: from urmel.joe.lo ([2001:16b8:3ffb:e500:aa5e:45ff:fe53:bf7])
        by smtp.gmail.com with ESMTPSA id h20sm40558341wrb.21.2020.12.15.06.37.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 06:37:43 -0800 (PST)
From:   Johannes Deisenhofer <jo.deisenhofer@gmail.com>
Subject: BLE Midi problem with mixed 16/128Bit UUIDs in characteristics
To:     linux-bluetooth@vger.kernel.org
Message-ID: <22bd6446-d293-c5d7-14b7-9db9fa0727f6@gmail.com>
Date:   Tue, 15 Dec 2020 15:37:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------D9C8B2F5581FB184D2FBA335"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is a multi-part message in MIME format.
--------------D9C8B2F5581FB184D2FBA335
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I could use some help understanding and hopefully fixing a BLE Midi problem.

I have bought a new MIDI device (Roland GO:Keys). This device connects 
fine via BLE, but does not send any key events. I have another keyboard 
working fine via BLE. Both devices work with android.

After digging into code and specs, I think that the chain of events is:
  - The MIDI Service is found
  - The characteristics are parsed
  - The code thinks that all characteristics in the PDU have 16bit UUIDS 
(len 7), while 3 of them. are 128bit
  - Thus it parses nonsense, and does not find the Midi I/O 
characteristic, no data transfer possible.

src/device.c:gatt_debug() MTU exchange complete, with MTU: 96
src/device.c:gatt_debug() Primary services found: 4
src/device.c:gatt_debug() start: 0x0001, end: 0x0003, uuid: 
00001800-0000-1000-8000-00805f9b34fb
src/device.c:gatt_debug() start: 0x0007, end: 0x000f, uuid: 
03b80e5a-ede8-4b33-a751-6ce34ec4c700
src/device.c:gatt_debug() start: 0x0021, end: 0x0023, uuid: 
00001801-0000-1000-8000-00805f9b34fb
src/device.c:gatt_debug() start: 0x0031, end: 0x0041, uuid: 
0000180a-0000-1000-8000-00805f9b34fb
src/device.c:gatt_debug() Characteristics found: 19
src/device.c:gatt_debug() start: 0x0002, end: 0x0007, value: 0x0003, 
props: 0x0a, uuid: 00002a00-0000-1
src/device.c:gatt_debug() start: 0x0008, end: 0x28a5, value: 0x0009, 
props: 0x18, uuid: 00000318-0000-1
src/device.c:gatt_debug() start: 0x28a6, end: 0xa347, value: 0xecd8, 
props: 0x5e, uuid: 00001c91-0000-1
src/device.c:gatt_debug() start: 0xa348, end: 0x000a, value: 0x5343, 
props: 0xac, uuid: 00004953-0000-1
src/device.c:gatt_debug() start: 0x000b, end: 0x9d0f, value: 0x000c, 
props: 0x1e, uuid: 00006bf3-0000-1
src/device.c:gatt_debug() start: 0x9d10, end: 0x6840, value: 0xa9f2, 
props: 0x66, uuid: 000012a1-0000-1
...

 From parsing handle 8, he parses 3 16 bit UUIDs instead of one 128bit.

wireshark has the same problem and misparses the buffer.

The buffer is the result of a
ATT_OP_READ_BY_TYPE_RESP opcode, which contains a unit length for the 
whole buffer, which is correct for some, but no all characteristics in 
the PDU.

Comparing the attributs from my working with my not working device, I find:
- The not working ROLAND has a total of 3 characteristics with 128bit 
UUIDS for the MIDI Service, the one needed ist the second one.
- The device also contains an audio sink, which I think does not matter

Now for the things that I don't know and where I could use some help:
  - Bug in the bluez stack or should I write to Roland?
  - I have no idea why my other MIDI Device works, mixed 16bit and 
128bit UUIDS is needed in both cases
  - How can I make sure that an attribute response only contains UUIDs 
of one kind? That seems to be required, since there is only one 'len' 
element.
  - Any tips on what needs to be changed?

Also attached is a wireshark dissection and hexdump of the "Read by Type 
Response":

I have a very ugly workaround, but having spent way to much time on 
debugging this, I could also invest the work for a proper patch.

Thanks,
Jo
-- 
Johannes Deisenhofer

--------------D9C8B2F5581FB184D2FBA335
Content-Type: text/plain; charset=UTF-8;
 name="badrolandpdu.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="badrolandpdu.txt"

RnJhbWUgMTAzNDogMjAgYnl0ZXMgb24gd2lyZSAoMTYwIGJpdHMpLCAyMCBieXRlcyBjYXB0
dXJlZCAoMTYwIGJpdHMpIG9uIGludGVyZmFjZSBibHVldG9vdGgtbW9uaXRvciwgaWQgMApC
bHVldG9vdGgKQmx1ZXRvb3RoIExpbnV4IE1vbml0b3IgVHJhbnNwb3J0CkJsdWV0b290aCBI
Q0kgQUNMIFBhY2tldApCbHVldG9vdGggTDJDQVAgUHJvdG9jb2wKQmx1ZXRvb3RoIEF0dHJp
YnV0ZSBQcm90b2NvbAogICAgT3Bjb2RlOiBSZWFkIEJ5IFR5cGUgUmVzcG9uc2UgKDB4MDkp
CiAgICBMZW5ndGg6IDcKICAgIEF0dHJpYnV0ZSBEYXRhLCBIYW5kbGU6IDB4MDAwMiwgQ2hh
cmFjdGVyaXN0aWMgSGFuZGxlOiAweDAwMDMsIFVVSUQ6IERldmljZSBOYW1lCiAgICAgICAg
SGFuZGxlOiAweDAwMDIgKEdlbmVyaWMgQWNjZXNzIFByb2ZpbGU6IEdBVFQgQ2hhcmFjdGVy
aXN0aWMgRGVjbGFyYXRpb24pCiAgICAgICAgICAgIFtTZXJ2aWNlIFVVSUQ6IEdlbmVyaWMg
QWNjZXNzIFByb2ZpbGUgKDB4MTgwMCldCiAgICAgICAgICAgIFtVVUlEOiBHQVRUIENoYXJh
Y3RlcmlzdGljIERlY2xhcmF0aW9uICgweDI4MDMpXQogICAgICAgIENoYXJhY3RlcmlzdGlj
IFByb3BlcnRpZXM6IDB4MGEsIFdyaXRlLCBSZWFkCiAgICAgICAgQ2hhcmFjdGVyaXN0aWMg
VmFsdWUgSGFuZGxlOiAweDAwMDMgKEdlbmVyaWMgQWNjZXNzIFByb2ZpbGU6IERldmljZSBO
YW1lKQogICAgICAgICAgICBbU2VydmljZSBVVUlEOiBHZW5lcmljIEFjY2VzcyBQcm9maWxl
ICgweDE4MDApXQogICAgICAgICAgICBbVVVJRDogRGV2aWNlIE5hbWUgKDB4MmEwMCldCiAg
ICAgICAgVVVJRDogRGV2aWNlIE5hbWUgKDB4MmEwMCkKICAgIEF0dHJpYnV0ZSBEYXRhLCBI
YW5kbGU6IDB4MDAwOCwgQ2hhcmFjdGVyaXN0aWMgSGFuZGxlOiAweDAwMDksIFVVSUQ6IFVu
a25vd24KICAgICAgICBIYW5kbGU6IDB4MDAwOCAoVW5rbm93bjogR0FUVCBDaGFyYWN0ZXJp
c3RpYyBEZWNsYXJhdGlvbikKICAgICAgICAgICAgW1NlcnZpY2UgVVVJRDogMDNiODBlNWFl
ZGU4NGIzM2E3NTE2Y2UzNGVjNGM3MDBdCiAgICAgICAgICAgIFtVVUlEOiBHQVRUIENoYXJh
Y3RlcmlzdGljIERlY2xhcmF0aW9uICgweDI4MDMpXQogICAgICAgIENoYXJhY3RlcmlzdGlj
IFByb3BlcnRpZXM6IDB4MTgsIE5vdGlmeSwgV3JpdGUKICAgICAgICBDaGFyYWN0ZXJpc3Rp
YyBWYWx1ZSBIYW5kbGU6IDB4MDAwOSAoVW5rbm93bjogVW5rbm93bikKICAgICAgICAgICAg
W1NlcnZpY2UgVVVJRDogMDNiODBlNWFlZGU4NGIzM2E3NTE2Y2UzNGVjNGM3MDBdCiAgICAg
ICAgICAgIFtVVUlEOiBVbmtub3duICgweDAzMTgpXQogICAgICAgIFVVSUQ6IFVua25vd24g
KDB4MDMxOCkKICAgIEF0dHJpYnV0ZSBEYXRhLCBIYW5kbGU6IDB4MjhhNiwgQ2hhcmFjdGVy
aXN0aWMgSGFuZGxlOiAweGVjZDgsIFVVSUQ6IFVua25vd24KICAgICAgICBIYW5kbGU6IDB4
MjhhNiAoRGV2aWNlIEluZm9ybWF0aW9uOiBNb2RlbCBOdW1iZXIgU3RyaW5nOiBHQVRUIENo
YXJhY3RlcmlzdGljIERlY2xhcmF0aW9uKQogICAgICAgICAgICBbU2VydmljZSBVVUlEOiBE
ZXZpY2UgSW5mb3JtYXRpb24gKDB4MTgwYSldCiAgICAgICAgICAgIFtDaGFyYWN0ZXJpc3Rp
YyBVVUlEOiBNb2RlbCBOdW1iZXIgU3RyaW5nICgweDJhMjQpXQogICAgICAgICAgICBbVVVJ
RDogR0FUVCBDaGFyYWN0ZXJpc3RpYyBEZWNsYXJhdGlvbiAoMHgyODAzKV0KICAgICAgICBD
aGFyYWN0ZXJpc3RpYyBQcm9wZXJ0aWVzOiAweDVlLCBBdXRoZW50aWNhdGVkIFNpZ25lZCBX
cml0ZXMsIE5vdGlmeSwgV3JpdGUsIFdyaXRlIHdpdGhvdXQgUmVzcG9uc2UsIFJlYWQKICAg
ICAgICBDaGFyYWN0ZXJpc3RpYyBWYWx1ZSBIYW5kbGU6IDB4ZWNkOCAoRGV2aWNlIEluZm9y
bWF0aW9uOiBVbmtub3duKQogICAgICAgICAgICBbU2VydmljZSBVVUlEOiBEZXZpY2UgSW5m
b3JtYXRpb24gKDB4MTgwYSldCiAgICAgICAgICAgIFtVVUlEOiBVbmtub3duICgweDFjOTEp
XQogICAgICAgIFVVSUQ6IFVua25vd24gKDB4MWM5MSkKICAgIEF0dHJpYnV0ZSBEYXRhLCBI
YW5kbGU6IDB4YTM0OCwgQ2hhcmFjdGVyaXN0aWMgSGFuZGxlOiAweDUzNDMsIFVVSUQ6IFVu
a25vd24KICAgICAgICBIYW5kbGU6IDB4YTM0OCAoRGV2aWNlIEluZm9ybWF0aW9uOiBVbmtu
b3duOiBHQVRUIENoYXJhY3RlcmlzdGljIERlY2xhcmF0aW9uKQogICAgICAgICAgICBbU2Vy
dmljZSBVVUlEOiBEZXZpY2UgSW5mb3JtYXRpb24gKDB4MTgwYSldCiAgICAgICAgICAgIFtD
aGFyYWN0ZXJpc3RpYyBVVUlEOiBVbmtub3duICgweDQ5NTMpXQogICAgICAgICAgICBbVVVJ
RDogR0FUVCBDaGFyYWN0ZXJpc3RpYyBEZWNsYXJhdGlvbiAoMHgyODAzKV0KICAgICAgICBD
aGFyYWN0ZXJpc3RpYyBQcm9wZXJ0aWVzOiAweGFjLCBFeHRlbmRlZCBQcm9wZXJ0aWVzLCBJ
bmRpY2F0ZSwgV3JpdGUsIFdyaXRlIHdpdGhvdXQgUmVzcG9uc2UKICAgICAgICBDaGFyYWN0
ZXJpc3RpYyBWYWx1ZSBIYW5kbGU6IDB4NTM0MyAoRGV2aWNlIEluZm9ybWF0aW9uOiBVbmtu
b3duKQogICAgICAgICAgICBbU2VydmljZSBVVUlEOiBEZXZpY2UgSW5mb3JtYXRpb24gKDB4
MTgwYSldCiAgICAgICAgICAgIFtVVUlEOiBVbmtub3duICgweDQ5NTMpXQogICAgICAgIFVV
SUQ6IFVua25vd24gKDB4NDk1MykKICAgIEF0dHJpYnV0ZSBEYXRhLCBIYW5kbGU6IDB4MDAw
YiwgQ2hhcmFjdGVyaXN0aWMgSGFuZGxlOiAweDAwMGMsIFVVSUQ6IFVua25vd24KICAgICAg
ICBIYW5kbGU6IDB4MDAwYiAoVW5rbm93bjogVW5rbm93bjogR0FUVCBDaGFyYWN0ZXJpc3Rp
YyBEZWNsYXJhdGlvbikKICAgICAgICAgICAgW1NlcnZpY2UgVVVJRDogMDNiODBlNWFlZGU4
NGIzM2E3NTE2Y2UzNGVjNGM3MDBdCiAgICAgICAgICAgIFtDaGFyYWN0ZXJpc3RpYyBVVUlE
OiBVbmtub3duICgweDAzMTgpXQogICAgICAgICAgICBbVVVJRDogR0FUVCBDaGFyYWN0ZXJp
c3RpYyBEZWNsYXJhdGlvbiAoMHgyODAzKV0KICAgICAgICBDaGFyYWN0ZXJpc3RpYyBQcm9w
ZXJ0aWVzOiAweDFlLCBOb3RpZnksIFdyaXRlLCBXcml0ZSB3aXRob3V0IFJlc3BvbnNlLCBS
ZWFkCiAgICAgICAgQ2hhcmFjdGVyaXN0aWMgVmFsdWUgSGFuZGxlOiAweDAwMGMgKFVua25v
d246IFVua25vd24pCiAgICAgICAgICAgIFtTZXJ2aWNlIFVVSUQ6IDAzYjgwZTVhZWRlODRi
MzNhNzUxNmNlMzRlYzRjNzAwXQogICAgICAgICAgICBbVVVJRDogVW5rbm93biAoMHg2YmYz
KV0KICAgICAgICBVVUlEOiBVbmtub3duICgweDZiZjMpCiAgICBBdHRyaWJ1dGUgRGF0YSwg
SGFuZGxlOiAweDlkMTAsIENoYXJhY3RlcmlzdGljIEhhbmRsZTogMHhhOWYyLCBVVUlEOiBV
bmtub3duCiAgICAgICAgSGFuZGxlOiAweDlkMTAgKERldmljZSBJbmZvcm1hdGlvbjogVW5r
bm93bjogR0FUVCBDaGFyYWN0ZXJpc3RpYyBEZWNsYXJhdGlvbikKICAgICAgICAgICAgW1Nl
cnZpY2UgVVVJRDogRGV2aWNlIEluZm9ybWF0aW9uICgweDE4MGEpXQogICAgICAgICAgICBb
Q2hhcmFjdGVyaXN0aWMgVVVJRDogVW5rbm93biAoMHg0OTUzKV0KICAgICAgICAgICAgW1VV
SUQ6IEdBVFQgQ2hhcmFjdGVyaXN0aWMgRGVjbGFyYXRpb24gKDB4MjgwMyldCiAgICAgICAg
Q2hhcmFjdGVyaXN0aWMgUHJvcGVydGllczogMHg2NiwgQXV0aGVudGljYXRlZCBTaWduZWQg
V3JpdGVzLCBJbmRpY2F0ZSwgV3JpdGUgd2l0aG91dCBSZXNwb25zZSwgUmVhZAogICAgICAg
IENoYXJhY3RlcmlzdGljIFZhbHVlIEhhbmRsZTogMHhhOWYyIChEZXZpY2UgSW5mb3JtYXRp
b246IFVua25vd24pCiAgICAgICAgICAgIFtTZXJ2aWNlIFVVSUQ6IERldmljZSBJbmZvcm1h
dGlvbiAoMHgxODBhKV0KICAgICAgICAgICAgW1VVSUQ6IFVua25vd24gKDB4MTJhMSldCiAg
ICAgICAgVVVJRDogVW5rbm93biAoMHgxMmExKQogICAgQXR0cmlidXRlIERhdGEsIEhhbmRs
ZTogMHg2ODQxLCBDaGFyYWN0ZXJpc3RpYyBIYW5kbGU6IDB4ZTVkYiwgVVVJRDogVW5rbm93
bgogICAgICAgIEhhbmRsZTogMHg2ODQxIChEZXZpY2UgSW5mb3JtYXRpb246IFVua25vd246
IEdBVFQgQ2hhcmFjdGVyaXN0aWMgRGVjbGFyYXRpb24pCiAgICAgICAgICAgIFtTZXJ2aWNl
IFVVSUQ6IERldmljZSBJbmZvcm1hdGlvbiAoMHgxODBhKV0KICAgICAgICAgICAgW0NoYXJh
Y3RlcmlzdGljIFVVSUQ6IFVua25vd24gKDB4NDk1MyldCiAgICAgICAgICAgIFtVVUlEOiBH
QVRUIENoYXJhY3RlcmlzdGljIERlY2xhcmF0aW9uICgweDI4MDMpXQogICAgICAgIENoYXJh
Y3RlcmlzdGljIFByb3BlcnRpZXM6IDB4MzgsIEluZGljYXRlLCBOb3RpZnksIFdyaXRlCiAg
ICAgICAgQ2hhcmFjdGVyaXN0aWMgVmFsdWUgSGFuZGxlOiAweGU1ZGIgKERldmljZSBJbmZv
cm1hdGlvbjogVW5rbm93bikKICAgICAgICAgICAgW1NlcnZpY2UgVVVJRDogRGV2aWNlIElu
Zm9ybWF0aW9uICgweDE4MGEpXQogICAgICAgICAgICBbVVVJRDogVW5rbm93biAoMHg3Nzcy
KV0KICAgICAgICBVVUlEOiBVbmtub3duICgweDc3NzIpCiAgICBBdHRyaWJ1dGUgRGF0YSwg
SGFuZGxlOiAweDAwMGUsIENoYXJhY3RlcmlzdGljIEhhbmRsZTogMHgwMDBmLCBVVUlEOiBV
bmtub3duCiAgICAgICAgSGFuZGxlOiAweDAwMGUgKFVua25vd246IFVua25vd246IEdBVFQg
Q2hhcmFjdGVyaXN0aWMgRGVjbGFyYXRpb24pCiAgICAgICAgICAgIFtTZXJ2aWNlIFVVSUQ6
IDAzYjgwZTVhZWRlODRiMzNhNzUxNmNlMzRlYzRjNzAwXQogICAgICAgICAgICBbQ2hhcmFj
dGVyaXN0aWMgVVVJRDogVW5rbm93biAoMHg2YmYzKV0KICAgICAgICAgICAgW1VVSUQ6IEdB
VFQgQ2hhcmFjdGVyaXN0aWMgRGVjbGFyYXRpb24gKDB4MjgwMyldCiAgICAgICAgQ2hhcmFj
dGVyaXN0aWMgUHJvcGVydGllczogMHgwOCwgV3JpdGUKICAgICAgICBDaGFyYWN0ZXJpc3Rp
YyBWYWx1ZSBIYW5kbGU6IDB4MDAwZiAoVW5rbm93bjogVW5rbm93bikKICAgICAgICAgICAg
W1NlcnZpY2UgVVVJRDogMDNiODBlNWFlZGU4NGIzM2E3NTE2Y2UzNGVjNGM3MDBdCiAgICAg
ICAgICAgIFtVVUlEOiBVbmtub3duICgweDliYjMpXQogICAgICAgIFVVSUQ6IFVua25vd24g
KDB4OWJiMykKICAgIEF0dHJpYnV0ZSBEYXRhLCBIYW5kbGU6IDB4MzQ3MiwgQ2hhcmFjdGVy
aXN0aWMgSGFuZGxlOiAweGQ0ZWMsIFVVSUQ6IFVua25vd24KICAgICAgICBIYW5kbGU6IDB4
MzQ3MiAoRGV2aWNlIEluZm9ybWF0aW9uOiBNb2RlbCBOdW1iZXIgU3RyaW5nOiBHQVRUIENo
YXJhY3RlcmlzdGljIERlY2xhcmF0aW9uKQogICAgICAgICAgICBbU2VydmljZSBVVUlEOiBE
ZXZpY2UgSW5mb3JtYXRpb24gKDB4MTgwYSldCiAgICAgICAgICAgIFtDaGFyYWN0ZXJpc3Rp
YyBVVUlEOiBNb2RlbCBOdW1iZXIgU3RyaW5nICgweDJhMjQpXQogICAgICAgICAgICBbVVVJ
RDogR0FUVCBDaGFyYWN0ZXJpc3RpYyBEZWNsYXJhdGlvbiAoMHgyODAzKV0KICAgICAgICBD
aGFyYWN0ZXJpc3RpYyBQcm9wZXJ0aWVzOiAweGJlLCBFeHRlbmRlZCBQcm9wZXJ0aWVzLCBJ
bmRpY2F0ZSwgTm90aWZ5LCBXcml0ZSwgV3JpdGUgd2l0aG91dCBSZXNwb25zZSwgUmVhZAog
ICAgICAgIENoYXJhY3RlcmlzdGljIFZhbHVlIEhhbmRsZTogMHhkNGVjIChEZXZpY2UgSW5m
b3JtYXRpb246IFVua25vd24pCiAgICAgICAgICAgIFtTZXJ2aWNlIFVVSUQ6IERldmljZSBJ
bmZvcm1hdGlvbiAoMHgxODBhKV0KICAgICAgICAgICAgW1VVSUQ6IFVua25vd24gKDB4ZjRh
OCldCiAgICAgICAgVVVJRDogVW5rbm93biAoMHhmNGE4KQogICAgQXR0cmlidXRlIERhdGEs
IEhhbmRsZTogMHg0MTQzLCBDaGFyYWN0ZXJpc3RpYyBIYW5kbGU6IDB4NTM0MywgVVVJRDog
VW5rbm93bgogICAgICAgIEhhbmRsZTogMHg0MTQzIChEZXZpY2UgSW5mb3JtYXRpb246IE1v
ZGVsIE51bWJlciBTdHJpbmc6IEdBVFQgQ2hhcmFjdGVyaXN0aWMgRGVjbGFyYXRpb24pCiAg
ICAgICAgICAgIFtTZXJ2aWNlIFVVSUQ6IERldmljZSBJbmZvcm1hdGlvbiAoMHgxODBhKV0K
ICAgICAgICAgICAgW0NoYXJhY3RlcmlzdGljIFVVSUQ6IE1vZGVsIE51bWJlciBTdHJpbmcg
KDB4MmEyNCldCiAgICAgICAgICAgIFtVVUlEOiBHQVRUIENoYXJhY3RlcmlzdGljIERlY2xh
cmF0aW9uICgweDI4MDMpXQogICAgICAgIENoYXJhY3RlcmlzdGljIFByb3BlcnRpZXM6IDB4
ODgsIEV4dGVuZGVkIFByb3BlcnRpZXMsIFdyaXRlCiAgICAgICAgQ2hhcmFjdGVyaXN0aWMg
VmFsdWUgSGFuZGxlOiAweDUzNDMgKERldmljZSBJbmZvcm1hdGlvbjogVW5rbm93bikKICAg
ICAgICAgICAgW1NlcnZpY2UgVVVJRDogRGV2aWNlIEluZm9ybWF0aW9uICgweDE4MGEpXQog
ICAgICAgICAgICBbVVVJRDogVW5rbm93biAoMHg0OTUzKV0KICAgICAgICBVVUlEOiBVbmtu
b3duICgweDQ5NTMpCiAgICBBdHRyaWJ1dGUgRGF0YSwgSGFuZGxlOiAweDAwMjIsIENoYXJh
Y3RlcmlzdGljIEhhbmRsZTogMHgwMDIzLCBVVUlEOiBTZXJ2aWNlIENoYW5nZWQKICAgICAg
ICBIYW5kbGU6IDB4MDAyMiAoR2VuZXJpYyBBdHRyaWJ1dGUgUHJvZmlsZTogR0FUVCBDaGFy
YWN0ZXJpc3RpYyBEZWNsYXJhdGlvbikKICAgICAgICAgICAgW1NlcnZpY2UgVVVJRDogR2Vu
ZXJpYyBBdHRyaWJ1dGUgUHJvZmlsZSAoMHgxODAxKV0KICAgICAgICAgICAgW1VVSUQ6IEdB
VFQgQ2hhcmFjdGVyaXN0aWMgRGVjbGFyYXRpb24gKDB4MjgwMyldCiAgICAgICAgQ2hhcmFj
dGVyaXN0aWMgUHJvcGVydGllczogMHgyNiwgSW5kaWNhdGUsIFdyaXRlIHdpdGhvdXQgUmVz
cG9uc2UsIFJlYWQKICAgICAgICBDaGFyYWN0ZXJpc3RpYyBWYWx1ZSBIYW5kbGU6IDB4MDAy
MyAoR2VuZXJpYyBBdHRyaWJ1dGUgUHJvZmlsZTogU2VydmljZSBDaGFuZ2VkKQogICAgICAg
ICAgICBbU2VydmljZSBVVUlEOiBHZW5lcmljIEF0dHJpYnV0ZSBQcm9maWxlICgweDE4MDEp
XQogICAgICAgICAgICBbVVVJRDogU2VydmljZSBDaGFuZ2VkICgweDJhMDUpXQogICAgICAg
IFVVSUQ6IFNlcnZpY2UgQ2hhbmdlZCAoMHgyYTA1KQogICAgQXR0cmlidXRlIERhdGEsIEhh
bmRsZTogMHgwMDMyLCBDaGFyYWN0ZXJpc3RpYyBIYW5kbGU6IDB4MDAzMywgVVVJRDogTWFu
dWZhY3R1cmVyIE5hbWUgU3RyaW5nCiAgICAgICAgSGFuZGxlOiAweDAwMzIgKERldmljZSBJ
bmZvcm1hdGlvbjogR0FUVCBDaGFyYWN0ZXJpc3RpYyBEZWNsYXJhdGlvbikKICAgICAgICAg
ICAgW1NlcnZpY2UgVVVJRDogRGV2aWNlIEluZm9ybWF0aW9uICgweDE4MGEpXQogICAgICAg
ICAgICBbVVVJRDogR0FUVCBDaGFyYWN0ZXJpc3RpYyBEZWNsYXJhdGlvbiAoMHgyODAzKV0K
ICAgICAgICBDaGFyYWN0ZXJpc3RpYyBQcm9wZXJ0aWVzOiAweDAyLCBSZWFkCiAgICAgICAg
Q2hhcmFjdGVyaXN0aWMgVmFsdWUgSGFuZGxlOiAweDAwMzMgKERldmljZSBJbmZvcm1hdGlv
bjogTWFudWZhY3R1cmVyIE5hbWUgU3RyaW5nKQogICAgICAgICAgICBbU2VydmljZSBVVUlE
OiBEZXZpY2UgSW5mb3JtYXRpb24gKDB4MTgwYSldCiAgICAgICAgICAgIFtVVUlEOiBNYW51
ZmFjdHVyZXIgTmFtZSBTdHJpbmcgKDB4MmEyOSldCiAgICAgICAgVVVJRDogTWFudWZhY3R1
cmVyIE5hbWUgU3RyaW5nICgweDJhMjkpCiAgICBBdHRyaWJ1dGUgRGF0YSwgSGFuZGxlOiAw
eDAwMzQsIENoYXJhY3RlcmlzdGljIEhhbmRsZTogMHgwMDM1LCBVVUlEOiBNb2RlbCBOdW1i
ZXIgU3RyaW5nCiAgICAgICAgSGFuZGxlOiAweDAwMzQgKERldmljZSBJbmZvcm1hdGlvbjog
TWFudWZhY3R1cmVyIE5hbWUgU3RyaW5nOiBHQVRUIENoYXJhY3RlcmlzdGljIERlY2xhcmF0
aW9uKQogICAgICAgICAgICBbU2VydmljZSBVVUlEOiBEZXZpY2UgSW5mb3JtYXRpb24gKDB4
MTgwYSldCiAgICAgICAgICAgIFtDaGFyYWN0ZXJpc3RpYyBVVUlEOiBNYW51ZmFjdHVyZXIg
TmFtZSBTdHJpbmcgKDB4MmEyOSldCiAgICAgICAgICAgIFtVVUlEOiBHQVRUIENoYXJhY3Rl
cmlzdGljIERlY2xhcmF0aW9uICgweDI4MDMpXQogICAgICAgIENoYXJhY3RlcmlzdGljIFBy
b3BlcnRpZXM6IDB4MDIsIFJlYWQKICAgICAgICBDaGFyYWN0ZXJpc3RpYyBWYWx1ZSBIYW5k
bGU6IDB4MDAzNSAoRGV2aWNlIEluZm9ybWF0aW9uOiBNb2RlbCBOdW1iZXIgU3RyaW5nKQog
ICAgICAgICAgICBbU2VydmljZSBVVUlEOiBEZXZpY2UgSW5mb3JtYXRpb24gKDB4MTgwYSld
CiAgICAgICAgICAgIFtVVUlEOiBNb2RlbCBOdW1iZXIgU3RyaW5nICgweDJhMjQpXQogICAg
ICAgIFVVSUQ6IE1vZGVsIE51bWJlciBTdHJpbmcgKDB4MmEyNCkKICAgIFtVVUlEOiBHQVRU
IENoYXJhY3RlcmlzdGljIERlY2xhcmF0aW9uICgweDI4MDMpXQogICAgW1JlcXVlc3QgaW4g
RnJhbWU6IDEwMjhdCgoKMDAwMCAgIDVkIDAwIDA0IDAwIDA5IDA3IDAyIDAwIDBhIDAzIDAw
IDAwIDJhIDA4IDAwIDE4ICAgXS4uLi4uLi4uLi4uKi4uLgowMDEwICAgMDkgMDAgMTggMDMg
YTYgMjggNWUgZDggZWMgOTEgMWMgNDggYTMgYWMgNDMgNTMgICAuLi4uLiheLi4uLkguLkNT
CjAwMjAgICA1MyA0OSAwYiAwMCAxZSAwYyAwMCBmMyA2YiAxMCA5ZCA2NiBmMiBhOSBhMSAx
MiAgIFNJLi4uLi4uay4uZi4uLi4KMDAzMCAgIDQxIDY4IDM4IGRiIGU1IDcyIDc3IDBlIDAw
IDA4IDBmIDAwIGIzIDliIDcyIDM0ICAgQWg4Li5ydy4uLi4uLi5yNAowMDQwICAgYmUgZWMg
ZDQgYTggZjQgNDMgNDEgODggNDMgNTMgNTMgNDkgMjIgMDAgMjYgMjMgICAuLi4uLkNBLkNT
U0kiLiYjCjAwNTAgICAwMCAwNSAyYSAzMiAwMCAwMiAzMyAwMCAyOSAyYSAzNCAwMCAwMiAz
NSAwMCAyNCAgIC4uKjIuLjMuKSo0Li41LiQKMDA2MCAgIDJhICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKgoK
--------------D9C8B2F5581FB184D2FBA335--
