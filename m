Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DC923505E
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Mar 2026 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772873970; cv=pass; b=apm3ByAABvUd85SkK4zDiK3w+3cdaVQ1hxTzxEKebiMn8EdMxbVjTDr6J4hxdN1tx1/NhwAvawP07sxIVGKcob9eHBA7FOdGoBSHPYKEwskotW4iPNn5ncQeINbiSGrm6OoBUyk6CGn/n0CrfMn+ZEyRy34n4Uwhcu4mXw6N4r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772873970; c=relaxed/simple;
	bh=iwSSpqBVXqMFqkavREGtktR5gYXmLmxArrnfDszkvAg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hJKfTjdb5HFlHZz16IO6ufyGOSJTDCCFEeCaX7SrDG5H1vLf12i3SGcQYWyqJXdxbsKxA12JVNpnQGBfwwDhKcQ2MxbdVygv6UITcIN9w2DPtlrP7VwGM1de8A6YkSRyZK2QEfYh14Ocbqgvggu/X3vkoKHMrlMCVtE6k63Ogy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=O3vseO+U; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="O3vseO+U"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fScf42DYLz49Q6d;
	Sat, 07 Mar 2026 10:59:24 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1772873964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V90Y3wwYHhexbEkUPvMfBrN2UBbZCj32aSxyY+1BOG4=;
	b=O3vseO+UPMwv6FmBhMBePfNleA+B91WHYEqRKt+2iqH/69fWeT/HwBA/IQMkJmRgNeABlp
	QJPgacnAKaPs4ZbYy17ljQQx79/EqRji8Jmi4OeHx13iLDeumb8+85XuW1gQ2hbAPgYXMQ
	n6CUAMpwB5Eh1eGOamIi3Q1JYE1cFxm6037hKtKfSJNIpGH6sVozX7UiSMncD32EVZR+2N
	3GSVJOwIPonBf5lKm2vzKGif2U9U8OK6ToMEwOqZXHOOF5/OMNVjUnOg+f0nFFhwUmE4ss
	ZggMxcSmtnHwJqQysAmUmsbq3Bfp5Zubr9Py0svIEay/8I9LuqfkidDveh6MPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1772873964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V90Y3wwYHhexbEkUPvMfBrN2UBbZCj32aSxyY+1BOG4=;
	b=ZyO+1oSGQ7bXIj1yWyics3MIozbSwNU/HPqAQCMsW6+1Zu2ul9AZeU8kksuX2stYc3e9aV
	g5rAYyiZjFYqAIVe70tkhjxA5RJftvx+2w1NXFjX6G9JsitU6nRRExWN2QmkD/0PEQxLHV
	uYJvcINeNjri1r06GMjRV4CHkqG0650SuMD0dS4Vk4mNuHY9UmwHGAYI1DuCLcaQXOUUex
	5z1b8sVJQ4pAsSJDMwLBgy/9faQl5tUazt87RN559Lm6OhYxgmRfKR+vZo/k9J4S+EQnQi
	4osHqPnT8sKKJgnK8QajsXc3xUGtek9k8UuHEeV25Acxi5Fkaa5K6ZxhIfqh3Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1772873964;
	b=fwsgc+1YioQJP/jy1qrW3D6e5o9Lm6owJ8xqKlyg347zWS0jDIZbFsUFex3mqLj/g/lTwO
	XejeNR/lL5oELTZVE67l5bXUvX2dCNO+MLoFo8aJPFn+/w5R47RYGubpsVRTb+8q18wnRv
	bOvxdTWZwSf8+gRhuLyHPZNGthD6mJYqNRVch5018gXfwvqfFq+sGN9DumrrtKCTMljrHk
	H3eWUCHicODhgeuR0E9zqc5w4wP49sv/rl5QnVOs3SqfSqAwn6raKIzygRtps1BFi9Rhgg
	/28JCbSoWY97O+6gwXnspsGExcX0sK/wV/Li0TcrAqTDIjOECXaiHk4NfrmS6w==
Message-ID: <625d3721ef07c7c15488af80fbfc53620921611b.camel@iki.fi>
Subject: Re: [RESEND] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_unregister_user
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
Date: Sat, 07 Mar 2026 10:59:23 +0200
In-Reply-To: <20260306210427.703454-1-luiz.dentz@gmail.com>
References: <20260306210427.703454-1-luiz.dentz@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: multipart/mixed; boundary="=-I4oMZjSpgmaIJLnLzrie"
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-I4oMZjSpgmaIJLnLzrie
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

pe, 2026-03-06 kello 16:04 -0500, Luiz Augusto von Dentz kirjoitti:
> From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
>=20
> After commit ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in
> hci_chan_del"), l2cap_conn_del() uses conn->lock to protect access to
> conn->users and conn->hchan. However, l2cap_register_user() and
> l2cap_unregister_user() still use hci_dev_lock(), creating a race
> condition where these functions can access conn->users and conn->hchan
> concurrently with l2cap_conn_del().

AFAIK the above text from the original submitter is a bit inaccurate,
as l2cap_conn_del()=C2=A0is called with hdev lock held, so conn->users/hcha=
n
should be safe.

However, using conn->mutex should fix the use-after-free in

	conn->hcon->hdev
	hci_dev_lock(hdev);
	hci_dev_unlock(hdev);

by making l2cap_unregister_user() safe to call after the hcon/hdev are
no longer alive.

The change looks OK to me, but probably worth to double check with
syzbot it fixes the original issue

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth=
-next.git master

> This can lead to use-after-free and list corruption bugs, as reported
> by syzbot.
>=20
> Fix this by changing l2cap_register_user() and l2cap_unregister_user()
> to use conn->lock instead of hci_dev_lock(), ensuring consistent locking
> for the l2cap_conn structure.
> Reported-by: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D14b6d57fb728e27ce23c
> Fixes: ab4eedb790ca ("Bluetooth: L2CAP: Fix corrupted list in hci_chan_de=
l")
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/l2cap_core.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>=20
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 14131e427efd..6606d7f12534 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1678,17 +1678,15 @@ static void l2cap_info_timeout(struct work_struct=
 *work)
> =20
>  int l2cap_register_user(struct l2cap_conn *conn, struct l2cap_user *user=
)
>  {
> -	struct hci_dev *hdev =3D conn->hcon->hdev;
>  	int ret;
> =20
>  	/* We need to check whether l2cap_conn is registered. If it is not, we
> -	 * must not register the l2cap_user. l2cap_conn_del() is unregisters
> -	 * l2cap_conn objects, but doesn't provide its own locking. Instead, it
> -	 * relies on the parent hci_conn object to be locked. This itself relie=
s
> -	 * on the hci_dev object to be locked. So we must lock the hci device
> -	 * here, too. */
> +	 * must not register the l2cap_user. l2cap_conn_del() unregisters
> +	 * l2cap_conn objects under conn->lock, and we use the same lock here
> +	 * to protect access to conn->users and conn->hchan.
> +	 */
> =20
> -	hci_dev_lock(hdev);
> +	mutex_lock(&conn->lock);
> =20
>  	if (!list_empty(&user->list)) {
>  		ret =3D -EINVAL;
> @@ -1709,16 +1707,14 @@ int l2cap_register_user(struct l2cap_conn *conn, =
struct l2cap_user *user)
>  	ret =3D 0;
> =20
>  out_unlock:
> -	hci_dev_unlock(hdev);
> +	mutex_unlock(&conn->lock);
>  	return ret;
>  }
>  EXPORT_SYMBOL(l2cap_register_user);
> =20
>  void l2cap_unregister_user(struct l2cap_conn *conn, struct l2cap_user *u=
ser)
>  {
> -	struct hci_dev *hdev =3D conn->hcon->hdev;
> -
> -	hci_dev_lock(hdev);
> +	mutex_lock(&conn->lock);
> =20
>  	if (list_empty(&user->list))
>  		goto out_unlock;
> @@ -1727,7 +1723,7 @@ void l2cap_unregister_user(struct l2cap_conn *conn,=
 struct l2cap_user *user)
>  	user->remove(conn, user);
> =20
>  out_unlock:
> -	hci_dev_unlock(hdev);
> +	mutex_unlock(&conn->lock);
>  }
>  EXPORT_SYMBOL(l2cap_unregister_user);
> =20

--=-I4oMZjSpgmaIJLnLzrie
Content-Disposition: attachment;
	filename*0=0001-Bluetooth-L2CAP-Fix-use-after-free-in-l2cap_unregist.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-Bluetooth-L2CAP-Fix-use-after-free-in-l2cap_unregist.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSAyZDBlOWNlMzg4OGU0OTRjMTIzMjRjMGY2ODI5MDBkOWY2MWQ1ZWIyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlEOiA8MmQwZTljZTM4ODhlNDk0YzEyMzI0YzBmNjgyOTAw
ZDlmNjFkNWViMi4xNzcyODczMzI5LmdpdC5wYXZAaWtpLmZpPgpGcm9tOiBTaGF1cnlhIFJhbmUg
PHNzcmFuZV9iMjNAZWUudmp0aS5hYy5pbj4KRGF0ZTogRnJpLCA2IE1hciAyMDI2IDE2OjA0OjI3
IC0wNTAwClN1YmplY3Q6IFtQQVRDSF0gQmx1ZXRvb3RoOiBMMkNBUDogRml4IHVzZS1hZnRlci1m
cmVlIGluIGwyY2FwX3VucmVnaXN0ZXJfdXNlcgpUbzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2Vy
bmVsLm9yZwoKQWZ0ZXIgY29tbWl0IGFiNGVlZGI3OTBjYSAoIkJsdWV0b290aDogTDJDQVA6IEZp
eCBjb3JydXB0ZWQgbGlzdCBpbgpoY2lfY2hhbl9kZWwiKSwgbDJjYXBfY29ubl9kZWwoKSB1c2Vz
IGNvbm4tPmxvY2sgdG8gcHJvdGVjdCBhY2Nlc3MgdG8KY29ubi0+dXNlcnMgYW5kIGNvbm4tPmhj
aGFuLiBIb3dldmVyLCBsMmNhcF9yZWdpc3Rlcl91c2VyKCkgYW5kCmwyY2FwX3VucmVnaXN0ZXJf
dXNlcigpIHN0aWxsIHVzZSBoY2lfZGV2X2xvY2soKSwgY3JlYXRpbmcgYSByYWNlCmNvbmRpdGlv
biB3aGVyZSB0aGVzZSBmdW5jdGlvbnMgY2FuIGFjY2VzcyBjb25uLT51c2VycyBhbmQgY29ubi0+
aGNoYW4KY29uY3VycmVudGx5IHdpdGggbDJjYXBfY29ubl9kZWwoKS4KClRoaXMgY2FuIGxlYWQg
dG8gdXNlLWFmdGVyLWZyZWUgYW5kIGxpc3QgY29ycnVwdGlvbiBidWdzLCBhcyByZXBvcnRlZApi
eSBzeXpib3QuCgpGaXggdGhpcyBieSBjaGFuZ2luZyBsMmNhcF9yZWdpc3Rlcl91c2VyKCkgYW5k
IGwyY2FwX3VucmVnaXN0ZXJfdXNlcigpCnRvIHVzZSBjb25uLT5sb2NrIGluc3RlYWQgb2YgaGNp
X2Rldl9sb2NrKCksIGVuc3VyaW5nIGNvbnNpc3RlbnQgbG9ja2luZwpmb3IgdGhlIGwyY2FwX2Nv
bm4gc3RydWN0dXJlLgoKUmVwb3J0ZWQtYnk6IHN5emJvdCsxNGI2ZDU3ZmI3MjhlMjdjZTIzY0Bz
eXprYWxsZXIuYXBwc3BvdG1haWwuY29tCkNsb3NlczogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3Bv
dC5jb20vYnVnP2V4dGlkPTE0YjZkNTdmYjcyOGUyN2NlMjNjCkZpeGVzOiBhYjRlZWRiNzkwY2Eg
KCJCbHVldG9vdGg6IEwyQ0FQOiBGaXggY29ycnVwdGVkIGxpc3QgaW4gaGNpX2NoYW5fZGVsIikK
U2lnbmVkLW9mZi1ieTogU2hhdXJ5YSBSYW5lIDxzc3JhbmVfYjIzQGVlLnZqdGkuYWMuaW4+ClNp
Z25lZC1vZmYtYnk6IEx1aXogQXVndXN0byB2b24gRGVudHogPGx1aXoudm9uLmRlbnR6QGludGVs
LmNvbT4KLS0tCiBuZXQvYmx1ZXRvb3RoL2wyY2FwX2NvcmUuYyB8IDIwICsrKysrKysrLS0tLS0t
LS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL2wyY2FwX2NvcmUuYyBiL25ldC9ibHVldG9vdGgv
bDJjYXBfY29yZS5jCmluZGV4IDE0MTMxZTQyN2VmZC4uNjYwNmQ3ZjEyNTM0IDEwMDY0NAotLS0g
YS9uZXQvYmx1ZXRvb3RoL2wyY2FwX2NvcmUuYworKysgYi9uZXQvYmx1ZXRvb3RoL2wyY2FwX2Nv
cmUuYwpAQCAtMTY3OCwxNyArMTY3OCwxNSBAQCBzdGF0aWMgdm9pZCBsMmNhcF9pbmZvX3RpbWVv
dXQoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCiBpbnQgbDJjYXBfcmVnaXN0ZXJfdXNlcihz
dHJ1Y3QgbDJjYXBfY29ubiAqY29ubiwgc3RydWN0IGwyY2FwX3VzZXIgKnVzZXIpCiB7Ci0Jc3Ry
dWN0IGhjaV9kZXYgKmhkZXYgPSBjb25uLT5oY29uLT5oZGV2OwogCWludCByZXQ7CiAKIAkvKiBX
ZSBuZWVkIHRvIGNoZWNrIHdoZXRoZXIgbDJjYXBfY29ubiBpcyByZWdpc3RlcmVkLiBJZiBpdCBp
cyBub3QsIHdlCi0JICogbXVzdCBub3QgcmVnaXN0ZXIgdGhlIGwyY2FwX3VzZXIuIGwyY2FwX2Nv
bm5fZGVsKCkgaXMgdW5yZWdpc3RlcnMKLQkgKiBsMmNhcF9jb25uIG9iamVjdHMsIGJ1dCBkb2Vz
bid0IHByb3ZpZGUgaXRzIG93biBsb2NraW5nLiBJbnN0ZWFkLCBpdAotCSAqIHJlbGllcyBvbiB0
aGUgcGFyZW50IGhjaV9jb25uIG9iamVjdCB0byBiZSBsb2NrZWQuIFRoaXMgaXRzZWxmIHJlbGll
cwotCSAqIG9uIHRoZSBoY2lfZGV2IG9iamVjdCB0byBiZSBsb2NrZWQuIFNvIHdlIG11c3QgbG9j
ayB0aGUgaGNpIGRldmljZQotCSAqIGhlcmUsIHRvby4gKi8KKwkgKiBtdXN0IG5vdCByZWdpc3Rl
ciB0aGUgbDJjYXBfdXNlci4gbDJjYXBfY29ubl9kZWwoKSB1bnJlZ2lzdGVycworCSAqIGwyY2Fw
X2Nvbm4gb2JqZWN0cyB1bmRlciBjb25uLT5sb2NrLCBhbmQgd2UgdXNlIHRoZSBzYW1lIGxvY2sg
aGVyZQorCSAqIHRvIHByb3RlY3QgYWNjZXNzIHRvIGNvbm4tPnVzZXJzIGFuZCBjb25uLT5oY2hh
bi4KKwkgKi8KIAotCWhjaV9kZXZfbG9jayhoZGV2KTsKKwltdXRleF9sb2NrKCZjb25uLT5sb2Nr
KTsKIAogCWlmICghbGlzdF9lbXB0eSgmdXNlci0+bGlzdCkpIHsKIAkJcmV0ID0gLUVJTlZBTDsK
QEAgLTE3MDksMTYgKzE3MDcsMTQgQEAgaW50IGwyY2FwX3JlZ2lzdGVyX3VzZXIoc3RydWN0IGwy
Y2FwX2Nvbm4gKmNvbm4sIHN0cnVjdCBsMmNhcF91c2VyICp1c2VyKQogCXJldCA9IDA7CiAKIG91
dF91bmxvY2s6Ci0JaGNpX2Rldl91bmxvY2soaGRldik7CisJbXV0ZXhfdW5sb2NrKCZjb25uLT5s
b2NrKTsKIAlyZXR1cm4gcmV0OwogfQogRVhQT1JUX1NZTUJPTChsMmNhcF9yZWdpc3Rlcl91c2Vy
KTsKIAogdm9pZCBsMmNhcF91bnJlZ2lzdGVyX3VzZXIoc3RydWN0IGwyY2FwX2Nvbm4gKmNvbm4s
IHN0cnVjdCBsMmNhcF91c2VyICp1c2VyKQogewotCXN0cnVjdCBoY2lfZGV2ICpoZGV2ID0gY29u
bi0+aGNvbi0+aGRldjsKLQotCWhjaV9kZXZfbG9jayhoZGV2KTsKKwltdXRleF9sb2NrKCZjb25u
LT5sb2NrKTsKIAogCWlmIChsaXN0X2VtcHR5KCZ1c2VyLT5saXN0KSkKIAkJZ290byBvdXRfdW5s
b2NrOwpAQCAtMTcyNyw3ICsxNzIzLDcgQEAgdm9pZCBsMmNhcF91bnJlZ2lzdGVyX3VzZXIoc3Ry
dWN0IGwyY2FwX2Nvbm4gKmNvbm4sIHN0cnVjdCBsMmNhcF91c2VyICp1c2VyKQogCXVzZXItPnJl
bW92ZShjb25uLCB1c2VyKTsKIAogb3V0X3VubG9jazoKLQloY2lfZGV2X3VubG9jayhoZGV2KTsK
KwltdXRleF91bmxvY2soJmNvbm4tPmxvY2spOwogfQogRVhQT1JUX1NZTUJPTChsMmNhcF91bnJl
Z2lzdGVyX3VzZXIpOwogCi0tIAoyLjUzLjAKCg==


--=-I4oMZjSpgmaIJLnLzrie--
