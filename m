Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E612D4B63;
	Thu,  3 Jul 2025 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551913; cv=none; b=Igiwb7yRVh3L/8HA+j7WZ0SIAKd5D4d0micIHVeA+i9hskHJ9Deos5rLdqqt/jWSxneaZJjUyny4pdOvIXXAl0fjMsBe4nRTfqt5Ke1SwYE5nK/c5XHuEsSEJVt0sFZkB93c7QSIrn1+NcPfsqoDJpuk29wghnCacYVf0dSuwAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551913; c=relaxed/simple;
	bh=XgXlb0/29fASjTyt1tyQsHF1V0mt2KTTUn6J1yVLuGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9vJNJkBE9u20YbEAUhIh854OPMXox3YAl7uAItd4mVzPyyZFPetslLPaLuRiFifDQT0o9B1VO6yPpdowm9MK0UXQxZENULDXFvnw902hPi6Z+CoZScZ00V2sjt0x2Rt8nuc+WrtULL9kc5o9nxp3+eOjbDiMgh9YHjkEEzzq3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqxlILhx; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqxlILhx"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32b7fd20f99so10916301fa.0;
        Thu, 03 Jul 2025 07:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751551910; x=1752156710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUe3EsQbL5Jq5eDFoPI3+AEIDD/BsCwEoKHOLBRElro=;
        b=kqxlILhxVb/NCwjUbG3rN+0O2MAuUDeL27TGWYnLLuAsy+eO7GkTZWKtH5rMRJ4VRm
         UZVoAPWhvnwAmA+nyMR5pAyI2+ZqgKhsBd10IOuj69i9mJIxmqgjnUYZttQsQeLl+ZQQ
         fCG1auCMocKnY5/FfQOnawseUz62TRP3qW3VfWhEOSk+6GMZJRBOMJrWPZpHoqf3d0iM
         TCK2BEJMignwLVuWNwJ2p1JXdTI6q9ZiNCJEtZx+23DGxF2LmsWR5lpIiAhaWLpKUoHR
         JaYUzwjuKgR8a5vqSvgCNCgN0KROdHM+/AY/nOfoxKmU+fNdLlUHRKV7BkIF0JuvJA0H
         KUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751551910; x=1752156710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUe3EsQbL5Jq5eDFoPI3+AEIDD/BsCwEoKHOLBRElro=;
        b=HoBQajE1rvu4BImJ689tou1t5KE4vbZaJ5NVCqRTi7FzJeomdUHfRHZTNwOFg8rKbp
         KULgmPiCUCshcdeGTk8JzepWEuIdiFOWNSLRxzZQvfF+C3V5E2Ym335pQzmvTDKeturc
         LD70Jyyht5OnLqgbwNYCkXY0Id0BJPL6zu2v8rS07ns3vA4mLunNTLmmyeOdGgABuxMh
         f2XNex7MNjKfyerjr/npunDb1nk/6wScYexArmQ4dayzlREEWO2uT3nBxFWXaCScSUJH
         V1bkev8n6RNbAoBAv68vBEJgNxZbkinpzJYuuXHM6jzMAVMuSd0rKzxPmxQbQVzSPkUR
         recQ==
X-Forwarded-Encrypted: i=1; AJvYcCUscauIPXrSsO26tjh03vz0OdpJQD7yEz073HfcL8XOEMG1Oi76AJsHoffd7DZ/PcMRhKTwzkkumQlQcJsY@vger.kernel.org, AJvYcCUt04cHofTgxHtFvL+Wy1A9ImWmBXvYKp6QfN4txruABhPiUrmmDgNc53FyyV3XfZUsDTAl2Tml7YrPHCnzxwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyqNQh//vY8RMBD0Fr1mlcuZJwSOa8SjXa6ZwP2ocgwjWCmJxb
	PSzjnNJVr4PYh5vqmo25RagUvX9SVp8KGy1Wm4hMav6bNsGPbGlB3qWhMDNcugL/1PMTsEgW5Wa
	V1MM18V9Uwuxy6nSY1KTPPZni7k59vvg=
X-Gm-Gg: ASbGncvpK8jBPiPm+b+7qfV+H/ygb1FmkV4pzvRIh7YL1vUTz56Ynw+7L/sHKT1CBZT
	DS355neF2O/roTTVrgdK/SpuqMC9N6X3BVTEuq4I4DAZS3Fwh2lcAG21nKcvK+2hAZ1nhBl3Wkv
	31Vi4EG/YoCvkQr/gmPP2m5dDWsrWuU03A0gODOE88z3eN0VuGr8nV
X-Google-Smtp-Source: AGHT+IGVSphrKmdCQCLkoZTARN4uOSX3ssIh+yrJIr/RMM+lwNdooqKTfXRr23zAV5PnWWJxFzbv2UbPzAJXLj2QOaA=
X-Received: by 2002:a2e:a99a:0:b0:32a:82d7:6d63 with SMTP id
 38308e7fff4ca-32e0f9af654mr9669501fa.12.1751551909325; Thu, 03 Jul 2025
 07:11:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702-hold_pa_sync-v1-1-3cbdd2c29c41@amlogic.com>
 <CABBYNZJJJcjhwbDwYZxqxu-RHtyUd9T3Lvf-qEqgNfxfCsk+9w@mail.gmail.com>
 <583badf5-26b0-431f-abe8-e411ef126c26@amlogic.com> <CABBYNZJxtfQUrLxo9chbqXz37dRF00id5sxwDBRHj5HEp2B_Bw@mail.gmail.com>
In-Reply-To: <CABBYNZJxtfQUrLxo9chbqXz37dRF00id5sxwDBRHj5HEp2B_Bw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 3 Jul 2025 10:11:36 -0400
X-Gm-Features: Ac12FXx2dd-oi2Q8DsiVH-xlIaqErAQ_g36vm2umMLDoeGfndTcxj2qJi6ny064
Message-ID: <CABBYNZJzPsHPyPKvrMsdd7=WfrmcP0A+BHkd0_xvkM_jjJWq4Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: Hold PA sync conn when BIG sync established
To: Yang Li <yang.li@amlogic.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 3, 2025 at 9:21=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Thu, Jul 3, 2025 at 4:45=E2=80=AFAM Yang Li <yang.li@amlogic.com> wrot=
e:
> >
> > Hi Luiz,
> > > [ EXTERNAL EMAIL ]
> > >
> > > Hi,
> > >
> > > On Tue, Jul 1, 2025 at 11:12=E2=80=AFPM Yang Li via B4 Relay
> > > <devnull+yang.li.amlogic.com@kernel.org> wrote:
> > >> From: Yang Li <yang.li@amlogic.com>
> > >>
> > >> Hold PA sync connection to prevent cleanup during hci_conn_timeout.
> > > You will need to do a better job explaining what is the issue here.
> >
> >
> > Since the PA sync connection is set to BT_CONNECTED in
> > hci_le_big_sync_established_evt, if its status is BT_CONNECTED when
> > hci_abort_conn_sync is called, hci_disconnect_sync() will be executed,
> > which will cause the PA sync connection to be deleted.
> >
> > int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8
> > reason)
> > {
> > ...
> >      switch (conn->state) {
> >      case BT_CONNECTED:
> >      case BT_CONFIG:
> >          err =3D hci_disconnect_sync(hdev, conn, reason);
> >          break;
> > ...
> >
> > stack trace as below:
> >
> > [   55.154495][0 T1966  d.] CPU: 0 PID: 1966 Comm: kworker/u9:0 Tainted=
:
> > G           O       6.6.77 #104
> > [   55.155721][0 T1966  d.] Hardware name: Amlogic (DT)
> > [   55.156336][0 T1966  d.] Workqueue: hci0 hci_cmd_sync_work
> > [   55.157018][0 T1966  d.] Call trace:
> > [   55.157461][0 T1966  d.]  dump_backtrace+0x94/0xec
> > [   55.158056][0 T1966  d.]  show_stack+0x18/0x24
> > [   55.158607][0 T1966  d.]  dump_stack_lvl+0x48/0x60
> > [   55.159205][0 T1966  d.]  dump_stack+0x18/0x24
> > [   55.159756][0 T1966  d.]  hci_conn_del+0x1c/0x12c
> > [   55.160341][0 T1966  d.]  hci_conn_failed+0xdc/0x150
> > [   55.160958][0 T1966  d.]  hci_abort_conn_sync+0x204/0x388
> > [   55.161630][0 T1966  d.]  abort_conn_sync+0x58/0x80
> > [   55.162237][0 T1966  d.]  hci_cmd_sync_work+0x94/0x100
> > [   55.162877][0 T1966  d.]  process_one_work+0x168/0x444
> > [   55.163516][0 T1966  d.]  worker_thread+0x378/0x3f4
> > [   55.164122][0 T1966  d.]  kthread+0x108/0x10c
> > [   55.164664][0 T1966  d.]  ret_from_fork+0x10/0x20
> > [   55.165408][0 T1966  d.] hci0 hcon 000000004f36962c handle 3841 #PA
> > sync connection
> >
> >
> > btmon trace:
> >
> > < HCI Command: Disconnect (0x01|0x0006) plen 3             #75 [hci0]
> > 14.640630
> >          Handle: 3841
> >          Reason: Remote User Terminated Connection (0x13)
> >  > HCI Event: Command Status (0x0f) plen 4                  #76 [hci0]
> > 14.642103
> >        Disconnect (0x01|0x0006) ncmd 1
> >          Status: Invalid HCI Command Parameters (0x12)
> >
>
> Ok, so this must be fixed and not worked around.
>
> > So the current question is whether the PA sync connection, which is
> > marked as BT_CONNECTED, really needs to be disconnected.
> > If it does need to be disconnected, then the PA sync terminate command
> > must be executed.
> > However, in my opinion, the PA sync connection should not be disconnect=
ed.
>
> Why not? The fact that it is not being cleanup properly doesn't mean
> it shouldn't be terminated, otherwise we will have a dangling
> hci_conn.

Looks like Ive messed up with the fix to mark the BIS as connected, it
marked the PA instead which is probably wrong and perhaps it is why
you were saying it shouldn't be terminated since the PA sync is
terminated when the last BIS is terminated.

Anyway I will be fixing up the PA being set to connected rather than
BIS, so please rebase.

> > >
> > >> Signed-off-by: Yang Li <yang.li@amlogic.com>
> > >> ---
> > >>   net/bluetooth/hci_event.c | 3 +++
> > >>   1 file changed, 3 insertions(+)
> > >>
> > >> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > >> index e817c4a77f97..85ae1608e028 100644
> > >> --- a/net/bluetooth/hci_event.c
> > >> +++ b/net/bluetooth/hci_event.c
> > >> @@ -6968,6 +6968,9 @@ static void hci_le_big_sync_established_evt(st=
ruct hci_dev *hdev, void *data,
> > >>
> > >>                  if (!ev->status) {
> > >>                          conn->state =3D BT_CONNECTED;
> > >> +                       /* Prevent cleanup in hci_conn_timeout. */
> > >> +                       hci_conn_hold(conn);
> > >> +
> > >>                          set_bit(HCI_CONN_BIG_SYNC, &bis->flags);
> > >>                          hci_debugfs_create_conn(conn);
> > >>                          hci_conn_add_sysfs(conn);
> > >>
> > >> ---
> > >> base-commit: 3bc46213b81278f3a9df0324768e152de71eb9fe
> > >> change-id: 20250702-hold_pa_sync-91ca7a81adf0
> > >>
> > >> Best regards,
> > >> --
> > >> Yang Li <yang.li@amlogic.com>
> > >>
> > >>
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
