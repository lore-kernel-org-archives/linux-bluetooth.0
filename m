Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77B6211712
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373840; cv=none; b=Psdwye0iCHGIt2myYd1rXg/dXt+nnsSWMNkrieqidJ9JLKQktIbBTiUxCtXvau6YoK29uSR3DWlhY+uTxzF0mCcAiw+vPaAODrX7oNoAX/4W+7q+oGMWXJyxbLwk+quaz8E1rzE9qcOExVRlS8sZaEwUJIk76sXoa/vDLFOvIq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373840; c=relaxed/simple;
	bh=DkWm7B5pWGxVonZzwpy19tuK3gxJhVZ+c7kxKV5lFU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEN6crXtmHowgaCIkjC0WfIUVYboZ+p2ejvAKBeTx8aGsp21jVUHThso0vUUaB+PJF0/XxpKeHZM9TlUcZbBFuIp6O2psLgnKXvddDl6J3aHyqo9E3yBoMYhUEGTkTcqrNTlpqr3egma9txtxOFwx7aSHLIMi7AE3GQ2KUFgzA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arzrMdsh; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arzrMdsh"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-307325f2436so64347981fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 07:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739373837; x=1739978637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlP2slLBqEIYL7sTJwr26Ht5fhDpsz7XrW5f7Kvgpkw=;
        b=arzrMdsh0/GzCIxytIzt9RWwPgAyxRK+OiOtZL/E+XpvzZx9apLnYysJlpz5ls6zMM
         NEIY9wxmQf2aeFQHHb4eVADR7RJBPX0A3KGx9uqe85E7cyHSyTSIjfrZs18DLk9QVHTu
         LDvwoFXSf1BrKOG1aRmWhSpomnBq4PAC2vQdYxcJYCPXGXGegnf9hCyHdPDn7g6yuvgh
         Ds40hCvEvUlsJeOeK6GsEYdDMWOzESmBxkChuCulRRCEifHc65U6Z/2G2U9A8dlU2s/K
         T1QTqrmodhOLfm8Q+bwAwuYPHUHkp7ewLiqf6ER5yUge3G/x14e6YFDn+nKA73oHkVWh
         Kb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739373837; x=1739978637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlP2slLBqEIYL7sTJwr26Ht5fhDpsz7XrW5f7Kvgpkw=;
        b=wss9CVaBaf4K/EWIk0V4TdgvwZ9W7SJnn2muTfqtLmY//ekwfrQGHSB7fBPtgHPXP7
         EGDHaXoBNI0bRTxQxXRM7MKMBLeN5plnpCKb3sJJ4949UouKs5fdIxJNXNO+u5vN//Fq
         TrvSbwa/f+D3bisbnhpY3LrOF/awJWLuxNA4NK44/Ldo1MazymkLSPzkDd8jVTr0+d94
         nV/BpzXGLUy2gzwbwaWL81XemEa17+HFLMbmCPjSl8oAQ3e2Don2acLb2yGazPBEP/8T
         63ajpGw09ZtvFVmtM9wcnk5Tds3wfFDfczhbVonDnc6SN0WdJiBTNOecW+kNUZnPfnjX
         3Ufw==
X-Forwarded-Encrypted: i=1; AJvYcCVYb09UXku95O695aWnCghJGdh1haWbJ5MHHEuaKfVUYpxFdhUk8SRTIvFlDoPjYFjd9FcpXNKb7K36zoCXItc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxpEEZOZo+HE5CaKmNVnyzYCw+Fk2hm9r8Y+QIxWUaadXH1WnK
	zIPPL3BbXcFPLXa89NIJ7CljTtz3AOzkBgjqxg1ntO29bLkec2kn1edLA0a2kWwUjoIhGjhS3LU
	D9ljwYKEjFZ54GtbrRWd624A3HN4=
X-Gm-Gg: ASbGnctG9HYxVMRGQRKgp4wRuSN7cPSPUIPTwJ7hfR5VxFzhylckQmI7wqKF8Tfulz8
	/lxqN4ewmex1LfvllFHaNqXI/XjmSpTD/SQiXHRvdTKq6/pN10oJoGsEPHupf3caXkkspjGo=
X-Google-Smtp-Source: AGHT+IFkKiUL2fMxLlKi07FxryhG9n8DcHKlcQ4Lfu7qNNArjM0V9Ls1asIuDU17yDa/AKNKDmjd7MEGDyaYWAjbQlE=
X-Received: by 2002:a05:651c:b0b:b0:308:eb58:6571 with SMTP id
 38308e7fff4ca-3090373a8d9mr13543261fa.26.1739373836704; Wed, 12 Feb 2025
 07:23:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4d3fd31a-7289-44d1-919d-92f1da4355ca@stanley.mountain>
In-Reply-To: <4d3fd31a-7289-44d1-919d-92f1da4355ca@stanley.mountain>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 12 Feb 2025 10:23:43 -0500
X-Gm-Features: AWEUYZnolSw4t9K_MWHgnVux9qRA6qT7MHuSoJSCzeNuU0PpdAhk-6lNnvwDF-8
Message-ID: <CABBYNZL5B_fyij4T-Kzm_0ayzFVhWbaOYbzdD4tVz89WtmPfZg@mail.gmail.com>
Subject: Re: [bug report] Bluetooth: L2CAP: Fix corrupted list in hci_chan_del
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Wed, Feb 12, 2025 at 10:19=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> Hello Luiz Augusto von Dentz,
>
> Commit dd6367916d2d ("Bluetooth: L2CAP: Fix corrupted list in
> hci_chan_del") from Feb 6, 2025 (linux-next), leads to the following
> Smatch static checker warning:
>
>         net/bluetooth/l2cap_core.c:7555 l2cap_recv_acldata()
>         error: we previously assumed 'conn' could be null (see line 7459)
>
> net/bluetooth/l2cap_core.c
>     7442 void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *s=
kb, u16 flags)
>     7443 {
>     7444         struct l2cap_conn *conn;
>     7445         int len;
>     7446
>     7447         /* Lock hdev to access l2cap_data to avoid race with l2c=
ap_conn_del */
>     7448         hci_dev_lock(hcon->hdev);
>     7449
>     7450         conn =3D hcon->l2cap_data;
>     7451
>     7452         if (!conn)
>     7453                 conn =3D l2cap_conn_add(hcon);
>     7454
>     7455         conn =3D l2cap_conn_hold_unless_zero(conn);
>     7456
>     7457         hci_dev_unlock(hcon->hdev);
>     7458
>     7459         if (!conn)
>     7460                 goto drop;
>
> Do you want to move drop after the unlock: or do you want to make this
> a direct return?  Choices, choices...
>
>         if (!conn) {
>                 kfree_skb(skb);
>                 return;
>         }

Ouch, yeah it seems like we should be doing this instead of drop, do
you care to spin a patch for it or shall I do it myself?

>     7461
>     7462         BT_DBG("conn %p len %u flags 0x%x", conn, skb->len, flag=
s);
>     7463
>     7464         mutex_lock(&conn->lock);
>     7465
>     7466         switch (flags) {
>     7467         case ACL_START:
>     7468         case ACL_START_NO_FLUSH:
>     7469         case ACL_COMPLETE:
>     7470                 if (conn->rx_skb) {
>     7471                         BT_ERR("Unexpected start frame (len %d)"=
, skb->len);
>     7472                         l2cap_recv_reset(conn);
>     7473                         l2cap_conn_unreliable(conn, ECOMM);
>     7474                 }
>     7475
>     7476                 /* Start fragment may not contain the L2CAP leng=
th so just
>     7477                  * copy the initial byte when that happens and u=
se conn->mtu as
>     7478                  * expected length.
>     7479                  */
>     7480                 if (skb->len < L2CAP_LEN_SIZE) {
>     7481                         l2cap_recv_frag(conn, skb, conn->mtu);
>     7482                         break;
>     7483                 }
>     7484
>     7485                 len =3D get_unaligned_le16(skb->data) + L2CAP_HD=
R_SIZE;
>     7486
>     7487                 if (len =3D=3D skb->len) {
>     7488                         /* Complete frame received */
>     7489                         l2cap_recv_frame(conn, skb);
>     7490                         goto unlock;
>     7491                 }
>     7492
>     7493                 BT_DBG("Start: total len %d, frag len %u", len, =
skb->len);
>     7494
>     7495                 if (skb->len > len) {
>     7496                         BT_ERR("Frame is too long (len %u, expec=
ted len %d)",
>     7497                                skb->len, len);
>     7498                         l2cap_conn_unreliable(conn, ECOMM);
>     7499                         goto drop;
>     7500                 }
>     7501
>     7502                 /* Append fragment into frame (with header) */
>     7503                 if (l2cap_recv_frag(conn, skb, len) < 0)
>     7504                         goto drop;
>     7505
>     7506                 break;
>     7507
>     7508         case ACL_CONT:
>     7509                 BT_DBG("Cont: frag len %u (expecting %u)", skb->=
len, conn->rx_len);
>     7510
>     7511                 if (!conn->rx_skb) {
>     7512                         BT_ERR("Unexpected continuation frame (l=
en %d)", skb->len);
>     7513                         l2cap_conn_unreliable(conn, ECOMM);
>     7514                         goto drop;
>     7515                 }
>     7516
>     7517                 /* Complete the L2CAP length if it has not been =
read */
>     7518                 if (conn->rx_skb->len < L2CAP_LEN_SIZE) {
>     7519                         if (l2cap_recv_len(conn, skb) < 0) {
>     7520                                 l2cap_conn_unreliable(conn, ECOM=
M);
>     7521                                 goto drop;
>     7522                         }
>     7523
>     7524                         /* Header still could not be read just c=
ontinue */
>     7525                         if (conn->rx_skb->len < L2CAP_LEN_SIZE)
>     7526                                 break;
>     7527                 }
>     7528
>     7529                 if (skb->len > conn->rx_len) {
>     7530                         BT_ERR("Fragment is too long (len %u, ex=
pected %u)",
>     7531                                skb->len, conn->rx_len);
>     7532                         l2cap_recv_reset(conn);
>     7533                         l2cap_conn_unreliable(conn, ECOMM);
>     7534                         goto drop;
>     7535                 }
>     7536
>     7537                 /* Append fragment into frame (with header) */
>     7538                 l2cap_recv_frag(conn, skb, skb->len);
>     7539
>     7540                 if (!conn->rx_len) {
>     7541                         /* Complete frame received. l2cap_recv_f=
rame
>     7542                          * takes ownership of the skb so set the=
 global
>     7543                          * rx_skb pointer to NULL first.
>     7544                          */
>     7545                         struct sk_buff *rx_skb =3D conn->rx_skb;
>     7546                         conn->rx_skb =3D NULL;
>     7547                         l2cap_recv_frame(conn, rx_skb);
>     7548                 }
>     7549                 break;
>     7550         }
>     7551
>     7552 drop:
>     7553         kfree_skb(skb);
>     7554 unlock:
> --> 7555         mutex_unlock(&conn->lock);
>     7556         l2cap_conn_put(conn);
>     7557 }
>
> regards,
> dan carpenter
>


--=20
Luiz Augusto von Dentz
