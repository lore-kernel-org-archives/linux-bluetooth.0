Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7E11BF37
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713987131; cv=none; b=htyt0vz9xXr3+T56S1nciz12B71IguNQFvH2kT5CRZjK8a3dW42wHBuDhVRCRRiQAbuLB9dXRVc+aghYvVNwVWl1qQayRYhKPFmYhi0SXMCnfUvagASeEqsscXiISxo+e1sG1BiSvlMZi/uvXe52qfJh9g6Qeh919tFek2jkOps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713987131; c=relaxed/simple;
	bh=fMnhv3IU+2Wtlu4OHN2GvchrPnp0KdIKfwUb0q4otf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0Lp68cD2lFIsrTZ+D7WXELWrzMwyXU4+PP32l0+5xOL+39yqKJSRxM8KcMrnauwfyTcqmVIwwJLE44uJQkhGjHOHTq2PEzFTbo1c1AMyUpW8DRqDhPt39qvwHVahFMJQbjOBegG3VpyUQrzDlMrosCF7VePlokFGPhBmtRpo6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGBaJ5Lr; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGBaJ5Lr"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2dd041acff1so2316871fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 12:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713987128; x=1714591928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khd1bQinBfuAW2ReCtJh6qolj7/CuLf+EnvLDQLwZh4=;
        b=LGBaJ5LrDdNxxDAK649m0jh4ag4y0SReZ1pSim8njY1jg/pXV0stsXRyt6qMSt5oNc
         mljOKG2I0QcEHoRN9Z24QXowWHmLZiYJAwUxU7l51zK8xbNWmdtlflcg6T+uBgMarteD
         koORDpP+bOtdPNyeySSgjzwRJ1CPgRwKYcIVNVz7+Je7SW6y+B03KaQxzlQ77VEYTSyH
         cbj0vjPvKD6dYXR8phfWjJtZz3cQkTEpxAMyQLs957l9PFVDp7NbkvUVoTcfoITNMO4l
         CnL85HEEA0EXvE+Gc5YZV/WSytz3ZolxuMtV8JvneGk97I+58y9bX1UIgTws81sT+iG2
         BeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713987128; x=1714591928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khd1bQinBfuAW2ReCtJh6qolj7/CuLf+EnvLDQLwZh4=;
        b=sPUCFmYmZeNptCcJP81a6e+6oObGhyYl55na+rXSeTVoAnqfT6xJWX57pQquWFuFg7
         vUOFwjLaE+VWFIVF+MrHyb4oUY+lI2xQUqkyXtMgIq3IZHLJVdbcOjeX4cGzRaoNAPa6
         yDGl4XqLGCsWn8jUQCrbuO2Taw9EAAvZP9Z/JzlOg3feFsK2C8A8KwPi2sP3tYEvmjz0
         gNPYTngrZ7XMzuQCh5CWLpUQr8HnwpEiLvXESlHY4FS+oSVONEx6d/1mHR+wWntCAVMn
         +aUyuvA8869oZwU73TExrnkrzvl6NIMZegevPOwQM0PLqR56X4fo0hTk5p81iU2MfTo+
         DjYA==
X-Gm-Message-State: AOJu0YxQbrCSrMVmSxX1JgmuArjrfc3VwMy9duIQhVpJ81ifZ+nXEKaI
	K+Pet+Gd7H2oSRzAgBX3ZavtS2Fe/eA6O7bFxjTraApBuaiXWZ2ZGVKULL3b+9edrDz3IDSIAUm
	MVRUOYxPJCV8c6/1EOa03AZadg+r3eJ+G
X-Google-Smtp-Source: AGHT+IHd1D9MWqfu63f7cSvdI9W5DqkCLk5yQGNCUmpsbTFI/6iT5tLQOzSEjkSgHxkm/DtN08QXvCraGsr1yZP6/j4=
X-Received: by 2002:a2e:a378:0:b0:2d8:3e60:b9c9 with SMTP id
 i24-20020a2ea378000000b002d83e60b9c9mr1986222ljn.33.1713987127852; Wed, 24
 Apr 2024 12:32:07 -0700 (PDT)
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
In-Reply-To: <AS5PR04MB9754210A13AD74FB8C3E361D89102@AS5PR04MB9754.eurprd04.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 24 Apr 2024 15:31:54 -0400
Message-ID: <CABBYNZJJq9UTf467LXJ-7WvWbn8bcge0L6CprkGSnu4ZpopSpw@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH BlueZ v1 1/1] LE Create Connection command
 timeout increased to 20 secs from 4 secs
To: Mahesh Talewad <mahesh.talewad@nxp.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	Devyani Godbole <devyani.godbole@nxp.com>, Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mahesh,

On Wed, Apr 24, 2024 at 9:49=E2=80=AFAM Mahesh Talewad <mahesh.talewad@nxp.=
com> wrote:
>
> Hi Luiz,
>
> We tried with - 6093f28402aa6342890fc3adb6be355f804b719d - with this as w=
ell issue is observed.

The lets do something like:

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5c12761cbc0e..fbf0a6263dae 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -456,7 +456,6 @@ enum {
 #define HCI_AUTO_OFF_TIMEOUT   msecs_to_jiffies(2000)  /* 2 seconds */
 #define HCI_ACL_CONN_TIMEOUT   msecs_to_jiffies(20000) /* 20 seconds */
 #define HCI_LE_CONN_TIMEOUT    msecs_to_jiffies(20000) /* 20 seconds */
-#define HCI_LE_AUTOCONN_TIMEOUT        msecs_to_jiffies(4000)  /* 4 second=
s */

 /* HCI data types */
 #define HCI_COMMAND_PKT                0x01
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 99b4e68075f4..651e5105fdd5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2556,7 +2556,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
        hdev->le_rx_def_phys =3D HCI_LE_SET_PHY_1M;
        hdev->le_num_of_adv_sets =3D HCI_MAX_ADV_INSTANCES;
        hdev->def_multi_adv_rotation_duration =3D HCI_DEFAULT_ADV_DURATION;
-       hdev->def_le_autoconnect_timeout =3D HCI_LE_AUTOCONN_TIMEOUT;
+       hdev->def_le_autoconnect_timeout =3D HCI_LE_CONN_TIMEOUT;
        hdev->min_le_tx_power =3D HCI_TX_POWER_INVALID;
        hdev->max_le_tx_power =3D HCI_TX_POWER_INVALID;
