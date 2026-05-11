Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0093FBEA3
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509669; cv=none; b=BYTv2NPU7VSHRGlI5ZP3o5naT4cFuJY5CEKUKgx1McfU4tES/NMUGzQQoGaiA4nr/nlgSR582TKbH1b6GRGbBmhNhaxYNnlcPWKHz7mm+wouFwR6nwKmXX8J0LAdmGEmue0x+lwpVihxvMLVhxroY49lAiFAlx01QTN8K+nFb5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509669; c=relaxed/simple;
	bh=b7I5DH/793cw9uF3yMa6enJUHDG9FlhKEV/iz5Q50Rg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=efxHEp77NTl/j+U+itldf+CmXmmxDNvn/iOklDTk/dxxI6ou+nUbewStIDX/5NEAj8DlfGnoFkStsfrcGLJrWSl8XstzqfEcepp3fl9VL0gWtnRPVmAD0+qwafdeCxiHuzT8zQgAf4sqGmmRXBW7qvWa4T+rMXJTrrWcXMXj/5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gn/rolgN; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gn/rolgN"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8ef0ba61d46so500581185a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 07:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778509666; x=1779114466; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b7I5DH/793cw9uF3yMa6enJUHDG9FlhKEV/iz5Q50Rg=;
        b=gn/rolgNAjWKSorjUUhIJpVm5WwNop7M8OP3A/KLw9+oDyntypMGgeMaqBnULbccch
         iCr52tmpUSnxJ0EXUUtFctsVD8OWH3I5vou0LRriDc4tHt8RakRc1rjAkwV00V8TCu+S
         H1XOvpdxi71B87ezXLcs4IYDC9c8d4IJmEHg2TJlzS2mViJzxx8nrXqtgMCY8lViWo9S
         /vk7GSbSpt2J6fnV9PmXWJ7tzGcGzHHNwol1U3A1l3FcHKi3gOebEA7CXrRnvVBLikuG
         DYFX7jM9QG8JcTgKBRD1gIt/r2HunjPgqMdsNYM44ZonCiVY0IhYCDNNrsnUtwLuKpvM
         TCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778509666; x=1779114466;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7I5DH/793cw9uF3yMa6enJUHDG9FlhKEV/iz5Q50Rg=;
        b=X4StnhH9VnRujgBJpjPzrIMJBZMRcdj7WNc6GyHdIjKdzsPYiIKmQpn/n7fCtia5TT
         dlj9NS1RB59lfe/saIMWByy+xrXUriOGF9RRzwgawMSL6Kh8YmxVCByUPtbFDzt0o2Rt
         UKz1zucZ6gm4U8+bNUuR2YmBaFcPIkWaEllY3hHbfTZG40PTB7njv8zxqc9Nx4cqO89N
         itjoKBEQU544dbEH++1PfiREvIoTi6zjBLPpTrwaLIPIlAb83rhlPlv7g8Nf7G5EwNXM
         nSuyLQ5AZnbtXHwbE/i/UEHQ6y9PygkRSdQYJdhL3N57wtILlbZR+JfbgTtNMu387qLx
         WKHw==
X-Gm-Message-State: AOJu0Yxxt7aWSJVX3dQrbJlftlZvySRPzIJVdrxh3UvDlKKQ+QDeq+FN
	g5BooswXZtsulHHw2VBnZU6qJ3I3pmcihE3q/rxhwQvly2Pt12HTTx1je67d1w==
X-Gm-Gg: Acq92OE52QCNKCwtrTXNk67qpxhh9+Pv48Z0GaDalRC4u+piK6RAfEfuW8AQHL+OlTN
	oLGx1/UjeVbRXZgENBoNhQPgE8J2DnWwlEg5Pxct67mYppmB5BPjlx+AEws6cpU0y1Ro7yazbXd
	QJG50K5ywQVCru+CcAbPATAh11sb6QH/YuaxyfZPZAh9GiQjbqJFG19kNmDhm+giznnBWzJ5eFi
	7RtDsz2lXeMch08Dol2Uy6fGqyp7FOyFQCLZE09+TFYrNOOXH47R6oore8sbyLC5r8G6XbtDg82
	QCP6cF4HqixafdyJNDNQjPJp1s9oYCXbS2oXnqMyjfERyMOZO6SLEg1dAwDu8YHoLLe7Di6bwl6
	zPcxncVZZUxINJU7LYfSahWRNjNyMosg3J53hYxpD/LgdO3roYj7MPW7hH8DYlutuORs/7ZjWgP
	97D+4r+oUFVXHwDTeBYWFKj2pxXNvP1sIN3bsfV57ecw==
X-Received: by 2002:a05:622a:391:b0:50f:bc91:709 with SMTP id d75a77b69052e-51461fbca53mr344940331cf.39.1778509665993;
        Mon, 11 May 2026 07:27:45 -0700 (PDT)
Received: from [172.17.0.2] ([52.152.180.203])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5149bf65846sm76260651cf.19.2026.05.11.07.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:27:45 -0700 (PDT)
Message-ID: <6a01e761.050a0220.2bd27.9332@mx.google.com>
Date: Mon, 11 May 2026 07:27:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9068463889603315809=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,1/3] mesh: Remove unused but set variable
In-Reply-To: <20260511113511.1217887-1-hadess@hadess.net>
References: <20260511113511.1217887-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9068463889603315809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9MTA5MjcyNAoKLS0t
VGVzdCByZXN1bHQtLS0KClRlc3QgU3VtbWFyeToKQ2hlY2tQYXRjaCAgICAgICAgICAgICAgICAg
ICAgRkFJTCAgICAgIDEuNDUgc2Vjb25kcwpHaXRMaW50ICAgICAgICAgICAgICAgICAgICAgICBG
QUlMICAgICAgMS4wNCBzZWNvbmRzCkJ1aWxkRWxsICAgICAgICAgICAgICAgICAgICAgIFBBU1Mg
ICAgICAyMC41MCBzZWNvbmRzCkJsdWV6TWFrZSAgICAgICAgICAgICAgICAgICAgIFBBU1MgICAg
ICA2MTAuNzMgc2Vjb25kcwpNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAg
MS4wNCBzZWNvbmRzCk1ha2VEaXN0Y2hlY2sgICAgICAgICAgICAgICAgIFBBU1MgICAgICAyMzUu
Njcgc2Vjb25kcwpDaGVja1ZhbGdyaW5kICAgICAgICAgICAgICAgICBQQVNTICAgICAgMjAxLjk3
IHNlY29uZHMKQ2hlY2tTbWF0Y2ggICAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDMyMi4xMiBz
ZWNvbmRzCmJsdWV6bWFrZWV4dGVsbCAgICAgICAgICAgICAgIFBBU1MgICAgICAxNjQuODIgc2Vj
b25kcwpJbmNyZW1lbnRhbEJ1aWxkICAgICAgICAgICAgICBQQVNTICAgICAgNjA0LjQ1IHNlY29u
ZHMKU2NhbkJ1aWxkICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDkwNS44MyBzZWNvbmRz
CgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja1BhdGNo
IC0gRkFJTApEZXNjOiBSdW4gY2hlY2twYXRjaC5wbCBzY3JpcHQKT3V0cHV0OgpbQmx1ZVosMi8z
XSBtZXNoOiBGaXggc3Rye3IsfWNociB1c2FnZQpXQVJOSU5HOkxPTkdfTElORTogbGluZSBsZW5n
dGggb2YgODIgZXhjZWVkcyA4MCBjb2x1bW5zCiM5NTogRklMRTogdG9vbHMvbWVzaC9tZXNoLWRi
LmM6MjU4OToKKwlzdHJfcyA9IGpzb25fb2JqZWN0X3RvX2pzb25fc3RyaW5nX2V4dChleHB0X2Nm
ZywgSlNPTl9DX1RPX1NUUklOR19QUkVUVFkgfAoKL2dpdGh1Yi93b3Jrc3BhY2Uvc3JjL3BhdGNo
LzE0NTY1MzU4LnBhdGNoIHRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgNDEgbGluZXMgY2hl
Y2tlZAoKTk9URTogRm9yIHNvbWUgb2YgdGhlIHJlcG9ydGVkIGRlZmVjdHMsIGNoZWNrcGF0Y2gg
bWF5IGJlIGFibGUgdG8KICAgICAgbWVjaGFuaWNhbGx5IGNvbnZlcnQgdG8gdGhlIHR5cGljYWwg
c3R5bGUgdXNpbmcgLS1maXggb3IgLS1maXgtaW5wbGFjZS4KCi9naXRodWIvd29ya3NwYWNlL3Ny
Yy9wYXRjaC8xNDU2NTM1OC5wYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcu
CgpOT1RFOiBJZ25vcmVkIG1lc3NhZ2UgdHlwZXM6IENPTU1JVF9NRVNTQUdFIENPTVBMRVhfTUFD
Uk8gQ09OU1RfU1RSVUNUIEZJTEVfUEFUSF9DSEFOR0VTIE1JU1NJTkdfU0lHTl9PRkYgUFJFRkVS
X1BBQ0tFRCBTUERYX0xJQ0VOU0VfVEFHIFNQTElUX1NUUklORyBTU0NBTkZfVE9fS1NUUlRPCgpO
T1RFOiBJZiBhbnkgb2YgdGhlIGVycm9ycyBhcmUgZmFsc2UgcG9zaXRpdmVzLCBwbGVhc2UgcmVw
b3J0CiAgICAgIHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZSBDSEVDS1BBVENIIGluIE1BSU5U
QUlORVJTLgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBHaXRMaW50IC0g
RkFJTApEZXNjOiBSdW4gZ2l0bGludApPdXRwdXQ6CltCbHVlWiwxLzNdIG1lc2g6IFJlbW92ZSB1
bnVzZWQgYnV0IHNldCB2YXJpYWJsZQoKV0FSTklORzogSTMgLSBpZ25vcmUtYm9keS1saW5lczog
Z2l0bGludCB3aWxsIGJlIHN3aXRjaGluZyBmcm9tIHVzaW5nIFB5dGhvbiByZWdleCAnbWF0Y2gn
IChtYXRjaCBiZWdpbm5pbmcpIHRvICdzZWFyY2gnIChtYXRjaCBhbnl3aGVyZSkgc2VtYW50aWNz
LiBQbGVhc2UgcmV2aWV3IHlvdXIgaWdub3JlLWJvZHktbGluZXMucmVnZXggb3B0aW9uIGFjY29y
ZGluZ2x5LiBUbyByZW1vdmUgdGhpcyB3YXJuaW5nLCBzZXQgZ2VuZXJhbC5yZWdleC1zdHlsZS1z
ZWFyY2g9VHJ1ZS4gTW9yZSBkZXRhaWxzOiBodHRwczovL2pvcmlzcm9vdmVycy5naXRodWIuaW8v
Z2l0bGludC9jb25maWd1cmF0aW9uLyNyZWdleC1zdHlsZS1zZWFyY2gKNjogQjEgTGluZSBleGNl
ZWRzIG1heCBsZW5ndGggKDk4PjgwKTogIm1lc2gvbmV0LmM6MTU2OToxODogZXJyb3I6IHZhcmlh
YmxlIOKAmGFja19jb3B54oCZIHNldCBidXQgbm90IHVzZWQgWy1XZXJyb3I9dW51c2VkLWJ1dC1z
ZXQtdmFyaWFibGU9XSIKW0JsdWVaLDIvM10gbWVzaDogRml4IHN0cntyLH1jaHIgdXNhZ2UKCldB
Uk5JTkc6IEkzIC0gaWdub3JlLWJvZHktbGluZXM6IGdpdGxpbnQgd2lsbCBiZSBzd2l0Y2hpbmcg
ZnJvbSB1c2luZyBQeXRob24gcmVnZXggJ21hdGNoJyAobWF0Y2ggYmVnaW5uaW5nKSB0byAnc2Vh
cmNoJyAobWF0Y2ggYW55d2hlcmUpIHNlbWFudGljcy4gUGxlYXNlIHJldmlldyB5b3VyIGlnbm9y
ZS1ib2R5LWxpbmVzLnJlZ2V4IG9wdGlvbiBhY2NvcmRpbmdseS4gVG8gcmVtb3ZlIHRoaXMgd2Fy
bmluZywgc2V0IGdlbmVyYWwucmVnZXgtc3R5bGUtc2VhcmNoPVRydWUuIE1vcmUgZGV0YWlsczog
aHR0cHM6Ly9qb3Jpc3Jvb3ZlcnMuZ2l0aHViLmlvL2dpdGxpbnQvY29uZmlndXJhdGlvbi8jcmVn
ZXgtc3R5bGUtc2VhcmNoCjg6IEIxIExpbmUgZXhjZWVkcyBtYXggbGVuZ3RoICgxMzA+ODApOiAi
dG9vbHMvbWVzaC9tZXNoLWRiLmM6MjU5ODoxMzogZXJyb3I6IGFzc2lnbm1lbnQgZGlzY2FyZHMg
4oCYY29uc3TigJkgcXVhbGlmaWVyIGZyb20gcG9pbnRlciB0YXJnZXQgdHlwZSBbLVdlcnJvcj1k
aXNjYXJkZWQtcXVhbGlmaWVyc10iCjExOiBCMSBMaW5lIGV4Y2VlZHMgbWF4IGxlbmd0aCAoMTMw
PjgwKTogInRvb2xzL21lc2gvbWVzaC1kYi5jOjI2MDQ6MTM6IGVycm9yOiBhc3NpZ25tZW50IGRp
c2NhcmRzIOKAmGNvbnN04oCZIHF1YWxpZmllciBmcm9tIHBvaW50ZXIgdGFyZ2V0IHR5cGUgWy1X
ZXJyb3I9ZGlzY2FyZGVkLXF1YWxpZmllcnNdIgoxNDogQjEgTGluZSBleGNlZWRzIG1heCBsZW5n
dGggKDEzMD44MCk6ICJ0b29scy9tZXNoL21lc2gtZGIuYzoyNjEzOjEzOiBlcnJvcjogYXNzaWdu
bWVudCBkaXNjYXJkcyDigJhjb25zdOKAmSBxdWFsaWZpZXIgZnJvbSBwb2ludGVyIHRhcmdldCB0
eXBlIFstV2Vycm9yPWRpc2NhcmRlZC1xdWFsaWZpZXJzXSIKW0JsdWVaLDMvM10gbWVzaDogRml4
IGNvbnN0IHF1YWxpZmllciBkcm9wcGluZyB3aGVuIHVzaW5nIHN0cmNocigpCgpXQVJOSU5HOiBJ
MyAtIGlnbm9yZS1ib2R5LWxpbmVzOiBnaXRsaW50IHdpbGwgYmUgc3dpdGNoaW5nIGZyb20gdXNp
bmcgUHl0aG9uIHJlZ2V4ICdtYXRjaCcgKG1hdGNoIGJlZ2lubmluZykgdG8gJ3NlYXJjaCcgKG1h
dGNoIGFueXdoZXJlKSBzZW1hbnRpY3MuIFBsZWFzZSByZXZpZXcgeW91ciBpZ25vcmUtYm9keS1s
aW5lcy5yZWdleCBvcHRpb24gYWNjb3JkaW5nbHkuIFRvIHJlbW92ZSB0aGlzIHdhcm5pbmcsIHNl
dCBnZW5lcmFsLnJlZ2V4LXN0eWxlLXNlYXJjaD1UcnVlLiBNb3JlIGRldGFpbHM6IGh0dHBzOi8v
am9yaXNyb292ZXJzLmdpdGh1Yi5pby9naXRsaW50L2NvbmZpZ3VyYXRpb24vI3JlZ2V4LXN0eWxl
LXNlYXJjaAo3OiBCMSBMaW5lIGV4Y2VlZHMgbWF4IGxlbmd0aCAoMTIwPjgwKTogIm1lc2gvdXRp
bC5jOjEwODoxNDogZXJyb3I6IGFzc2lnbm1lbnQgZGlzY2FyZHMg4oCYY29uc3TigJkgcXVhbGlm
aWVyIGZyb20gcG9pbnRlciB0YXJnZXQgdHlwZSBbLVdlcnJvcj1kaXNjYXJkZWQtcXVhbGlmaWVy
c10iCgoKaHR0cHM6Ly9naXRodWIuY29tL2JsdWV6L2JsdWV6L3B1bGwvMjExNwoKLS0tClJlZ2Fy
ZHMsCkxpbnV4IEJsdWV0b290aAoK

--===============9068463889603315809==--
