Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73682172762
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Apr 2024 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483934; cv=none; b=h9FOAiOGc7dWb9HNt0QKVdDm0VDxi/DgQQz2XQN5hbu0q0sFmrYO1sGd6LywR4PHu49flDArGVtfG9bWJDebssS/w1Qo4WxYudDcIuizMwD0rh9xA6lhATGSo2Yrq/wUi61c5lenxobaTAIG9YXn9/2bvy47ek/Z9hQsEbyJReE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483934; c=relaxed/simple;
	bh=0DWyrocco/+AIOLFyMurUsXDtQ24NUHWx5kSDtdkjbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCDFmdTVg5ASYWXQE58GAr/fgnqqsM+WmJQ5yZkFcVi8bi9kAFabiEXx/DfN2ZIPUqe9IjDnHF9bdcEd2svgg/qjTfiruBcrcmIGUp04IE2zaq0OOyckgSTIRXESmqD2ajtaZBWeY5WXXVZS0++M4pE/TGXJHsnQessrEbYAkF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atjwLhMy; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atjwLhMy"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e10b6e2bacso5427901fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Apr 2024 06:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714483930; x=1715088730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ox9t7JV9a8VxxAYHr7qj94QPJmEyq6wU538YZaqru4M=;
        b=atjwLhMyy9h6itOK0Jgc73rY8ldR+hJGyWBYLoNHFPN01QNGy9fWha2LwWnKVIWbPm
         VWvTIzQmbYNcXv4p9vzioKvF/VvEcbUwnhbtRfOP/SKL+2c0vYHgM0koYSZO1hqjZXAX
         YGz+wQx1KNtE46AiVUHH9HkC0MI8uIVtS3DaBY4JNgN5lF1Oq8farC+VVlWpTbVP25sV
         o1tPhd7pYy1Quu4SpeRbRcjxeRScJVKfrOdyfjfVv4ymnIwl5BjrxrZAAK7TjZscV7+B
         y/wyCuKamF3hoZe1u7K7trEmB3Pv3dYw9/d7r0//Z6T38cf/52PqvquO71UFV4zPVoW8
         jLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714483930; x=1715088730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ox9t7JV9a8VxxAYHr7qj94QPJmEyq6wU538YZaqru4M=;
        b=hBfrpPcldFssDq4Y+3JDH1FkEPfhez3nTypD/oQtM6vIOYHGax2CD3ahjOHjXcBzG1
         JezpCV3MO96aUSMKged0/DP40BX8cT6zToEh7hbiY4htXkmcGxlKPztOi508XVw4UDjy
         mJgoMazjI6sBRMnYPVZUnB8vwpGirjGfLmj3doqUG+xr++gfO3Fnzo0P40tkPIMw9iEo
         quJprOd8rVt48o4jY/h1W1ROB/qEpWRyxRNLIAZTa5TuIIiiGVE4h45cJaa3vAwfrWk6
         JxGlB7ubBlJXuYd8EdCfdt14TDPjnaXilpZY1guhpKJF4Gv5H3CfOSu51pk1NxbYzTt3
         8CpQ==
X-Gm-Message-State: AOJu0YwiYQsV5zOvIdrjfJWtZyACD+dnNH08fkI5Cwc9f4oPo+a8jspc
	zYVoKD/c9eTvCkBOxP/X5fBjStY/sCtpzBvYnvgG40IUv3F7eV+jJPvE0fiXQuF3O+hxrCW5PaH
	t/pf9YYQWvL+TiSpkDEbJiNpl5RDqHg==
X-Google-Smtp-Source: AGHT+IHxqsSPwJEZPMFeIHJjVawIu89jqkxUjRXWfcUB27aUVDDceOElhO9UiCn0UvSYnNhBtbDmUSabWFq08A8DuZo=
X-Received: by 2002:a2e:b6d4:0:b0:2df:49b:27d6 with SMTP id
 m20-20020a2eb6d4000000b002df049b27d6mr8051366ljo.38.1714483929319; Tue, 30
 Apr 2024 06:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318123712.9729-1-mahesh.talewad@nxp.com> <20240318123712.9729-2-mahesh.talewad@nxp.com>
 <CABBYNZKvAmb5JjfxkPADED6CQKD+GxsRqLajHX=w0GE+imhCMA@mail.gmail.com>
 <AS5PR04MB975486834B434042CE2A693689332@AS5PR04MB9754.eurprd04.prod.outlook.com>
 <CABBYNZK5YS6paOYbx4yL6R7Wt9o+oGrtmfiQNmOaTAUo2DBfdQ@mail.gmail.com>
 <AS5PR04MB9754B55170413A2FD0A00F0A89122@AS5PR04MB9754.eurprd04.prod.outlook.com>
 <AS5PR04MB9754210A13AD74FB8C3E361D89102@AS5PR04MB9754.eurprd04.prod.outlook.com>
 <CABBYNZJJq9UTf467LXJ-7WvWbn8bcge0L6CprkGSnu4ZpopSpw@mail.gmail.com> <AS5PR04MB97540A3B63FC307F4B64F2BB891A2@AS5PR04MB9754.eurprd04.prod.outlook.com>
In-Reply-To: <AS5PR04MB97540A3B63FC307F4B64F2BB891A2@AS5PR04MB9754.eurprd04.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 30 Apr 2024 09:31:57 -0400
Message-ID: <CABBYNZJ3Bcakaw12UCVRQRzM6GaPpgz7UeS3BhYdSw8bdvqdag@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH BlueZ v1 1/1] LE Create Connection command
 timeout increased to 20 secs from 4 secs
To: Mahesh Talewad <mahesh.talewad@nxp.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	Devyani Godbole <devyani.godbole@nxp.com>, Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mahesh,

On Tue, Apr 30, 2024 at 8:23=E2=80=AFAM Mahesh Talewad <mahesh.talewad@nxp.=
com> wrote:
>
> Hi Luiz,
>
> Thank you. This patch is working. le connection timeout successfully chan=
ged to 20secs.

Please send as a proper patch then.

> Thanks and regards,
> Mahesh Vithal Talewad
>
> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Thursday, April 25, 2024 1:02 AM
> To: Mahesh Talewad <mahesh.talewad@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Devyani Godbole <devyani.godbole@nxp=
.com>; Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
> Subject: Re: [EXT] Re: [PATCH BlueZ v1 1/1] LE Create Connection command =
timeout increased to 20 secs from 4 secs
>
> Caution: This is an external email. Please take care when clicking links =
or opening attachments. When in doubt, report the message using the 'Report=
 this email' button
>
>
> Hi Mahesh,
>
> On Wed, Apr 24, 2024 at 9:49=E2=80=AFAM Mahesh Talewad <mahesh.talewad@nx=
p.com> wrote:
> >
> > Hi Luiz,
> >
> > We tried with - 6093f28402aa6342890fc3adb6be355f804b719d - with this as=
 well issue is observed.
>
> The lets do something like:
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h in=
dex 5c12761cbc0e..fbf0a6263dae 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -456,7 +456,6 @@ enum {
>  #define HCI_AUTO_OFF_TIMEOUT   msecs_to_jiffies(2000)  /* 2 seconds */
>  #define HCI_ACL_CONN_TIMEOUT   msecs_to_jiffies(20000) /* 20 seconds */
>  #define HCI_LE_CONN_TIMEOUT    msecs_to_jiffies(20000) /* 20 seconds */
> -#define HCI_LE_AUTOCONN_TIMEOUT        msecs_to_jiffies(4000)  /* 4 seco=
nds */
>
>  /* HCI data types */
>  #define HCI_COMMAND_PKT                0x01
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c index 99=
b4e68075f4..651e5105fdd5 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2556,7 +2556,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
>         hdev->le_rx_def_phys =3D HCI_LE_SET_PHY_1M;
>         hdev->le_num_of_adv_sets =3D HCI_MAX_ADV_INSTANCES;
>         hdev->def_multi_adv_rotation_duration =3D HCI_DEFAULT_ADV_DURATIO=
N;
> -       hdev->def_le_autoconnect_timeout =3D HCI_LE_AUTOCONN_TIMEOUT;
> +       hdev->def_le_autoconnect_timeout =3D HCI_LE_CONN_TIMEOUT;
>         hdev->min_le_tx_power =3D HCI_TX_POWER_INVALID;
>         hdev->max_le_tx_power =3D HCI_TX_POWER_INVALID;



--=20
Luiz Augusto von Dentz
