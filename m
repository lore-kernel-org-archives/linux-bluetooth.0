Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C980F38B14C
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602100; cv=none; b=Yz7h1uknOOIQKoIZT6Gj6lqj334cYWivk4obWsLNYc27IZjgzGFEmcxgvOJ0hL+poJvUeL9NxXYpaT1Wrb9lGP2LGTT2ykQ52/F0SOzzw8u6hPNOvPP1lmT7XshDvKX9StvMmXFA2dE6Kh2HosdsHIhA7ScUahoA29oIobTtBHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602100; c=relaxed/simple;
	bh=EemzPsHLG+84PhwYMfS9TmLQq91LFwPVdcg0coTGHjE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bx8jT/6zS+5+ftYJT/FzqoxZDKuED1zl9prwXyVjZtatKQ3pnjo0DHRlmMDR2n80zXUPoNqrwyO/CLufuAN9tSZrCGq0ApEZGeXiSL5A36kpK39unNjaObyiJ0bhbtIoYIw8wiyCMMMmTHhpKe7FTaUO0aBND+DDJAa8FfD12TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8q3TTRO; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8q3TTRO"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4b190cdc9feso3456335b6e.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 13:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787602098; x=1788206898; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EemzPsHLG+84PhwYMfS9TmLQq91LFwPVdcg0coTGHjE=;
        b=f8q3TTRORPLXCh1KoariLUvsXhafTS5ldKVYHFBuqwiWfMKRHOIbNAztEDVqKz4Dvf
         seKOoCdKcHzA68NEQEAybhL046y5kRbCFYBp1Q2UP9w3n7QjpuMZEwKAQxEWfkx3Y+Xa
         ogzoYRZXVfnrkSWhS8XY4NWrKX1rbYyN8ITR4C4hdYbiGlG3RTJdQ7pYyOCooUkHrRL9
         l4uhCJXfUnHYSG6BNuLFKqv7nVKfEh5oFE9Jf4UCVrTI52zyKKNVJj1mQWorGlg4129Z
         uGI0ZrGvvQljW8PmtCU1MSSLmyQc/dnKx9LWHxORN8g/BV+iXBOPulPhmkuHaujN0YY3
         3UBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787602098; x=1788206898;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EemzPsHLG+84PhwYMfS9TmLQq91LFwPVdcg0coTGHjE=;
        b=isgyg3vq6cRoRJMbNsbDFQLvwXsrBRKYs3hbqtZjMXP+vJkl9dnm6j+fp45Hnr0DJi
         pNmzD3iDW6JXBlqjcbLAGvoqeXgGDYD5mPrGFZgMAEgu0TGBJy7+zgAILQA1hPfViwqh
         DBPei0wXBw+bqHHEATmwoe9FHjGGkbVJeUXFyfMkky/FWLPJTmC0WyInY6x/YKbXXg1p
         K3DZnNAmPEOWm1tSU82Q4xIkf35lvMwlxgKxFehgyRmwlDwWm5SwFqMGYMyrMro+Lfe/
         uU9oT64TNN1JkIfqq27/puJEfqkL4wUg6hsBqmDSMFGCMKqe5gPUAThPdAxGxk0ZrGWc
         pU5g==
X-Gm-Message-State: AFuF++m8SOGcxLpCx6nQrfDZdnB1tZwXl38nHTRW6myE/Jj2SwxjHrFY
	S6KVH+WjzS6oy7844xgM7xCoSav1mUZH4r7Cu7NOk5xY3ogF3FUjm9XKAUT/nA==
X-Gm-Gg: AR+sD11yEwrhFZXlewVGIlNOQ5XTUG4fZ09KcvAAM3wYij2w/NyqCh3WqH3YU1ZkhMK
	OkCcmXYcjKcJEU3Zb1KoohYnZgDrY9yK+am7QZrnha/R0H1YovTVq8nR9HjYmqIxkhtoqMc8eSa
	jFV4tUyJH8upotGzrfHTx+duaR/4kd67XXRTobOFTb0JGlc4goqeaEMgnb5fRvFseBoYcjCoCWn
	VbneXYIGJdlYD6wfTekZG5Tcco+bHFUfPceKryqzPF5ri1Kna7TxTaKY2nLksM+nM0zNZgR0ZuO
	NRqOWZYBcgfonStwxKbqHisfCwyt3bOQbiyWfJ1XRjto1TkUaGvN61qwuxz/CGU4oheffEcbGGl
	XB0zrATL+e6kNom0qpmcFreAoX8DNJRPzemzbcXmb2P2O4pEOVEl7sxsGCDIQuObONY1OhdIF16
	QoMIMQbZGES6DEtuxkv7xEccJm3DjZc4ortkGnup3SxFRIQ2MkiA7ZK90FbpAams0T
X-Received: by 2002:a05:6808:c3e9:b0:489:352c:5153 with SMTP id 5614622812f47-4b2ef482faemr27788154b6e.21.1787602097499;
        Mon, 24 Aug 2026 13:08:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.118.30.0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b32c690a5asm4259007b6e.8.2026.08.24.13.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:08:17 -0700 (PDT)
Message-ID: <6a8ca4b1.a96d76c3.16624d.1468@mx.google.com>
Date: Mon, 24 Aug 2026 13:08:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4060491149959171901=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, uldixxion@gmail.com
Subject: =?utf-8?q?RE=3A_MT7925_=280e8d=3A0717=29=3A_HFP_microphone_unusable_=E2=80=94_firmware_delivers_zero-filled_=28e=29SCO_frames_on_sentinel_handle_0x0E00?=
In-Reply-To: <CAPCBbk7t6OKtOGynNhf6oGnxGrSEqkh-SfweO_Yfms5NXDSCZQ@mail.gmail.com>
References: <CAPCBbk7t6OKtOGynNhf6oGnxGrSEqkh-SfweO_Yfms5NXDSCZQ@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4060491149959171901==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9MTE1MTExOQoKLS0t
VGVzdCByZXN1bHQtLS0KClRlc3QgU3VtbWFyeToKQ2hlY2tQYXRjaCAgICAgICAgICAgICAgICAg
ICAgRkFJTCAgICAgIDAuNjAgc2Vjb25kcwpWZXJpZnlGaXhlcyAgICAgICAgICAgICAgICAgICBQ
QVNTICAgICAgMC4xMCBzZWNvbmRzClZlcmlmeVNpZ25lZG9mZiAgICAgICAgICAgICAgIFBBU1Mg
ICAgICAwLjEwIHNlY29uZHMKR2l0TGludCAgICAgICAgICAgICAgICAgICAgICAgRkFJTCAgICAg
IDAuMjYgc2Vjb25kcwpTdWJqZWN0UHJlZml4ICAgICAgICAgICAgICAgICBGQUlMICAgICAgMC4w
OSBzZWNvbmRzCkJ1aWxkS2VybmVsICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAyMi40OSBz
ZWNvbmRzCkNoZWNrQWxsV2FybmluZyAgICAgICAgICAgICAgIFBBU1MgICAgICAyNC41OCBzZWNv
bmRzCkNoZWNrU3BhcnNlICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAyMi44OSBzZWNvbmRz
CkJ1aWxkS2VybmVsMzIgICAgICAgICAgICAgICAgIFBBU1MgICAgICAyMS40MSBzZWNvbmRzCkNo
ZWNrS2VybmVsTExWTSAgICAgICAgICAgICAgIFNLSVAgICAgICAwLjAwIHNlY29uZHMKVGVzdFJ1
bm5lclNldHVwICAgICAgICAgICAgICAgUEFTUyAgICAgIDM4My4yNSBzZWNvbmRzCkluY3JlbWVu
dGFsQnVpbGQgICAgICAgICAgICAgIFBBU1MgICAgICAyMS4wOCBzZWNvbmRzCgpEZXRhaWxzCiMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja1BhdGNoIC0gRkFJTApEZXNj
OiBSdW4gY2hlY2twYXRjaC5wbCBzY3JpcHQKT3V0cHV0OgpNVDc5MjUgKDBlOGQ6MDcxNyk6IEhG
UCBtaWNyb3Bob25lIHVudXNhYmxlIOKAlCBmaXJtd2FyZSBkZWxpdmVycyB6ZXJvLWZpbGxlZCAo
ZSlTQ08gZnJhbWVzIG9uIHNlbnRpbmVsIGhhbmRsZSAweDBFMDAKRVJST1I6IEludmFsaWQgY29t
bWl0IHNlcGFyYXRvciAtIHNvbWUgdG9vbHMgbWF5IGhhdmUgcHJvYmxlbXMgYXBwbHlpbmcgdGhp
cwojMTIwOiAKLS0tLS0tLS0tLS0tLS0tLS0tLQoKRVJST1I6IEludmFsaWQgY29tbWl0IHNlcGFy
YXRvciAtIHNvbWUgdG9vbHMgbWF5IGhhdmUgcHJvYmxlbXMgYXBwbHlpbmcgdGhpcwojMTM1OiAK
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKRVJST1I6IEludmFsaWQgY29tbWl0IHNlcGFyYXRvciAt
IHNvbWUgdG9vbHMgbWF5IGhhdmUgcHJvYmxlbXMgYXBwbHlpbmcgdGhpcwojMTUwOiAKLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgpFUlJPUjogSW52YWxpZCBjb21taXQgc2VwYXJh
dG9yIC0gc29tZSB0b29scyBtYXkgaGF2ZSBwcm9ibGVtcyBhcHBseWluZyB0aGlzCiMxNzg6IAot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCkVSUk9SOiBJbnZhbGlkIGNvbW1pdCBz
ZXBhcmF0b3IgLSBzb21lIHRvb2xzIG1heSBoYXZlIHByb2JsZW1zIGFwcGx5aW5nIHRoaXMKIzIw
ODogCi0tLS0tLS0tLS0tLS0tLS0tLS0tCgpXQVJOSU5HOiBQcmVmZXIgYSBtYXhpbXVtIDc1IGNo
YXJzIHBlciBsaW5lIChwb3NzaWJsZSB1bndyYXBwZWQgY29tbWl0IGRlc2NyaXB0aW9uPykKIzI2
NDogCjA5OjAwLjAgTmV0d29yayBjb250cm9sbGVyIFswMjgwXTogTUVESUFURUsgQ29ycC4gTVQ3
OTI1IChSWjcxNykgV2ktRmkgNyAxNjBNSHogWzE0YzM6MDcxN10KCkVSUk9SOiBBdm9pZCB1c2lu
ZyBkaWZmIGNvbnRlbnQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIC0gcGF0Y2goMSkgbWlnaHQgbm90
IHdvcmsKIzI3MTogCi0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMKCkVSUk9SOiBJbnZh
bGlkIGNvbW1pdCBzZXBhcmF0b3IgLSBzb21lIHRvb2xzIG1heSBoYXZlIHByb2JsZW1zIGFwcGx5
aW5nIHRoaXMKIzI3MTogCi0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMKCkVSUk9SOiBN
aXNzaW5nIFNpZ25lZC1vZmYtYnk6IGxpbmUocykKCnRvdGFsOiA4IGVycm9ycywgMSB3YXJuaW5n
cywgNDYgbGluZXMgY2hlY2tlZAoKTk9URTogRm9yIHNvbWUgb2YgdGhlIHJlcG9ydGVkIGRlZmVj
dHMsIGNoZWNrcGF0Y2ggbWF5IGJlIGFibGUgdG8KICAgICAgbWVjaGFuaWNhbGx5IGNvbnZlcnQg
dG8gdGhlIHR5cGljYWwgc3R5bGUgdXNpbmcgLS1maXggb3IgLS1maXgtaW5wbGFjZS4KCi9naXRo
dWIvd29ya3NwYWNlL3NyYy9wYXRjaC8xNDc2NjAzMS5wYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMs
IHBsZWFzZSByZXZpZXcuCgpOT1RFOiBJZ25vcmVkIG1lc3NhZ2UgdHlwZXM6IFVOS05PV05fQ09N
TUlUX0lECgpOT1RFOiBJZiBhbnkgb2YgdGhlIGVycm9ycyBhcmUgZmFsc2UgcG9zaXRpdmVzLCBw
bGVhc2UgcmVwb3J0CiAgICAgIHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZSBDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBH
aXRMaW50IC0gRkFJTApEZXNjOiBSdW4gZ2l0bGludApPdXRwdXQ6Ck1UNzkyNSAoMGU4ZDowNzE3
KTogSEZQIG1pY3JvcGhvbmUgdW51c2FibGUg4oCUIGZpcm13YXJlIGRlbGl2ZXJzIHplcm8tZmls
bGVkIChlKVNDTyBmcmFtZXMgb24gc2VudGluZWwgaGFuZGxlIDB4MEUwMAoKMTogQ0MxIEJvZHkg
ZG9lcyBub3QgY29udGFpbiBhICdTaWduZWQtb2ZmLWJ5JyBsaW5lCjE6IFQxIFRpdGxlIGV4Y2Vl
ZHMgbWF4IGxlbmd0aCAoMTE1PjgwKTogIk1UNzkyNSAoMGU4ZDowNzE3KTogSEZQIG1pY3JvcGhv
bmUgdW51c2FibGUg4oCUIGZpcm13YXJlIGRlbGl2ZXJzIHplcm8tZmlsbGVkIChlKVNDTyBmcmFt
ZXMgb24gc2VudGluZWwgaGFuZGxlIDB4MEUwMCIKMTE2OiBCMSBMaW5lIGV4Y2VlZHMgbWF4IGxl
bmd0aCAoODU+ODApOiAiWyA0ODM3Ljg3NjA0OF0gQmx1ZXRvb3RoOiBoY2kwOiBIVy9TVyBWZXJz
aW9uOiAweDAwMDAwMDAwLCBCdWlsZCBUaW1lOiAyMDI2MDYwNTE4NDkzNSIKMTE4OiBCMSBMaW5l
IGV4Y2VlZHMgbWF4IGxlbmd0aCAoMTE1PjgwKTogIlsgNDgzOS43MDUzMjRdIEJsdWV0b290aDog
aGNpMDogSENJIEVuaGFuY2VkIFNldHVwIFN5bmNocm9ub3VzIENvbm5lY3Rpb24gY29tbWFuZCBp
cyBhZHZlcnRpc2VkLCBidXQgbm90IHN1cHBvcnRlZC4iCjE0MjogQjEgTGluZSBleGNlZWRzIG1h
eCBsZW5ndGggKDEwMz44MCk6ICJMaW51eCB1bGRpeHhpb24gNy4yLjAtMS1jYWNoeW9zICMxIFNN
UCBQUkVFTVBUX0RZTkFNSUMgVGh1LCAyMCBBdWcgMjAyNiAwNjowNjozMCArMDAwMCB4ODZfNjQg
R05VL0xpbnV4IgoxNTU6IEIxIExpbmUgZXhjZWVkcyBtYXggbGVuZ3RoICg5MT44MCk6ICIwOTow
MC4wIE5ldHdvcmsgY29udHJvbGxlciBbMDI4MF06IE1FRElBVEVLIENvcnAuIE1UNzkyNSAoUlo3
MTcpIFdpLUZpIDcgMTYwTUh6IFsxNGMzOjA3MTddIgoxNTk6IEIxIExpbmUgZXhjZWVkcyBtYXgg
bGVuZ3RoICgxMTA+ODApOiAi0LDQstCzIDI0IDE1OjQ4OjMwIHVsZGl4eGlvbiBrZXJuZWw6IG10
NzkyNWUgMDAwMDowOTowMC4wOiBIVy9TVyBWZXJzaW9uOiAweDhhMTA4YTEwLCBCdWlsZCBUaW1l
OiAyMDI2MDYwNTE4NDY1MWEiCjE2MDogQjEgTGluZSBleGNlZWRzIG1heCBsZW5ndGggKDExNT44
MCk6ICLQsNCy0LMgMjQgMTU6NDg6MzAgdWxkaXh4aW9uIGtlcm5lbDogbXQ3OTI1ZSAwMDAwOjA5
OjAwLjA6IFdNIEZpcm13YXJlIFZlcnNpb246IF9fX18wMDAwMDAsIEJ1aWxkIFRpbWU6IDIwMjYw
NjA1MTg0ODA1IgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogU3ViamVjdFBy
ZWZpeCAtIEZBSUwKRGVzYzogQ2hlY2sgc3ViamVjdCBjb250YWlucyAiQmx1ZXRvb3RoIiBwcmVm
aXgKT3V0cHV0OgoiQmx1ZXRvb3RoOiAiIHByZWZpeCBpcyBub3Qgc3BlY2lmaWVkIGluIHRoZSBz
dWJqZWN0CiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja0tlcm5lbExM
Vk0gLSBTS0lQCkRlc2M6IEJ1aWxkIGtlcm5lbCB3aXRoIExMVk0gKyBjb250ZXh0IGFuYWx5c2lz
Ck91dHB1dDoKQ2xhbmcgbm90IGZvdW5kCgoKaHR0cHM6Ly9naXRodWIuY29tL2JsdWV6L2JsdWV0
b290aC1uZXh0L3B1bGwvNjQ3CgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============4060491149959171901==--
