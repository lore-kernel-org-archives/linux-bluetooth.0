Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB1126C01;
	Mon, 23 Sep 2024 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727104859; cv=none; b=pfMVIUtyMxaXkAfi9Au/cznB6IgSkBLD9anxVlEk75l/JL3WM6TDhYla6KTvvcOeBNJG1LqpIGSPaOdoMjHqbY9VpWZii5eWXixhFuwLz96jj+8iUhV8XA93iZpg9tZOwVSWL3Z7pHeAJ/xtUVjjfyPlpLExpHZwI//Ou5ERs6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727104859; c=relaxed/simple;
	bh=YSWCktVxHghjtszXZwcauDiq7p2MJW8gBplodPVyGFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0mjAP0hEBDVOSQ47jEweZ6zHZYX8zdAHEpQvIukISQEaFyzUonF3ReK1aew9J35fH/+aoMgVTUcLQRPNPd4hw1B5OYawpUnnEbF54NVNRT+Nji0C8yzq06fVX9qo/G2vyv3/i6VIHHwCZo08ckn/RzIeOceAb3cB0cOqihm1Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH89QFpX; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH89QFpX"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f754d4a6e4so43155061fa.3;
        Mon, 23 Sep 2024 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727104855; x=1727709655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YKpJjkT/dP6ztSbjaCFugg3gOx+PZd6e/Lb/+M/JDA=;
        b=PH89QFpXpQfcktpdv+wE3gOyylDxe6B9KawlvzIvIZLek8B13q34K6P99RofEyh2x9
         rwJSEizVuQf1fm9y7iiFQvzCqa0m0Sd9q6k4HDKPRrhzQUEsfTLjFiJnSj0N01CMn7nL
         4n7mi0FrSzvMFgu1rnKHdsxWESbXaOtzSpR8AemLrE8R5hOnWl88FEkr2S9QcC1hdfR1
         qNZf4jwEcinoOWiQT4V6kJccyu1tjD16CaefXlvDR4TdDgDjHGiJ0AYWe2RQVUGDsCwA
         Y1fWl2R3AEKdODVbUDaLMRx6rle6FwA12rXcVDjd6snTYQnRi7MybGXOtrbWUkhhHGhc
         sBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727104855; x=1727709655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YKpJjkT/dP6ztSbjaCFugg3gOx+PZd6e/Lb/+M/JDA=;
        b=WRShlQYZh6H7bce6CDWen+KuRrRes6mj9JyPKjOhnBWM5dagpgVt774akl1sZIBggP
         hNK9AIledz1ih/pEIn0YOzTuhRyha3o8U52WB1Da1kCqgdTmYQR3OQ5xah4ClqXLmT5S
         vfavwH24md3CNfPpwVKdZGrfNiST2wG+YvVOF9lyhhTsIlew52kAdJCjMID8N4iN7199
         DC5wFBJK+eMtQ+So+DoQ9KqbF8QRGLFx+FybVr9ixGwzJYz6hbC57jqJpV6CV1FUVtWG
         lP2kGmZR528KRf4mHAFZpTKC/I5AXdHrV57ib3sFbzZhrGfd617Vdb00a9KKaCjvsnZ6
         Wv9A==
X-Forwarded-Encrypted: i=1; AJvYcCU4OMmKQR9DVyrbMrC4Fi2XxYkIBYsfZ0HugZdHFYKCKdLHJlWrv7NTiJowmzI+o+P9D95kQrVgNDYCFJNe@vger.kernel.org, AJvYcCVVQ2zqZZPVDjmeG92+6E5BUZSDR/TYtX0xT/HdqhKQVH36cORIMWH+fuWAdSg2qTbDa5/YbDrwPv+EFK5XNQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLVkbVYICi2MdovvMY0gqBwL4xmHXsl51unM9zKn2FdcZtQ8eO
	GOuVakrUYKE82lEBKP4Qnn7GQx9bdrZpOcVsm9Tt/AGQtuw8vSu13yY5nDOGGKV5ZPjNZc+u9z9
	xfSkaLPFLCzcWgKQmGspTGfGGyzk=
X-Google-Smtp-Source: AGHT+IEL2czF2KjlS+h6a4/EK6zHMexJS+PrFlJf2J3D4oheXFf9W5E4gcN9lgiTM0lnOJgvx6EsHQbhXGdz9TrRP2A=
X-Received: by 2002:a2e:a98a:0:b0:2f7:5a95:3a11 with SMTP id
 38308e7fff4ca-2f7cc3576c4mr52982621fa.6.1727104855203; Mon, 23 Sep 2024
 08:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZLnohZofm4Tchk7p36XS=HwYmN94DB0FGyiPFJno+evSw@mail.gmail.com>
 <20240921105609.1025-1-hdanton@sina.com> <CABBYNZLqXfAc7_YO+goAf7fnAsmJ+j9V0cjmPMX4+MhoDhzOCA@mail.gmail.com>
 <CANp29Y7bbvUckx7c+Bke28p5AzNCw7kYfXr87DsAD2DtUm99Xw@mail.gmail.com>
In-Reply-To: <CANp29Y7bbvUckx7c+Bke28p5AzNCw7kYfXr87DsAD2DtUm99Xw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 23 Sep 2024 11:20:41 -0400
Message-ID: <CABBYNZLKMu296VLeEcyMZBw1HFivMA=L6xOZRHHcKwWZb7PQ4g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth/l2cap: Fix uaf in l2cap_connect
To: Aleksandr Nogikh <nogikh@google.com>
Cc: Hillf Danton <hdanton@sina.com>, Edward Adam Davis <eadavis@qq.com>, 
	syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aleksandr,

On Mon, Sep 23, 2024 at 10:37=E2=80=AFAM Aleksandr Nogikh <nogikh@google.co=
m> wrote:
>
> On Mon, Sep 23, 2024 at 4:33=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Hillf,
> >
> > On Sat, Sep 21, 2024 at 6:56=E2=80=AFAM Hillf Danton <hdanton@sina.com>=
 wrote:
> > >
> > > On Tue, Sep 10, 2024 at 4:56=E2=80=AFPM Luiz Augusto von Dentz <luiz.=
dentz@gmail.com> wrote:
> > > >
> > > > Maybe something like the following would be a better approach:
> > > >
> > > > https://gist.github.com/Vudentz/121a15fa4391b2b1f6c7e8d420a6846e
> > >
> > > If your idea is not bad, boy, feel free to win Tested-by from syzbot =
with it.
> >
> > Is there a way to quickly check a patch with syzbot?
>
> You can send a `#syz test` command in a reply to syzbot and attach the
> patch-to-test to the email message.
>
> See https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testin=
g-patches

Thanks, lets see if this works:

#syz test

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d6976db02c06..b2f8f9c5b610 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3782,6 +3782,8 @@ static void hci_acldata_packet(struct hci_dev
*hdev, struct sk_buff *skb)

        hci_dev_lock(hdev);
        conn =3D hci_conn_hash_lookup_handle(hdev, handle);
+       if (conn && hci_dev_test_flag(hdev, HCI_MGMT))
+               mgmt_device_connected(hdev, conn, NULL, 0);
        hci_dev_unlock(hdev);

        if (conn) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1c82dcdf6e8f..b87c0f1dab9e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3706,7 +3706,7 @@ static void hci_remote_features_evt(struct
hci_dev *hdev, void *data,
                goto unlock;
        }

-       if (!ev->status && !test_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)=
) {
+       if (!ev->status) {
                struct hci_cp_remote_name_req cp;
                memset(&cp, 0, sizeof(cp));
                bacpy(&cp.bdaddr, &conn->dst);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9988ba382b68..6544c1ed7143 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4066,17 +4066,9 @@ static void l2cap_connect(struct l2cap_conn
*conn, struct l2cap_cmd_hdr *cmd,
 static int l2cap_connect_req(struct l2cap_conn *conn,
                             struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *da=
ta)
 {
-       struct hci_dev *hdev =3D conn->hcon->hdev;
-       struct hci_conn *hcon =3D conn->hcon;
-
        if (cmd_len < sizeof(struct l2cap_conn_req))
                return -EPROTO;

-       hci_dev_lock(hdev);
-       if (hci_dev_test_flag(hdev, HCI_MGMT))
-               mgmt_device_connected(hdev, hcon, NULL, 0);
-       hci_dev_unlock(hdev);
-
        l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP);
        return 0;
 }
