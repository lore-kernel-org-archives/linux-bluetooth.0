Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DA8476CC5;
	Sat,  5 Sep 2026 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788609266; cv=pass; b=qP2bNKH7o4WgKBWpMohigxqx3qB7jge+oT2qwu3bul8O6781bCwPk4T+zAIfQrpSxMiOQwzakhjxW/Zk57ja2cTbxL7qgPXpkvOa89aEf9xi8Nl1kQBrwH4dCtkPPC4oJf4KyrIHe2+A7CFUXmccWUjtqVYL0ndx87Z2C7N35+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788609266; c=relaxed/simple;
	bh=HAy5gInRKAuedVFPr1RINRXiwEyT57RDvjgxazqdbCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CE4kwhTjPGz/vn4+m4CYE8eUqfCIn0U+Dln1d3TKVehYh8dlzFNFKn95AcNcuUlX+QHjaU+I+/C3Zv2Lnxkxu4CnmJVco6v7b8forwqW4+wh7re6Wzb7Ojavu0biVg6D3EGcoF0uuN6RqRDlQSp3V1NwTYY4a6RoWWffyYDV2i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=mDhOEdrK; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="mDhOEdrK"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:1:f410::dc01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hcWvq6kqNz49Pyr;
	Sat, 05 Sep 2026 14:54:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1788609256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82FnXtCOV3RIU5Wrcw7ERScIbK3Tjj5nZpgxYArCsls=;
	b=mDhOEdrKZCjC8AFLZ0XfTlP1k0ATf91FiqePMw0KB4yIvU1c0oYCSQiQd6+dtfyjFvcvc8
	10Wa4FY4jpW2zvyf+cXr9jpooaYmjPfuGogH1Llw4gTmjIqWc1PGCg2Z4PadeT8SDfucDh
	fBOdMG/ggM9Hne/e+6zI7v2e/G/N2NnIk1a4dPSuTFTC972WLctn6iHiQYs1Zq+7fTsbSs
	aN439deTwhk6OWXEaU6z/F2sOQMyCi74giiWHeEZUQcCzm5p2aKbzXkhf0NKGi3GEg5A/l
	P2Tp+LDBQ3odreDB0HgFJoR9nM41joZOalkVqGSQEWB0JRbgFPWQG5GwSTJ3ig==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1788609256;
	b=VLDdQK3X4xjHD3TiE5A6ve1nIO2c4ZCk+rmU1vd7/mbZhGU06qLcFTBJoHhndcUiJr5P/q
	vav4nRKdxoOPA+veBDzddkeC3AQ0bsGOIsc6Zx4HuUO3+H7GLDG+wdfg8VSfnFwvxuoGGh
	q+/j4B1oCrEFj1haznJEgMUpEW3gS4ExoKOCrVlZ+rp9vSBu66QnLxRSMMa1ePRXZLK/m9
	WO+SxZVrSrWPnNL+rd59OBllcRlCQ110yeCpjZ/6Hrprc9JNb4sXjcr+9VrVfeunjgJZXV
	gmxYQUOsyN74ENfd8/fhajqCiMMad8WVtfMHIOU2EXlnuhMfZahkZG4IgvwFRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1788609256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82FnXtCOV3RIU5Wrcw7ERScIbK3Tjj5nZpgxYArCsls=;
	b=CIr+OxaWQxqO9pRSJDOWvMeruLcazEE9NwCy/14oCVwcgTGoODWHtXMatC8FRQSBr+DOZh
	Y2vQQjB5x65+mIP22L7pejQUTRzEhUBai0Dh48KAQlSFI88yWV3RDrclweMg+ZJlxVNC1p
	blVz2QMabx9UGgI1Z9mS0NwifmGSz1vg6rSo4yXid5i0ZzsQ5X+FplfHNkSEyNppz+DI3/
	R8YmC6nx9gMj4Is79s560hxVDL6esjy8Kg4nwRGlPza/luv105TG6KFSL8dYuftmgaa8fv
	QS1RokoqjyRu8hdmf1bRuJPIKtzubtJsn0mwLtf37DqeWRaLHY6yjDH1EdZKBg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <e316af2c02709047ae4982a72d92bebc7feb81e3.camel@iki.fi>
Subject: Re: [PATCH v2] Bluetooth: RFCOMM: defer security confirmation to
 krfcommd
From: Pauli Virtanen <pav@iki.fi>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, marcel@holtmann.org, 
	luiz.dentz@gmail.com
Cc: nicoyip.dev@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com
Date: Sat, 05 Sep 2026 14:54:14 +0300
In-Reply-To: <20260904012028.77590-1-mikhail.v.gavrilov@gmail.com>
References: <20260902235132.453044-1-mikhail.v.gavrilov@gmail.com>
		 <20260904012028.77590-1-mikhail.v.gavrilov@gmail.com>
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

pe, 2026-09-04 kello 06:20 +0500, Mikhail Gavrilov kirjoitti:
> An RFCOMM connect() issued while a BR/EDR link is being authenticated
> makes lockdep report a circular dependency, and the reported cycle is a
> real AB/BA between rfcomm_mutex and hdev->lock.

The delayed processing of the security confirmations is somewhat hard
for me to reason about.

This v2 checks session hci_conn is the same as original,=C2=A0however it is
unclear if delayed processing of confirmation on the same hci_conn, can
result to wrong outcomes.

What makes it not introduce new race conditions?

My best guess is that synchronization between DLC events and security
CFM was questionable also before, so this would only widen existing
race windows. GPT-5.6 produced report of pre-existing race condition
where security_cfm() races with DLC open and results to intermittent
wrong security level, but I didn't verify this was not nonsense.

I wonder if the kernel_connect() could be moved out from under
rfcomm_mutex, since the RFCOMM channels should already have to handle
transition to CONNECTED state and possible failures there, and the lock
cycle solved from the other side.

LLVM is happy with the context analysis annotations in v2.

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
> pass, ahead of session processing.
>=20
> The queued entry pins both the connection and the controller, and
> krfcommd takes hdev->lock while applying it, so the lookup and
> hci_conn_check_secure() run in the same context as before.  A session
> that was torn down and set up again while the confirmation was queued
> runs over a different hci_conn and is skipped.  A confirmation that
> cannot be allocated is dropped and the DLC closes on its auth timeout.
>=20
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
> v1: https://lore.kernel.org/linux-bluetooth/20260902235132.453044-1-mikha=
il.v.gavrilov@gmail.com/
>=20
> v2:
>  - free queued confirmations from rfcomm_init() and rfcomm_exit() after
>    hci_unregister_cb(), instead of at the end of rfcomm_run(); the init
>    error path stops the thread before unregistering the callback, so
>    the old placement leaked there
>  - pin the controller too and take hdev->lock while the confirmation is
>    applied, so conn->sec_level is read in the same context as before
>  - skip a session that runs over a different hci_conn than the one the
>    confirmation was reported for
>  - context-analysis annotations for security_cfm_list and
>    __rfcomm_security_cfm(); not verified with clang, done by inspection
>  - the reproducer below now uses spaces, gitlint tripped over the tabs
>=20
> Tested on 7.3.0-rc1 with an MT7922 controller (btusb).  Without the
> patch the steps above report the inversion on every run.  With v2
> applied the reproducer leaves the validator armed and silent
> (debug_locks: 1), and a 2.5 hour session with three BR/EDR headsets
> (soundcore Liberty 5, FIIO UTWS17, JBL Tour Pro 3), HFP/SCO audio and
> AVRCP produced no lockdep report.
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
>       unsigned short  rc_family;
>       uint8_t         rc_bdaddr[6];   /* little endian */
>       uint8_t         rc_channel;
>   };
>=20
>   int main(void)
>   {
>       struct sockaddr_rc addr =3D { .rc_family =3D AF_BLUETOOTH,
>                                   .rc_channel =3D 1 };
>       int fd =3D socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
>=20
>       memcpy(addr.rc_bdaddr, "\x55\x44\x33\x22\x11\x00", 6);
>       connect(fd, (struct sockaddr *)&addr, sizeof(addr));
>       close(fd);
>       return 0;
>   }
>=20
>  net/bluetooth/rfcomm/core.c | 178 ++++++++++++++++++++++++++++--------
>  1 file changed, 140 insertions(+), 38 deletions(-)
>=20
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index f7463f092283..246c811dfca1 100644
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
> +	struct hci_dev		*hdev;
> +	struct hci_conn		*conn;
> +	u8			status;
> +	u8			encrypt;
> +};
> +
> +static DEFINE_SPINLOCK(security_cfm_lock);
> +static __guarded_by(&security_cfm_lock) LIST_HEAD(security_cfm_list);
> +
>  static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len=
);
>  static int rfcomm_send_sabm(struct rfcomm_session *s, u8 dlci);
>  static int rfcomm_send_disc(struct rfcomm_session *s, u8 dlci);
> @@ -2122,6 +2134,117 @@ static void rfcomm_process_sessions(void)
>  	rfcomm_unlock();
>  }
> =20
> +static void rfcomm_sec_cfm_free(struct rfcomm_sec_cfm *cfm)
> +{
> +	hci_conn_put(cfm->conn);
> +	hci_dev_put(cfm->hdev);
> +	kfree(cfm);
> +}
> +
> +static struct hci_conn *rfcomm_session_hcon(struct rfcomm_session *s)
> +{
> +	struct l2cap_conn *conn =3D l2cap_pi(s->sock->sk)->chan->conn;
> +
> +	return conn ? conn->hcon : NULL;
> +}
> +
> +static void __rfcomm_security_cfm(struct rfcomm_sec_cfm *cfm)
> +	__must_hold(&rfcomm_mutex)
> +{
> +	struct rfcomm_session *s;
> +	struct rfcomm_dlc *d, *n;
> +
> +	s =3D rfcomm_session_get(&cfm->hdev->bdaddr, &cfm->conn->dst);
> +	if (!s)
> +		return;
> +
> +	/* The confirmation belongs to the link it was reported for.  A
> +	 * session that was torn down and set up again in the meantime runs
> +	 * over a different connection and must not be judged by it.
> +	 */
> +	if (rfcomm_session_hcon(s) !=3D cfm->conn)
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
> +		/* Restores the context the callback used to run in, so that
> +		 * hci_conn_check_secure() sees a stable sec_level.
> +		 */
> +		hci_dev_lock(cfm->hdev);
> +		__rfcomm_security_cfm(cfm);
> +		hci_dev_unlock(cfm->hdev);
> +
> +		list_del(&cfm->list);
> +		rfcomm_sec_cfm_free(cfm);
> +	}
> +
> +	rfcomm_unlock();
> +}
> +
> +/* Drops confirmations that krfcommd will not get to any more.  Called o=
nce
> + * the HCI callback is unregistered and the thread is gone.
> + */
> +static void rfcomm_flush_security_cfm(void)
> +{
> +	struct rfcomm_sec_cfm *cfm, *n;
> +	LIST_HEAD(cfm_list);
> +
> +	spin_lock(&security_cfm_lock);
> +	list_splice_init(&security_cfm_list, &cfm_list);
> +	spin_unlock(&security_cfm_lock);
> +
> +	list_for_each_entry_safe(cfm, n, &cfm_list, list) {
> +		list_del(&cfm->list);
> +		rfcomm_sec_cfm_free(cfm);
> +	}
> +}
> +
>  static int rfcomm_add_listener(bdaddr_t *ba)
>  {
>  	struct sockaddr_l2 addr;
> @@ -2201,6 +2324,7 @@ static int rfcomm_run(void *unused)
>  	while (!kthread_should_stop()) {
> =20
>  		/* Process stuff */
> +		rfcomm_process_security_cfm();
>  		rfcomm_process_sessions();
> =20
>  		wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
> @@ -2214,50 +2338,25 @@ static int rfcomm_run(void *unused)
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
> -
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
> =20
> -		if (!test_and_clear_bit(RFCOMM_AUTH_PENDING, &d->flags))
> -			continue;
> -
> -		if (!status && hci_conn_check_secure(conn, d->sec_level))
> -			set_bit(RFCOMM_AUTH_ACCEPT, &d->flags);
> -		else
> -			set_bit(RFCOMM_AUTH_REJECT, &d->flags);
> -	}
> +	/* hci_conn drops its own reference on hdev once it is deleted, so
> +	 * both objects are pinned until krfcommd is done with them.
> +	 */
> +	cfm->hdev =3D hci_dev_hold(conn->hdev);
> +	cfm->conn =3D hci_conn_get(conn);
> +	cfm->status =3D status;
> +	cfm->encrypt =3D encrypt;
> =20
> -	rfcomm_unlock();
> +	spin_lock(&security_cfm_lock);
> +	list_add_tail(&cfm->list, &security_cfm_list);
> +	spin_unlock(&security_cfm_lock);
> =20
>  	rfcomm_schedule();
>  }
> @@ -2333,6 +2432,7 @@ static int __init rfcomm_init(void)
> =20
>  unregister:
>  	hci_unregister_cb(&rfcomm_cb);
> +	rfcomm_flush_security_cfm();
> =20
>  	return err;
>  }
> @@ -2345,6 +2445,8 @@ static void __exit rfcomm_exit(void)
> =20
>  	kthread_stop(rfcomm_thread);
> =20
> +	rfcomm_flush_security_cfm();
> +
>  	rfcomm_cleanup_ttys();
> =20
>  	rfcomm_cleanup_sockets();
