Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1139D37C923
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691603; cv=pass; b=sPyAXZgJZ2ILSdCGmRfavdRf6JjttdpQqqnCrr67FCAfwRJuQjjzBiN+SheZjotanqvQ8MnD7rf5QsLTQzqiLdqgT0V6LGcFXX3th6+mcWjfv1kPupgyQ4ZEcFcFTV4IPmQLfxEKRF7mIRbcq7KruPY4uKh4RoNi8mX9oOyBVac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691603; c=relaxed/simple;
	bh=1ZNMDJbD7Asz8bOY1FPsr9LYzcspyLVGgXYKGJ326Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kE3ZswLOYIsQJO08ajiuBa6WWfFCnilAX+Y6GsvwVEn8W0/DW0UxxCT7baDRUPvShWwd6BDyvrei9qbGZeER/eYLAIXb/4aWuucgCiCGtbAi1hcPzN3V2wmgk6jMTOnsJAGmHiufCWEjF1iKNwOe+UHHKfat7bEHVM2G46eY7lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVubQVCZ; arc=pass smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVubQVCZ"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2e01f5c0aeso41995066b.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 07:20:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790691599; cv=none;
        d=google.com; s=arc-20260327;
        b=i1bTxJeAlGGLf/H7kx/U2XHZKuo0l7Y6zFOt7pMYYfjR6MRHCMpqHoO6oaGnbo9bkX
         BryoaYtxpnRFJ63fh+1UAlqxVMZhQRRvgbxQXF91jiCTx6VQl6qf63Bwf3PCgQrMEx7u
         AVdmZ0Z0WhdnxtgRbQbnXbpIx8rgzr22ECXJ8DWMP6wz/t9AduXCAtboux9RH275QYJP
         Y+PXaKxuosKpjpKgoe25QxQ9kkrolTgVEsd4pb0gzLdWrpiGpymXIbT47Xaw0ksjJItn
         uvJpxrbXPp4kkOCF1Z2o5weEruW+K3/1rMOSoWY5otTudxDoUQa0oIPD9WHV4IfYgMCN
         qpxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VZpjYb6hPh+5qFcb/iVJHG9jrAivdx0dpQXp2FDHj3w=;
        fh=19OzgknSZRlaq5DrPUvE6ClfdUqw4E+eBDnhn9XnNuQ=;
        b=V39NNDTzsZG0jTU0SbeEhpf7Hy12k+XQihCscFPtD/58Cfg+ud1N1L1EeXq/vL/Sv4
         WL9BFQCzlCzKCQyu2JVAl00pHGEwH52wvthOZC7g6QYkH5FDD7OSzFwvpT4OYLCKLegk
         Ah53umoCozAxe+D3KRQDidoXuc0S6r5kbV+BoQRbkiCvCbUCjQ2abAN2BxbF/x6OjHEY
         Z04zy2y6ifgSSD2FWxzMwQe/JfVzwUye1yxc29yhgwSI868hmLnTUEY7jzoMf+j0J1vc
         MZ0SuzPPy2U4m7wznYC12Ltvgt5wxBiDAWEWmA1xjE/Vp/x6v8VkCipwa+QeJiju5k9X
         gUCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790691599; x=1791296399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VZpjYb6hPh+5qFcb/iVJHG9jrAivdx0dpQXp2FDHj3w=;
        b=VVubQVCZL6NBzRpH3ERlHh1S8fUH4UoRsxX0pMheH+AR3mQmWaTwvno7Z5wP9F/nAf
         BbFCAuIhODwdEDHjQC4lstJ0QKGZMeTL2kg6NU7S7YZHwDrpT5g8Nktdda7ngvklPe9i
         5CSnrVUljLghtQHPAdYyMBC2ZPlZlWZ8sbNINabuaJ5/od0qrlD79aPVn5i9DoLWfn+o
         Ng41cYx6KIpPJS35KtAX0715CMTCazrFkQfhG1wAl4bZ9Xxo/Q7EJ4kIj0Gw4eAI0lDn
         zS10d0JwPZ9IZQEI+Dr3tyKxfW/9q5G+0KHlk4EwJHXaXsRl5jxSVaI8VMErCydjn0H9
         vIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790691599; x=1791296399;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VZpjYb6hPh+5qFcb/iVJHG9jrAivdx0dpQXp2FDHj3w=;
        b=m6hWmNBTUPEarNtjhJGF9f6CIMrO8+y50jUdxMoL5awSsuBoQ5+F/4wr4szZkj5BzA
         cAGXm0q3znO7vk6r1Nis7VRuynfnoB+4GFPgLh6NN2rJVbaPbEF+hbwjbadTN/OHjWEE
         Zik/9mnpgp83kcA/mrkshdgdM62zF/vBhj7gEZ9g8XPO8Ao6LGbNG37T3faptHMicfuU
         Uw+kl6xUX+w+GgB5kEO81Zyuovx1xGzjUb8oZt+m9dUy4iTi3gTSZdDqPOwcTA7rEYnD
         5hVSz2bf+twcp228SHebCgyKV5rYRvHsi2VD+cdHAHQnOWlpolhF2Ml6cCD7Vgc8AbKR
         lR0w==
X-Forwarded-Encrypted: i=1; AKwUvBzegqVhtW4iufbgCR4WPkVMe3bIPYsy0qevDiYkj9oIus+0CL5OntFP0AQwXKp/M/3mCdwid/vcpki9qlgLwxI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfTq3S724v43v5kKUG00p760mnn0L/lliE8bEzsVGE5cHsvj5u
	UTODfqW1jIMB/dUoXiNDqViIJhXOQ/uOl8gDSEImPG9UTwG5ty2YvaGSBq1h0d3M+VIeD9feqt7
	9D5Vj2yorIzuysMHSbBK9g+ZRTSXmFcc=
X-Gm-Gg: AYBFou3FIYNcXv3czAjZHXqZCa/j5t5j5cT2vXn+fh7YaK5+FuQ24sBTAH1pddU5gxv
	QSYkGWHZwWN1mQ6HZ+fTF6wQLkvx0pOnbUZfoO5XLNRVgxzZWpq5bOoT5RIh+D3TABYVujUWkMp
	GXCkU00g+PZBMZEMGNG2PMW5DuHPnj0r6SApHqS/UcNEvptgznWEF01qYdPR2MpYNlOXugYbnzg
	6WpmX9BYZ9n6P4zKsFkwjgHSVDRZx++vFK7FYIUcafXtUuOdDbj7hTHKdfUNtFXrk7/aH7UYtGl
	8BZU62AKdJbQjLB3sQa47AAId2c1/0xlA5wusvBJFKdOXMlSJVRcgD1I
X-Received: by 2002:a17:906:a348:20b0:c29:5340:182e with SMTP id
 a640c23a62f3a-c2ac525f2cemr886013966b.2.1790691598377; Tue, 29 Sep 2026
 07:19:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929122226.98970-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20260929122226.98970-1-mikhail.v.gavrilov@gmail.com>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Tue, 29 Sep 2026 22:19:10 +0800
X-Gm-Features: AclHuK9SxdkZ7NL-t5yQszsaST46CKZ58kNaZqB8TFkYGfaujrXcoKF4lJCRxA4
Message-ID: <CANypQFbYeAtYjQzrYd+tsjauOtgfx77aw2UP_nEza6DU4P5TLQ@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: RFCOMM: connect the session socket without rfcomm_mutex
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, nicoyip.dev@gmail.com, 
	pav@iki.fi, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> =E4=BA=8E2026=E5=B9=B49=E6=
=9C=8829=E6=97=A5=E5=91=A8=E4=BA=8C 20:22=E5=86=99=E9=81=93=EF=BC=9A
>
> An RFCOMM connect() issued while a BR/EDR link is being authenticated
> makes lockdep report a circular dependency, and the reported cycle is a
> real AB/BA between rfcomm_mutex and hdev->lock.
>
> rfcomm_security_cfm() is called from the HCI event path, which already
> holds hdev->lock:
>
>   hci_rx_work()
>     hci_event_packet()
>       hci_cc_read_enc_key_size()   [hdev->lock]
>         hci_encrypt_cfm()          [hci_cb_list_lock]
>           rfcomm_security_cfm()    [rfcomm_mutex]
>
> while an RFCOMM connect() from userspace takes the same two locks the
> other way round:
>
>   rfcomm_sock_connect()
>     rfcomm_dlc_open()              [rfcomm_mutex]
>       __rfcomm_dlc_open()
>         rfcomm_session_create()
>           kernel_connect()
>             l2cap_sock_connect()
>               l2cap_chan_connect() [hdev->lock]
>
>   WARNING: possible circular locking dependency detected
>   kworker/u131:1/1128 is trying to acquire lock:
>   rfcomm_mutex, at: rfcomm_security_cfm+0x31/0x3e0 [rfcomm]
>   but task is already holding lock:
>   hci_cb_list_lock, at: hci_cc_read_enc_key_size+0x1d2/0xcc0
>   Chain exists of:
>     rfcomm_mutex --> &hdev->lock --> hci_cb_list_lock
>
> hci_auth_complete_evt() and hci_encrypt_change_evt() reach the callback
> the same way.
>
> Both orders have to be seen in the same boot, which is why a BR/EDR
> connection alone is not enough to show it: a session set up by the
> remote side is created by rfcomm_accept_connection() in krfcommd, which
> calls kernel_accept() and never takes hdev->lock under rfcomm_mutex.
> Connecting a device that authenticates and encrypts the link and then
> calling connect() on an RFCOMM socket towards any address - the connect
> does not have to succeed, the order is recorded before the page timeout
> - reports it every time.
>
> Only the session socket has to be connected with the lock held, and it
> does not: nothing else can see the socket before it is put on the
> session list.  So connect it first and take rfcomm_mutex afterwards,
> which removes the rfcomm_mutex -> hdev->lock order for good, rather
> than keeping the HCI event path out of rfcomm_mutex.
>
> rfcomm_session_create() becomes rfcomm_session_connect(), which returns
> the connected socket without touching the session list, and
> rfcomm_dlc_open() adds the session once it holds the lock again.  If
> another opener added a session for the same pair while this socket was
> connecting, that session is used and this socket is dropped.
> __rfcomm_dlc_open() now takes the session it should use, and its state
> check runs after the lock is re-acquired, so a DLC that was opened or
> closed in the meantime is still handled.
>
> Over an existing ACL link the connection can complete before the
> session reaches the list, and the wakeup from the socket callback is
> then lost, so krfcommd is woken once the session is visible.
>
> Connecting without the lock opens a window in which the socket can be
> closed.  The DLC is not on a session yet, so rfcomm_dlc_close() finds
> nothing to do and returns without touching it, and rfcomm_dlc_open()
> would then attach a DLC whose owner is gone.  rfcomm_dlc_close() now
> marks such a DLC with RFCOMM_CLOSED, and rfcomm_dlc_open() checks the
> mark once it holds rfcomm_mutex again and drops the socket instead of
> attaching the DLC.  The mark is cleared when an open starts, so a DLC
> that is reused is not affected.  This covers both callers of
> rfcomm_dlc_open(), the socket and the tty layer.
>
> Fixes: 759c185d0bbd ("Bluetooth: RFCOMM: serialize security confirmation =
handling")
> Suggested-by: Pauli Virtanen <pav@iki.fi>
> Reported-by: Pauli Virtanen <pav@iki.fi>
> Closes: https://lore.kernel.org/linux-bluetooth/5e76a95e934e451e7006db288=
27c2d64af5a88be.camel@iki.fi/
> Reported-by: syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-bluetooth/6a92fadc.08e933ee.dbf97.0=
08f.GAE@google.com/
> Reported-by: Jiaming Zhang <r772577952@gmail.com>
> Closes: https://lore.kernel.org/all/CANypQFabseTuRiyz2pGkc_Qj0moGDnY7KEp1=
qdTOqkw6gAL3hw@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
>
> The commit this fixes is in v7.3-rc1 and is marked for stable, so this
> probably wants the bluetooth fixes tree rather than -next.
>
> v4:
>  - rfcomm_dlc_close() marks a DLC that is not on a session yet, and
>    rfcomm_dlc_open() drops the socket instead of attaching the DLC when
>    it finds the mark after taking rfcomm_mutex again (Luiz, and the
>    Sashiko review of v3)
>  - Reported-by/Closes for Jiaming Zhang's report, which hits the same
>    cycle from the connect side: rfcomm_dlc_open() holding rfcomm_mutex
>    while l2cap_chan_connect() takes hdev->lock
>  - syzbot tested v3 with its reproducer, no issue:
>    https://lore.kernel.org/all/6ab100d7.71f81b7d.15fa6d.0029.GAE@google.c=
om/
>
> Tested on 7.3.0-rc5 with an MT7922 controller (btusb) and a JBL Tour
> Pro 3 headset.  An RFCOMM connect() towards an address that does not
> answer, run after the headset has authenticated its link, reports the
> inversion without the patch (checked on 7.3-rc2); with v4 it stays quiet
> and the validator is still armed afterwards (debug_locks: 1).  A connect
> towards the connected headset is answered in 23 ms with ECONNREFUSED -
> the session is established over the existing ACL link and the peer
> rejects the channel - and towards an idle one it fails with EHOSTDOWN
> after the page timeout.  The reproducer is in the v3 posting.
>
> v3: https://lore.kernel.org/linux-bluetooth/20260912100315.151674-1-mikha=
il.v.gavrilov@gmail.com/
> v2: https://lore.kernel.org/linux-bluetooth/20260904012028.77590-1-mikhai=
l.v.gavrilov@gmail.com/
> v1: https://lore.kernel.org/linux-bluetooth/20260902235132.453044-1-mikha=
il.v.gavrilov@gmail.com/
>
>  include/net/bluetooth/rfcomm.h |   1 +
>  net/bluetooth/rfcomm/core.c    | 134 +++++++++++++++++++++++----------
>  2 files changed, 96 insertions(+), 39 deletions(-)
>
> diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcom=
m.h
> index 102c278e3..9dc5fd4cb 100644
> --- a/include/net/bluetooth/rfcomm.h
> +++ b/include/net/bluetooth/rfcomm.h
> @@ -207,6 +207,7 @@ struct rfcomm_dlc {
>  #define RFCOMM_AUTH_REJECT  7
>  #define RFCOMM_DEFER_SETUP  8
>  #define RFCOMM_ENC_DROP     9
> +#define RFCOMM_CLOSED       10
>
>  /* Scheduling flags and events */
>  #define RFCOMM_SCHED_WAKEUP 31
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index d91e2a6ee..54ec1136f 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -62,10 +62,9 @@ static void rfcomm_make_uih(struct sk_buff *skb, u8 ad=
dr);
>
>  static void rfcomm_process_connect(struct rfcomm_session *s);
>
> -static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
> -                                                       bdaddr_t *dst,
> -                                                       u8 sec_level,
> -                                                       int *err);
> +static struct socket *rfcomm_session_connect(bdaddr_t *src, bdaddr_t *ds=
t,
> +                                            u8 sec_level, int *err);
> +static struct rfcomm_session *rfcomm_session_add(struct socket *sock, in=
t state);
>  static struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t=
 *dst);
>  static struct rfcomm_session *rfcomm_session_del(struct rfcomm_session *=
s);
>
> @@ -365,28 +364,17 @@ static int rfcomm_check_channel(u8 channel)
>         return channel < 1 || channel > 30;
>  }
>
> -static int __rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr=
_t *dst, u8 channel)
> +static int __rfcomm_dlc_open(struct rfcomm_dlc *d, struct rfcomm_session=
 *s,
> +                            u8 channel)
>  {
> -       struct rfcomm_session *s;
> -       int err =3D 0;
>         u8 dlci;
>
> -       BT_DBG("dlc %p state %ld %pMR -> %pMR channel %d",
> -              d, d->state, src, dst, channel);
> -
> -       if (rfcomm_check_channel(channel))
> -               return -EINVAL;
> +       BT_DBG("dlc %p state %ld session %p channel %d",
> +              d, d->state, s, channel);
>
>         if (d->state !=3D BT_OPEN && d->state !=3D BT_CLOSED)
>                 return 0;
>
> -       s =3D rfcomm_session_get(src, dst);
> -       if (!s) {
> -               s =3D rfcomm_session_create(src, dst, d->sec_level, &err)=
;
> -               if (!s)
> -                       return err;
> -       }
> -
>         dlci =3D __dlci(__session_dir(s), channel);
>
>         /* Check if DLCI already exists */
> @@ -421,14 +409,84 @@ static int __rfcomm_dlc_open(struct rfcomm_dlc *d, =
bdaddr_t *src, bdaddr_t *dst,
>
>  int rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst, =
u8 channel)
>  {
> -       int r;
> +       struct rfcomm_session *s;
> +       struct socket *sock;
> +       int err;
> +
> +       BT_DBG("dlc %p state %ld %pMR -> %pMR channel %d",
> +              d, d->state, src, dst, channel);
> +
> +       if (rfcomm_check_channel(channel))
> +               return -EINVAL;
>
>         rfcomm_lock();
>
> -       r =3D __rfcomm_dlc_open(d, src, dst, channel);
> +       clear_bit(RFCOMM_CLOSED, &d->flags);
>
> +       /* Do not page the remote device for a DLC that cannot be opened
> +        * anyway.  __rfcomm_dlc_open() looks at the state again once the
> +        * lock has been re-acquired below.
> +        */
> +       if (d->state !=3D BT_OPEN && d->state !=3D BT_CLOSED) {
> +               rfcomm_unlock();
> +               return 0;
> +       }
> +
> +       s =3D rfcomm_session_get(src, dst);
> +       if (s) {
> +               err =3D __rfcomm_dlc_open(d, s, channel);
> +               rfcomm_unlock();
> +               return err;
> +       }
>         rfcomm_unlock();
> -       return r;
> +
> +       /* There is no session for this pair yet.  kernel_connect() ends =
up in
> +        * l2cap_chan_connect(), which takes hdev->lock, and the HCI even=
t
> +        * path takes rfcomm_mutex while holding hdev->lock, so the socke=
t has
> +        * to be connected with rfcomm_mutex released.
> +        */
> +       sock =3D rfcomm_session_connect(src, dst, d->sec_level, &err);
> +       if (!sock)
> +               return err;
> +
> +       rfcomm_lock();
> +
> +       /* The DLC may have been closed while the socket was connecting. =
 It
> +        * was not on a session, so rfcomm_dlc_close() could only mark it=
;
> +        * attaching it now would leave it with no owner.
> +        */
> +       if (test_bit(RFCOMM_CLOSED, &d->flags)) {
> +               rfcomm_unlock();
> +               sock_release(sock);
> +               return -ECONNRESET;
> +       }
> +
> +       /* Another opener may have added a session for the same pair in t=
he
> +        * meantime; that one is used and this socket is dropped.
> +        */
> +       s =3D rfcomm_session_get(src, dst);
> +       if (!s) {
> +               s =3D rfcomm_session_add(sock, BT_BOUND);
> +               if (s) {
> +                       s->initiator =3D 1;
> +                       sock =3D NULL;
> +               }
> +       }
> +
> +       err =3D s ? __rfcomm_dlc_open(d, s, channel) : -ENOMEM;
> +
> +       rfcomm_unlock();
> +
> +       if (sock)
> +               sock_release(sock);
> +
> +       /* Over an existing ACL link the connection can complete before t=
he
> +        * session reaches the list, and that wakeup is then lost, so let
> +        * krfcommd look at the socket state now.
> +        */
> +       rfcomm_schedule();
> +
> +       return err;
>  }
>
>  static void __rfcomm_dlc_disconn(struct rfcomm_dlc *d)
> @@ -508,8 +566,14 @@ int rfcomm_dlc_close(struct rfcomm_dlc *d, int err)
>         rfcomm_lock();
>
>         s =3D d->session;
> -       if (!s)
> +       if (!s) {
> +               /* Not on a session yet: rfcomm_dlc_open() may be connect=
ing a
> +                * socket for it with rfcomm_mutex released.  Leave a mar=
k so
> +                * that it does not attach the DLC once it holds the lock=
 again.
> +                */
> +               set_bit(RFCOMM_CLOSED, &d->flags);
>                 goto no_session;
> +       }
>
>         /* after waiting on the mutex check the session still exists
>          * then check the dlc still exists
> @@ -757,12 +821,12 @@ static struct rfcomm_session *rfcomm_session_close(=
struct rfcomm_session *s,
>         return rfcomm_session_del(s);
>  }
>
> -static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src,
> -                                                       bdaddr_t *dst,
> -                                                       u8 sec_level,
> -                                                       int *err)
> +/* Creates the L2CAP socket a new session will run on and starts connect=
ing
> + * it.  Must be called with rfcomm_mutex released.
> + */
> +static struct socket *rfcomm_session_connect(bdaddr_t *src, bdaddr_t *ds=
t,
> +                                            u8 sec_level, int *err)
>  {
> -       struct rfcomm_session *s =3D NULL;
>         struct sockaddr_l2 addr;
>         struct socket *sock;
>         struct sock *sk;
> @@ -792,24 +856,16 @@ static struct rfcomm_session *rfcomm_session_create=
(bdaddr_t *src,
>                 l2cap_pi(sk)->chan->mode =3D L2CAP_MODE_ERTM;
>         release_sock(sk);
>
> -       s =3D rfcomm_session_add(sock, BT_BOUND);
> -       if (!s) {
> -               *err =3D -ENOMEM;
> -               goto failed;
> -       }
> -
> -       s->initiator =3D 1;
> -
>         bacpy(&addr.l2_bdaddr, dst);
>         addr.l2_family =3D AF_BLUETOOTH;
>         addr.l2_psm    =3D cpu_to_le16(L2CAP_PSM_RFCOMM);
>         addr.l2_cid    =3D 0;
>         addr.l2_bdaddr_type =3D BDADDR_BREDR;
>         *err =3D kernel_connect(sock, (struct sockaddr_unsized *)&addr, s=
izeof(addr), O_NONBLOCK);
> -       if (*err =3D=3D 0 || *err =3D=3D -EINPROGRESS)
> -               return s;
> +       if (*err && *err !=3D -EINPROGRESS)
> +               goto failed;
>
> -       return rfcomm_session_del(s);
> +       return sock;
>
>  failed:
>         sock_release(sock);
> --
> 2.43.0
>

After applying the patch and running my reproducer, no issues were triggere=
d.

Tested-by: Jiaming Zhang <r772577952@gmail.com>
