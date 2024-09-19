Received: from constitution.troyrollo.com.au (constitution.troyrollo.com.au [202.153.212.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3327B320F
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 02:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.153.212.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726713957; cv=none; b=d9xKEEmkKqmzWhxOWpX11VFYQVZ/t+c8DvyLLaEoo48OKPSiGuwHSbPkR0dsY391ZSiM4QDD5cZBbncdtbGoVLXDeU5U2K0kp1uQ3PyQrBDJRQ4aBb7b2mAXXVotJxU60/942jK2bCMiTWi5DstHtI4Mik1UkaeEyUxAA3IF/lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726713957; c=relaxed/simple;
	bh=/5g8h2D10Ax1pyg2+NhJ123XRyeTYmpGHDLiyPscHL4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=nHuXFP6a/CO5xa7ku5ok04FcOXTwq+X1VkNmZ52xMzprC7qWuIOCS+AmIS1VZ2Yph8rPfupCxcOCqkTYprSwH0DLab8cWVMNPzzjNyvdOvf65dVZk96ekEU9qVZotaZsakSyCCbmxvaigc3SDZ8HrM7qp+lV7a4wxRBUtnh9NNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=troyrollo.com.au; spf=pass smtp.mailfrom=troyrollo.com.au; dkim=pass (1024-bit key) header.d=troyrollo.com.au header.i=@troyrollo.com.au header.b=PUy2Lcc7; arc=none smtp.client-ip=202.153.212.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=troyrollo.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=troyrollo.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=troyrollo.com.au header.i=@troyrollo.com.au header.b="PUy2Lcc7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=troyrollo.com.au; s=20151118; h=Content-Type:Subject:From:To:MIME-Version:
	Date:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7QKlt1uWXlJ7HwnBRQTBBNnfOgB5keHFKXfouW4w84Q=; b=PUy2Lcc7CJfc3ItEtp9GSPXwAL
	uJ6rPQUUnuX1nD+SrBbR0b0+mUKIJCiwTGQAqzxScNkE+VtFtn8kpUjKgTrLo0P3Lf2AXMqZ8cpSd
	3dwEoHFBKpzbB4qhaZ9MxBd2ceDHfGxOPddMK2R2IUhpKVSyFPwB2/FRYuBIxAEYUVSM=;
Received: from localhost ([127.0.0.1])
	by constitution.troyrollo.com.au with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <bluez@troyrollo.com.au>)
	id 1sr7B2-00ATNL-37
	for linux-bluetooth@vger.kernel.org;
	Thu, 19 Sep 2024 12:45:52 +1000
Message-ID: <f2aa8f0f-5343-447d-b086-09eee4058e91@troyrollo.com.au>
Date: Thu, 19 Sep 2024 12:45:52 +1000
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-bluetooth@vger.kernel.org
Content-Language: en-GB
From: Troy Rollo <bluez@troyrollo.com.au>
Subject: Support for user-based and seat-based device restrictions (multi-user
 and multi-seat)
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms070705060101020704040306"

This is a cryptographically signed message in MIME format.

--------------ms070705060101020704040306
Content-Type: multipart/alternative;
 boundary="------------5LNH8mdhZdQLhHWYt0nzHOPa"

--------------5LNH8mdhZdQLhHWYt0nzHOPa
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

V2hpbGUgYmx1ZXogc2VlbXMgKG5vdCB1bnJlYXNvbmFibHksIGhhdmluZyByZWdhcmQgdG8g
dGhlIHdheSBwYWlyaW5nIA0Kd29ya3MpIHRvIGJlIGRlc2lnbmVkIHRvIHNoYXJlIGRldmlj
ZXMgb24gYSBzeXN0ZW13aWRlIGJhc2lzLCB0aGVyZSBhcmUgDQp0aW1lcyB3aGVuIGRldmlj
ZXMgc2hvdWxkIGJlIHJlc3RyaWN0ZWQgdG8gYSBwYXJ0aWN1bGFyIHVzZXIgb3Igc2VhdC4g
DQpNb3N0IG9mdGVuLCBiYXNlZCBvbiBHb29nbGUgc2VhcmNoZXMsIHRoaXMgc2VlbXMgdG8g
YXJpc2Ugd2l0aCBibHVldG9vdGggDQpoZWFkc2V0cywgYnV0IGl0IGNvdWxkIGFsc28gYXJp
c2Ugd2l0aCBvdGhlciBkZXZpY2VzIHN1Y2ggYXMgYmx1ZXRvb3RoIA0KY29ubmVjdGlvbnMg
YmV0d2VlbiBhIGRlc2t0b3AgYW5kIGEgdGFibGV0IG9yIHBob25lLg0KDQpXaGlsZSB0aGlz
IGNvdWxkIGJlIGFkZHJlc3NlZCAob24gYSBjb29wZXJhdGl2ZSBiYXNpcykgb24gdGhlIGNs
aWVudCANCnNpZGUsIGl0IHNlZW1zIHRoYXQgdGhpcyBpcyBhdCB0aW1lcyBhIHNlY3VyaXR5
IGlzc3VlIHdoaWNoIG91Z2h0IHRvIGJlIA0KZGVhbHQgd2l0aCBpbiB0aGUgZGFlbW9uIHNv
IHRoYXQgb25seSBhdXRob3Jpc2VkIHVzZXJzIGNhbiBldmVuIHNlZSB0aGUgDQpkZXZpY2Uu
DQoNCkkgc2VlIGEgbnVtYmVyIG9mIHBvc3NpYmxlIGFwcHJvYWNoZXMgdG8gdGhpcywgYnV0
IGl0IHNlZW1zIHRvIG1lIHRoYXQgDQp0aGUgY2xpZW50IHRoYXQgaW5pdGlhdGVzIG9yIGNv
bmZpcm1zIGEgcGFpcmluZyByZXF1ZXN0IHNob3VsZCBoYXZlIHRoZSANCm9wcG9ydHVuaXR5
IHRvIGJlY29tZSB0aGUgIm93bmVyIiBvZiB0aGUgZGV2aWNlIHNvIHRoYXQgdGhleSBjYW4g
dGhlbiANCmRldGVybWluZSB3aG8gZWxzZSBnZXRzIHRvIHNlZSAvIHVzZSB0aGUgZGV2aWNl
LiBUaGUgb3duZXIgY2FuIHRoZW4gDQpkZXRlcm1pbmUgd2hldGhlciBvdGhlciB1c2VycyBj
YW4gc2VlIGl0IChhbmQgaWRlYWxseSwgd2hpY2ggdXNlcnMpLg0KDQpJIGhhdmUgdGhlIGZv
bGxvd2luZyBpZGVhcyBvbiB0aGlzICh0aGlzIGlzIGZyb20gYSBwcmV2aW91cyByZXBvcnQg
DQplbHNld2hlcmUgYW5kIHBhcnRseSByZWZsZWN0IGVhcmxpZXIgdGhpbmtpbmcgLSBJIGhh
dmUgbm90ZWQgY2hhbmdlcyBpbiANCm15IHRoaW5raW5nIGluIHNxdWFyZSBicmFja2V0cyk6
DQoNCg0KIDEuIE9uIFVuaXgvTGludXggc3lzdGVtcywgdGhlIGNsaWVudCBjb3VsZCBiZSBp
ZGVudGlmaWVkIGJ5DQogICAgR2V0Q29ubmVjdGlvblVuaXhVc2VyLiBIb3dldmVyLCB0aGF0
IHdvdWxkIHJlc3RyaWN0IHRoZQ0KICAgIGZ1bmN0aW9uYWxpdHkgdG8gdGhvc2Ugc3lzdGVt
cyBbdGhpcyB3b3VsZCBub3Qgc2VlbSB0byBiZSBhIHByb2JsZW0NCiAgICBhcyBpdCBzZWVt
cyBibHVleiBpcyByZXN0cmljdGVkIHRvIExpbnV4IGFueXdheV0NCiAyLiBbdGhpcyB3b3Vs
ZCBzZWVtIG5vdCB0byBiZSBuZWNlc3NhcnkgZ2l2ZW4gdGhlIExpbnV4IHJlc3RyaWN0aW9u
XSBPbg0KICAgIGFueSBzeXN0ZW0sIHRoZSBjbGllbnQgY291bGQgYmUgaWRlbnRpZmllZCBi
eSBhIG1hZ2ljIGNvb2tpZS4gVGhpcw0KICAgIHdvdWxkIGdpdmUgc29tZSBmbGV4aWJpbGl0
eSB0byBjbGllbnRzIHRvIHNoYXJlIG1hZ2ljIGNvb2tpZXMgdG8NCiAgICBlbmFibGUgc2hh
cmluZyBvZiBhY2Nlc3MsIG9yIGZvciBlYWNoIGNsaWVudCB0byBoYXZlIG11bHRpcGxlIG1h
Z2ljDQogICAgY29va2llcyAoZm9yIGV4YW1wbGUsIG9uZSAidXNlciIgY29va2llLCBhbmQg
bXVsdGlwbGUgInVzZXIrc2VhdCINCiAgICBjb29raWVzIiwgd2l0aCBhIGNsaWVudCBtYWtp
bmcgcXVlcmllcyBhYmxlIHRvIGluY2x1ZGUgbXVsdGlwbGUNCiAgICBjb29raWVzKSBhbmQg
Zm9yIHRoZSBzeXN0ZW0gdG8gYmUgcG9ydGFibGUgdG8gZGlmZmVyZW50IHBsYXRmb3Jtcy4N
CiAgICBUaGUgZHJhd2JhY2sgb2YgdGhpcyBhcHByb2FjaCBpcyB0aGF0IGl0IHJlcXVpcmVz
IGV2ZXJ5IGNsaWVudCB0aGF0DQogICAgd2lzaGVzIHRvIHF1ZXJ5LCBhY2Nlc3Mgb3IgdXNl
IGEgcmVzdHJpY3RlZCBkZXZpY2UgdG8gYmUgY29va2llIGF3YXJlLg0KIDMuIEl0IHNlZW1z
IHRoYXQgb25jZSBhIHVzZXIgaGFzIGFjY2VzcyB0byBhIGRldmljZSwgdGhlcmUgaXMgbm8g
d2F5DQogICAgZm9yIHRoZSBkYWVtb24gdG8gc2VjdXJlbHkgaWRlbnRpZnkgdGhlIHNlYXQg
b24gd2hpY2ggY2xpZW50IGlzIFtpdA0KICAgICptaWdodCogYmUgcG9zc2libGUgdG8gZG8g
c28gdXNpbmcgR2V0Q29ubmVjdGlvblVuaXhQcm9jZXNzSUQsDQogICAgc2RfcGlkX2dldF9z
ZXNzaW9uLMKgIGFuZCBzZF9zZXNzaW9uX2dldF9zZWF0LCBidXQgSSBzdXNwZWN0IHRoYXQN
CiAgICBwcm9jZXNzZXMgc3RhcnRlZCB3aXRoIHN5c3RlbWN0bCAtLXVzZXIsIGxpa2Ugd2ly
ZXBsdW1iZXIsIG1pZ2h0DQogICAgbWVzcyB0aGF0IHVwLCBzaW5jZSBpdCBzZWVtcyB0aGV5
IGFyZSBub3QgcGFydCBvZiBhIHNlc3Npb24gLSB0aGUNCiAgICBjb21tZW50IHRvIHNkX3Bp
ZF9nZXRfc2Vzc2lvbiBpbiBzZC1sb2dpbi5oIHNlZW1zIHRvIHBvaW50IHRvIHRoaXMNCiAg
ICBwcm9ibGVtLCBzdWdnZXN0aW5nIHRoYXQgdGhlIGJlc3QgdGhhdCBjb3VsZCBiZSBkb25l
IGlzIHRvIHVzZQ0KICAgIEdldENvbm5lY3Rpb25Vbml4VXNlciBhbmQgc2RfdWlkX2dldF9z
ZWF0c10uDQogNC4gVGhlcmUgd291bGQsIGl0IHNlZW1zIHRvIG1lLCBiZSBzb21lIHV0aWxp
dHkgaW4gYmVpbmcgYWJsZSB0bw0KICAgIGFzc29jaWF0ZSBnZW5lcmljIG5hbWVkIHByb3Bl
cnRpZXMgd2l0aCBhIGRldmljZSBzbyB0aGF0LCBmb3INCiAgICBleGFtcGxlLCBjby1vcGVy
YXRpdmUgc2VhdCByZXN0cmljdGlvbnMgY291bGQgYmUgaW1wbGVtZW50ZWQgYnkgYQ0KICAg
IGNsaWVudC1iYXNlZCBwcm90b2NvbC4NCiA1LiBJcyB0aGVyZSBhbiBhcHBldGl0ZSB0byBh
ZGQgc3VwcG9ydCBmb3IgZmVhdHVyZXMgb2YgdGhpcyBraW5kIGludG8NCiAgICBibHVlej8g
SWYgc28sIGlzIHRoZXJlIGEgcHJlZmVycmVkIGFwcHJvYWNoIHRvIGRvaW5nIHNvPw0KDQo=

--------------5LNH8mdhZdQLhHWYt0nzHOPa
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    While bluez seems (not unreasonably, having regard to the way
    pairing works) to be designed to share devices on a systemwide
    basis, there are times when devices should be restricted to a
    particular user or seat. Most often, based on Google searches, this
    seems to arise with bluetooth headsets, but it could also arise with
    other devices such as bluetooth connections between a desktop and a
    tablet or phone.<br>
    <br>
    While this could be addressed (on a cooperative basis) on the client
    side, it seems that this is at times a security issue which ought to
    be dealt with in the daemon so that only authorised users can even
    see the device.<br>
    <br>
    I see a number of possible approaches to this, but it seems to me
    that the client that initiates or confirms a pairing request should
    have the opportunity to become the "owner" of the device so that
    they can then determine who else gets to see / use the device. The
    owner can then determine whether other users can see it (and
    ideally, which users).<br>
    <br>
    I have the following ideas on this (this is from a previous report
    elsewhere and partly reflect earlier thinking - I have noted changes
    in my thinking in square brackets):<br>
    <p dir=3D"auto"
style=3D"box-sizing: border-box; margin-top: 0px; margin-bottom: var(--ba=
se-size-16); color: rgb(31, 35, 40); font-family: -apple-system, BlinkMac=
SystemFont, &quot;Segoe UI&quot;, &quot;Noto Sans&quot;, Helvetica, Arial=
, sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;; =
font-size: 14px; font-style: normal; font-variant-ligatures: normal; font=
-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans:=
 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2;=
 word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; =
background-color: rgb(255, 255, 255); text-decoration-thickness: initial;=
 text-decoration-style: initial; text-decoration-color: initial;"><br>
    </p>
    <ol>
      <li>On Unix/Linux systems, the client could be identified by
        GetConnectionUnixUser. However, that would restrict the
        functionality to those systems [this would not seem to be a
        problem as it seems bluez is restricted to Linux anyway]<br>
      </li>
      <li>[this would seem not to be necessary given the Linux
        restriction] On any system, the client could be identified by a
        magic cookie. This would give some flexibility to clients to
        share magic cookies to enable sharing of access, or for each
        client to have multiple magic cookies (for example, one "user"
        cookie, and multiple "user+seat" cookies", with a client making
        queries able to include multiple cookies) and for the system to
        be portable to different platforms. The drawback of this
        approach is that it requires every client that wishes to query,
        access or use a restricted device to be cookie aware.</li>
      <li>It seems that once a user has access to a device, there is no
        way for the daemon to securely identify the seat on which client
        is [it *might* be possible to do so using
        GetConnectionUnixProcessID, sd_pid_get_session,=C2=A0 and
        sd_session_get_seat, but I suspect that processes started with
        systemctl --user, like wireplumber, might mess that up, since it
        seems they are not part of a session - the comment to
        sd_pid_get_session in sd-login.h seems to point to this problem,
        suggesting that the best that could be done is to use
        GetConnectionUnixUser and sd_uid_get_seats].</li>
      <li>There would, it seems to me, be some utility in being able to
        associate generic named properties with a device so that, for
        example, co-operative seat restrictions could be implemented by
        a client-based protocol.</li>
      <li>Is there an appetite to add support for features of this kind
        into bluez? If so, is there a preferred approach to doing so?</li=
>
    </ol>
  </body>
</html>

--------------5LNH8mdhZdQLhHWYt0nzHOPa--

--------------ms070705060101020704040306
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
CqgwggUuMIIEFqADAgECAhBuYWaYcrycMAAAAABR05MeMA0GCSqGSIb3DQEBCwUAMIG+MQsw
CQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjEoMCYGA1UECxMfU2VlIHd3dy5l
bnRydXN0Lm5ldC9sZWdhbC10ZXJtczE5MDcGA1UECxMwKGMpIDIwMDkgRW50cnVzdCwgSW5j
LiAtIGZvciBhdXRob3JpemVkIHVzZSBvbmx5MTIwMAYDVQQDEylFbnRydXN0IFJvb3QgQ2Vy
dGlmaWNhdGlvbiBBdXRob3JpdHkgLSBHMjAeFw0xOTA0MTYxNTM1NTJaFw0zMDExMTYxNjA1
NTJaMIG3MQswCQYDVQQGEwJVUzEWMBQGA1UEChMNRW50cnVzdCwgSW5jLjEoMCYGA1UECxMf
U2VlIHd3dy5lbnRydXN0Lm5ldC9sZWdhbC10ZXJtczE5MDcGA1UECxMwKGMpIDIwMTUgRW50
cnVzdCwgSW5jLiAtIGZvciBhdXRob3JpemVkIHVzZSBvbmx5MSswKQYDVQQDEyJFbnRydXN0
IENsYXNzIDEgQ2xpZW50IENBIC0gU0hBMjU2MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEA2DmtXj1lwZOXaWXvERtOSP7QMI+Ts82RQc2etqDeYwctILXqkwsQrZB6YjKa1BQn
BmLHxn3cWxKJtqCT7ZP95YVxc0MXjP5ifP9xD/f59jlYd/7SPIxQUjX1+vsV6aY4tTzPiaOu
3VHVGbD70si3WdUvJh367CMOU2o0mXi9MwW1fBwMHK99NKgpwpr4QhyT2aZ+os/hGGQLUYms
e5Dfshq79eelXyFC1FIrvM0AhAk+T3NKFPmckKwyk30jkFMElSneTR7ganOTMeT1OEqVomyJ
sMzJugVaMzuSt4vhJFSt/XXRMPcPT9PEx39X78NNkWeTTkL1Ghq9O2WeAStQNwIDAQABo4IB
KzCCAScwDgYDVR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0lBBYwFAYI
KwYBBQUHAwIGCCsGAQUFBwMEMDsGA1UdIAQ0MDIwMAYEVR0gADAoMCYGCCsGAQUFBwIBFhpo
dHRwOi8vd3d3LmVudHJ1c3QubmV0L3JwYTAzBggrBgEFBQcBAQQnMCUwIwYIKwYBBQUHMAGG
F2h0dHA6Ly9vY3NwLmVudHJ1c3QubmV0MDAGA1UdHwQpMCcwJaAjoCGGH2h0dHA6Ly9jcmwu
ZW50cnVzdC5uZXQvZzJjYS5jcmwwHQYDVR0OBBYEFOJJuewl3rcM3uVQGFtIzAyOFfKmMB8G
A1UdIwQYMBaAFGpyJnrQHu995ztpUdRsjZ+QEmarMA0GCSqGSIb3DQEBCwUAA4IBAQBVuaCw
N5r85cQphcyUe+RXqaYyUmVEqTWG/a98UJdX44vkCgzdD/+Cn4o6wbRun7Ak0kdCR3qfFA17
/5QOQ8DLOyR5X37Ytxby24lTLKKehNlc3japM8XQQFaJqLMq3MXXFYhWlFk4UHwXYLcDR7Xy
A3hYuaL6HU92h+uGSDEcBeV+nXrk4FRgEfGvilHfd+8ozBjSVKOF6L1+fuJNkaFWYvJ4Qi64
nlmXDsk6K9f6P4FT8hXA2Cn6tQGAqCz8t6bn7ljtaxCMJ10LE+omiZDfWXv4PrkvgWnNqZEz
Qw+E09HwEc7DjV9/fGqUhLR2AKkjYE/78rlymYPvOf7bmpSYMIIFcjCCBFqgAwIBAgIQM3aE
+0cPnrye7wdfmopOljANBgkqhkiG9w0BAQsFADCBtzELMAkGA1UEBhMCVVMxFjAUBgNVBAoT
DUVudHJ1c3QsIEluYy4xKDAmBgNVBAsTH1NlZSB3d3cuZW50cnVzdC5uZXQvbGVnYWwtdGVy
bXMxOTA3BgNVBAsTMChjKSAyMDE1IEVudHJ1c3QsIEluYy4gLSBmb3IgYXV0aG9yaXplZCB1
c2Ugb25seTErMCkGA1UEAxMiRW50cnVzdCBDbGFzcyAxIENsaWVudCBDQSAtIFNIQTI1NjAe
Fw0yMjA1MTEwMzE2MTlaFw0yNTA1MTAwMzE2MTlaMIGfMR4wHAYDVQQLExVQZXJzb25hIE5v
dCBWYWxpZGF0ZWQxNzA1BgNVBAsTLkVudHJ1c3QgQ2xhc3MgMSBJZGVudGl0eSBDZXJ0aWZp
Y2F0aW9uIFNlcnZpY2UxHjAcBgNVBAMMFXRyb3lAdHJveXJvbGxvLmNvbS5hdTEkMCIGCSqG
SIb3DQEJARYVdHJveUB0cm95cm9sbG8uY29tLmF1MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEAvyLVjuXO4gto0seUhh2tZiJ7RA3vXgebzFBr3Og5DfQRAe/H1kPdeXLlDQb3
X+4PVy9Fbg6+/U4EZEd0lQB1fDNAfXKrOQmtrcWmsuXh6stE/YTbVFBrxfGDBRYcQXxedY8K
jDzy0xFd4VdkDiSBPxMR76ytXRQNTrlQakdPsGHQGFz+NjetYuBRxrJr2JbVrtASmz5STQAz
xehn5Nl4RQS6EeoS0AFLKD2zXnWLNBCHXB22VbFOlzy+wlruKTh/OYb2Pv6EAMg58ES2sWgu
VRoLjcWzdsFhrRdV/tz5XHgjVszqLajFULw2sAYmk/YXdMCwV1w58u5pP1jVod6LRQIDAQAB
o4IBjjCCAYowDAYDVR0TAQH/BAIwADAdBgNVHQ4EFgQUMHZKCp74vYc1aS8Rxzl/VtjuL+cw
HwYDVR0jBBgwFoAU4km57CXetwze5VAYW0jMDI4V8qYwaQYIKwYBBQUHAQEEXTBbMCMGCCsG
AQUFBzABhhdodHRwOi8vb2NzcC5lbnRydXN0Lm5ldDA0BggrBgEFBQcwAoYoaHR0cDovL2Fp
YS5lbnRydXN0Lm5ldC9jbGFzczEtc2hhMjU2LmNlcjA5BgNVHR8EMjAwMC6gLKAqhihodHRw
Oi8vY3JsLmVudHJ1c3QubmV0L2NsYXNzMS1zaGEyNTYuY3JsMCAGA1UdEQQZMBeBFXRyb3lA
dHJveXJvbGxvLmNvbS5hdTAOBgNVHQ8BAf8EBAMCBaAwHQYDVR0lBBYwFAYIKwYBBQUHAwIG
CCsGAQUFBwMEMEMGA1UdIAQ8MDowOAYLYIZIAYb6bAoBBAEwKTAnBggrBgEFBQcCARYbaHR0
cHM6Ly93d3cuZW50cnVzdC5uZXQvcnBhMA0GCSqGSIb3DQEBCwUAA4IBAQClD6pWVO7Sdjf6
dwRPKH8C0LkrmxCj/QmBZFcjqcTfFywO3qI4g+1bUksSO2wH7hZIVyzHiSbJ+nB1PinNjotf
BYm825JzWbO7OV/K+ralJj/FavC8kNOxJs3WH68YQA9sGzmgitxXmbUA04dfcZU4JN+1G3vN
wHCKKncG8XPdD83cBPWcpRVUNU37XjxKfoFMYmpzbTURiMVM5WnP/JxT3bm+oHNV6D43oUkU
eeYjiz+xhrziWDLCKl39us63KXSQCb1NrMpjcnilKDem+TWLf7NEDqxh73aVcXuSkIPseY5y
RZZThnvFdADU/9e30esnWgZqAf1y4r3cuehGXNYuMYIElTCCBJECAQEwgcwwgbcxCzAJBgNV
BAYTAlVTMRYwFAYDVQQKEw1FbnRydXN0LCBJbmMuMSgwJgYDVQQLEx9TZWUgd3d3LmVudHJ1
c3QubmV0L2xlZ2FsLXRlcm1zMTkwNwYDVQQLEzAoYykgMjAxNSBFbnRydXN0LCBJbmMuIC0g
Zm9yIGF1dGhvcml6ZWQgdXNlIG9ubHkxKzApBgNVBAMTIkVudHJ1c3QgQ2xhc3MgMSBDbGll
bnQgQ0EgLSBTSEEyNTYCEDN2hPtHD568nu8HX5qKTpYwDQYJYIZIAWUDBAIBBQCgggKZMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDkxOTAyNDU1Mlow
LwYJKoZIhvcNAQkEMSIEIMHhcG7hSyhFs0TVdPgYUk7rrUkv39im79DMaEYfTQeeMGwGCSqG
SIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggq
hkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgd0G
CSsGAQQBgjcQBDGBzzCBzDCBtzELMAkGA1UEBhMCVVMxFjAUBgNVBAoTDUVudHJ1c3QsIElu
Yy4xKDAmBgNVBAsTH1NlZSB3d3cuZW50cnVzdC5uZXQvbGVnYWwtdGVybXMxOTA3BgNVBAsT
MChjKSAyMDE1IEVudHJ1c3QsIEluYy4gLSBmb3IgYXV0aG9yaXplZCB1c2Ugb25seTErMCkG
A1UEAxMiRW50cnVzdCBDbGFzcyAxIENsaWVudCBDQSAtIFNIQTI1NgIQM3aE+0cPnrye7wdf
mopOljCB3wYLKoZIhvcNAQkQAgsxgc+ggcwwgbcxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1F
bnRydXN0LCBJbmMuMSgwJgYDVQQLEx9TZWUgd3d3LmVudHJ1c3QubmV0L2xlZ2FsLXRlcm1z
MTkwNwYDVQQLEzAoYykgMjAxNSBFbnRydXN0LCBJbmMuIC0gZm9yIGF1dGhvcml6ZWQgdXNl
IG9ubHkxKzApBgNVBAMTIkVudHJ1c3QgQ2xhc3MgMSBDbGllbnQgQ0EgLSBTSEEyNTYCEDN2
hPtHD568nu8HX5qKTpYwDQYJKoZIhvcNAQEBBQAEggEAI9sHTbCC3rQlqY4KNMT44kmJ7dpK
b+LN++XbEa5tckbld8nnx1n4QkxQsdy4t+90cwKDlBwQBtjvjik6o7AOQKYOuK6KM+XrJ9KD
c90QaqdXEC0XBL84JLcmxcg4+tPKXqk8oJX6nKt9tis3mT+J5lcUfVxsgLvef9RowqaBeYv/
G3WmlZkygoL3W2UT9a2/bkanRrbmPJizi5mhXhIlEMoMy1dbLIvMc+UM/tjZ7N+3YcVJr7A9
9jN1d40dmah96cKaNhXMn9aN9pw11/nPF4M8YlDUEO+nBoUMQtta5Ysv43hhTeFGjPtPWpvm
WXdJcHGiOEukDWk1jC8K18381AAAAAAAAA==
--------------ms070705060101020704040306--
