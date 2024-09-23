Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F0B19993C;
	Mon, 23 Sep 2024 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106500; cv=none; b=i7VgsyIZjz+D6DvGCXD9Z18xnlC5Z0c1FdormAOrQXooa9BLYtc47hj+ga4aLsYF6aUmRy4B6MvLhnwSWtb9szpdc18m6OYCk/9NS868OBLbKEKriYRQz6Hf8+eVszjnseN79aaQgx8xe6Ff/tT6fhC8r0IeAIx8/FqxHMJh+do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106500; c=relaxed/simple;
	bh=SLcuKgLcUT8aqpSs8qhw3n3/w8ioTGNuUfQfw28+qhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cn4jRzb9/uZ0tAUi4I3g5JfM5X9BCdAlXCQWOTF/GuReplGimwFeg3sbj1z9D/8CgrjRHv+40hu4yA5D+xDN3+T9zmX0NlwI9KC49BwsOqSu3TiDBAMwSW8YKxYLEdjkYIY/AnEYOWvaL5POSRBXfOU5ygJO7exLVj37gnP0qYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2k/ScW3; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2k/ScW3"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f75c6ed397so46906521fa.2;
        Mon, 23 Sep 2024 08:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727106497; x=1727711297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/o+nvdEXYuJLkNWmBsOhSKHD6q0tuxvNWkXFGcVow1E=;
        b=O2k/ScW3EWzUG7XobFW9X+AHgwnMn4LGPuvLeux3hsW3235Urnv/c1GVc5ebmqq6ri
         wFBJqGQ95AIOR46rn0L4CF5YzGeTgWz3tkxv+GjZYRobnEFTS0mpvCZngT0NyxUOzU7t
         5B91vCaSnTtKALGrm7U2DecJafN1Vho5UDCXDJiLpuM2K1K3InR4dOP7ud8Yg+FLKr/S
         hH2wcK+73RrKr1eusX4FSwLJTAPyzwbYtvX3rNcfwgoZjtejKFtJ4nImMCp1AXlmkCk3
         Kgvr/QjkbGK5iSnoIRGl+uve1ybruYJIl+G18FcxUFPS75wTD8krlfMQqydppfj0YJZu
         8S3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727106497; x=1727711297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/o+nvdEXYuJLkNWmBsOhSKHD6q0tuxvNWkXFGcVow1E=;
        b=vVNNDQn6qPGz9u6nN4awJNjE/n9Z89jSEdKgfhiXB4GjdeBfzXqIdWRIVND+xRqb02
         hh4eLfnYrjE8PR0JB7wlwFueAt1OCsSbmKwa/YszS82IKYRRroIB/GEZRyi7Ya7Dt/ON
         yjzyXGnwmoKw/cI1AVUFiW1wf4Po/zyJmFSfxFvt5dLMgwWttqJmgJnTTmnUY+VVQrU4
         EfCUB3cleTvNim3qChW5ITbxYQEx7W2RViyx+ax62nwyearyGeuiYtzkldfbVb1Onk60
         CQaljqzGfT76aAOWn3YobNiOzStinQGrhEuS3V99Gp9nSh1G2EKTJwsw987wPA9uf5Fu
         h7JA==
X-Forwarded-Encrypted: i=1; AJvYcCVJPlnMDP3zy6zX0BKfw0SrsSeFG3pUTS2qTx95RUvItGZ4iafst1jDpesF+YIq9iiVE56ql9VMvLUKDpyBnEY=@vger.kernel.org, AJvYcCXfJSYWeumQ8mObDmh/kawOCWBnE2WbVaqnlkTd1NG49ecuq8u4OCQpDLTar5McbKe4J/KqKISPy8QA0Vgs@vger.kernel.org
X-Gm-Message-State: AOJu0YyiPw7AmK4LGCR1DzWk2PNUtlEh8bkqzP8iJf5i0pECjSQY4IqW
	R20MSX/KY+0Yv2rgjUAiWyee/KQuRo/R54l6KPB7GGKDVBguXwbZ5ZdAa7tKCEBTC8y5HKv7ra/
	zhcV5rF23tceF+zHUWIYfn61TJeY=
X-Google-Smtp-Source: AGHT+IGsp3hJPtYNM0TMsnsFCAUkDhmwThT9+1ZPVMwNRxYlXzX06Beoi6nOamvq4bYIyRXVYFJhSNApPkvQP3yHqts=
X-Received: by 2002:a2e:bea7:0:b0:2f7:7031:dc31 with SMTP id
 38308e7fff4ca-2f7cc382c22mr60295191fa.27.1727106497011; Mon, 23 Sep 2024
 08:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZLnohZofm4Tchk7p36XS=HwYmN94DB0FGyiPFJno+evSw@mail.gmail.com>
 <20240921105609.1025-1-hdanton@sina.com> <CABBYNZLqXfAc7_YO+goAf7fnAsmJ+j9V0cjmPMX4+MhoDhzOCA@mail.gmail.com>
 <CANp29Y7bbvUckx7c+Bke28p5AzNCw7kYfXr87DsAD2DtUm99Xw@mail.gmail.com> <CABBYNZLKMu296VLeEcyMZBw1HFivMA=L6xOZRHHcKwWZb7PQ4g@mail.gmail.com>
In-Reply-To: <CABBYNZLKMu296VLeEcyMZBw1HFivMA=L6xOZRHHcKwWZb7PQ4g@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 23 Sep 2024 11:48:04 -0400
Message-ID: <CABBYNZKg28ccCZXqBphNLp0WEOznS89Z-AiShC53JAVbsSsbGw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth/l2cap: Fix uaf in l2cap_connect
To: Aleksandr Nogikh <nogikh@google.com>
Cc: Hillf Danton <hdanton@sina.com>, Edward Adam Davis <eadavis@qq.com>, 
	syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 23, 2024 at 11:20=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Aleksandr,
>
> On Mon, Sep 23, 2024 at 10:37=E2=80=AFAM Aleksandr Nogikh <nogikh@google.=
com> wrote:
> >
> > On Mon, Sep 23, 2024 at 4:33=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Hillf,
> > >
> > > On Sat, Sep 21, 2024 at 6:56=E2=80=AFAM Hillf Danton <hdanton@sina.co=
m> wrote:
> > > >
> > > > On Tue, Sep 10, 2024 at 4:56=E2=80=AFPM Luiz Augusto von Dentz <lui=
z.dentz@gmail.com> wrote:
> > > > >
> > > > > Maybe something like the following would be a better approach:
> > > > >
> > > > > https://gist.github.com/Vudentz/121a15fa4391b2b1f6c7e8d420a6846e
> > > >
> > > > If your idea is not bad, boy, feel free to win Tested-by from syzbo=
t with it.
> > >
> > > Is there a way to quickly check a patch with syzbot?
> >
> > You can send a `#syz test` command in a reply to syzbot and attach the
> > patch-to-test to the email message.
> >
> > See https://github.com/google/syzkaller/blob/master/docs/syzbot.md#test=
ing-patches
>

Lets try again with git diff output:

#syz test

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d6976db02c06..b2f8f9c5b610 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3782,6 +3782,8 @@ static void hci_acldata_packet(struct hci_dev
*hdev, struct sk_buff *skb)

     hci_dev_lock(hdev);
     conn =3D hci_conn_hash_lookup_handle(hdev, handle);
+    if (conn && hci_dev_test_flag(hdev, HCI_MGMT))
+        mgmt_device_connected(hdev, conn, NULL, 0);
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

-    if (!ev->status && !test_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
+    if (!ev->status) {
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
                  struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *data)
 {
-    struct hci_dev *hdev =3D conn->hcon->hdev;
-    struct hci_conn *hcon =3D conn->hcon;
-
     if (cmd_len < sizeof(struct l2cap_conn_req))
         return -EPROTO;

-    hci_dev_lock(hdev);
-    if (hci_dev_test_flag(hdev, HCI_MGMT))
-        mgmt_device_connected(hdev, hcon, NULL, 0);
-    hci_dev_unlock(hdev);
-
     l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP);
     return 0;
 }
