Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6A721257E
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763577968; cv=none; b=j4RVgBW8N2X9V7vJL0jLP2M8GHCTDleFTljjXxEnRVlWnAtbzYAWjABq3k8yhXhXIKedIrUIm8rOoFKIR2FjG7HHi1mXWRDCjCdanUMUJr4G3Sm5R6aC870qksYGGnW4A2ixBIDm70oBKkEuyt9OaWXHrvSFblKsuvVzc9LlV5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763577968; c=relaxed/simple;
	bh=3ED5AgQ9dFH9nsvtoZsO0kc8A9BMbIaFvzpkMF784VU=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To; b=lE/KbaG8tztQxGWgHBbA5w9EtZhn27B7YwAshOZF8oNFY0xFTLFWfpHij8lseCegmIi9NtM/CQxhI6A0rzT1nJS/4e7blMmTGOQ1HxhE9EZl8QHXidV309N5ATi0+Ax7BzfGF/lDcTkJ7udAnIu52aWS2UmZStp3NSsmHqf1buU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEpVn9Lv; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEpVn9Lv"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7ba92341f83so55178b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 10:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763577959; x=1764182759; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:subject:references:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ED5AgQ9dFH9nsvtoZsO0kc8A9BMbIaFvzpkMF784VU=;
        b=UEpVn9Lv2ro4mMsVQb2my4Ag6CS0mvUEnKYE/GjMWmcxMCWCQZ+CqCeo6uaJ+gGm3U
         p+ztcSHlyEFyZiQVmdHa5nv/tTHpv20Y8s36wDbPCnmgztFTl/4PZE+07IUTKV5nWEeT
         R8saf/woN61pr6eolP6z1giWQ3zPzJvIJyTvWB7sUAEf9K/MweHInu5ts7OFwim/rIyC
         gx0WojMhbhicqpSniInq5rfzCbl4AoboLIuDA0M28QFDIaGtjLTqWjhIKqV2pj+z4VzR
         TjwVnViujgK6gucYB1QHqsbhMdFwL/TWD/u8S95x33u1NIwi7BlQcr7RDRS0cWPfVmEV
         b1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763577959; x=1764182759;
        h=in-reply-to:from:content-language:subject:references:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ED5AgQ9dFH9nsvtoZsO0kc8A9BMbIaFvzpkMF784VU=;
        b=jxSJD7AZdlerRUE+7mOY76/+nZjovRcCmJhmFZkSPJEw2Y1PhOnMJeT8PdlSSs5kpC
         hypxHjD0i/aX7QS4bHv8OJZ8bRbxHL7KSjxf1R9M5rww4RCebNkc8I7ICX8Y/xwFiTtY
         VoJyEMiVu9e6i4N3RJ6vYZJcCY3VUH+aQkiOmzgVAL+Mtepp88EBCjf236flhx4IxkXz
         ICeqP8L62pJ4tuamg7YD4SOeRGq0dCbfzwbYyNitx8dgj1jaJRZT4/WVoivZzC1K42XJ
         5zUi6bacYSwAT2Ge8F+RTczPnuIyB9Rsw5pEepAeg+k3BS30cDcrG50vH4dYp6/8MxvP
         S69Q==
X-Gm-Message-State: AOJu0Yyu6eDOaRv6PS/PXaDAWQCIyWApdJx1XJkkCEcHXRJ0WsoTq08h
	PDWa+vCIFU1CiuQdR/ffW2zc+FMJrrtZfVlDfniJimkNs1Psml3Pp7l4
X-Gm-Gg: ASbGncv/A5QQHfucpqsbguOzPh7E/iD7RX1OXLwFuva9gCh4H1RASRMgxEE5Pqqv1/2
	m3Ws1U/Bjim3HiW8q3snrCjAmKLXXT7iJBVTUVYFPI5dYSkMyNT9GAgGZO6DjVVh3gtOpEJPh/y
	UZKvMdk9VepoqgVGkduBpyQJ5+BCgtLzD/coaGFMcNklGl3FHyseeBRBh62ecPVaK+wSJCicGes
	gQqwLf4+IyoqzVPbXLDSwIoVLSD0128j9qIl/BOl3sO72XICgwiVaXQ4UDXfT6r7P/5APSFfwEC
	bjdvOoIutJlS7SImGT6pfKvzsmt2uYYz8SEw6VlZiXCjwzY4EE5Ee9rRUWulLpsoVaXJ12kykOR
	NjlWQmp3wX09bdIbL1U1QPxnjexT9uV3ta7kOy5pmb1fAI1iPJx2hALybHn1QpKXT609jnhSn0t
	uGPyWjSVHnmM5/9srXYDJXFRX1LDDsJVKdB/Rbhq5QjkVnstwa8aYxT5c=
X-Google-Smtp-Source: AGHT+IEvPtbmZfjyl+3cOqU5e06CHgKRKQUBIYlz5zNEX/mMFJLIkZWLFkpqeK1gHz8lIBJkZ8GIXw==
X-Received: by 2002:a05:6a00:2e87:b0:7ad:9470:27a1 with SMTP id d2e1a72fcca58-7c3f0e69f6cmr141808b3a.28.1763577958832;
        Wed, 19 Nov 2025 10:45:58 -0800 (PST)
Received: from ?IPV6:2405:201:31:d869:f90c:b1d6:a722:7f9d? ([2405:201:31:d869:f90c:b1d6:a722:7f9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0b69d16sm60492b3a.53.2025.11.19.10.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 10:45:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------WXWdXnzHHMcitnV0hCUir8rM"
Message-ID: <6d2a1c9f-d4db-496d-9230-e41e5166eb86@gmail.com>
Date: Thu, 20 Nov 2025 00:15:54 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+f098d64cc684b8dbaf65@syzkaller.appspotmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <691b301e.a70a0220.f6df1.0011.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] [usb?] memory leak in __hci_cmd_sync_sk
Content-Language: en-US
From: shaurya <ssranevjti@gmail.com>
In-Reply-To: <691b301e.a70a0220.f6df1.0011.GAE@google.com>

This is a multi-part message in MIME format.
--------------WXWdXnzHHMcitnV0hCUir8rM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

--------------WXWdXnzHHMcitnV0hCUir8rM
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Bluetooth-hci_sync-fix-memory-leak-in-__hci_cmd_sync.patch"
Content-Disposition: attachment;
 filename*0="0001-Bluetooth-hci_sync-fix-memory-leak-in-__hci_cmd_sync.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAzMWM5M2ZiYzM3ZDY5OWU0OThjZjUxZjdkYzE3ZTY5Y2IyMTBmYWFmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTaGF1cnlhIFJhbmUgPHNzcmFuZV9iMjNAZWUudmp0
aS5hYy5pbj4KRGF0ZTogVGh1LCAyMCBOb3YgMjAyNSAwMDoxMTo0MCArMDUzMApTdWJqZWN0
OiBbUEFUQ0hdIEJsdWV0b290aDogaGNpX3N5bmM6IGZpeCBtZW1vcnkgbGVhayBpbiBfX2hj
aV9jbWRfc3luY19zawoKRml4IGEgbWVtb3J5IGxlYWsgaW4gX19oY2lfY21kX3N5bmNfc2sg
d2hlcmUgYWxsb2NhdGVkIHJlcXVlc3QgY29tbWFuZApTS0JzIGFyZSBub3QgcHJvcGVybHkg
Y2xlYW5lZCB1cCB3aGVuIHRoZSBmdW5jdGlvbiBmYWlscy4KClRoZSBpc3N1ZSBvY2N1cnMg
d2hlbiBoY2lfY21kX3N5bmNfYWxsb2MoKSBzdWNjZXNzZnVsbHkgYWxsb2NhdGVzIGFuIFNL
QgphbmQgaXQgZ2V0cyBxdWV1ZWQgdmlhIGhjaV9jbWRfc3luY19hZGQoKSwgYnV0IHRoZW4g
X19oY2lfY21kX3N5bmNfc2soKQpmYWlscyBkdWUgdG8gdGltZW91dCwgaW50ZXJydXB0aW9u
LCBvciBjYW5jZWxsYXRpb24uIEluIHRoZXNlIGVycm9yCnBhdGhzLCB0aGUgcmVxX3NrYiB0
aGF0IHdhcyBjbG9uZWQgYW5kIHN0b3JlZCBpbiBoZGV2LT5yZXFfc2tiIGlzIG5vdApmcmVl
ZCwgbGVhZGluZyB0byBtZW1vcnkgbGVha3MuCgpUaGUgbWVtb3J5IGxlYWsgY2FuIGJlIHJl
cHJvZHVjZWQgd2hlbiBfX2hjaV9jbWRfc3luY19zaygpIGFsbG9jYXRlcwphbmQgcXVldWVz
IGFuIEhDSSBjb21tYW5kIFNLQiwgYW5kIGhjaV9yZXFfc3luY19ydW4oKSB0cmFuc2ZlcnMg
dGhpcwpTS0IgdG8gaGRldi0+Y21kX3EgYW5kIGNsb25lcyBpdCB0byBoZGV2LT5yZXFfc2ti
LiBJZiB0aGUgc3Vic2VxdWVudAp3YWl0X2V2ZW50X2ludGVycnVwdGlibGVfdGltZW91dCgp
IGNhbGwgZmFpbHMgKGR1ZSB0byB0aW1lb3V0IG9yCmludGVycnVwdGlvbiksIHRoZSBmdW5j
dGlvbiByZXR1cm5zIGFuIGVycm9yIHdpdGhvdXQgaGRldi0+cmVxX3NrYgpldmVyIGJlaW5n
IGNsZWFuZWQgdXAuCgpUaGUgZml4IGVuc3VyZXMgdGhhdCB3aGVuIF9faGNpX2NtZF9zeW5j
X3NrKCkgcmV0dXJucyBhbiBlcnJvciwgYW55CnBlbmRpbmcgcmVxdWVzdCBjb21tYW5kIFNL
QiBpbiBoZGV2LT5yZXFfc2tiIGlzIHByb3Blcmx5IGZyZWVkIGJlZm9yZQpyZXR1cm5pbmcu
IFRoaXMgbWF0Y2hlcyB0aGUgY2xlYW51cCBwYXR0ZXJuIHVzZWQgZWxzZXdoZXJlIGluIHRo
ZSBIQ0kKc3luYyBjb2RlLgoKUmVwb3J0ZWQtYnk6IHN5emJvdCtmMDk4ZDY0Y2M2ODRiOGRi
YWY2NUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCkNsb3NlczogaHR0cHM6Ly9zeXprYWxs
ZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPWYwOThkNjRjYzY4NGI4ZGJhZjY1ClNpZ25lZC1v
ZmYtYnk6IFNoYXVyeWEgUmFuZSA8c3NyYW5lX2IyM0BlZS52anRpLmFjLmluPgotLS0KIG5l
dC9ibHVldG9vdGgvaGNpX3N5bmMuYyB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL2hjaV9zeW5jLmMgYi9u
ZXQvYmx1ZXRvb3RoL2hjaV9zeW5jLmMKaW5kZXggNmU3Njc5OGVjNzg2Li5mYmFhNTc0OWFk
N2IgMTAwNjQ0Ci0tLSBhL25ldC9ibHVldG9vdGgvaGNpX3N5bmMuYworKysgYi9uZXQvYmx1
ZXRvb3RoL2hjaV9zeW5jLmMKQEAgLTIwMyw2ICsyMDMsMTEgQEAgc3RydWN0IHNrX2J1ZmYg
Kl9faGNpX2NtZF9zeW5jX3NrKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCB1MTYgb3Bjb2RlLCB1
MzIgcGxlbiwKIAogCWlmIChlcnIgPCAwKSB7CiAJCWtmcmVlX3NrYihza2IpOworCQkvKiBD
bGVhbiB1cCBhbnkgcGVuZGluZyByZXF1ZXN0IGNvbW1hbmQgKi8KKwkJaWYgKGhkZXYtPnJl
cV9za2IpIHsKKwkJCWtmcmVlX3NrYihoZGV2LT5yZXFfc2tiKTsKKwkJCWhkZXYtPnJlcV9z
a2IgPSBOVUxMOworCQl9CiAJCXJldHVybiBFUlJfUFRSKGVycik7CiAJfQogCi0tIAoyLjM0
LjEKCg==

--------------WXWdXnzHHMcitnV0hCUir8rM--
