Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FA0372049
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418612; cv=pass; b=ubXN6YT/O3h82x6f1Eb4PuRUwN+HoW0b5cl7WuxAb5nycB4cwo9DH4NZZgzrxrOeEY2lVnrvEOXdTgXSgC3GupBnsD5UFiQybrgE/jK11ei4A6pScuFp9imra52nPu6CZyH29b3sW98Z/96LCS1986XJXA/l7TEWdQ8t9LwkbdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418612; c=relaxed/simple;
	bh=ef67Cs5mlDD4nA81Y2zzgtZB7fbIa2D0X6VcANU5/M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdsszDP8LhzveYSG5P2KU21KSA1k8q218z9FJCL4YD6dhCDiT/Quwu/zMMdD3bsoqRCbseBRdUvOcjA3wLOx/047Qkl1Wx5t0A80wVQYIUchvX0Ldkv30Z73znlisa/u4tUYPeuU94Aagk5OAzlsyPuKIDxQyiI0eJGVl6mc3qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZvIZiyP; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZvIZiyP"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7e8833c99fcso14642217b3.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 09:43:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780418610; cv=none;
        d=google.com; s=arc-20240605;
        b=CJUmuKeV5KumXitxivpbVgs3G0MOGCn0DyWJx5eBv+5/7Oh+o+lHnQD5cy2MDMch9+
         0DSCIeAfTlhPTdEaw54f1CSnVxZ3f6oU+b463JA0QfNV7EKBEfYV3kxBN1ZFf5BONjwY
         eDxskzoe8j3/G6+1EBGnak8RLvEXbck+6sTcHWFE+dFiJw1bziVvHsLwCe6fY2GCCrDy
         DHp7MzQ75AM0Muxy8ANrDVSxq8S+7BlHAjScVG93VmxfTKsx/QhW/nfTNDO5wlsDkTAq
         aDxvhDrSBZuJDiTboxS8NLPyVSGhkdU1IA+7GPlrROlhHKh9/OMT6vguCR7SVW4peYdL
         ceHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K7/yR/6yJQMUOUNFEFlQIz6R4csXrk7PwebzPFHLL6A=;
        fh=99aSovJA+BhU7KmfKSo8sR8jURIHW/fHE+XHpqSCLDQ=;
        b=j2avFA9AvfykZY1t2ySbAtTCaLOzAk8ibBsnA8RGho3TsFXVlT+mRUng7X+5ds8KcU
         glggI596wruHX+CTmKaQjRf6p8qsCM9OJje3WhZ55er/JqCVhAbva+BQRSQdn5Jvfcr+
         Tc86A4M+ruXBV5DZMWCHmaoD9xfsHkj38LiH12Qw+oytEu/ufbKulOKAOasrqJHbxuur
         jdNOSQev68R/ShGGUCPQflX+C2D3vzNRuNs/9yQjmxQyn8dMssSJrZU69yxYFuYZhDVW
         7BQYXsX3SHfwKKFWYCn2+OO2BF+LAlSrNqGorRWpMSzhCfT5aIzflz8PWhI7Ehk3jFMm
         mj2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780418610; x=1781023410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7/yR/6yJQMUOUNFEFlQIz6R4csXrk7PwebzPFHLL6A=;
        b=KZvIZiyPUVCmPoUV7QaE+9hjQKd7JVuCRDROqwWYfOvhbZfdjhl10CgLeHgHY0UzA6
         gAoDC+k98TjlYIQ+vXzqfAKBwuaSnfJvbZ3QFMUJqcVJpWBDMmNr/PrrSu7mG1XgcOSL
         HsBKHm5/AshHaLe6uogpOgBL9FwvUQ7fOCnJYFVI1E6mTo+X+qgQKAandLhAKcEm3Gqr
         fI7A+qxZPLxnk8McGtyKouReHkmL14SsnYZ/Az3pss9g/WxwpfIdlIDjGxMhPJwDklBg
         C1aWkf85YmOjLvUodSQmM3kAkzVOVf6GM/tqh7GpfeIc8WDDuIXk/y4/LZ1Vi/JFMZ+a
         yqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780418610; x=1781023410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K7/yR/6yJQMUOUNFEFlQIz6R4csXrk7PwebzPFHLL6A=;
        b=VoNVwk/BThzog/+NiTg6KhGANrTRCx9sPCDKW5n9Xqs796OEF2eElxuCLF1R09rvW7
         uvXv4ku1xjTuCR1mIc8NchOeXBZ3+vh5VS/f7cE7t6dCQem0OQ0QgG0wMr8Qydkl+7Pt
         kuWDr6VQclfUMpIuTWrb/lR9Qf9rgl+rr4TFCNfNaRutS1b+TFkpLppH4dvwGSflCOaw
         hTxVjsGWP2eIr9mg5Odw9ykS1omyvX9A0Ko4/2QZAW8thDd8VxDEGzRI/5t5ZPXnFbde
         6QoJYa8PAS2b9iTAkPzDJGvL2Wvbn9x37NCXbEFU23aiC0akszqnS+16yFCj7XjujmeU
         D8Mg==
X-Forwarded-Encrypted: i=1; AFNElJ+UrQQ6CTiMBcr5+mXXhfMXwGLol84ylas5r9Ioo6rwhdQbLfa7vUft65QtS4Kl1foYEIEk0GiWrVXWzHG1uM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4sz0moSunkXGGldJytdbU7c1eDBEAkRBgyO3XEBCzIIy/IFlS
	aAhQWheIKZaifOChfe1mdOxehtODt8Kk6EmE2q9CKOXLdPdyBKOZrrbWcjW1t/lzKrrOwMlxRfu
	Op2e7hUDBTazoj5cBniZ1rkSdhrfDxrY=
X-Gm-Gg: Acq92OFdKi2m4vmLYTOpZ+c+gaIpbp2uLGZVY4X/9NhDEAWomiOJb5D36v8Ukf+Yc82
	FI4N0V3/VVd4SEprzi6+4cQ2gqVra2fpRT4CguSPcuArMuMz1xoKIpY75bKufYMaSXND+S+iyMa
	tJd9sM7cMXbatg3yC7rHGZzXndKcA/JToZlPiTL6jJhNKDBkugk74JEJnBX4esY++Il/thjJtiK
	LvGPPZuhfDMF+yG5LtnLr0AUJdQjZ4XzxWC27eVsAgFeEg0QGa7vJAjr8wvSHEyBgtO9IKLuDU8
	6EUrkDPHg/sN55ZicK8/y6y+4mxgmscnJrE1bU52MJoJLHXT3YBdMDAxUHiFPZlPlawjcCj3fyX
	WSxP5gvnS0wcRXu8=
X-Received: by 2002:a05:690e:130d:b0:660:40a6:4c9f with SMTP id
 956f58d0204a3-660d6119435mr534727d50.54.1780418609787; Tue, 02 Jun 2026
 09:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602070032.51248-1-liujiajia@kylinos.cn> <fc5c142e-3187-42a2-af4d-9103858da93e@molgen.mpg.de>
In-Reply-To: <fc5c142e-3187-42a2-af4d-9103858da93e@molgen.mpg.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Jun 2026 12:43:17 -0400
X-Gm-Features: AVHnY4IHiw5zLo2H9IcCVSz1fPQ2W3Z4a5Ga-dTuzozBZt4tDq1rMK-08mFBwyY
Message-ID: <CABBYNZK1GLGu+xdKng3O4b=NrNwxB6ZAyfXSn8DE4WptXN=5CQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_event: fix simultaneous discovery stuck
 in FINDING
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Jiajia Liu <liujiajia@kylinos.cn>, Marcel Holtmann <marcel@holtmann.org>, 
	Brian Gix <brian.gix@intel.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jiajia Liu <liujia6264@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Tue, Jun 2, 2026 at 10:41=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Jiajia,
>
>
> Thank you for your patch.
>
> Am 02.06.26 um 09:00 schrieb Jiajia Liu:
> > When hci_inquiry_complete_evt is called between le_scan_disable and
> > le_set_scan_enable_complete and no remote name needs to be resolved,
> > the interleaved discovery with SIMULTANEOUS quirk gets stuck in
> > DISCOVERY_FINDING. le_set_scan_enable_complete does not check inquiry
> > state. No one sets DISCOVERY_STOPPED in this process.
> >
> > Add state check in le_set_scan_enable_complete and change state if
> > the state is DISCOVERY_FINDING. Tested with AX201 (8087:0026) in Dell
>
> =E2=80=A6 change state to DISCOVERY_STOPPED =E2=80=A6
>
> I=E2=80=99d add a new paragraph for the Tested part.
>
> > Vostro 13. Discovering disabled MGMT Event below is reported when
> > running into the above condition.
>
> Thank you for sharing the test device. Could you please document how to
> get into this state exactly? Some Xiaomi device?

What are you talking about here by saying Xiaom devicei? He literally
said Dell Vostro 13, a laptop, and this is a local only procedure,
there is no remote device involved here.

> >   @ MGMT Command: Start Discovery (0x0023)    {0x0001} [hci0] 10885.970=
873
> >           Address type: 0x07
> >             BR/EDR
> >             LE Public
> >             LE Random
> >   ...
> >   < HCI Command: LE Set Extended Scan Enable    #38205 [hci0] 10886.131=
438
> >           Extended scan: Enabled (0x01)
> >           Filter duplicates: Enabled (0x01)
> >           Duration: 0 msec (0x0000)
> >           Period: 0.00 sec (0x0000)
> >   > HCI Event: Command Complete (0x0e) plen 4   #38206 [hci0] 10886.133=
295
> >         LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
> >           Status: Success (0x00)
> >   @ MGMT Event: Discovering (0x0013) plen 2   {0x0001} [hci0] 10886.133=
414
> >           Address type: 0x07
> >             BR/EDR
> >             LE Public
> >             LE Random
> >           Discovery: Enabled (0x01)
> >   < HCI Command: Inquiry (0x01|0x0001) plen 5   #38207 [hci0] 10886.133=
528
> >           Access code: 0x9e8b33 (General Inquiry)
> >           Length: 10.24s (0x08)
> >           Num responses: 0
> >   > HCI Event: Command Status (0x0f) plen 4     #38208 [hci0] 10886.141=
333
> >         Inquiry (0x01|0x0001) ncmd 2
> >           Status: Success (0x00)
> >   ...
> >   < HCI Command: LE Set Extended Scan Enable    #38242 [hci0] 10896.381=
802
> >           Extended scan: Disabled (0x00)
> >           Filter duplicates: Disabled (0x00)
> >           Duration: 0 msec (0x0000)
> >           Period: 0.00 sec (0x0000)
> >   > HCI Event: Inquiry Complete (0x01) plen 1   #38243 [hci0] 10896.383=
419
> >           Status: Success (0x00)
> >   > HCI Event: Command Complete (0x0e) plen 4   #38244 [hci0] 10896.394=
378
> >         LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
> >           Status: Success (0x00)
> >   @ MGMT Event: Device Found (0x0012) plen 22 {0x0001} [hci0] 10896.394=
497
> >           LE Address: 88:12:AC:92:43:69
> >           RSSI: -101 dBm (0x9b)
> >           Flags: 0x00000004
> >             Not Connectable
> >           Data length: 8
> >           Company: Xiaomi Inc. (911)
> >             Data[0]:
> >           16-bit Service UUIDs (complete): 1 entry
> >             Xiaomi Inc. (0xfdaa)
> >   @ MGMT Event: Discovering (0x0013) plen 2   {0x0001} [hci0] 10896.394=
506
> >           Address type: 0x07
> >             BR/EDR
> >             LE Public
> >             LE Random
> >           Discovery: Disabled (0x00)
> >
> > Fixes: 8ffde2a73f2c ("Bluetooth: Convert le_scan_disable timeout to hci=
_sync")
> > Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
> > ---
> >
> > Changes in v2:
> > - move the handler to hci_event.c
> > - remove unnecessary bt_dev_dbg
> > - update commit message
> >
> > ---
> >   net/bluetooth/hci_event.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index eea2f810aafa..1cd5f97daafe 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -1769,6 +1769,13 @@ static void le_set_scan_enable_complete(struct h=
ci_dev *hdev, u8 enable)
> >
> >               hci_dev_clear_flag(hdev, HCI_LE_SCAN);
> >
> > +             if (hdev->discovery.type =3D=3D DISCOV_TYPE_INTERLEAVED &=
&
> > +                 hci_test_quirk(hdev, HCI_QUIRK_SIMULTANEOUS_DISCOVERY=
) &&
> > +                 !test_bit(HCI_INQUIRY, &hdev->flags) &&
> > +                 hdev->discovery.state =3D=3D DISCOVERY_FINDING) {
> > +                     hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> > +             }
> > +
> >               /* The HCI_LE_SCAN_INTERRUPTED flag indicates that we
> >                * interrupted scanning due to a connect request. Mark
> >                * therefore discovery as stopped.
>
>
> Kind regards,
>
> Paul



--=20
Luiz Augusto von Dentz
