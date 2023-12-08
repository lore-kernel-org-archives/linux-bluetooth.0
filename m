Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgupbazh"
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC62B1727
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 00:28:49 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-77f44cd99c6so85960085a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Dec 2023 00:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702024128; x=1702628928; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OV3ZmSfhMqr7ucbpBmbHavne5avy8MkJLBKwmK0QaLo=;
        b=cgupbazhZIYIr2aPbdjkhYSi4WNQ4gZSc8HNi5Nc9d/+LWs5nBjAqXskIr+hJFHj9a
         AoF+hguhIYDD89XoPdHWCL/ovYIutv43FXcf3s5v4NSXnuCTUeG3+fNM2T0syFKVgR86
         X60MKQsxjOgBoYQ/3zo8dMFY2tGH64HFL5FbZkk10Z3wi7pyJu4AUxSvbqD90/upXFO4
         Tbm8FqtKtrM5B01BtGh9qGNokLPpuecT8i1rReRdVZqHIfhj3tWc9n4kPL2BCjxrlWfO
         M4Vu7O2UlOtcsNQieBd8WmJAwXPRAopNPPX8HuiTdPeprq1Jrs5jZ7JExLneFgSDaOUv
         t4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702024128; x=1702628928;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OV3ZmSfhMqr7ucbpBmbHavne5avy8MkJLBKwmK0QaLo=;
        b=YBRz+mWW7HZWxtOlDJIgoOgLD3pn+9AKM7xawmRlWcTPVkjrPAyB4IxiLNItj79bgB
         ZNaxrMqFs6J+nwGaA0ZAnRAbwJo9LPax48V/dxpl674ZQl7MzczhKwKN5SDLdvQbUlhX
         sJmmRhwKp1tjIRQzjpFFE1UaAEqEBOwpqWhz6AAXKS0O2qlvVhxCM5ZyS0/CpnU15fh/
         MPiVUx/M3f4DqD2+ZexryjV8CNPncj/ev9Q5a2Rv7ZmLlxp/aJKTnXBfekQpuuuVKD5I
         6RHOQiIGDZy+AyoGasCoAob1wJLnhLy/WEXcVfTOzsu8eCu0EdM8c5HO4OFnXWWM5Ro4
         6LGA==
X-Gm-Message-State: AOJu0Yw6FekQnt7xVK48i7aXK/5d/NJ9lKwcbdIw9UXHulwzrAo0hJUn
	DiNGd9/x6v/AUu9vfHljSHYRhxa23eo=
X-Google-Smtp-Source: AGHT+IHrlfNtfweQdWpqKq+58S0kCGFYGhx5DtKcw60pXTedeOetgT92NPz1zt1Fx/epYyZ1Pt5vLA==
X-Received: by 2002:a05:620a:2685:b0:779:e19b:64f5 with SMTP id c5-20020a05620a268500b00779e19b64f5mr767147qkp.21.1702024128565;
        Fri, 08 Dec 2023 00:28:48 -0800 (PST)
Received: from [172.17.0.2] ([20.55.15.17])
        by smtp.gmail.com with ESMTPSA id br16-20020a05620a461000b007659935ce64sm531722qkb.71.2023.12.08.00.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 00:28:48 -0800 (PST)
Message-ID: <6572d3c0.050a0220.77b7b.2b11@mx.google.com>
Date: Fri, 08 Dec 2023 00:28:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8256662393085080879=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] tools: avtest: Add reject-code option
In-Reply-To: <20231208070740.611032-1-frederic.danis@collabora.com>
References: <20231208070740.611032-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8256662393085080879==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9ODA4MTM3CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBGQUlMICAgICAgMC43MSBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIFBB
U1MgICAgICAwLjMzIHNlY29uZHMKQnVpbGRFbGwgICAgICAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDIzLjk3IHNlY29uZHMKQmx1ZXpNYWtlICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDcyOS44OCBzZWNvbmRzCk1ha2VDaGVjayAgICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICAx
Mi4xNSBzZWNvbmRzCk1ha2VEaXN0Y2hlY2sgICAgICAgICAgICAgICAgIFBBU1MgICAgICAxNTMu
NDEgc2Vjb25kcwpDaGVja1ZhbGdyaW5kICAgICAgICAgICAgICAgICBQQVNTICAgICAgMjE0LjUx
IHNlY29uZHMKQ2hlY2tTbWF0Y2ggICAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDMxOC45NiBz
ZWNvbmRzCmJsdWV6bWFrZWV4dGVsbCAgICAgICAgICAgICAgIFBBU1MgICAgICAxMDAuMjAgc2Vj
b25kcwpJbmNyZW1lbnRhbEJ1aWxkICAgICAgICAgICAgICBQQVNTICAgICAgNjU3LjUyIHNlY29u
ZHMKU2NhbkJ1aWxkICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDg5NS44OSBzZWNvbmRz
CgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja1BhdGNo
IC0gRkFJTApEZXNjOiBSdW4gY2hlY2twYXRjaC5wbCBzY3JpcHQKT3V0cHV0OgpbQmx1ZVpdIHRv
b2xzOiBhdnRlc3Q6IEFkZCByZWplY3QtY29kZSBvcHRpb24KV0FSTklORzpDT01NSVRfTE9HX0xP
TkdfTElORTogUG9zc2libGUgdW53cmFwcGVkIGNvbW1pdCBkZXNjcmlwdGlvbiAocHJlZmVyIGEg
bWF4aW11bSA3NSBjaGFycyBwZXIgbGluZSkKIzQ2OiAKU29tZSBQVFMgdGVzdHMgbGlrZSBBMkRQ
L1NOSy9BVlAvQkktMDMtQywgQTJEUC9TTksvQVZQL0JJLTA4LUMgLCDigKYgcmVxdWVzdAoKV0FS
TklORzpMT05HX0xJTkU6IGxpbmUgbGVuZ3RoIG9mIDk0IGV4Y2VlZHMgODAgY29sdW1ucwojNjM6
IEZJTEU6IHRvb2xzL2F2dGVzdC5jOjE5MToKKwkJCQkJCQkJaW50IGZyYWdtZW50LCBpbnQgcmVq
ZWN0X2NvZGUpCgpXQVJOSU5HOkxPTkdfTElORV9DT01NRU5UOiBsaW5lIGxlbmd0aCBvZiA5MSBl
eGNlZWRzIDgwIGNvbHVtbnMKIzcyOiBGSUxFOiB0b29scy9hdnRlc3QuYzoyODc6CisJCQkJYnVm
WzNdID0gcmVqZWN0X2NvZGUgPyByZWplY3RfY29kZSA6IDB4MTM7IC8qIFNFUCBJbiBVc2UgKi8K
CldBUk5JTkc6TE9OR19MSU5FOiBsaW5lIGxlbmd0aCBvZiA5NSBleGNlZWRzIDgwIGNvbHVtbnMK
IzgxOiBGSUxFOiB0b29scy9hdnRlc3QuYzo0NDY6CitzdGF0aWMgdm9pZCBkb19saXN0ZW4oY29u
c3QgYmRhZGRyX3QgKnNyYywgdW5zaWduZWQgY2hhciByZWplY3QsIGludCBmcmFnbWVudCwgaW50
IHJlamVjdF9jb2RlKQoKL2dpdGh1Yi93b3Jrc3BhY2Uvc3JjL3NyYy8xMzQ4NDk1NS5wYXRjaCB0
b3RhbDogMCBlcnJvcnMsIDQgd2FybmluZ3MsIDc4IGxpbmVzIGNoZWNrZWQKCk5PVEU6IEZvciBz
b21lIG9mIHRoZSByZXBvcnRlZCBkZWZlY3RzLCBjaGVja3BhdGNoIG1heSBiZSBhYmxlIHRvCiAg
ICAgIG1lY2hhbmljYWxseSBjb252ZXJ0IHRvIHRoZSB0eXBpY2FsIHN0eWxlIHVzaW5nIC0tZml4
IG9yIC0tZml4LWlucGxhY2UuCgovZ2l0aHViL3dvcmtzcGFjZS9zcmMvc3JjLzEzNDg0OTU1LnBh
dGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4KCk5PVEU6IElnbm9yZWQgbWVz
c2FnZSB0eXBlczogQ09NTUlUX01FU1NBR0UgQ09NUExFWF9NQUNSTyBDT05TVF9TVFJVQ1QgRklM
RV9QQVRIX0NIQU5HRVMgTUlTU0lOR19TSUdOX09GRiBQUkVGRVJfUEFDS0VEIFNQRFhfTElDRU5T
RV9UQUcgU1BMSVRfU1RSSU5HIFNTQ0FORl9UT19LU1RSVE8KCk5PVEU6IElmIGFueSBvZiB0aGUg
ZXJyb3JzIGFyZSBmYWxzZSBwb3NpdGl2ZXMsIHBsZWFzZSByZXBvcnQKICAgICAgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlIENIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoKCgotLS0KUmVn
YXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============8256662393085080879==--
