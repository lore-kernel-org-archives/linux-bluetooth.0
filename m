Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1603533121E
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773869760; cv=pass; b=Qx6QkTbGT0hXZgRq8+XpGn40tQN+tAWwn4iVbq9wehX0lL8QeC36KCHNxZ/kX9Wfs5jQlFjboRMUFOmFX9St9L8x4d1XoYXdha6aHPMPjZZsdAD6a70YWI08OM/iECpj2ubkvNo+8GmlA79Clhz4WIB0ZZ1PkMp++5XXL7a1FBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773869760; c=relaxed/simple;
	bh=Q1zi0meOvmHf3bkXvpqAYNmpovQS7TwyqTX/2jsLUuI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kcTGMtRfNNDG4gcHlyFijCF/4M9lvaj2dF/UHlos3yvojJsW9WW2G08xadSOHEv+qPbcZGIbsWYUS3fHeeNk33u9hZtSiT4pNnBI/lpHs/poN5GnUOitTNr9JyiF6UTjUJxwggB99BCjABVIoK7CMFH6bmL+3tZnEHCxs+bSL4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=MNjgA5r9; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="MNjgA5r9"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fbhvb5Jjvz49PwP;
	Wed, 18 Mar 2026 23:35:39 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1773869746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ef9DlqdlQcQetaIsdytkvqmQzdfRJdcFyVs0H4KDFbY=;
	b=MNjgA5r9VRbCVtNdrBRFc5UWkWQR9ZLpTmH06uH34TSYqxL6c6juHlvnik5XAoZ8jGjNW/
	+jC1enYkf64soH7yjUlCwK9IAkc9ZylXdxpVvCTCNujzmXnLmM1+hg5z1kZJ1pgd99f9+j
	1KYRxJ0utsYvxSrptv3Y4IvkPFseTx5K3+m2gE4KFiG5dZE71q1lLUHDRa7jIxcx4wUT55
	9I32pfJwn4Vv80W6sm2XFPQkZTK4hmIQmQsGiuZK+gn6aYFCnmaZGQQfIDe9RAqCIqn7eV
	VTho4kUl4WnCCAVsWd8IS8MZ7nm1BZedcHLuIPH3FJ1RIftoNW2l85QRqKqs8w==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1773869746;
	b=eL+fPoe24kdpCZlqbj2YKHna1cNuW0L703SQxTiAD6RwY1hghLws/zfYTMICbh+jJp9ZwZ
	KPVO9Dv1n0yfxYa++8YmbGpjCdQ4q/954AK9+C4wrr8PtK7fknswQ8aQqoC6+bCVVDnKC2
	8uORr8cCfydKg5CQoIGdzRezh7vSw1lmAKvrLzMDpWs9d5STMyhCahSl3pfA9VrMZvRy18
	ccXp++Q+KBMhOpFXyhOM9HMQppvokGnhUGIOjs+O4KBjhAw0V3kj4WedDDn3EnePvPxsMd
	sFMJpwUuLr6X+QtJDyync/vglu1tn0SIKdVQg+C9h36+67U3T2aCn5Jwsb9lag==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pauli.virtanen@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1773869745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ef9DlqdlQcQetaIsdytkvqmQzdfRJdcFyVs0H4KDFbY=;
	b=LX+z4TLjfK7CL/Ht1qAWHFTjIpm7jfDknNTWiefH8Ib/4tMXMgEPavRLS1jJ7yY0XFWHcl
	QBB9N8iKiwy3q96XKbDbdLwKL4VTzdHN74kF9DfAul2QCuivw3QI8/yCoWoUbWg3gpaw0V
	18p/A8iF9YEsAp+OsJ7uuqQBTf+7z3ZJDKjIDdsSk1rVF3Dx/0F0KXmoirGh1sdtylslVh
	VhR6gboM6mIO+S5FzOSXwWWK3ps4AOMoMSa/oQESbX4ahZrekqkGqkQRoiNo1rbPu2cbZY
	itbo2b8z+ysr5Le1AShz02pJgH3SoR0LAnuMrvGJctbnFkvcFzFzV4yi9XmePA==
Message-ID: <b6508eb975a31a10542682e71ed99bc175fedc27.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: ISO: add timestamp for outgoing HCI ISO
From: Pauli Virtanen <pauli.virtanen@iki.fi>
To: Tailu Shi <tailu.shi@samsung.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Wed, 18 Mar 2026 23:35:37 +0200
In-Reply-To: <20260318110935.3859683-1-tailu.shi@samsung.com>
References: 
	<CGME20260318110941epcas5p14254ccd641695fb7715ec1c10776ae27@epcas5p1.samsung.com>
	 <20260318110935.3859683-1-tailu.shi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ke, 2026-03-18 kello 19:09 +0800, Tailu Shi kirjoitti:
> Hi Pauli,
>=20
> Thanks for your valuable feedback in your previous email.
>=20
> On Fri, 13 Mar 2026 22:50:33 +0200, Pauli worte:
> > TMAP likely assumes the controller implements the specification so that
> > providing correct time stamps would be possible, but when they in
> > practice don't, spec compliance seems dubious and not setting known-
> > wrong Time_Stamp on packets sounds safer.
>=20
> Okay! I see. Thank you.
>=20
> > I think we will want LE Read ISO TX Sync support at least, as this will
> > solve the CIS/BIS synchronization problem, as user application can then
> > know what ISO packets controller considers are playing at the same time
> > (if controller actually implements this command properly).
> >=20
> > It would be good to have information how different manufacturers have
> > interpreted the specification vs. LE Read ISO TX Sync. Right now, I can
> > only read what Zephyr is doing, and tested some other controllers
> > return zeros. If you have access to controllers that implement this
> > command, it would be very useful to know their precise interpretation.
>=20
> Yes, I can confirm that we have a working controller that implements this
> command. However, I am unable to disclose any specific hardware details
> due to our company's confidentiality policy. I appreciate your understand=
ing.
>=20
> To facilitate upstream integration, I can give a concise overview of the
> implementation of the LE Read ISO TX Sync command on the controller side.
>
> The controller returns information about the currently ongoing CIG/BIG.
> - The sequence number is tied to the currently active CIG or BIG event.
>   It originates from the HOST and is extracted from ISO packet.
> - The timestamp is the reference point of the ongoing CIG (or the anchor
>   point of the BIG). It is taken from the controller's free running clock=
.

Thank you, this is very useful, and probably sufficient information for
implementation. I'll still need to check MT7925 behavior on this, but
it is probably enough to start with.

>  Partial btsnoop output:
>=20
>  *No.* -- *Time* ----------------------*Info* -------------------------*S=
ource* ------------- *Destination* --------- *Protocol*
>  46971 | 72.066457 | Sent LE Read ISO Tx Sync                   | host   =
           | controller                      | HCI_CMD
>  46972 | 72.067106 | Handle: 0xa01, SeqNo: 4408, SDU length: 60 | 44:67:9=
3:7e:00:9d | e4:e3:a6:e7:45:45 (INZONE Buds) | ISO Data
>  46973 | 72.067118 | Handle: 0xa02, SeqNo: 4408, SDU length: 60 | 44:67:9=
3:7e:00:9d | e4:ec:1a:c4:cf:01 (INZONE Buds) | ISO Data
>=20
>  46981 | 72.072452 | Rcvd Command Complete (LE Read ISO Tx Sync)| control=
ler        | host                            | HCI_EVT
>  46982 | 72.072462 | Sent LE Read ISO Tx Sync                   | host   =
           | controller                      | HCI_CMD
>  46984 | 72.074644 | Handle: 0xa01, SeqNo: 4409, SDU length: 60 | 44:67:9=
3:7e:00:9d | e4:e3:a6:e7:45:45 (INZONE Buds) | ISO Data
>  46985 | 72.074683 | Handle: 0xa01, SeqNo: 4410, SDU length: 60 | 44:67:9=
3:7e:00:9d | e4:e3:a6:e7:45:45 (INZONE Buds) | ISO Data
>  46986 | 72.074695 | Handle: 0xa02, SeqNo: 4409, SDU length: 60 | 44:67:9=
3:7e:00:9d | e4:ec:1a:c4:cf:01 (INZONE Buds) | ISO Data
>  46987 | 72.074701 | Handle: 0xa02, SeqNo: 4410, SDU length: 60 | 44:67:9=
3:7e:00:9d | e4:ec:1a:c4:cf:01 (INZONE Buds) | ISO Data
> =20
>  46992 | 72.077452 | Rcvd Command Complete (LE Read ISO Tx Sync)| control=
ler        | host                            | HCI_EVT
>  46993 | 72.077461 | Sent LE Read ISO Tx Sync                   | host   =
           | controller                      | HCI_CMD
>  46994 | 72.079450 | Rcvd Command Complete (LE Read ISO Tx Sync)| control=
ler        | host                            | HCI_EVT
>=20
> // sdu_interval: 7.5ms, Packing: Sequential, Unframed.
> // HOST transmits SDU, SeqNum =3D 4408, handle =3D 0x0a01
>  Frame 46972: 72 bytes on wire (576 bits), 72 bytes captured (576 bits)
>  Bluetooth HCI ISO Packet
>      .... 1010 0000 0001 =3D Connection Handle: 0xa01
>      ..10 .... .... .... =3D PB Flag: Complete SDU (0x2)
>      .1.. .... .... .... =3D Timestamp present: True
>      0... .... .... .... =3D Reserved: 0x0
>      ..00 0000 0100 0100 =3D Data Length: 68
>      Data
>      [Connect in frame: 6122]
>      Bluetooth ISO Data
>      Timestamp: 193973666=C2=B5s
>      Sequence Number: 4408
>      .... 0000 0011 1100 =3D SDU Length: 60
>      SDU
>=20
> // CMPLT reported in frame frame #46981 for the command issued in frame #=
46971=20
>  Frame 46981: 17 bytes on wire (136 bits), 17 bytes captured (136 bits)
>  Bluetooth HCI Event - Command Complete
>      Event Code: Command Complete (0x0e)
>      Parameter Total Length: 15
>      Number of Allowed Command Packets: 1
>      Command Opcode: LE Read ISO Tx Sync (0x2061)
>      Status: Success (0x00)
>      CIS/BIS Handle: 0x0a01
>      SDU Packet Sequence Number: 4407
>      SDU Packet Timestamp: 212355139=C2=B5s
>      SDU Packet Offset: 0=C2=B5s
>      [Command in frame: 46971]
>      [Command-Response Delta: 5.995ms]
>=20
> // CMPLT reported in frame frame #46992 for the command issued in frame #=
46982=20
>  Frame 46992: 17 bytes on wire (136 bits), 17 bytes captured (136 bits)
>  Bluetooth HCI Event - Command Complete
>      Event Code: Command Complete (0x0e)
>      Parameter Total Length: 15
>      Number of Allowed Command Packets: 1
>      Command Opcode: LE Read ISO Tx Sync (0x2061)
>      Status: Success (0x00)
>      CIS/BIS Handle: 0x0a01
>      SDU Packet Sequence Number: 4408
>      SDU Packet Timestamp: 212362639=C2=B5s
>      SDU Packet Offset: 0=C2=B5s
>      [Command in frame: 46982]
>      [Command-Response Delta: 4.99ms]
>=20
> // CMPLT reported in frame frame #46994 for the command issued in frame #=
46993=20
>  Frame 46994: 17 bytes on wire (136 bits), 17 bytes captured (136 bits)
>  Bluetooth HCI Event - Command Complete
>      Event Code: Command Complete (0x0e)
>      Parameter Total Length: 15
>      Number of Allowed Command Packets: 1
>      Command Opcode: LE Read ISO Tx Sync (0x2061)
>      Status: Success (0x00)
>      CIS/BIS Handle: 0x0a02
>      SDU Packet Sequence Number: 4408
>      SDU Packet Timestamp: 212356039=C2=B5s
>      SDU Packet Offset: 0=C2=B5s
>      [Command in frame: 46993]
>      [Command-Response Delta: 1.989ms]
>=20
> I hope this information will be of some help.
>=20
> > @Luiz: thoughts on the below?
> >=20
> > For setting Time_Stamp, I think there should be plan how userspace
> > application uses the new APIs to produce working sound on different
> > controllers, without having to maintain a quirk list for each
> > controller. I think quirk lists should be in the kernel driver.
> >=20
> > Depending on what hardware is doing, we could add driver quirks along
> > the lines of
> >=20
> > HCI_QUIRK_BROKEN_LE_READ_ISO_TX_SYNC, /* always zero / dummy value */
> > HCI_QUIRK_LE_READ_ISO_TX_SYNC_HOST_PREV, /* most recent from host */
> > HCI_QUIRK_LE_READ_ISO_TX_SYNC_NOCP, /* most recent completed */
> > HCI_QUIRK_LE_READ_ISO_TX_SYNC_HOST_SEQ, /* uses host seqnum */
> >=20
> > and should affect what skb is reported in hci_cc_le_read_iso_tx_sync(),
> > and if SOF_TIMESTAMPING_TX_HARDWARE capability is reported in ethtool.
> >=20
> > (Eg. IIUC Zephyr HCI appears to interpret LE Read ISO TX Sync meaning
> > as follows:
> >=20
> > - The sequence number is controller-assigned.
> > - The response corresponds to the ISO data packet that
> > the controller *most recently received from host*.
> >=20
> > This interpretation makes sense, but is different from my patch and
> > iiuc also different from what Luiz had in mind.)
> >=20
> > If no quirk is set but the command is supported, probably should emit
> > visible error in kernel log, or something along such lines, so the
> > driver authors can see something is not right.
> >=20
> > But knowing what is the precise hardware behavior for each
> > chip/firmware seems a bit involved, probably should have some testing
> > tool for this.
> >=20
> > ***
> >=20
> > What it seems userspace can do:
> >=20
> > Userspace application would check via ethtool
> > SOF_TIMESTAMPING_TX_HARDWARE capability to know whether controller
> > handles Time_Stamp in a non-broken way. (For testing, there could be a
> > switch to force it to use timestamps regardless.)
> >=20
> > It could then rely that the HW timestamp corresponds to specific packet
> > it sent earlier. It could assume that in its clock domain, the HW
> > timestamp is after SND timestamp, before COMPLETION timestamp, and
> > likely close to COMPLETION.
> >=20
> > Since it doesn't know the exact correspondence, probably it would
> > always have to ensure a few packets are always queued in controller.
> >=20
> > There also needs to be a way to recover from a situation where the
> > application is setting timestamps that are in the past in controller
> > clock domain.
> >=20
> > The controller does not necessarily send them I think, but will report
> > them completed immediately (after older ones get flushed from its
> > buffers).
> >=20
> > In this case LE Read ISO TX Sync timestamp would not advance, as no
> > packets get sent. Kernel would also not send HW timestamps to user
> > application in this case.
> >=20
> > If the application when it doesn't receive HW timestamps from kernel,
> > just increments its send timestamp by SDU interval for each packet, it
> > eventually catches up the controller clock, and receives HW timestamp
> > and can resync.
> >=20
> > Alternatively the user application may stop setting timestamps, in
> > which case controller shall send it in next SDU interval, and in this
> > case HW timestamp is received and user application can resync.
> >=20
> > Or, alternatively, controller will decide the clock is out of sync and
> > send the SDU regardless, in which case user application will receive a
> > new HW timestamp and can again resync.=20
> =20
>=20
> Thanks!
>=20
> Best regards!
>=20
> Tailu

--=20
Pauli Virtanen
