Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187CF21C178;
	Thu,  3 Jul 2025 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751548901; cv=none; b=Iu5fJP+TZ6l1+c9cRw3h/1NvCu6DbDhfDVcdQHxcM6oKSb0xfp2hdqp6vRrjFGsRXnwd0ISAcMQWl6d9Hcb7x+wLGmMdLW810QrVChJoUYjdKem1misEwN8559umJK8GbH8qI3qdnB33El2lTG5bPLccBL7wk7l2/asp94VFC/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751548901; c=relaxed/simple;
	bh=cpbU88cxsv+Bt1t9ISQndsNGndQCeB2egi7EX9e2WIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfZBLDd6unLa5wF4dy/MAjsesayIPD272hmiyrjhSI/aXB6Rkvt6gsJL3nuupXRG7xAzlK8014QTWzqKEe3VwnJNKxBwRDryS68zrhLtt6QyjRHSfEIJKgraZPBUlk38rDB3wrTOsay26GNLYO2kEaCxqKweblxzi53NZ/g53IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/meVeus; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/meVeus"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32aabfd3813so57054381fa.3;
        Thu, 03 Jul 2025 06:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751548898; x=1752153698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3T1H1hRIHpZQdO50cakQfUA0ng9VAFLVYhJJpI2uUY=;
        b=e/meVeusmw1Ck1axM/nBzX/emnva0Z5Y09vyUcHQNlfexmOodyC6y2z6qL5zHni1Ar
         PYy6fm3QblsV2GyXiFlulvLn8A2d7l2Xdif9U/8/CxcuRDIc5waTAQGMBSlPpKafwefx
         fXJwyyu36zcNNA5J0ck55qQpbKzvUvLuB6Bzw83sDQAwL0Lvx7saTq2jTA0xmpfZ3iJI
         Ass+xOtH1z6tHlmY20nP0GySd4t/OFOT5BM5x9GIlZFfkswtjP5rWzhLCMplcKzYBqVq
         6jMUxYKXQh3CIFiiYSqF4+gruS0Uj7NGb4+tg4LWqNIz0+PbECypI47ysvDo9XJ23yAl
         zogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751548898; x=1752153698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3T1H1hRIHpZQdO50cakQfUA0ng9VAFLVYhJJpI2uUY=;
        b=gGOOGoMKzo2qENEYpJFRShHxm5qjEVGyiDLWY7PSkhze5l/XCrY5xxWM0TYFtgy33i
         fo0SYX3ZEDYwF94pcBkjw6I+Be5WxTUNGKr6dw33Zpi7BWWfJwuBJK5mL0s4UFhtfj5k
         Nxt3mLvbRgkPrQXiNN6JnzpOfBJllZcIJsRbFP8qvDBAugEwEGCrzF3BjFFuNeHidQbo
         aN+EgyE5XzEpuWwv9o/Mib+tmMOr8cDOuS2R31G1fAg0M0nlYGxpSGXw0zhqVqNEOJW7
         uBGHgcysmb4LD1BtU5X0Xj1JZjd1waMDnPX9XnXzOtjnq2KN3WsEsccx/B4xjtuLskEQ
         H0OQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3nqOIpZwVuOxTSVlcqT0RFMwb2M9MY3RoGXdfuZLjaiGdDbOiDYdHt9G/LfWJW5ibOsl80RpAg7CrYrZq@vger.kernel.org, AJvYcCWDY6V0bC+sPKoYctrudjqFZBF1lpPg43e7+U6ygYWj/twtWnCxSoD6ou5iYBs6VlaQE53bF64ntv0Dhwo0ggU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzarHtwc7V45r7ZRjzVljpxFug5WuP22jYSb7BQ4869vm6hhJPZ
	NjQchJxsfgh3oYMAzaPlHkaad/dUpaFH8ApLQ2CKV59HWEtvvR5Wjow65W2lxI7J3f1/L7bQMtd
	lMFBDMLp3xGbuwuk6Re4XZ2k+/36FVjGj1lvDQ/Y=
X-Gm-Gg: ASbGnct+MfH4HuIm11jvfLctnMcYqZflI49XHKNDR5kFPBXI02qPBkZNoRNyFbJ3X6/
	/yHwm7MyhpW9ykNKMCpHx/KWFaiGJ9Ewopgs24tFOAVoUu9/jFIFOtnldwZPLdVGwH88+AHy7Wt
	V5PRS72OwqADHHBCIf4KP/lKKetRvsu5Y1x7Slvcb2G82rh91dzsP2
X-Google-Smtp-Source: AGHT+IGvoIiksXLZVJv+6QV1AoZ+jMU+cHojBnNDcnASFVGjDHykBMwLRTuqg/8od2bAzw+uWXJZ67WOFjZJecNAERM=
X-Received: by 2002:a2e:8a92:0:b0:32a:8062:69b1 with SMTP id
 38308e7fff4ca-32e0cf836a6mr9466161fa.8.1751548897712; Thu, 03 Jul 2025
 06:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702-hold_pa_sync-v1-1-3cbdd2c29c41@amlogic.com>
 <CABBYNZJJJcjhwbDwYZxqxu-RHtyUd9T3Lvf-qEqgNfxfCsk+9w@mail.gmail.com> <583badf5-26b0-431f-abe8-e411ef126c26@amlogic.com>
In-Reply-To: <583badf5-26b0-431f-abe8-e411ef126c26@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 3 Jul 2025 09:21:24 -0400
X-Gm-Features: Ac12FXx6WWBOGktjBKpYl5K3cikNqbjUH3zIeA2BwbYcgzbyhSouGSgP1bKxsgg
Message-ID: <CABBYNZJxtfQUrLxo9chbqXz37dRF00id5sxwDBRHj5HEp2B_Bw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: Hold PA sync conn when BIG sync established
To: Yang Li <yang.li@amlogic.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 3, 2025 at 4:45=E2=80=AFAM Yang Li <yang.li@amlogic.com> wrote:
>
> Hi Luiz,
> > [ EXTERNAL EMAIL ]
> >
> > Hi,
> >
> > On Tue, Jul 1, 2025 at 11:12=E2=80=AFPM Yang Li via B4 Relay
> > <devnull+yang.li.amlogic.com@kernel.org> wrote:
> >> From: Yang Li <yang.li@amlogic.com>
> >>
> >> Hold PA sync connection to prevent cleanup during hci_conn_timeout.
> > You will need to do a better job explaining what is the issue here.
>
>
> Since the PA sync connection is set to BT_CONNECTED in
> hci_le_big_sync_established_evt, if its status is BT_CONNECTED when
> hci_abort_conn_sync is called, hci_disconnect_sync() will be executed,
> which will cause the PA sync connection to be deleted.
>
> int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8
> reason)
> {
> ...
>      switch (conn->state) {
>      case BT_CONNECTED:
>      case BT_CONFIG:
>          err =3D hci_disconnect_sync(hdev, conn, reason);
>          break;
> ...
>
> stack trace as below:
>
> [   55.154495][0 T1966  d.] CPU: 0 PID: 1966 Comm: kworker/u9:0 Tainted:
> G           O       6.6.77 #104
> [   55.155721][0 T1966  d.] Hardware name: Amlogic (DT)
> [   55.156336][0 T1966  d.] Workqueue: hci0 hci_cmd_sync_work
> [   55.157018][0 T1966  d.] Call trace:
> [   55.157461][0 T1966  d.]  dump_backtrace+0x94/0xec
> [   55.158056][0 T1966  d.]  show_stack+0x18/0x24
> [   55.158607][0 T1966  d.]  dump_stack_lvl+0x48/0x60
> [   55.159205][0 T1966  d.]  dump_stack+0x18/0x24
> [   55.159756][0 T1966  d.]  hci_conn_del+0x1c/0x12c
> [   55.160341][0 T1966  d.]  hci_conn_failed+0xdc/0x150
> [   55.160958][0 T1966  d.]  hci_abort_conn_sync+0x204/0x388
> [   55.161630][0 T1966  d.]  abort_conn_sync+0x58/0x80
> [   55.162237][0 T1966  d.]  hci_cmd_sync_work+0x94/0x100
> [   55.162877][0 T1966  d.]  process_one_work+0x168/0x444
> [   55.163516][0 T1966  d.]  worker_thread+0x378/0x3f4
> [   55.164122][0 T1966  d.]  kthread+0x108/0x10c
> [   55.164664][0 T1966  d.]  ret_from_fork+0x10/0x20
> [   55.165408][0 T1966  d.] hci0 hcon 000000004f36962c handle 3841 #PA
> sync connection
>
>
> btmon trace:
>
> < HCI Command: Disconnect (0x01|0x0006) plen 3             #75 [hci0]
> 14.640630
>          Handle: 3841
>          Reason: Remote User Terminated Connection (0x13)
>  > HCI Event: Command Status (0x0f) plen 4                  #76 [hci0]
> 14.642103
>        Disconnect (0x01|0x0006) ncmd 1
>          Status: Invalid HCI Command Parameters (0x12)
>

Ok, so this must be fixed and not worked around.

> So the current question is whether the PA sync connection, which is
> marked as BT_CONNECTED, really needs to be disconnected.
> If it does need to be disconnected, then the PA sync terminate command
> must be executed.
> However, in my opinion, the PA sync connection should not be disconnected=
.

Why not? The fact that it is not being cleanup properly doesn't mean
it shouldn't be terminated, otherwise we will have a dangling
hci_conn.

> >
> >> Signed-off-by: Yang Li <yang.li@amlogic.com>
> >> ---
> >>   net/bluetooth/hci_event.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> >> index e817c4a77f97..85ae1608e028 100644
> >> --- a/net/bluetooth/hci_event.c
> >> +++ b/net/bluetooth/hci_event.c
> >> @@ -6968,6 +6968,9 @@ static void hci_le_big_sync_established_evt(stru=
ct hci_dev *hdev, void *data,
> >>
> >>                  if (!ev->status) {
> >>                          conn->state =3D BT_CONNECTED;
> >> +                       /* Prevent cleanup in hci_conn_timeout. */
> >> +                       hci_conn_hold(conn);
> >> +
> >>                          set_bit(HCI_CONN_BIG_SYNC, &bis->flags);
> >>                          hci_debugfs_create_conn(conn);
> >>                          hci_conn_add_sysfs(conn);
> >>
> >> ---
> >> base-commit: 3bc46213b81278f3a9df0324768e152de71eb9fe
> >> change-id: 20250702-hold_pa_sync-91ca7a81adf0
> >>
> >> Best regards,
> >> --
> >> Yang Li <yang.li@amlogic.com>
> >>
> >>
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
