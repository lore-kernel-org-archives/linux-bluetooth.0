Received: from mail-106117.protonmail.ch (mail-106117.protonmail.ch [79.135.106.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4AB1714AA
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 04:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773028924; cv=none; b=WX4iFD208iDTUPpEKkkDLj43nfTtkeZUdPZnCBC/UGzQi1Je+xog3d/MQVr/a6Jb7SKFdmuRUZ70wEs2Icl3Ke0dTdK5X/a62FCRk636cPPoBkEw5JkbJWgv551OhJcPiycEBKFunXd3G8P/orLRr1NzhLNs639ZmHDVgdwhFl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773028924; c=relaxed/simple;
	bh=WZWYH64W49MBD5oFa9w2sXtJ+f8EEzRA+tOhM5kSub8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=RziaxnP4cP6R+sF1oz1GXFAKvl9r4V/lIouCJVZwbQaIueJs52Zv4e4RQMt04Nl+2ZVRwXnkgHyuJbGhLpf3hmzFS+tRA4EeRghu03+EAdppRRtJs8Q+PQjvUguFXJEjrdnib+HuDKm/Emu0KTqhSDDQtMPH/dH3OZFp3H/dIz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deschouwer.co.za; spf=pass smtp.mailfrom=deschouwer.co.za; dkim=pass (2048-bit key) header.d=deschouwer.co.za header.i=@deschouwer.co.za header.b=GBS41u+Q; arc=none smtp.client-ip=79.135.106.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deschouwer.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deschouwer.co.za
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deschouwer.co.za header.i=@deschouwer.co.za header.b="GBS41u+Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deschouwer.co.za;
	s=protonmail2; t=1773028910; x=1773288110;
	bh=MqmI7xFUnH9SM2yc7l7oMuUfYJvTyDoGuKCE7AIZrH8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GBS41u+QAtFO7yJT6i02qw3Nj8NnsrPuuCSJyCAG/C9fQP6N8VpN0z+nxEC/WB+P/
	 tVrrE7ngkxEVB7kl4l4c0fBanaCu9JFCnNiza4IjZzW4mg5M+CyCnhDtelODJlhRyJ
	 K8IM/Lma7zOoHzEIzFIUhJI1VBpzx5uV9OEfPigVVfsWbf1bSf2x1MP5GfLHIPBrxb
	 rs7AYy3nDWDNynmeBBQ/l3A/C+bnofg6JYBCsB6tM7O8YrN/83YW8N0Hs53OeTozse
	 EIlJX+gMEHynvoknxWyyjC1rmWo03OUO6gZxNa+ZOGde7bfKniK1cEMg5c6niLjUv5
	 pn/PDAqARmDWA==
Date: Mon, 09 Mar 2026 04:01:47 +0000
To: linux-bluetooth@vger.kernel.org
From: berend de schouwer <berend@deschouwer.co.za>
Cc: berend de schouwer <berend@deschouwer.co.za>
Subject: [PATCH BlueZ 0/1] pause discovery on suspend
Message-ID: <20260309040136.159073-1-berend@deschouwer.co.za>
Feedback-ID: 50941660:user:proton
X-Pm-Message-ID: 5e37de6c2c87d03e383ca3a76d66a601ebbfbc01
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------f7ec8e37cb1d658784ec68766d1ee7a858d48e3af7c1536b3d42a01f3f4f1faa"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------f7ec8e37cb1d658784ec68766d1ee7a858d48e3af7c1536b3d42a01f3f4f1faa
Content-Type: multipart/mixed;
 boundary=d5ee2fa3bc3a17e49182f1911fe201bab85ebb4dbb067de97b91592ceb17
From: berend de schouwer <berend@deschouwer.co.za>
To: linux-bluetooth@vger.kernel.org
Cc: berend de schouwer <berend@deschouwer.co.za>
Subject: [PATCH BlueZ 0/1] pause discovery on suspend
Date: Mon,  9 Mar 2026 06:01:35 +0200
Message-ID: <20260309040136.159073-1-berend@deschouwer.co.za>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0

--d5ee2fa3bc3a17e49182f1911fe201bab85ebb4dbb067de97b91592ceb17
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some hardware will not reconnect after a suspend/resume or soft reboot
cycle.  That hardware will need a power cycle (if it has an on/off
button), or need to be re-paired.

The symptom is mentioned repeatedly with Logitech hardware on the
github page for bluez.

Confirmed the problem with a Logitech MX Master 3, and a MediaTek
MT7921e.  Confirmed that it happens when the adapter has discovery
enabled on suspend or soft reboot.  Confirmed that it works fine if
discovery is paused.

berend de schouwer (1):
  Stop and start some actions on suspend and resume

 src/adapter.c |  35 ++++++++
 src/adapter.h |   2 +
 src/main.c    | 226 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 263 insertions(+)

-- 
2.53.0


--d5ee2fa3bc3a17e49182f1911fe201bab85ebb4dbb067de97b91592ceb17
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - Berend De Schouwer -
 0x128CD671.asc"; name="publickey - Berend De Schouwer - 0x128CD671.asc"
Content-Type: application/pgp-keys; filename="publickey - Berend De Schouwer
 - 0x128CD671.asc"; name="publickey - Berend De Schouwer - 0x128CD671.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29w
ZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuOS4wCgp4c0ZOQkZXS2tVRUJFQURYdWlFWVcx
WUlnTm5yYXpFby8wemVsVHp4YkhDRy93V3huN0FTdWQ4eEhMMWpxWks1CnF4UVMvNldSYm5RdjVj
NURQdmsxT2Y2RS8yWFZzRlVRSmdSMVlGeEd0TnQxUUFsNVIwdmo3cnZyOG5CYmVRaGMKbUhzdndH
cFQ3YWJrZXZXRnZtY0hiTktmWGJjL3NmRHJDTW90UkZRQm9oYzdveW8rTnpPSk9RcEpxQ2J6d2sr
awpWbVZoVkhwdzhZenZuRDJzVkRxYlFPeHRXbXJjb2ZtOURiMjhORTBOY04yUDlBQmJOSnV0MVFV
Wld0WjFsbVc2CnJ5aGdLckM0dXhTei9ZTmNjNXpzMlo3NjFTR0tPU1k4UFZ6dlZrTGJLOWZiZFk3
amNnR0NGZDZHUllPQjJJM0IKN0NPOXVhZnVUb0NEeWhscWx1Z1dYcEdvQTVCN28vYTRaMWI3cWxO
c0VtcWxHaCtlRDk0SDhNL0xXOGR3WU5SSQpvVU5ZSWF5UkYxT1FwcmM1UHozaUN4YW9ub0lpR2Z4
R1pxTktUOVFXb0lnOHJPQzA4dGNyOHVqNG0xUmpKcnN6ClNqdGt3c29tMFV3cEJ5Z0hlLzNCcDR4
WlN4Z2FmTXc2ZEdTS1JzRFRBSGoyRkpGV2N0Tmx1WTRqdnhSWDdDdVcKNTlRMzVKSUU4bStPZ1li
Z0xrR1FmRWRVeWhjUnFCMCtWUjJXUmxYNXNLVVprV2cxQWhnY0w3RmltTmxsM2YwNgp5ZS91emJy
YVVZSFg3eGMzdjVDSjJaNnd4Nk1waFp6aGh4dUJxTGNZSkViTjlmTnNldlRPWWtFUUlzR0M3Tldv
ClQyaHkzdWplWUJQajNjbzJOZDRpV085dHB5c0xaOGdLMTUvZE5qTUJUc3ByUys5UlBxZ3o1QnRG
bXdBUkFRQUIKelN4Q1pYSmxibVFnUkdVZ1UyTm9iM1YzWlhJZ1BHSmxjbVZ1WkVCa1pYTmphRzkx
ZDJWeUxtTnZMbnBoUHNMQgplQVFUQVFJQUlnVUNWWXFSUVFJYkF3WUxDUWdIQXdJR0ZRZ0NDUW9M
QkJZQ0F3RUNIZ0VDRjRBQUNna1EyMjdnCmNaT0FvT25YZGcvOUVGZFJyL1h0T1liQmVsdGIwc05I
YVNQN1M0dmtscWNBdE9udFRZVjN5TUZOdjlYQlhYdkYKU0thR2wwbTVMaGVOQWtJdS9ZYkFkR1h5
U3pOVWQ3V3NmeWIrMjNpcTVVS0d0K3dEK1JvY0xaWTA5NHVBS2NRUQpUWndKS1R3NHRLSWdONHFC
dE9hTmlKd0x1cnNOWllBUDdKSUpGUFFZNTVwYSt5ZWMzanhmVFgwYTdydWllY29zCm16YXZRMTgy
VitMZGV2Mmtvckd2WTFjejQzclA4eGlMMURqdGNCVW5laWdiajUrTjBaOFVsam5SNlFrU1J1YWoK
ZHNHQkFYSG1rT3NCVi9vOE04dkZXYThOODN1czFHa3k1SzU0eFFPYVZ5TlJWclI0RUlTdjh5MGkz
M3J3R1l2UApCRCtSS2FMYWN1S2I4KzhLTlZ1UTVNMHYrNHBHci9GZVhwUCtuUHpWRGZiWlpoWDFp
d2VRMDY5TEthOXJlZjhxCkV3NFZWdDdBdVlGU3dlSFZNSUNBMFpHeUtKNWhaejdMZEkwdkFGQU55
VXQwS29XZWVLNjl4aWs4cnZGNzVlbzQKZnovV0p0Zi9BZG5DdVlwNjBvYm94L3NKQTdLclpyV1FO
YkRjbEplZmlTWlY3dHVIaDdqTEpxUXVma201RDVnbwp3QUFvNWdyTS82V0FOSFZ3NWlvak0vVUc2
ZjArdEZaWGdGTXlrMkpaeTljMnM4VlFnSTJVenJiVThKc0N0ZERqCkJVU1RDNjRSN2tsdlY1Ymt1
MzFBbTNSUEMyOWwxaGZZKzNVTGc0dzhtbXBKMjhwcSsvejBvS0g4Q3d5aWN1RlAKRkJHOTVsbi83
dHRlNGlmV2tmek1MOE9oMmJwdUtFYjJQV1I0NHNRMVpxOCtJQWpTMlh3TDQ1N093VTBFVllxUgpR
UUVRQUtYYUwvaEhueXdzRnlVUVVHNVdxYm9xSHRWODNTNEc5aEpMQ25MOWhnU0J2Z2twbTRjNi85
Mmt6Lzh5CmdvRTRjUjNHSmZsZm40OHRUNFkvWDZzTkZiSXY5VkhpWVo4aW9YVUc0bHBhMFIyN3pk
MVZZT1pXUStvS3RjRnoKb1djVlViOHQrT1BoM2tuME5WQWxFRnlya0k5YWdUc0p1OFJ0alNpMEV6
Wi9iQ0xaTStFMU9UQnpZUzFuelZlcgp1NVVid1FWbXAzbUlzS2JSVTRRbnpZSElWVGNFeDF5SGxC
M1ZkZFd6M0pnenVsWlF4SDdRREVGaTVBaDhjcUVDCjJSZ2w2K2JkdVBqYnJBK2RwV2VaTGtvUGhH
d0xZcVM0YnJxN0ZBbmtMMjFSTGVGQzkvY203dTNaMnozd1o5QXkKZWt2bmtPNnhxdGlqcDB2Y0RD
V3kxbldiV0tpN2Y5K1NQWW5xTTNKVFBqWnlobk9CQ2pWTFhUcnlYQ3BhRGFCYgpnWGZRSlpMOWwx
bTRqVzBoQjNEdlU5eGQ2Zi8zdW1vODMzS1BnMm5XenpnZ0tRODREUUd3L0hYdkFSdDVtR0ZTCmQv
REtkMlliTHc5QjJKSlpqb2kzc2VGWlN6YVZKZ0FWZk9neUk0NHRnN3pJSlVUZDk2VzVpeEE3SEVP
TkV4cG0KQ0JrZ3ArMmswZEg1SU84c1lXd1o0c3lXQk5kZ1cxeGd2Qzc1dm94TmZTZGJmcGRhMG91
YU5xYVR0YjdzcnlVZApsTFZ3bExZZkV4NU9EeFFVY1VyNHRKUDhsR1I4dkEwemhGSEJhTEdCcjBa
SU16UU5TcS9jS3NrNnNESXI0Wms1ClZMT0VVN3R3SFRrZjQ3bXpWTExCQmZ6alJJc2hXRnJvNnBj
NDFBaGk5Y3ArQ3hLYkFCRUJBQUhDd1Y4RUdBRUMKQUFrRkFsV0trVUVDR3d3QUNna1EyMjdnY1pP
QW9PbXkzUkFBdGpNMGtPQjN1OTZ0S0pieGpERnlUTjZhTk9WLwo5WXk2V2doRjJITldvN0hzbk55
dnNRTkF1cHhWMndBTGF0UGVjUFgrL04vdWVGUUtyQTMvd3FVUTkwMkw0VXhWCnJMa1d5a2RZb09P
cGd4TUxkUXB6Z2NRT1RTV1BDdlAwVi9jVnNYY1dKaVZFRGg5VGp1SzBLc1loRm1XR2E2bmUKNHVS
MVY2VkJ5SUtaay9vRGthSVhCanJaU1ZUT1M2ZzZWRi9XaWhHKy9NL0MyZU94eEJZMzdqWm5xREpR
bjNxWApoWTJjVE4wbTlrTFFQdjJqUE9LcjAzUHIvbFdIV1Rpc1EzRkNWbG1ZUTBJSUcyRlpKSmNS
RGNELzhOOGpoMWVhCnpFQmowK1lSMitMUUxzVWN6bDBQSkM0TGV4eERTUVg4MlRlV21nUklXc3Mv
UTM2VUNIOVNyOFl6Sk9BSkxWWEYKNUJMQXgybFlVQWk4bmN0cjhIMmdML0RQOHlOT3hBZ05QSVhy
QjNnQk9XYTF4MmNROHNOeDMvVXVYZFIyNXQyYgo3eGpseFdlWmM5ejJnTzlyZUVKRWt6a21HVjhR
Sk1QSFAvejZRdTZIUVlqUFlyL3I0T1FSSGFpN1RMSkZsTFBNCkJLQTJGVWlZNzFaTUxZWHRXUms1
WG85SnVGL0F0dncwU3JxcFoyRE5PeUtLZmJzMTRNOS84RXkzUUFVTklTSXQKUDQyMlJNQUQxdzha
WGcxWlBqSEo4TGo3Qms3RTJGN0YzVlUwSXFCSVVsc1J5eUJvMUs3SDdRT1pwdmJFeERRSgpnMWx4
YlhhS1lrRFEwREdhb2FnT3pVYVo5ckxCdkpFNHo3QzBTZ3BjWFpaMHJuT3lkdm5GMGhCWG93djdX
YkYrCmk0WlB5REJjM242OHJxcz0KPTlTWGwKLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxPQ0st
LS0tLQ==
--d5ee2fa3bc3a17e49182f1911fe201bab85ebb4dbb067de97b91592ceb17--

--------f7ec8e37cb1d658784ec68766d1ee7a858d48e3af7c1536b3d42a01f3f4f1faa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsGpBAEBCABdBYJprkYrCRDbbuBxk4Cg6TUUAAAAAAAcABBzYWx0QG5vdGF0
aW9ucy5vcGVucGdwanMub3Jnf7ietOORwFnTJWxMf8+PShYhBBKM1nGLSON6
q6UFAttu4HGTgKDpAAC70Q//chgyJpV5fAetGn+m8uRVmBT4apyesl1G6Dpa
sBBlMh1wVBH2weXvF+HGHT11DjeDYwTmaA5IobOG7eqWerS/0DjoAKY/0MaP
QWPZJJyN+MvzpktBq1re1ieofqWMtCXi7ilBbryIY3e1TSurAQxNCr0g0qPW
NH1le8A00QYfr/wwmzh1903fYSsyWTyEpkVLeI1EYNiqbxPBtis7vbglpSlA
mcypIiqsBXyrgsa7RW5A6vo7j4PLnZzZIROK2+CDQoTjka0xAaAqU57gez9q
5MdTadYtN27fJ+UcWoOFxk3st3VC3NEGKVi84EQ7tQfz326K38Nz1xVkFFor
/psJONMtavc0vfoiDCY2CqV9BND606ygbzDmCjzEkUEjzwmYE+vA5r4mCdmS
3HRMeSoJdJ/2oMIBAOaxea36MFpH7iY8rF0LrE0GCr2pJvngFM1v7QbqyOjN
lRNeTqff4ftGEfuz2FY4u1TtN3wuUCMuFwJxO6XN85y9R32937OlFi7HZKXE
vPbOQ2iZSsE9sBYQjGv+rPtoZEKs66KpiEoK2UcWdBiAstLBsmrJ74MqRl3u
7c0Dtc2a4iYpivYnymXLIJ0QlkTew+Ewl9qLPjb583rhpYTTgkZNJNf4h438
KVqfGweczhj8Dvi+1RdkeFTsv0xzcpmmqkeHzuJ99PsJ2jA=
=yMa6
-----END PGP SIGNATURE-----


--------f7ec8e37cb1d658784ec68766d1ee7a858d48e3af7c1536b3d42a01f3f4f1faa--

