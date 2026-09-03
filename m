Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FF14F0545;
	Thu,  3 Sep 2026 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788454059; cv=pass; b=E73+Za8RNKLMuX6qCQGB/orWi8paFZeNYuECSe0GmBrxAplBACmHBD8lKBYZCuasTj20mNd9wYQhevUVEW3AoAKc6uYVQaTxb3zwN7eCPoXCo+Fqh6y16jKh6TpApXcDxHZjtVk1p4L4UUZwgelDh8VGs8toieIkU8BLXoimlV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788454059; c=relaxed/simple;
	bh=MIRUMVkYDzZ/Seq9yXEy1WuJCG31PCa9NudAd3g09dM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O9uJDjczKiqyROyveoVVWghUiQcUbnef12VxKM960vdesk/mp0kzGHZEUQhnht4XVuy3HufIafXNTftwMZBu+qaH8nqs7YkXZgUyvWqJ07ySEe1+CFy2cDphs0vF6JTzKcF1zxY3R/aEoIqPT49/Z+aysuZluZFs4fLAHusQL1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=VMLlySSM; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="VMLlySSM"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hbQW363vFz49Q35;
	Thu, 03 Sep 2026 19:47:27 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1788454049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBINaVXGEcgFK1UwLcfLYXPUftBRZd4zl8QsZ8eUl6g=;
	b=VMLlySSM+Y4+sMHwZyrp8MMnXMgKzx6gbfGbUM3mJ4v2rlr/Aquib2wth44VSCgx4Sytni
	s4GOw7kYTxWTXHQdZq5VNcUcN9Czs0x/bz70tNyJbPtd+68tDp+lt4z7lUeHw6c91fbNQw
	tGGYKdRuzGczsMnctbp3mT+tB+2kbF08yyBcTQT1nTAwyOPChc+BKPe9whknksqrHbkI0c
	cqWynNpg/zuazrosF5P11jgzrGX6/7mBNJ/l72uxAMo6aeYa0o+vL+47857AZu4y2GeWPG
	A1eaiSiz3iaTdd/kqJ5ngu0XwHeRRZt4+7zdcav9Im+k+3H7pqxVMa2daiWE0g==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1788454049;
	b=icVJLbquYr9upOL1XAo4IhoR8miFjnw138IOIWD0tQjihfOI3aesYDU4u6hSk6vmHrB+8N
	oFnHSxURk3l+7Z0Gy9nlEcLX/2pQkLTVgvpJBOqwfEvJB93vnlq72OES3GU50CkKDh/81l
	bucg0sngtQKHD6lRA6eNEudAylgvdMr1qD7JwzT5oD23/HfhmQXByd7sQ7tAPf9y0YFVDL
	GjC01epB77T4bbmBf4/cXdUAu+vljH5sZzcG+BE28qUmmZVNh0g5c+C8jtxTTn3XNab0qY
	Lqpgj40deO03sExme9JnZklROe/H0/t8kwVTqOQXd60Ibb8v0WwmL69/g92KMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1788454049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBINaVXGEcgFK1UwLcfLYXPUftBRZd4zl8QsZ8eUl6g=;
	b=VqrCa9IihnVNreRHk/1Darr7fY03Zr/DrQ8fuiS/LwNw2YEGyCdvYEZ0hCr13/cGhkOEu0
	3bB5QYp86sCkckv5cW2esv6+X9cOeqgrYADxf3oOvjWyorcCPwWr8tnAHpdCQyXTWsiBmz
	2dKSjWWqJ7ovqLpti/gcIo3nGTOu345P1uCklPaNUIbmaLob2MyTvIQ3aMKGp2hQzf3TS2
	XQskWcxYwRy+OR+M4wnu7M7xCbUz1xHUpEEF15E855gLkox4olh54YOJOu7aU0q0PiKOjl
	yT8iAazY9n5BwmUWSREga2IdyJ0U0j9H6NuYaGZ9mBgTKt3ZDye0H4UMBpNmGw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <947b663be7dded8a00aad6a277bb82eb8a9069be.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: RFCOMM: defer security confirmation to
 krfcommd
From: Pauli Virtanen <pav@iki.fi>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, marcel@holtmann.org, 
	luiz.dentz@gmail.com
Cc: nicoyip.dev@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com
Date: Thu, 03 Sep 2026 19:47:26 +0300
In-Reply-To: <20260902235132.453044-1-mikhail.v.gavrilov@gmail.com>
References: <20260902235132.453044-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

to, 2026-09-03 kello 04:51 +0500, Mikhail Gavrilov kirjoitti:
> An RFCOMM connect() issued while a BR/EDR link is being authenticated
> makes lockdep report a circular dependency, and the reported cycle is a
> real AB/BA between rfcomm_mutex and hdev->lock.
>=20
> rfcomm_security_cfm() is called from the HCI event path, which already
> holds hdev->lock:
>=20
>   hci_rx_work()
>     hci_event_packet()
>       hci_cc_read_enc_key_size()   [hdev->lock]
>         hci_encrypt_cfm()          [hci_cb_list_lock]
>           rfcomm_security_cfm()    [rfcomm_mutex]
>=20
> while an RFCOMM connect() from userspace takes the same two locks the
> other way round:
>=20
>   rfcomm_sock_connect()
>     rfcomm_dlc_open()              [rfcomm_mutex]
>       __rfcomm_dlc_open()
>         rfcomm_session_create()
>           kernel_connect()
>             l2cap_sock_connect()
>               l2cap_chan_connect() [hdev->lock]
>=20
>   WARNING: possible circular locking dependency detected
>   kworker/u131:1/1128 is trying to acquire lock:
>   rfcomm_mutex, at: rfcomm_security_cfm+0x31/0x3e0 [rfcomm]
>   but task is already holding lock:
>   hci_cb_list_lock, at: hci_cc_read_enc_key_size+0x1d2/0xcc0
>   Chain exists of:
>     rfcomm_mutex --> &hdev->lock --> hci_cb_list_lock
>=20
> hci_auth_complete_evt() and hci_encrypt_change_evt() reach the callback
> the same way.
>=20
> Both orders have to be seen in the same boot, which is why a BR/EDR
> connection alone is not enough to show it: a session set up by the
> remote side is created by rfcomm_accept_connection() in krfcommd, which
> calls kernel_accept() and never takes hdev->lock under rfcomm_mutex.
> Connecting a device that authenticates and encrypts the link and then
> calling connect() on an RFCOMM socket towards any address - the connect
> does not have to succeed, the order is recorded before the page timeout
> - reports it every time.
>=20
> The callback does not have to run in the HCI event context at all: it
> only updates DLC flags and timers that krfcommd consumes in
> rfcomm_process_dlcs(), and it already ends with rfcomm_schedule().  So
> queue the confirmation instead of taking rfcomm_mutex from the HCI
> event path, and let krfcommd apply it under rfcomm_mutex on its next
> pass, ahead of session processing.  The queued entry carries the local
> address and a reference on the connection, so the session lookup and
> hci_conn_check_secure() stay valid without hdev->lock.  A confirmation
> that cannot be allocated is dropped and the DLC closes on its auth
> timeout.

Sashiko review comment that security_cfm() cleanup should be run in
rfcomm_init() after hci_unregister_cb(), appears correct.

AFAICS, none of the callsites of hci_auth_cfm(), which call the
security_cfm, require that it is synchronous under the lock.=C2=A0

However, rfcomm_session_get() could return a different session if
processing is delayed. Is this a concern? ABA issue?

This patch introduces data race in read of conn->cfm->sec_level,
probably benign, but these are not marked with READ_ONCE/WRITE_ONCE.

I'd maybe take hdev_lock in rfcomm_process_security_cfm instead. This
requires struct hci_dev *hdev; added in rfcomm_sec_cfm and hci_dev
get/put, since hci_conn_get() does not guarantee hci_conn::hdev is
valid pointer.

I'd maybe also add Documentation/dev-tools/context-analysis.rst
annotations while at it, unless it requires extensive changes.

> Fixes: 759c185d0bbd ("Bluetooth: RFCOMM: serialize security confirmation =
handling")
> Reported-by: Pauli Virtanen <pav@iki.fi>
> Closes: https://lore.kernel.org/linux-bluetooth/5e76a95e934e451e7006db288=
27c2d64af5a88be.camel@iki.fi/
> Reported-by: syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-bluetooth/6a92fadc.08e933ee.dbf97.0=
08f.GAE@google.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
>=20
> The commit this fixes is in v7.3-rc1 and is marked for stable, so this
> probably wants the bluetooth fixes tree rather than -next.
>=20
> Tested on 7.3.0-rc1 with an MTK MT7921 controller (btusb) and a JBL
> Tour Pro 3 headset.  Without this patch the steps above report the
> inversion on every run.  With it applied the reproducer leaves the
> validator armed and silent (debug_locks: 1), and a 5.5 hour session
> with four headset connects, HFP/SCO audio and AVRCP produced no
> lockdep report either.
>=20
> The connect() side used for testing, so that it does not depend on which
> end sets up the HFP session:
>=20
>   #include <stdint.h>
>   #include <string.h>
>   #include <unistd.h>
>   #include <sys/socket.h>
>=20
>   #define BTPROTO_RFCOMM 3
>=20
>   struct sockaddr_rc {
> 	unsigned short	rc_family;
> 	uint8_t		rc_bdaddr[6];	/* little endian */
> 	uint8_t		rc_channel;
>   };
>=20
>   int main(void)
>   {
> 	struct sockaddr_rc addr =3D { .rc_family =3D AF_BLUETOOTH,
> 				    .rc_channel =3D 1 };
> 	int fd =3D socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
>=20
> 	memcpy(addr.rc_bdaddr, "\x55\x44\x33\x22\x11\x00", 6);
> 	connect(fd, (struct sockaddr *)&addr, sizeof(addr));
> 	close(fd);
> 	return 0;
>   }
>=20
>  net/bluetooth/rfcomm/core.c | 139 ++++++++++++++++++++++++++----------
>  1 file changed, 100 insertions(+), 39 deletions(-)
>=20
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index f7463f092283..728a6bd2986b 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -49,6 +49,18 @@ static DEFINE_MUTEX(rfcomm_mutex);
> =20
>  static LIST_HEAD(session_list);
> =20
> +/* Security confirmations handed over from the HCI event handler to krfc=
ommd */
> +struct rfcomm_sec_cfm {
> +	struct list_head	list;
> +	struct hci_conn		*conn;
> +	bdaddr_t		src;
> +	u8			status;
> +	u8			encrypt;
> +};
> +
> +static LIST_HEAD(security_cfm_list);
> +static DEFINE_SPINLOCK(security_cfm_lock);

Context analysis annotations would be useful here:

static DEFINE_SPINLOCK(security_cfm_lock);
static __guarded_by(&security_cfm_lock) LIST_HEAD(security_cfm_list);

struct rfcomm_sec_cfm {
	struct list_head	list __guarded_by(&security_cfm_lock);
	struct hci_conn		*conn;
	bdaddr_t		src;
	u8			status;
	u8			encrypt;
};

Static checker can be run with Clang 23,=C2=A0
make LLVM=3D1 net/bluetooth/

>  static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len=
);
>  static int rfcomm_send_sabm(struct rfcomm_session *s, u8 dlci);
>  static int rfcomm_send_disc(struct rfcomm_session *s, u8 dlci);
> @@ -2122,6 +2134,73 @@ static void rfcomm_process_sessions(void)
>  	rfcomm_unlock();
>  }
> =20
> +/* Must be called with rfcomm_mutex held */
> +static void __rfcomm_security_cfm(struct rfcomm_sec_cfm *cfm)

__must_hold(&rfcomm_mutex) annotation is better than comment, although
would be needed also in the caller.

> +{
> +	struct rfcomm_session *s;
> +	struct rfcomm_dlc *d, *n;
> +
> +	s =3D rfcomm_session_get(&cfm->src, &cfm->conn->dst);
> +	if (!s)
> +		return;
> +
> +	list_for_each_entry_safe(d, n, &s->dlcs, list) {
> +		if (test_and_clear_bit(RFCOMM_SEC_PENDING, &d->flags)) {
> +			rfcomm_dlc_clear_timer(d);
> +			if (cfm->status || cfm->encrypt =3D=3D 0x00) {
> +				set_bit(RFCOMM_ENC_DROP, &d->flags);
> +				continue;
> +			}
> +		}
> +
> +		if (d->state =3D=3D BT_CONNECTED && !cfm->status &&
> +		    cfm->encrypt =3D=3D 0x00) {
> +			if (d->sec_level =3D=3D BT_SECURITY_MEDIUM) {
> +				set_bit(RFCOMM_SEC_PENDING, &d->flags);
> +				rfcomm_dlc_set_timer(d, RFCOMM_AUTH_TIMEOUT);
> +				continue;
> +			} else if (d->sec_level =3D=3D BT_SECURITY_HIGH ||
> +				   d->sec_level =3D=3D BT_SECURITY_FIPS) {
> +				set_bit(RFCOMM_ENC_DROP, &d->flags);
> +				continue;
> +			}
> +		}
> +
> +		if (!test_and_clear_bit(RFCOMM_AUTH_PENDING, &d->flags))
> +			continue;
> +
> +		if (!cfm->status && hci_conn_check_secure(cfm->conn,
> +							  d->sec_level))
> +			set_bit(RFCOMM_AUTH_ACCEPT, &d->flags);
> +		else
> +			set_bit(RFCOMM_AUTH_REJECT, &d->flags);
> +	}
> +}
> +
> +static void rfcomm_process_security_cfm(void)
> +{
> +	struct rfcomm_sec_cfm *cfm, *n;
> +	LIST_HEAD(cfm_list);
> +
> +	spin_lock(&security_cfm_lock);
> +	list_splice_init(&security_cfm_list, &cfm_list);
> +	spin_unlock(&security_cfm_lock);
> +
> +	if (list_empty(&cfm_list))
> +		return;
> +
> +	rfcomm_lock();
> +
> +	list_for_each_entry_safe(cfm, n, &cfm_list, list) {
> +		__rfcomm_security_cfm(cfm);
> +		list_del(&cfm->list);
> +		hci_conn_put(cfm->conn);
> +		kfree(cfm);
> +	}
> +
> +	rfcomm_unlock();
> +}
> +
>  static int rfcomm_add_listener(bdaddr_t *ba)
>  {
>  	struct sockaddr_l2 addr;
> @@ -2201,12 +2280,18 @@ static int rfcomm_run(void *unused)
>  	while (!kthread_should_stop()) {
> =20
>  		/* Process stuff */
> +		rfcomm_process_security_cfm();
>  		rfcomm_process_sessions();
> =20
>  		wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
>  	}
>  	remove_wait_queue(&rfcomm_wq, &wait);
> =20
> +	/* rfcomm_exit() unregisters the HCI callback before stopping this
> +	 * thread, so no further confirmation can be queued here.
> +	 */
> +	rfcomm_process_security_cfm();
> +
>  	rfcomm_kill_listener();
> =20
>  	return 0;
> @@ -2214,50 +2299,26 @@ static int rfcomm_run(void *unused)
> =20
>  static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 enc=
rypt)
>  {
> -	struct rfcomm_session *s;
> -	struct rfcomm_dlc *d, *n;
> +	struct rfcomm_sec_cfm *cfm;
> =20
>  	BT_DBG("conn %p status 0x%02x encrypt 0x%02x", conn, status, encrypt);
> =20
> -	rfcomm_lock();
> -
> -	s =3D rfcomm_session_get(&conn->hdev->bdaddr, &conn->dst);
> -	if (!s) {
> -		rfcomm_unlock();
> +	cfm =3D kmalloc_obj(*cfm);
> +	if (!cfm)
>  		return;
> -	}
> -
> -	list_for_each_entry_safe(d, n, &s->dlcs, list) {
> -		if (test_and_clear_bit(RFCOMM_SEC_PENDING, &d->flags)) {
> -			rfcomm_dlc_clear_timer(d);
> -			if (status || encrypt =3D=3D 0x00) {
> -				set_bit(RFCOMM_ENC_DROP, &d->flags);
> -				continue;
> -			}
> -		}
> =20
> -		if (d->state =3D=3D BT_CONNECTED && !status && encrypt =3D=3D 0x00) {
> -			if (d->sec_level =3D=3D BT_SECURITY_MEDIUM) {
> -				set_bit(RFCOMM_SEC_PENDING, &d->flags);
> -				rfcomm_dlc_set_timer(d, RFCOMM_AUTH_TIMEOUT);
> -				continue;
> -			} else if (d->sec_level =3D=3D BT_SECURITY_HIGH ||
> -				   d->sec_level =3D=3D BT_SECURITY_FIPS) {
> -				set_bit(RFCOMM_ENC_DROP, &d->flags);
> -				continue;
> -			}
> -		}
> -
> -		if (!test_and_clear_bit(RFCOMM_AUTH_PENDING, &d->flags))
> -			continue;
> -
> -		if (!status && hci_conn_check_secure(conn, d->sec_level))
> -			set_bit(RFCOMM_AUTH_ACCEPT, &d->flags);
> -		else
> -			set_bit(RFCOMM_AUTH_REJECT, &d->flags);
> -	}
> -
> -	rfcomm_unlock();
> +	/* The connection is pinned for hci_conn_check_secure(), but it drops
> +	 * its reference on hdev once it is deleted, so take a copy of the
> +	 * local address needed for the session lookup.
> +	 */
> +	cfm->conn =3D hci_conn_get(conn);
> +	bacpy(&cfm->src, &conn->hdev->bdaddr);
> +	cfm->status =3D status;
> +	cfm->encrypt =3D encrypt;
> +
> +	spin_lock(&security_cfm_lock);
> +	list_add_tail(&cfm->list, &security_cfm_list);
> +	spin_unlock(&security_cfm_lock);
> =20
>  	rfcomm_schedule();
>  }

--=20
Pauli Virtanen
