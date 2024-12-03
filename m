Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9B31D79A0
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Dec 2024 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733265016; cv=none; b=aYiXiAyyF0ebl3lulWAcDKQHd7p0edAgX/5R64brXCilzoiXMmOnd/ddHpJ5NiGHTAuMlMfRhWkjdItfK+Xq0Ewc5DCcLGV/rxec4KRYHbpFD+/7sRqboy9PV2mcYWIDItrhH+kOEg0DZba4Y8noyw90miAWOE4SRkN7FuOJyAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733265016; c=relaxed/simple;
	bh=s7SyZ9ajfTAROeZISJbJSZGfKD9q3PX+PeLUb+2tALk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HmgTYDd34OZ9jClbtbC9Ls/nPgoSLi+6UnKCsOUmdLuRmGb1veHUOOuCoSaxxmxFeFzjYmxbk5A+/GifyFiEf/DMn7uZhlh24x94SacQvIjhwCR9NIBYPevwJRig+vqUIsMrHV6L21cOxF0KqucC3vfllZyzzWZwbl/5S4Z07DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LojZFtQG; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LojZFtQG"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ffa8df8850so70146321fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Dec 2024 14:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733265012; x=1733869812; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o6bzzcokBh9EmsiKRX/Y2YgYtkKBvL/HMf3V1kwDOcI=;
        b=LojZFtQGOHWraX+teW6Xy2520t7GPQ3uLJOarb4rmx0PlYH3gRBzBZ3ls7rhjT4VVD
         +BlAc1amvl3DXpHnxOJnbYWF3Nf8grPlKgceCpVmrBG+SymvaKIAPpdRyoqH9k1bcIkz
         IFBUKLByaAHj3dvT/w/qThW+rA42ev0WAWhIsUN5LAZqfvDw9COspOlyCcoqbhQj+OMf
         xrmgtlQrvDwWvsEKS6lQ/wVcZbxCLsET684xvuU4nRAEmp4ly2gjKETNM6T9p8VxLByk
         4mkmTwjI0MACEE3AeFxsD3djoI5MwD0zahMDjc+G0Ct5Oc6CLZJjoyCeaJRSJJHh7hDR
         z7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733265012; x=1733869812;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6bzzcokBh9EmsiKRX/Y2YgYtkKBvL/HMf3V1kwDOcI=;
        b=Mm7wH0MxO0A19Lbj2Dsw6BTlmMKf/UbVzo/KhEQOTfzO7dkTfqKpp1H10QJHoiVTcR
         eGBrt6tV9T8IKQEDvV/rNPh+Wyypr4RUTCrTiJNK3DYdTxXStlFVgfY5dXUzk/g/As7O
         kYXOmNbdoZ9k+FOE/gkFlw56ICzINWiqVceUBXVpBWP9TK9trYhVSWZhC/UXjezI6TnH
         Q/iYZJH4zb/nYPDsIzs4BvIQSbGd4BGA3hrmCvf4jQEcH5vfplfsuKPt5DQtJtmcjJhj
         da4xrVWEQZS1c0nu+tQPVkVMDf/Gtin0a+gvQeQRM0AfQuY5RjopD4hm2J0BeelTdlAn
         caCg==
X-Gm-Message-State: AOJu0Yx+UelszMdzrY7wuLm+ufZAVtNtSzwEs9+9zzvak10SLackuNaY
	AnTkoR/l5e3BDXMEUyf3HNl5GVkC47XjhIzclYqNZ/bmTJvMCWC7sDRCogqUlQ5kT37u53r4SBD
	wrtanBzAAoIkpz3qdTeaP8TQBvleZhQ==
X-Gm-Gg: ASbGncsjz9ld8Nf0/PdBzKYv7CM0WPNHOk7M/tNTAPPexsnvfT7ZdfVbY/d0xD6i/oc
	H2OQRo6X2SME2n8/sUffIK93Y9h9WktX/
X-Google-Smtp-Source: AGHT+IFIzMcA2mnyUYBK9Bav4tY3bewNcelnpWyRinvmcvwt52vrWhYT+JbUr1zMPmfdJIHN0nGYEUoSn8mGvn1zsNo=
X-Received: by 2002:a2e:bcc1:0:b0:2ff:d821:3bc5 with SMTP id
 38308e7fff4ca-30009d2a21cmr27500621fa.36.1733265011294; Tue, 03 Dec 2024
 14:30:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203211435.194301-1-luiz.dentz@gmail.com>
In-Reply-To: <20241203211435.194301-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 3 Dec 2024 17:29:58 -0500
Message-ID: <CABBYNZJeXf0Lbe-vwC1XX6-hRmw4iqgSRbTV=zCZHbT1hWZLoQ@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_core: Fix sleeping function called from
 invalid context
To: linux-bluetooth@vger.kernel.org
Cc: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: multipart/mixed; boundary="0000000000004cdde40628653560"

--0000000000004cdde40628653560
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Tue, Dec 3, 2024 at 4:15=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This reworks hci_cb_list to not use mutex hci_cb_list_lock to avoid bugs
> like the bellow:
>
> BUG: sleeping function called from invalid context at kernel/locking/mute=
x.c:585
> in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 5070, name: kworke=
r/u9:2
> preempt_count: 0, expected: 0
> RCU nest depth: 1, expected: 0
> 4 locks held by kworker/u9:2/5070:
>  #0: ffff888015be3948 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_on=
e_work kernel/workqueue.c:3229 [inline]
>  #0: ffff888015be3948 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_sc=
heduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
>  #1: ffffc90003b6fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at=
: process_one_work kernel/workqueue.c:3230 [inline]
>  #1: ffffc90003b6fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at=
: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
>  #2: ffff8880665d0078 (&hdev->lock){+.+.}-{3:3}, at: hci_le_create_big_co=
mplete_evt+0xcf/0xae0 net/bluetooth/hci_event.c:6914
>  #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire i=
nclude/linux/rcupdate.h:298 [inline]
>  #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock incl=
ude/linux/rcupdate.h:750 [inline]
>  #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: hci_le_create_big_=
complete_evt+0xdb/0xae0 net/bluetooth/hci_event.c:6915
> CPU: 0 PID: 5070 Comm: kworker/u9:2 Not tainted 6.8.0-syzkaller-08073-g48=
0e035fc4c7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
> Workqueue: hci0 hci_rx_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  __might_resched+0x5d4/0x780 kernel/sched/core.c:10187
>  __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>  __mutex_lock+0xc1/0xd70 kernel/locking/mutex.c:752
>  hci_connect_cfm include/net/bluetooth/hci_core.h:2004 [inline]
>  hci_le_create_big_complete_evt+0x3d9/0xae0 net/bluetooth/hci_event.c:693=
9
>  hci_event_func net/bluetooth/hci_event.c:7514 [inline]
>  hci_event_packet+0xa53/0x1540 net/bluetooth/hci_event.c:7569
>  hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4171
>  process_one_work kernel/workqueue.c:3254 [inline]
>  process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
>  worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
>  kthread+0x2f0/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
>
> Reported-by: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D2fb0835e0c9cefc34614
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/hci_core.h | 89 ++++++++++++++++++++++----------
>  net/bluetooth/hci_core.c         |  9 ++--
>  2 files changed, 65 insertions(+), 33 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index ea798f07c5a2..95f11f04e24a 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -804,7 +804,6 @@ struct hci_conn_params {
>  extern struct list_head hci_dev_list;
>  extern struct list_head hci_cb_list;
>  extern rwlock_t hci_dev_list_lock;
> -extern struct mutex hci_cb_list_lock;
>
>  #define hci_dev_set_flag(hdev, nr)             set_bit((nr), (hdev)->dev=
_flags)
>  #define hci_dev_clear_flag(hdev, nr)           clear_bit((nr), (hdev)->d=
ev_flags)
> @@ -2029,12 +2028,18 @@ static inline void hci_connect_cfm(struct hci_con=
n *conn, __u8 status)
>  {
>         struct hci_cb *cb;
>
> -       mutex_lock(&hci_cb_list_lock);
> -       list_for_each_entry(cb, &hci_cb_list, list) {
> -               if (cb->connect_cfm)
> -                       cb->connect_cfm(conn, status);
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(cb, &hci_cb_list, list) {
> +               if (cb->connect_cfm) {
> +                       struct hci_cb cpy =3D *cb;
> +
> +                       /* Callback may block so release RCU read lock */
> +                       rcu_read_unlock();
> +                       cpy.connect_cfm(conn, status);
> +                       rcu_read_lock();
> +               }
>         }
> -       mutex_unlock(&hci_cb_list_lock);
> +       rcu_read_unlock();
>
>         if (conn->connect_cfm_cb)
>                 conn->connect_cfm_cb(conn, status);
> @@ -2044,12 +2049,18 @@ static inline void hci_disconn_cfm(struct hci_con=
n *conn, __u8 reason)
>  {
>         struct hci_cb *cb;
>
> -       mutex_lock(&hci_cb_list_lock);
> +       rcu_read_lock();
>         list_for_each_entry(cb, &hci_cb_list, list) {
> -               if (cb->disconn_cfm)
> -                       cb->disconn_cfm(conn, reason);
> +               if (cb->disconn_cfm) {
> +                       struct hci_cb cpy =3D *cb;
> +
> +                       /* Callback may block so release RCU read lock */
> +                       rcu_read_unlock();
> +                       cpy.disconn_cfm(conn, reason);
> +                       rcu_read_lock();
> +               }
>         }
> -       mutex_unlock(&hci_cb_list_lock);
> +       rcu_read_unlock();
>
>         if (conn->disconn_cfm_cb)
>                 conn->disconn_cfm_cb(conn, reason);
> @@ -2065,12 +2076,18 @@ static inline void hci_auth_cfm(struct hci_conn *=
conn, __u8 status)
>
>         encrypt =3D test_bit(HCI_CONN_ENCRYPT, &conn->flags) ? 0x01 : 0x0=
0;
>
> -       mutex_lock(&hci_cb_list_lock);
> +       rcu_read_lock();
>         list_for_each_entry(cb, &hci_cb_list, list) {
> -               if (cb->security_cfm)
> -                       cb->security_cfm(conn, status, encrypt);
> +               if (cb->security_cfm) {
> +                       struct hci_cb cpy =3D *cb;
> +
> +                       /* Callback may block so release RCU read lock */
> +                       rcu_read_unlock();
> +                       cpy.security_cfm(conn, status, encrypt);
> +                       rcu_read_lock();
> +               }
>         }
> -       mutex_unlock(&hci_cb_list_lock);
> +       rcu_read_unlock();
>
>         if (conn->security_cfm_cb)
>                 conn->security_cfm_cb(conn, status);
> @@ -2105,12 +2122,18 @@ static inline void hci_encrypt_cfm(struct hci_con=
n *conn, __u8 status)
>                         conn->sec_level =3D conn->pending_sec_level;
>         }
>
> -       mutex_lock(&hci_cb_list_lock);
> +       rcu_read_lock();
>         list_for_each_entry(cb, &hci_cb_list, list) {
> -               if (cb->security_cfm)
> -                       cb->security_cfm(conn, status, encrypt);
> +               if (cb->security_cfm) {
> +                       struct hci_cb cpy =3D *cb;
> +
> +                       /* Callback may block so release RCU read lock */
> +                       rcu_read_unlock();
> +                       cpy.security_cfm(conn, status, encrypt);
> +                       rcu_read_lock();
> +               }
>         }
> -       mutex_unlock(&hci_cb_list_lock);
> +       rcu_read_unlock();
>
>         if (conn->security_cfm_cb)
>                 conn->security_cfm_cb(conn, status);
> @@ -2120,12 +2143,18 @@ static inline void hci_key_change_cfm(struct hci_=
conn *conn, __u8 status)
>  {
>         struct hci_cb *cb;
>
> -       mutex_lock(&hci_cb_list_lock);
> +       rcu_read_lock();
>         list_for_each_entry(cb, &hci_cb_list, list) {
> -               if (cb->key_change_cfm)
> -                       cb->key_change_cfm(conn, status);
> +               if (cb->key_change_cfm) {
> +                       struct hci_cb cpy =3D *cb;
> +
> +                       /* Callback may block so release RCU read lock */
> +                       rcu_read_unlock();
> +                       cpy.key_change_cfm(conn, status);
> +                       rcu_read_lock();
> +               }
>         }
> -       mutex_unlock(&hci_cb_list_lock);
> +       rcu_read_unlock();
>  }
>
>  static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 statu=
s,
> @@ -2133,12 +2162,18 @@ static inline void hci_role_switch_cfm(struct hci=
_conn *conn, __u8 status,
>  {
>         struct hci_cb *cb;
>
> -       mutex_lock(&hci_cb_list_lock);
> -       list_for_each_entry(cb, &hci_cb_list, list) {
> -               if (cb->role_switch_cfm)
> -                       cb->role_switch_cfm(conn, status, role);
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(cb, &hci_cb_list, list) {
> +               if (cb->role_switch_cfm) {
> +                       struct hci_cb cpy =3D *cb;
> +
> +                       /* Callback may block so release RCU read lock */
> +                       rcu_read_unlock();
> +                       cpy.role_switch_cfm(conn, status, role);
> +                       rcu_read_lock();
> +               }
>         }
> -       mutex_unlock(&hci_cb_list_lock);
> +       rcu_read_unlock();
>  }
>
>  static inline bool hci_bdaddr_is_rpa(bdaddr_t *bdaddr, u8 addr_type)
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index f9e19f9cb5a3..25d180d225c1 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2993,9 +2993,7 @@ int hci_register_cb(struct hci_cb *cb)
>  {
>         BT_DBG("%p name %s", cb, cb->name);
>
> -       mutex_lock(&hci_cb_list_lock);
> -       list_add_tail(&cb->list, &hci_cb_list);
> -       mutex_unlock(&hci_cb_list_lock);
> +       list_add_tail_rcu(&cb->list, &hci_cb_list);
>
>         return 0;
>  }
> @@ -3005,9 +3003,8 @@ int hci_unregister_cb(struct hci_cb *cb)
>  {
>         BT_DBG("%p name %s", cb, cb->name);
>
> -       mutex_lock(&hci_cb_list_lock);
> -       list_del(&cb->list);
> -       mutex_unlock(&hci_cb_list_lock);
> +       list_del_rcu(&cb->list);
> +       synchronize_rcu();
>
>         return 0;
>  }
> --
> 2.47.1
>


--=20
Luiz Augusto von Dentz

--0000000000004cdde40628653560
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v1-0001-Bluetooth-hci_core-Fix-sleeping-function-called-f.patch"
Content-Disposition: attachment; 
	filename="v1-0001-Bluetooth-hci_core-Fix-sleeping-function-called-f.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m491848o0>
X-Attachment-Id: f_m491848o0

RnJvbSBiNWI1NjkzYTIwYzUxZDI4NzUzZDFmYjJlNjk2YzAxOGFkZTRlNjFhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IFR1ZSwgMyBEZWMgMjAyNCAxNjowNzozMiAtMDUwMApTdWJqZWN0
OiBbUEFUQ0ggdjFdIEJsdWV0b290aDogaGNpX2NvcmU6IEZpeCBzbGVlcGluZyBmdW5jdGlvbiBj
YWxsZWQgZnJvbQogaW52YWxpZCBjb250ZXh0CgpUaGlzIHJld29ya3MgaGNpX2NiX2xpc3QgdG8g
bm90IHVzZSBtdXRleCBoY2lfY2JfbGlzdF9sb2NrIHRvIGF2b2lkIGJ1Z3MKbGlrZSB0aGUgYmVs
bG93OgoKQlVHOiBzbGVlcGluZyBmdW5jdGlvbiBjYWxsZWQgZnJvbSBpbnZhbGlkIGNvbnRleHQg
YXQga2VybmVsL2xvY2tpbmcvbXV0ZXguYzo1ODUKaW5fYXRvbWljKCk6IDAsIGlycXNfZGlzYWJs
ZWQoKTogMCwgbm9uX2Jsb2NrOiAwLCBwaWQ6IDUwNzAsIG5hbWU6IGt3b3JrZXIvdTk6MgpwcmVl
bXB0X2NvdW50OiAwLCBleHBlY3RlZDogMApSQ1UgbmVzdCBkZXB0aDogMSwgZXhwZWN0ZWQ6IDAK
NCBsb2NrcyBoZWxkIGJ5IGt3b3JrZXIvdTk6Mi81MDcwOgogIzA6IGZmZmY4ODgwMTViZTM5NDgg
KCh3cV9jb21wbGV0aW9uKWhjaTAjMil7Ky4rLn0tezA6MH0sIGF0OiBwcm9jZXNzX29uZV93b3Jr
IGtlcm5lbC93b3JrcXVldWUuYzozMjI5IFtpbmxpbmVdCiAjMDogZmZmZjg4ODAxNWJlMzk0OCAo
KHdxX2NvbXBsZXRpb24paGNpMCMyKXsrLisufS17MDowfSwgYXQ6IHByb2Nlc3Nfc2NoZWR1bGVk
X3dvcmtzKzB4OGUwLzB4MTc3MCBrZXJuZWwvd29ya3F1ZXVlLmM6MzMzNQogIzE6IGZmZmZjOTAw
MDNiNmZkMDAgKCh3b3JrX2NvbXBsZXRpb24pKCZoZGV2LT5yeF93b3JrKSl7Ky4rLn0tezA6MH0s
IGF0OiBwcm9jZXNzX29uZV93b3JrIGtlcm5lbC93b3JrcXVldWUuYzozMjMwIFtpbmxpbmVdCiAj
MTogZmZmZmM5MDAwM2I2ZmQwMCAoKHdvcmtfY29tcGxldGlvbikoJmhkZXYtPnJ4X3dvcmspKXsr
LisufS17MDowfSwgYXQ6IHByb2Nlc3Nfc2NoZWR1bGVkX3dvcmtzKzB4OTFiLzB4MTc3MCBrZXJu
ZWwvd29ya3F1ZXVlLmM6MzMzNQogIzI6IGZmZmY4ODgwNjY1ZDAwNzggKCZoZGV2LT5sb2NrKXsr
LisufS17MzozfSwgYXQ6IGhjaV9sZV9jcmVhdGVfYmlnX2NvbXBsZXRlX2V2dCsweGNmLzB4YWUw
IG5ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmM6NjkxNAogIzM6IGZmZmZmZmZmOGUxMzIwMjAgKHJj
dV9yZWFkX2xvY2spey4uLi59LXsxOjJ9LCBhdDogcmN1X2xvY2tfYWNxdWlyZSBpbmNsdWRlL2xp
bnV4L3JjdXBkYXRlLmg6Mjk4IFtpbmxpbmVdCiAjMzogZmZmZmZmZmY4ZTEzMjAyMCAocmN1X3Jl
YWRfbG9jayl7Li4uLn0tezE6Mn0sIGF0OiByY3VfcmVhZF9sb2NrIGluY2x1ZGUvbGludXgvcmN1
cGRhdGUuaDo3NTAgW2lubGluZV0KICMzOiBmZmZmZmZmZjhlMTMyMDIwIChyY3VfcmVhZF9sb2Nr
KXsuLi4ufS17MToyfSwgYXQ6IGhjaV9sZV9jcmVhdGVfYmlnX2NvbXBsZXRlX2V2dCsweGRiLzB4
YWUwIG5ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmM6NjkxNQpDUFU6IDAgUElEOiA1MDcwIENvbW06
IGt3b3JrZXIvdTk6MiBOb3QgdGFpbnRlZCA2LjguMC1zeXprYWxsZXItMDgwNzMtZzQ4MGUwMzVm
YzRjNyAjMApIYXJkd2FyZSBuYW1lOiBHb29nbGUgR29vZ2xlIENvbXB1dGUgRW5naW5lL0dvb2ds
ZSBDb21wdXRlIEVuZ2luZSwgQklPUyBHb29nbGUgMDMvMjcvMjAyNApXb3JrcXVldWU6IGhjaTAg
aGNpX3J4X3dvcmsKQ2FsbCBUcmFjZToKIDxUQVNLPgogX19kdW1wX3N0YWNrIGxpYi9kdW1wX3N0
YWNrLmM6ODggW2lubGluZV0KIGR1bXBfc3RhY2tfbHZsKzB4MjQxLzB4MzYwIGxpYi9kdW1wX3N0
YWNrLmM6MTE0CiBfX21pZ2h0X3Jlc2NoZWQrMHg1ZDQvMHg3ODAga2VybmVsL3NjaGVkL2NvcmUu
YzoxMDE4NwogX19tdXRleF9sb2NrX2NvbW1vbiBrZXJuZWwvbG9ja2luZy9tdXRleC5jOjU4NSBb
aW5saW5lXQogX19tdXRleF9sb2NrKzB4YzEvMHhkNzAga2VybmVsL2xvY2tpbmcvbXV0ZXguYzo3
NTIKIGhjaV9jb25uZWN0X2NmbSBpbmNsdWRlL25ldC9ibHVldG9vdGgvaGNpX2NvcmUuaDoyMDA0
IFtpbmxpbmVdCiBoY2lfbGVfY3JlYXRlX2JpZ19jb21wbGV0ZV9ldnQrMHgzZDkvMHhhZTAgbmV0
L2JsdWV0b290aC9oY2lfZXZlbnQuYzo2OTM5CiBoY2lfZXZlbnRfZnVuYyBuZXQvYmx1ZXRvb3Ro
L2hjaV9ldmVudC5jOjc1MTQgW2lubGluZV0KIGhjaV9ldmVudF9wYWNrZXQrMHhhNTMvMHgxNTQw
IG5ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmM6NzU2OQogaGNpX3J4X3dvcmsrMHgzZTgvMHhjYTAg
bmV0L2JsdWV0b290aC9oY2lfY29yZS5jOjQxNzEKIHByb2Nlc3Nfb25lX3dvcmsga2VybmVsL3dv
cmtxdWV1ZS5jOjMyNTQgW2lubGluZV0KIHByb2Nlc3Nfc2NoZWR1bGVkX3dvcmtzKzB4YTAwLzB4
MTc3MCBrZXJuZWwvd29ya3F1ZXVlLmM6MzMzNQogd29ya2VyX3RocmVhZCsweDg2ZC8weGQ3MCBr
ZXJuZWwvd29ya3F1ZXVlLmM6MzQxNgoga3RocmVhZCsweDJmMC8weDM5MCBrZXJuZWwva3RocmVh
ZC5jOjM4OAogcmV0X2Zyb21fZm9yaysweDRiLzB4ODAgYXJjaC94ODYva2VybmVsL3Byb2Nlc3Mu
YzoxNDcKIHJldF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMCBhcmNoL3g4Ni9lbnRyeS9lbnRyeV82
NC5TOjI0MwogPC9UQVNLPgoKUmVwb3J0ZWQtYnk6IHN5emJvdCsyZmIwODM1ZTBjOWNlZmMzNDYx
NEBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCkNsb3NlczogaHR0cHM6Ly9zeXprYWxsZXIuYXBw
c3BvdC5jb20vYnVnP2V4dGlkPTJmYjA4MzVlMGM5Y2VmYzM0NjE0ClNpZ25lZC1vZmYtYnk6IEx1
aXogQXVndXN0byB2b24gRGVudHogPGx1aXoudm9uLmRlbnR6QGludGVsLmNvbT4KLS0tCiBpbmNs
dWRlL25ldC9ibHVldG9vdGgvaGNpX2NvcmUuaCB8IDg5ICsrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tCiBuZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmMgICAgICAgICB8ICA5ICsrLS0KIDIg
ZmlsZXMgY2hhbmdlZCwgNjUgaW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmggYi9pbmNsdWRlL25ldC9ibHVl
dG9vdGgvaGNpX2NvcmUuaAppbmRleCBlYTc5OGYwN2M1YTIuLjk1ZjExZjA0ZTI0YSAxMDA2NDQK
LS0tIGEvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmgKKysrIGIvaW5jbHVkZS9uZXQv
Ymx1ZXRvb3RoL2hjaV9jb3JlLmgKQEAgLTgwNCw3ICs4MDQsNiBAQCBzdHJ1Y3QgaGNpX2Nvbm5f
cGFyYW1zIHsKIGV4dGVybiBzdHJ1Y3QgbGlzdF9oZWFkIGhjaV9kZXZfbGlzdDsKIGV4dGVybiBz
dHJ1Y3QgbGlzdF9oZWFkIGhjaV9jYl9saXN0OwogZXh0ZXJuIHJ3bG9ja190IGhjaV9kZXZfbGlz
dF9sb2NrOwotZXh0ZXJuIHN0cnVjdCBtdXRleCBoY2lfY2JfbGlzdF9sb2NrOwogCiAjZGVmaW5l
IGhjaV9kZXZfc2V0X2ZsYWcoaGRldiwgbnIpICAgICAgICAgICAgIHNldF9iaXQoKG5yKSwgKGhk
ZXYpLT5kZXZfZmxhZ3MpCiAjZGVmaW5lIGhjaV9kZXZfY2xlYXJfZmxhZyhoZGV2LCBucikgICAg
ICAgICAgIGNsZWFyX2JpdCgobnIpLCAoaGRldiktPmRldl9mbGFncykKQEAgLTIwMjksMTIgKzIw
MjgsMTggQEAgc3RhdGljIGlubGluZSB2b2lkIGhjaV9jb25uZWN0X2NmbShzdHJ1Y3QgaGNpX2Nv
bm4gKmNvbm4sIF9fdTggc3RhdHVzKQogewogCXN0cnVjdCBoY2lfY2IgKmNiOwogCi0JbXV0ZXhf
bG9jaygmaGNpX2NiX2xpc3RfbG9jayk7Ci0JbGlzdF9mb3JfZWFjaF9lbnRyeShjYiwgJmhjaV9j
Yl9saXN0LCBsaXN0KSB7Ci0JCWlmIChjYi0+Y29ubmVjdF9jZm0pCi0JCQljYi0+Y29ubmVjdF9j
Zm0oY29ubiwgc3RhdHVzKTsKKwlyY3VfcmVhZF9sb2NrKCk7CisJbGlzdF9mb3JfZWFjaF9lbnRy
eV9yY3UoY2IsICZoY2lfY2JfbGlzdCwgbGlzdCkgeworCQlpZiAoY2ItPmNvbm5lY3RfY2ZtKSB7
CisJCQlzdHJ1Y3QgaGNpX2NiIGNweSA9ICpjYjsKKworCQkJLyogQ2FsbGJhY2sgbWF5IGJsb2Nr
IHNvIHJlbGVhc2UgUkNVIHJlYWQgbG9jayAqLworCQkJcmN1X3JlYWRfdW5sb2NrKCk7CisJCQlj
cHkuY29ubmVjdF9jZm0oY29ubiwgc3RhdHVzKTsKKwkJCXJjdV9yZWFkX2xvY2soKTsKKwkJfQog
CX0KLQltdXRleF91bmxvY2soJmhjaV9jYl9saXN0X2xvY2spOworCXJjdV9yZWFkX3VubG9jaygp
OwogCiAJaWYgKGNvbm4tPmNvbm5lY3RfY2ZtX2NiKQogCQljb25uLT5jb25uZWN0X2NmbV9jYihj
b25uLCBzdGF0dXMpOwpAQCAtMjA0NCwxMiArMjA0OSwxOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQg
aGNpX2Rpc2Nvbm5fY2ZtKHN0cnVjdCBoY2lfY29ubiAqY29ubiwgX191OCByZWFzb24pCiB7CiAJ
c3RydWN0IGhjaV9jYiAqY2I7CiAKLQltdXRleF9sb2NrKCZoY2lfY2JfbGlzdF9sb2NrKTsKKwly
Y3VfcmVhZF9sb2NrKCk7CiAJbGlzdF9mb3JfZWFjaF9lbnRyeShjYiwgJmhjaV9jYl9saXN0LCBs
aXN0KSB7Ci0JCWlmIChjYi0+ZGlzY29ubl9jZm0pCi0JCQljYi0+ZGlzY29ubl9jZm0oY29ubiwg
cmVhc29uKTsKKwkJaWYgKGNiLT5kaXNjb25uX2NmbSkgeworCQkJc3RydWN0IGhjaV9jYiBjcHkg
PSAqY2I7CisKKwkJCS8qIENhbGxiYWNrIG1heSBibG9jayBzbyByZWxlYXNlIFJDVSByZWFkIGxv
Y2sgKi8KKwkJCXJjdV9yZWFkX3VubG9jaygpOworCQkJY3B5LmRpc2Nvbm5fY2ZtKGNvbm4sIHJl
YXNvbik7CisJCQlyY3VfcmVhZF9sb2NrKCk7CisJCX0KIAl9Ci0JbXV0ZXhfdW5sb2NrKCZoY2lf
Y2JfbGlzdF9sb2NrKTsKKwlyY3VfcmVhZF91bmxvY2soKTsKIAogCWlmIChjb25uLT5kaXNjb25u
X2NmbV9jYikKIAkJY29ubi0+ZGlzY29ubl9jZm1fY2IoY29ubiwgcmVhc29uKTsKQEAgLTIwNjUs
MTIgKzIwNzYsMTggQEAgc3RhdGljIGlubGluZSB2b2lkIGhjaV9hdXRoX2NmbShzdHJ1Y3QgaGNp
X2Nvbm4gKmNvbm4sIF9fdTggc3RhdHVzKQogCiAJZW5jcnlwdCA9IHRlc3RfYml0KEhDSV9DT05O
X0VOQ1JZUFQsICZjb25uLT5mbGFncykgPyAweDAxIDogMHgwMDsKIAotCW11dGV4X2xvY2soJmhj
aV9jYl9saXN0X2xvY2spOworCXJjdV9yZWFkX2xvY2soKTsKIAlsaXN0X2Zvcl9lYWNoX2VudHJ5
KGNiLCAmaGNpX2NiX2xpc3QsIGxpc3QpIHsKLQkJaWYgKGNiLT5zZWN1cml0eV9jZm0pCi0JCQlj
Yi0+c2VjdXJpdHlfY2ZtKGNvbm4sIHN0YXR1cywgZW5jcnlwdCk7CisJCWlmIChjYi0+c2VjdXJp
dHlfY2ZtKSB7CisJCQlzdHJ1Y3QgaGNpX2NiIGNweSA9ICpjYjsKKworCQkJLyogQ2FsbGJhY2sg
bWF5IGJsb2NrIHNvIHJlbGVhc2UgUkNVIHJlYWQgbG9jayAqLworCQkJcmN1X3JlYWRfdW5sb2Nr
KCk7CisJCQljcHkuc2VjdXJpdHlfY2ZtKGNvbm4sIHN0YXR1cywgZW5jcnlwdCk7CisJCQlyY3Vf
cmVhZF9sb2NrKCk7CisJCX0KIAl9Ci0JbXV0ZXhfdW5sb2NrKCZoY2lfY2JfbGlzdF9sb2NrKTsK
KwlyY3VfcmVhZF91bmxvY2soKTsKIAogCWlmIChjb25uLT5zZWN1cml0eV9jZm1fY2IpCiAJCWNv
bm4tPnNlY3VyaXR5X2NmbV9jYihjb25uLCBzdGF0dXMpOwpAQCAtMjEwNSwxMiArMjEyMiwxOCBA
QCBzdGF0aWMgaW5saW5lIHZvaWQgaGNpX2VuY3J5cHRfY2ZtKHN0cnVjdCBoY2lfY29ubiAqY29u
biwgX191OCBzdGF0dXMpCiAJCQljb25uLT5zZWNfbGV2ZWwgPSBjb25uLT5wZW5kaW5nX3NlY19s
ZXZlbDsKIAl9CiAKLQltdXRleF9sb2NrKCZoY2lfY2JfbGlzdF9sb2NrKTsKKwlyY3VfcmVhZF9s
b2NrKCk7CiAJbGlzdF9mb3JfZWFjaF9lbnRyeShjYiwgJmhjaV9jYl9saXN0LCBsaXN0KSB7Ci0J
CWlmIChjYi0+c2VjdXJpdHlfY2ZtKQotCQkJY2ItPnNlY3VyaXR5X2NmbShjb25uLCBzdGF0dXMs
IGVuY3J5cHQpOworCQlpZiAoY2ItPnNlY3VyaXR5X2NmbSkgeworCQkJc3RydWN0IGhjaV9jYiBj
cHkgPSAqY2I7CisKKwkJCS8qIENhbGxiYWNrIG1heSBibG9jayBzbyByZWxlYXNlIFJDVSByZWFk
IGxvY2sgKi8KKwkJCXJjdV9yZWFkX3VubG9jaygpOworCQkJY3B5LnNlY3VyaXR5X2NmbShjb25u
LCBzdGF0dXMsIGVuY3J5cHQpOworCQkJcmN1X3JlYWRfbG9jaygpOworCQl9CiAJfQotCW11dGV4
X3VubG9jaygmaGNpX2NiX2xpc3RfbG9jayk7CisJcmN1X3JlYWRfdW5sb2NrKCk7CiAKIAlpZiAo
Y29ubi0+c2VjdXJpdHlfY2ZtX2NiKQogCQljb25uLT5zZWN1cml0eV9jZm1fY2IoY29ubiwgc3Rh
dHVzKTsKQEAgLTIxMjAsMTIgKzIxNDMsMTggQEAgc3RhdGljIGlubGluZSB2b2lkIGhjaV9rZXlf
Y2hhbmdlX2NmbShzdHJ1Y3QgaGNpX2Nvbm4gKmNvbm4sIF9fdTggc3RhdHVzKQogewogCXN0cnVj
dCBoY2lfY2IgKmNiOwogCi0JbXV0ZXhfbG9jaygmaGNpX2NiX2xpc3RfbG9jayk7CisJcmN1X3Jl
YWRfbG9jaygpOwogCWxpc3RfZm9yX2VhY2hfZW50cnkoY2IsICZoY2lfY2JfbGlzdCwgbGlzdCkg
ewotCQlpZiAoY2ItPmtleV9jaGFuZ2VfY2ZtKQotCQkJY2ItPmtleV9jaGFuZ2VfY2ZtKGNvbm4s
IHN0YXR1cyk7CisJCWlmIChjYi0+a2V5X2NoYW5nZV9jZm0pIHsKKwkJCXN0cnVjdCBoY2lfY2Ig
Y3B5ID0gKmNiOworCisJCQkvKiBDYWxsYmFjayBtYXkgYmxvY2sgc28gcmVsZWFzZSBSQ1UgcmVh
ZCBsb2NrICovCisJCQlyY3VfcmVhZF91bmxvY2soKTsKKwkJCWNweS5rZXlfY2hhbmdlX2NmbShj
b25uLCBzdGF0dXMpOworCQkJcmN1X3JlYWRfbG9jaygpOworCQl9CiAJfQotCW11dGV4X3VubG9j
aygmaGNpX2NiX2xpc3RfbG9jayk7CisJcmN1X3JlYWRfdW5sb2NrKCk7CiB9CiAKIHN0YXRpYyBp
bmxpbmUgdm9pZCBoY2lfcm9sZV9zd2l0Y2hfY2ZtKHN0cnVjdCBoY2lfY29ubiAqY29ubiwgX191
OCBzdGF0dXMsCkBAIC0yMTMzLDEyICsyMTYyLDE4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBoY2lf
cm9sZV9zd2l0Y2hfY2ZtKHN0cnVjdCBoY2lfY29ubiAqY29ubiwgX191OCBzdGF0dXMsCiB7CiAJ
c3RydWN0IGhjaV9jYiAqY2I7CiAKLQltdXRleF9sb2NrKCZoY2lfY2JfbGlzdF9sb2NrKTsKLQls
aXN0X2Zvcl9lYWNoX2VudHJ5KGNiLCAmaGNpX2NiX2xpc3QsIGxpc3QpIHsKLQkJaWYgKGNiLT5y
b2xlX3N3aXRjaF9jZm0pCi0JCQljYi0+cm9sZV9zd2l0Y2hfY2ZtKGNvbm4sIHN0YXR1cywgcm9s
ZSk7CisJcmN1X3JlYWRfbG9jaygpOworCWxpc3RfZm9yX2VhY2hfZW50cnlfcmN1KGNiLCAmaGNp
X2NiX2xpc3QsIGxpc3QpIHsKKwkJaWYgKGNiLT5yb2xlX3N3aXRjaF9jZm0pIHsKKwkJCXN0cnVj
dCBoY2lfY2IgY3B5ID0gKmNiOworCisJCQkvKiBDYWxsYmFjayBtYXkgYmxvY2sgc28gcmVsZWFz
ZSBSQ1UgcmVhZCBsb2NrICovCisJCQlyY3VfcmVhZF91bmxvY2soKTsKKwkJCWNweS5yb2xlX3N3
aXRjaF9jZm0oY29ubiwgc3RhdHVzLCByb2xlKTsKKwkJCXJjdV9yZWFkX2xvY2soKTsKKwkJfQog
CX0KLQltdXRleF91bmxvY2soJmhjaV9jYl9saXN0X2xvY2spOworCXJjdV9yZWFkX3VubG9jaygp
OwogfQogCiBzdGF0aWMgaW5saW5lIGJvb2wgaGNpX2JkYWRkcl9pc19ycGEoYmRhZGRyX3QgKmJk
YWRkciwgdTggYWRkcl90eXBlKQpkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9oY2lfY29yZS5j
IGIvbmV0L2JsdWV0b290aC9oY2lfY29yZS5jCmluZGV4IGY5ZTE5ZjljYjVhMy4uMjVkMTgwZDIy
NWMxIDEwMDY0NAotLS0gYS9uZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmMKKysrIGIvbmV0L2JsdWV0
b290aC9oY2lfY29yZS5jCkBAIC0yOTkzLDkgKzI5OTMsNyBAQCBpbnQgaGNpX3JlZ2lzdGVyX2Ni
KHN0cnVjdCBoY2lfY2IgKmNiKQogewogCUJUX0RCRygiJXAgbmFtZSAlcyIsIGNiLCBjYi0+bmFt
ZSk7CiAKLQltdXRleF9sb2NrKCZoY2lfY2JfbGlzdF9sb2NrKTsKLQlsaXN0X2FkZF90YWlsKCZj
Yi0+bGlzdCwgJmhjaV9jYl9saXN0KTsKLQltdXRleF91bmxvY2soJmhjaV9jYl9saXN0X2xvY2sp
OworCWxpc3RfYWRkX3RhaWxfcmN1KCZjYi0+bGlzdCwgJmhjaV9jYl9saXN0KTsKIAogCXJldHVy
biAwOwogfQpAQCAtMzAwNSw5ICszMDAzLDggQEAgaW50IGhjaV91bnJlZ2lzdGVyX2NiKHN0cnVj
dCBoY2lfY2IgKmNiKQogewogCUJUX0RCRygiJXAgbmFtZSAlcyIsIGNiLCBjYi0+bmFtZSk7CiAK
LQltdXRleF9sb2NrKCZoY2lfY2JfbGlzdF9sb2NrKTsKLQlsaXN0X2RlbCgmY2ItPmxpc3QpOwot
CW11dGV4X3VubG9jaygmaGNpX2NiX2xpc3RfbG9jayk7CisJbGlzdF9kZWxfcmN1KCZjYi0+bGlz
dCk7CisJc3luY2hyb25pemVfcmN1KCk7CiAKIAlyZXR1cm4gMDsKIH0KLS0gCjIuNDcuMQoK
--0000000000004cdde40628653560--
