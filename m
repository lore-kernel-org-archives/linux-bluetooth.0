Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213928;
	b=SVcMCSz8rG8lDSYAzoCt8gyCP02ep/2SLqbX+a5Y6aQXI4VML4AChGrCtiJu2HCGo2jt
	 jtwA6Y2ymrh6WMQGX1rV0SbPkGUI3753dQq/4Vo7NXhM7VQMI8XosS1rVsieabQj4PtuT
	 pIrBc0GSTYYptfMLDpyHuQreToBHVkP9Pd5XsLg4/sCnK5qkNmEanx9oHEhaK9mIkuv4F
	 UrMIfur7OAhnJia3dwiOObdHsIJ9Ss98ojtbA4TLiz9ei6EF6/3hcfonYVJaFW/Rh8yvH
	 BzBOMqIEnDNmBwh3DdjZ8qvAl9Bd29RsGwKRbSgDaDtEkACDAbr8yhJ8eTzNdQFBv6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=BH+upZSVQ7OPiPxfnFmcCDdD4JGg5FFYgBbOWBYm9EM=;
	b=IzS4MkTw1Ky0/EAmdF0KIsIIJJ4RKAN7upPcsug4M/VW1MJqX4DHxsedx1VHx79SmzWh
	 9IHGAuC3MS9lXU8Ec2qX4oq9XYdG5pYVEVKPw1cIKujEu6CvxkCf9lxLSlgztgQCXGkXP
	 Mp6toCtCgAGwr/iheEtqKSqvALw35yzp2jR2WRR+XYaj6Lu+9ftBUi1nCc/h6/0gdy9Tv
	 1iND6PhODoglKWBdDQJYkTrwELYVklTNUR9QxJ0ezcXgLEPjBlvfjV14NwW+5Om/Gag5C
	 d/2R8oJNnFWWEuAUlWYJqukJQOZQNFgoS2nQ+CGEx+8egtjhzPRNHTeJLwtlveH1F5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qqj14nZh;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E1E606A686
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 22:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52E1E606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qqj14nZh
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5366ae57896so14952621cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 14:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795213926; x=1795818726; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BH+upZSVQ7OPiPxfnFmcCDdD4JGg5FFYgBbOWBYm9EM=;
        b=Qqj14nZhIz4afX2f5DtsKlVYXNz4029NtJqRWmuLbrr232fdpWOPyOz+8yeyI4W2wn
         Zbp6e1IyqlU18uNInqZbhVP8HwI/fKHl/q0l6FCqllVl4cDNEAa08jpCftWDf2RQSyNx
         0md1z1eeEB7cXsvhUEtIN/b904UsRzHxan47n/yqXUy6uNrVaR+EYmkaKPvcDYD9JWRU
         9gl/IRvgsSN0EjVXtAc/4rhEJXe8D6cNy7+iDDWIukdcOA6N6uzw0iR+0X82EnaY1Sv4
         N7dgwN9vD7GVySnrAA0okPrvVIdf8Qp42ou4z86v/9SVmzmWci3i5lkwhmsOSKHivg1V
         UUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213926; x=1795818726;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BH+upZSVQ7OPiPxfnFmcCDdD4JGg5FFYgBbOWBYm9EM=;
        b=y4OUTx5GeLTgpQVasIqlTd/N8jO5Y1yMmTJL9plFCY3tcqN7ZazL3A6du13HiY2wO7
         YQ66jLVZNHPK/UV2JncyKlP2czpl/jnCIBrR84HHryacDjEHYP7tzCwtMT6T5LcHs3r0
         9OS/eP2FUhclsr8nK6YclRwiXUIQFlfi2kAiXvs8HaqcevfpRXOfxr9bNl6c0F+fzb0A
         Vnxuj704k0rxwmU8fXR+vwikKgMebNULzujtiiUvYXUHNq4G3djIUqUVzvXrA6IMrSf5
         NTNEUDxDVEfAYOWln9of+pYIocZBdB9Wufk1FiVmAp5fxyMwu/CEXuGsEqKcucehHbOr
         9PUA==
X-Gm-Message-State: APuU4Z+yfBT/pj3ZvFNq3nNEHmutdRn+RqG9Gsp7SctS60rMRXC27yXa
	pmpDSBR42dR91X1A9ui47wQ1oAhmtDqn6HpGZ8/0XAu0CUbGgRgnfLZztsx8Yg==
X-Gm-Gg: AZFdTZfoLL2wxtmaKtESn+RqT6Dz9fuvcndHghFPu9oQbYX6GbqsKjMWEST7ysq645a
	K9QE928k8RPFFl9GbDlzBzVxso48Ua8yhJRxpV6OtMNtIqNxeYxXsZS4FsE7KW8jcjcWwgwY7gr
	FdeD8hAvFNDjfk14TsomvHohD8BSgH3K/F83TrW1or1DfD0ZJwsDHhD1ZHB/pYyI0OJgDSBWSKa
	i7pypHmnFZ2aD87Q/Z78nUDICCK5ho67MMArZnQTGMkDf30EgWRqrdQ0NT7jnlv/oHXe8IxJWQr
	l/DakjsIIA0h0xfOuceksnNb1T9OohbVx5nenJX+eJJhkFdTAw3KmK053Q/d/nciqigxZiN+KOw
	jb1Gf4g+NUGV+JZUdbESETLKi6sXyYNtDUUzhnd8I3cFN8dSuTlprto9JFxwxi4o49BjIfHnENf
	5kzQKlK3VfYYM4oky0TWpYIA/RJ+peQY8WoxWgDlNzjjBIKYDTD5OwJw8CFP0GEUHo9Pn1enZJu
	uHE6U+OFN8VF3YC4HFreO5wGJZaiiJ3DheqLhPSADAkMYuE4Y/8c52bQTWszD16Bq6aUmpRHwop
	6WmqQYBAWTHNHqqROGaL4netyF3N9xI=
X-Received: by 2002:a05:622a:58b:b0:533:3192:7a8e with SMTP id d75a77b69052e-55d76a76454mr82575661cf.43.1795213926329;
        Fri, 20 Nov 2026 14:32:06 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-41-210-118.compute-1.amazonaws.com. [3.41.210.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d14d1sm37944466d6.18.2026.11.20.14.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 14:32:05 -0800 (PST)
Message-ID: <6b00ca65.c0a35c19.390d42.d237@mx.google.com>
Date: Fri, 20 Nov 2026 14:32:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4521042529292460735=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Channel Sounding and RAP fixes
In-Reply-To: <20261120165510.1858959-2-luiz.dentz@gmail.com>
References: <20261120165510.1858959-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4521042529292460735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9zZXJpZXMvMTIxNzU3MC8KCi0tLVRlc3QgcmVzdWx0LS0tCgpUZXN0IFN1
bW1hcnk6CkNoZWNrUGF0Y2ggICAgICAgICAgICAgICAgICAgIFBBU1MgICAgICA4LjM3IHNlY29u
ZHMKR2l0TGludCAgICAgICAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDUuMjUgc2Vjb25kcwpC
dWlsZEVsbCAgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTMuNTYgc2Vjb25kcwpCbHVl
ek1ha2UgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMjA0Ljk0IHNlY29uZHMKTWFrZUNo
ZWNrICAgICAgICAgICAgICAgICAgICAgRkFJTCAgICAgIDE0LjI1IHNlY29uZHMKTWFrZURpc3Rj
aGVjayAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDEwNi45MyBzZWNvbmRzCkNoZWNrVmFsZ3Jp
bmQgICAgICAgICAgICAgICAgIEZBSUwgICAgICAyNTQuNTMgc2Vjb25kcwpDaGVja1NtYXRjaCAg
ICAgICAgICAgICAgICAgICBQQVNTICAgICAgMTg1LjQ3IHNlY29uZHMKYmx1ZXptYWtlZXh0ZWxs
ICAgICAgICAgICAgICAgUEFTUyAgICAgIDY1LjgwIHNlY29uZHMKVGVzdEZ1bmN0aW9uYWwgICAg
ICAgICAgICAgICAgUEFTUyAgICAgIDkxNC45MCBzZWNvbmRzCkluY3JlbWVudGFsQnVpbGQgICAg
ICAgICAgICAgIFBBU1MgICAgICAzNDYuMjAgc2Vjb25kcwpTY2FuQnVpbGQgICAgICAgICAgICAg
ICAgICAgICBQQVNTICAgICAgNzE0LjA5IHNlY29uZHMKCkRldGFpbHMKIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjClRlc3Q6IEdpdExpbnQgLSBGQUlMCkRlc2M6IFJ1biBnaXRsaW50Ck91
dHB1dDoKW0JsdWVaLHY0LDAzLzE4XSBzaGFyZWQvcmFwOiBTdWJzY3JpYmUgb24tZGVtYW5kIGRh
dGEgd2l0aCB0aGUgcmVxdWVzdGVkIHRyYW5zcG9ydAoKMTogVDEgVGl0bGUgZXhjZWVkcyBtYXgg
bGVuZ3RoICg4Mj44MCk6ICJbQmx1ZVosdjQsMDMvMThdIHNoYXJlZC9yYXA6IFN1YnNjcmliZSBv
bi1kZW1hbmQgZGF0YSB3aXRoIHRoZSByZXF1ZXN0ZWQgdHJhbnNwb3J0IgpbQmx1ZVosdjQsMDgv
MThdIHByb2ZpbGVzL3Jhbmdpbmc6IExldCBTdGFydE1lYXN1cmVtZW50KCkgcGljayB0aGUgSW5p
dGlhdG9yIGZvciBCb3RoCgoxOiBUMSBUaXRsZSBleGNlZWRzIG1heCBsZW5ndGggKDg1PjgwKTog
IltCbHVlWix2NCwwOC8xOF0gcHJvZmlsZXMvcmFuZ2luZzogTGV0IFN0YXJ0TWVhc3VyZW1lbnQo
KSBwaWNrIHRoZSBJbml0aWF0b3IgZm9yIEJvdGgiCltCbHVlWix2NCwxMi8xOF0gcHJvZmlsZXMv
cmFuZ2luZzogRGVmZXIgQ1MgU2VjdXJpdHkgRW5hYmxlIHVudGlsIHRoZSBsaW5rIGlzIGVuY3J5
cHRlZAoKMTogVDEgVGl0bGUgZXhjZWVkcyBtYXggbGVuZ3RoICg4Nz44MCk6ICJbQmx1ZVosdjQs
MTIvMThdIHByb2ZpbGVzL3Jhbmdpbmc6IERlZmVyIENTIFNlY3VyaXR5IEVuYWJsZSB1bnRpbCB0
aGUgbGluayBpcyBlbmNyeXB0ZWQiCltCbHVlWix2NCwxMy8xOF0gcHJvZmlsZXMvcmFuZ2luZzog
Q2hvb3NlIHRoZSBDUyBhbnRlbm5hIGNvbmZpZ3VyYXRpb24gZnJvbSBib3RoIGVuZHMKCjE6IFQx
IFRpdGxlIGV4Y2VlZHMgbWF4IGxlbmd0aCAoODU+ODApOiAiW0JsdWVaLHY0LDEzLzE4XSBwcm9m
aWxlcy9yYW5naW5nOiBDaG9vc2UgdGhlIENTIGFudGVubmEgY29uZmlndXJhdGlvbiBmcm9tIGJv
dGggZW5kcyIKW0JsdWVaLHY0LDE0LzE4XSBwcm9maWxlcy9yYW5naW5nOiBEbyBub3Qgc3RhcnQg
YSBwcm9jZWR1cmUgYWZ0ZXIgU3RvcE1lYXN1cmVtZW50KCkKCjE6IFQxIFRpdGxlIGV4Y2VlZHMg
bWF4IGxlbmd0aCAoODM+ODApOiAiW0JsdWVaLHY0LDE0LzE4XSBwcm9maWxlcy9yYW5naW5nOiBE
byBub3Qgc3RhcnQgYSBwcm9jZWR1cmUgYWZ0ZXIgU3RvcE1lYXN1cmVtZW50KCkiCltCbHVlWix2
NCwxNS8xOF0gcHJvZmlsZXMvcmFuZ2luZzogS2VlcCBDUyBzZXNzaW9ucyBhcGFydCBmcm9tIHN0
YWxlIGFuZCB1bnJlbGF0ZWQgZXZlbnRzCgoxOiBUMSBUaXRsZSBleGNlZWRzIG1heCBsZW5ndGgg
KDg5PjgwKTogIltCbHVlWix2NCwxNS8xOF0gcHJvZmlsZXMvcmFuZ2luZzogS2VlcCBDUyBzZXNz
aW9ucyBhcGFydCBmcm9tIHN0YWxlIGFuZCB1bnJlbGF0ZWQgZXZlbnRzIgpbQmx1ZVosdjQsMTYv
MThdIHNoYXJlZC9yYXA6IFN0YXJ0IHRoZSBSZWFsLXRpbWUgdGltZW91dCB3aGVuIHRoZSBwcm9j
ZWR1cmUgc3RhcnRzCgoxOiBUMSBUaXRsZSBleGNlZWRzIG1heCBsZW5ndGggKDgyPjgwKTogIltC
bHVlWix2NCwxNi8xOF0gc2hhcmVkL3JhcDogU3RhcnQgdGhlIFJlYWwtdGltZSB0aW1lb3V0IHdo
ZW4gdGhlIHByb2NlZHVyZSBzdGFydHMiCltCbHVlWix2NCwxNy8xOF0gdW5pdC90ZXN0LXJhcDog
QWRkIHRlc3RzIGZvciBSYW5naW5nIERhdGEgc3Vic2NyaXB0aW9uIGFuZCBjb3VudGVycwoKMTog
VDEgVGl0bGUgZXhjZWVkcyBtYXggbGVuZ3RoICg4ND44MCk6ICJbQmx1ZVosdjQsMTcvMThdIHVu
aXQvdGVzdC1yYXA6IEFkZCB0ZXN0cyBmb3IgUmFuZ2luZyBEYXRhIHN1YnNjcmlwdGlvbiBhbmQg
Y291bnRlcnMiCltCbHVlWix2NCwxOC8xOF0gc2hhcmVkL3JhcDogRGVmZXIgUmFuZ2luZyBEYXRh
IG1vZGUgc2VsZWN0aW9uIHVudGlsIEZlYXR1cmVzIGlzIHJlYWQKCjE6IFQxIFRpdGxlIGV4Y2Vl
ZHMgbWF4IGxlbmd0aCAoODU+ODApOiAiW0JsdWVaLHY0LDE4LzE4XSBzaGFyZWQvcmFwOiBEZWZl
ciBSYW5naW5nIERhdGEgbW9kZSBzZWxlY3Rpb24gdW50aWwgRmVhdHVyZXMgaXMgcmVhZCIKIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1ha2VDaGVjayAtIEZBSUwKRGVzYzog
UnVuIEJsdWV6IE1ha2UgQ2hlY2sKT3V0cHV0OgoKbWFrZVszXTogKioqIFtNYWtlZmlsZToxMDQz
NjogdGVzdC1zdWl0ZS5sb2ddIEVycm9yIDEKbWFrZVsyXTogKioqIFtNYWtlZmlsZToxMDU3MTog
Y2hlY2stVEVTVFNdIEVycm9yIDIKbWFrZVsxXTogKioqIFtNYWtlZmlsZToxMTA3NDogY2hlY2st
YW1dIEVycm9yIDIKbWFrZTogKioqIFtNYWtlZmlsZToxMTA3NjogY2hlY2tdIEVycm9yIDIKIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrVmFsZ3JpbmQgLSBGQUlMCkRl
c2M6IFJ1biBCbHVleiBNYWtlIENoZWNrIHdpdGggVmFsZ3JpbmQKT3V0cHV0OgoKdG9vbHMvbWdt
dC10ZXN0ZXIuYzogSW4gZnVuY3Rpb24g4oCYbWFpbuKAmToKdG9vbHMvbWdtdC10ZXN0ZXIuYzox
NDUxODo1OiBub3RlOiB2YXJpYWJsZSB0cmFja2luZyBzaXplIGxpbWl0IGV4Y2VlZGVkIHdpdGgg
4oCYLWZ2YXItdHJhY2tpbmctYXNzaWdubWVudHPigJksIHJldHJ5aW5nIHdpdGhvdXQKMTQ1MTgg
fCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogICAgICB8ICAgICBefn5+Cm1ha2Vb
M106IHdhcm5pbmc6IC1qNCBmb3JjZWQgaW4gc3VibWFrZTogcmVzZXR0aW5nIGpvYnNlcnZlciBt
b2RlLgptYWtlWzNdOiAqKiogW01ha2VmaWxlOjEwNDM2OiB0ZXN0LXN1aXRlLmxvZ10gRXJyb3Ig
MQptYWtlWzJdOiAqKiogW01ha2VmaWxlOjEwNTcxOiBjaGVjay1URVNUU10gRXJyb3IgMgptYWtl
WzFdOiAqKiogW01ha2VmaWxlOjExMDc0OiBjaGVjay1hbV0gRXJyb3IgMgptYWtlOiAqKiogW01h
a2VmaWxlOjExMDc2OiBjaGVja10gRXJyb3IgMgoKCmh0dHBzOi8vZ2l0aHViLmNvbS9ibHVlei9i
bHVlei9wdWxsLzI4NjAKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgKCg==

--===============4521042529292460735==--
