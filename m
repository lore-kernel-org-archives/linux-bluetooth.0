Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D0C218AD0
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Dec 2024 13:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733405566; cv=none; b=rHY1+rI7eqqZx+2aC9y2jCl7SQt/toqP+y7m0wolgxmiGWEq9fpPsCKnFWuBoJjLMcVBmAehT9SaAvKyOxB2dWAy0YjtC3dAoUnLM8nB0j5HEzFw7Sz713ruRHGQWIyUaUWvdYhVGhbmQNFE5sEdUMfMayYJNzXRrROspbuDfNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733405566; c=relaxed/simple;
	bh=hqMGKFMfHCRisggZjF2fWoVlAlP14dS2+ftUiHZ+EGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MhgQ6EC8elDoDj1YtPStVOdjbQW2G+rDxqCy2gfzxbczWKpIVrq7qSntj0KyY7cmWDWKUe9n+qW1B6Gu7R7jsrVyqwpBVN3PB9g0AH1FyMPbmym2UiOlaB1u4Y6q4rtZUKEnAkG8BSk0fsFY8ihyjhImjuuHoAI6a11d+/CT2I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=mdEhSE0H; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="mdEhSE0H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733405562; x=1734010362; i=fiona.klute@gmx.de;
	bh=hqMGKFMfHCRisggZjF2fWoVlAlP14dS2+ftUiHZ+EGk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mdEhSE0HkrAeLxnGGkPUV69xf8C99kyYmXUWh/4G4OXRMTgxv5IKFxMuLrCS7cCi
	 S/c+OWpzqzmAo6AHm0fPbKoGcx+viy6k650IQmaCQPagCbaYtZ0tHW9a8X1ATlyEx
	 INUkW8FeHtch1ebtZ6aJm3YI8IUL+4W4EDWsWmyslL3tJ0/7Peqj0QFGK4gldUujK
	 BlkipRIhZ9uvvrxn56lFlpBeX4N2mPBE56k27nvno7RVWm9EkbP9zAxurZTwBdUnm
	 YgoR+gRD/Rd2kS9/KoZNj51HoWxJzL99y2+RNnethHz2J7VOmci/vnLweQsfmGPRK
	 03Up1J4JZNGKJaK0/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.30.37]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmDIo-1u11AH2tii-00eBfj; Thu, 05
 Dec 2024 14:32:41 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-bluetooth@vger.kernel.org
Cc: Fiona Klute <fiona.klute@gmx.de>
Subject: [PATCH BlueZ] Leave config files writable for owner
Date: Thu,  5 Dec 2024 14:32:33 +0100
Message-ID: <20241205133233.1738092-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:AfdvcWB3GF9wbH0PLeY218YdaQQpRHdGml4iNg1m+oB6pUtpljH
 qaEWTxWoE+GI93+i047h4iZ4nfAIkgb/prXohQIYxTK01KOjyHX4S6TBWwGPzpWcrtsDPtj
 EJaTAoDsnYsJVRzf+C4AaDtebBXwD1zWDP5Pxus9rFOsTNcxTZWx7n57xQGPRe++V7N06Y0
 ExNVd0Jxxy0lhEjcS0FBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:07jauETwhNU=;nMP4qvhA9UMDd0RqvMsKBeYKcSv
 4So2G0Oc4cn7yVW6F5HRqkq96Ugm/51kNtkN5qVVduxN0wFfDi4/o9CNiZ9Uh+IniYkkOlr9D
 hREFnfIyD0OAxzUTh0UdnEJhtkogkVhi49jJR0on/MyB7U8GxFS1f4OrJVMkgHV3nhmRaHaR8
 UwxSShbL4hd3oYFHaF/ouoMNmw9dDXCbVHf56s5tJMyuRXPJaYVthfsxsdAfVMsYFbC4lbCfp
 H0XdCSa5j0HC7a3vVYv9Bw8je3y4Tgd4jNY7osQ4PAQlabxdjZ4RpHN6q+XRb3n+7pu6JI5Ie
 Juk1wn367TQve1Q9N7yQykllQlBNRWwRsdTS4iley2V9LOvE5BfZI7aT9YNHqyWxPu1HaZFLB
 vRkQw52kv7p9LTvYGTRzO6ogpS8crsXnUJbepJ5htiIQXc/PnVWeDhHJhz8P4AKLG7k6gUfeP
 UUYYZl0Wh8X7qoHtqHTEehwW4uEumj4imf3bygBrSR0I2k5WCwZYuCgiu21AyMDl9sm3rlGM0
 dEizwXZasu/svKeF0F49UujM1LIWB7l0xZi+fO3xZyU/pY2P0YvctaoqAFn+lPNgSoPQuYKXB
 L419cx9xPV9Tf4PeIY0UiiwcBL82WrYfi74ARDi+mRY1fll8kQdTUw5K1f+bkXmUq22q91+5y
 uqlD+uz5cYQTk4uiuucPGbGspBYglzzq3ZSja/6Ir9tRWI77b7YFz0sf2uidlkf9yAFEBsYNt
 Zna6FkHZb1BhcGgAIQGtWHIbz3E9Bb+SlaUvpY+egnWV5Mo+KbpiQ0fRcctpFqSRVzAHyYKwx
 ts3pxPfcQWTmVAjoZee0BakGv9KKc35OqJg05KSQkvOItcMs062YVT+CyLsudLrQe5Cug6PiS
 fCCEjTHk34ehJMdkciljxca97Wv75iMnHf4BF0oUCmxKaD698y7NtXk+J

VGhpcyBpcyBuZWVkZWQgYm90aCBzbyB0aGUgb3duZXIgY2FuIGFkanVzdCBjb25maWcgYXMgbmVl
ZGVkLCBhbmQgZm9yCmRpc3RyaWJ1dGlvbiBidWlsZHMgdG8gYmUgYWJsZSB0byBtb3ZlL2RlbGV0
ZSBmaWxlcyBhcyBwYXJ0IG9mIHRoZQpidWlsZCB3aXRob3V0IGFkanVzdGluZyBwZXJtaXNzaW9u
cyB0aGVtc2VsdmVzLiBMaW1pdGluZyB3cml0ZXMgZnJvbQp0aGUgcnVubmluZyBzZXJ2aWNlIG5l
ZWRzIHRvIGJlIGRvbmUgaW4gdGhlIHN5c3RlbWQgdW5pdCAoYWxyZWFkeSB0aGUKY2FzZSkgb3Ig
aW5pdCBzY3JpcHQuCgpTZWUgYWxzbzogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYmx1
ZXRvb3RoLzRkMTIwNmRmLTU5OGItNGE2OC04NjU1LTc0OTgxYjYyZWNjYUBnbXguZGUvVC8KLS0t
CiBNYWtlZmlsZS5hbSB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL01ha2VmaWxlLmFtIGIvTWFrZWZpbGUuYW0KaW5kZXgg
Mjk3ZDA3NzRjLi4yOTAxOGE5MWMgMTAwNjQ0Ci0tLSBhL01ha2VmaWxlLmFtCisrKyBiL01ha2Vm
aWxlLmFtCkBAIC0zMiw3ICszMiw3IEBAIGNvbmZkaXIgPSAkKHN5c2NvbmZkaXIpL2JsdWV0b290
aAogc3RhdGVkaXIgPSAkKGxvY2Fsc3RhdGVkaXIpL2xpYi9ibHVldG9vdGgKIAogYmx1ZXRvb3Ro
ZC1maXgtcGVybWlzc2lvbnM6Ci0JaW5zdGFsbCAtZG01NTUgJChERVNURElSKSQoY29uZmRpcikK
KwlpbnN0YWxsIC1kbTc1NSAkKERFU1RESVIpJChjb25mZGlyKQogCWluc3RhbGwgLWRtNzAwICQo
REVTVERJUikkKHN0YXRlZGlyKQogCiBpZiBEQVRBRklMRVMKLS0gCjIuNDUuMgoK
