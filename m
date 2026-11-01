Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793547751;
	b=ukOokv+LC1iE06FL9SR8fC+6s/a626tOH4blwWrlc3dEcqvbxFQQ4HXInVaYKceKMsTi
	 2ZuEA/jTyRVuo9IefCfp0Zk/fKXK6MqljwkvhhSGSyBdQYQdaomVPGpUBHQVbVHFxXy17
	 MXSpWUHseHoyom/Y05W4ZAMhdBqpYVf6WNmXNtaqdT46hCkol50plTjGalgq8bIXf6bzC
	 ed8YoYEQuwQYBZ2XotW6XYf74qf44vCaxmUmP3DfWJ4fQzZv8vWltzdPgnbK7awmsFs9l
	 bXrm9BjV1Icwj9DIBqbgSl4OCao+pgN8bHJDTe/sbAG2dCMs6oB4vFERU/uASjF8XnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793547751;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Content-Transfer-Encoding:
	 From:Mime-Version:Subject:Date:Message-Id:References:Cc:In-Reply-To:
	 To:X-Mailer;
	bh=+hfJTfIE4c9lTY9KbtMmyOg2v8RzrvoME+4vIGZ/RDU=;
	b=TDJQm5jDqaj4btfU9fQhfd7lnJb8OlLVsuz+WeUkXl0822Mvaiv4EomzemvDXscEUzn6
	 5TLjcPbI6GPmOhfxByFaCHQPERgGW0AKzb62/FCgTspqkJmoMQasIMBPHL6X6MddwCNmH
	 KF4F6ezUXO3Nr5VMPfWlQyz4BwRgb9u+GfHH6FvYKOcMPI+jq2V2XG+s5VZvaBEit3LQ7
	 0PmZKghVHzVDGDYSn2GTUTsVS1cSJoGhDo2+IsZTdd+8cbBR3Zkkt8o2N9nz1VCXghxjV
	 lOJtXNZHec6QoEURoEWpfHMFWPKA/BlmTDp/eHlgIfpmrSqEfPifzCc3swC8qURSX2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TPJPyTYA;
	arc=none smtp.remote-ip=95.215.58.77
Received: from mta1.migadu.com (out-77.mta1.migadu.com [95.215.58.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38C0606A324
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Nov 2026 15:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C38C0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TPJPyTYA
X-Envelope-To: linux-bluetooth@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JP5vsCwy4egMsces+lLZVoxETUXGeacn1AnVYveGSys=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793547747; v=1; x=1794152547;
 b=TPJPyTYAsDuy/BFlcrmmiFv9z4gSPce/3JWAz9l9YupufSAgrnAYgnsxRd9xK1S8cf+J64+4
 HCUXiKvR78SF+InoG9Tbj0ff4JfINpIMvfpxivMGDngg/6y+7sogyWLms9MbZVB/k8MfV4Gr7gS
 SSKwIQTkYs/+0rbib/JrnHUw=
X-Envelope-To: linux-bluetooth@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id e2615d605fb60ce4;
	Sun, 01 Nov 2026 15:42:27 +0000
X-Mizu-Trace-ID: e2615d605fb60ce4
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Aditya Garg <aditya.garg@linux.dev>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH bluetooth-next] Bluetooth: hci_event: strip Broadcom vendor bits from legacy adv report type
Date: Sun, 1 Nov 2026 21:12:06 +0530
Message-Id: <F4853998-F2A8-4AFE-99EA-544657EAB0E8@linux.dev>
References: <20261015114903.784731-1-66ton99@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org,
 Jose Miguel Ochoa <josemiguelo.ochoa@gmail.com>,
 Ton Sharp <66ton99@gmail.com>
In-Reply-To: <20261015114903.784731-1-66ton99@gmail.com>
To: Ton Sharp <66ton99@gmail.com>
X-Mailer: iPad Mail (24B119)



> On 15 Oct 2026, at 5:20=E2=80=AFPM, Ton Sharp <66ton99@gmail.com> wrote:
>=20
> =EF=BB=BFBroadcom controllers running ROM firmware on Apple T2 Macs (where=
 no
> RAM patchram exists, e.g. BCM4364B3 on MacBookPro16,1) set vendor bits
> 0x10/0x20/0x80 in the legacy LE Advertising Report Event_Type.
>=20
> As a result, directed advertisements (ADV_DIRECT_IND) arrive as
> 0x81/0x91/0xa1 instead of 0x01. Because process_adv_report() drops any
> legacy report with type > LE_ADV_SCAN_RSP (0x04) as an unknown advertising=

> packet type, bonded LE peripherals (such as Apple Magic Mouse/Keyboard)
> and Chrome passkey proximity scans fail to discover or reliably reconnect
> to the host.
>=20
> The valid legacy type is always located in the low nibble. Mask the type
> field for Broadcom controllers (manufacturer 15) when it is out of range.
> Valid legacy reports (0x00-0x04) remain untouched, low nibbles >=3D 5 rema=
in
> out of range and will continue to be dropped, and controllers from other
> manufacturers are unaffected.
>=20
> The fix is based on the initial t2linux patch from Jose Miguel Ochoa.

Late to the discussion but are you sure this applies to all Broadcom chips t=
hat are not in T2 Macs?

We have a WIP patch that does the same thing only for chips seen in T2 Macs s=
o I think that should be implemented?
>=20
> Link: https://lore.kernel.org/r/3352A23E-EA42-4366-BBAA-459CEAE6F51B@live.=
com
> Suggested-by: Jose Miguel Ochoa <josemiguelo.ochoa@gmail.com>
> Signed-off-by: Ton Sharp <66ton99@gmail.com>
> ---
> net/bluetooth/hci_event.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)
>=20
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index c055d16cfb8e..a03a33bca095 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6593,6 +6593,17 @@ static void hci_le_adv_report_evt(struct hci_dev *h=
dev, void *data,
>=20
>        hci_store_wake_reason(hdev, &info->bdaddr, info->bdaddr_type);
>=20
> +        /* Broadcom ROM firmware (BCM4364B3 on Apple T2 Macs, no
> +         * patchram) sets vendor bits in the legacy Event_Type.
> +         */
> +        if (hdev->manufacturer =3D=3D 15 && info->type > LE_ADV_SCAN_RSP)=
 {
> +            /* 0x0f masks out upper vendor bits (0x10, 0x20, 0x80),
> +             * extracting the standard legacy advertising type
> +             * (0x00-0x04) stored in the low nibble (bits 0-3).
> +             */
> +            info->type &=3D 0x0f;
> +        }
> +
>        if (info->length <=3D max_adv_len(hdev)) {
>            rssi =3D info->data[info->length];
>            process_adv_report(hdev, info->type, &info->bdaddr,
> --
> 2.52.0
>=20
