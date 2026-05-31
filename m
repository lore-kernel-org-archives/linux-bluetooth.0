Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0649A34AB03
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780250849; cv=pass; b=B390VcJKEBKmHnxVV5E2kq6c86ITeSALQbdVXF1H2EEBBbqAfOeR3gdukw83w/9TNTRLiUSv2dumkhhSG3DrqmnVqQ+H4hP8dJZt8wA8CediYtAiyk79Q/dua/zRXxGtRZZoYBvKQAzGQrcSg4iID7ag50Xe0UK51NomwLYvGII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780250849; c=relaxed/simple;
	bh=+K5QVbX8HvjyoBqNa+k4qZFMfA9HY406BM+t9ZGHs9w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ESnZl/RsUpFVZS1LmHfKjVTdRNBvhuDWCzT8pTMtSrnt/YwNjGGosMR2e/vsRq6xoi+07k1hOk7auwyV6e5QVtOEZ0+KrfWTREusKALzN8qP3CTDY44g+lKabVh2OtbV/z0HE+uaJjGnfZ7xMzmnnBogjtVj4vXdwMJrPKjNhRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gdu2K2Mk; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gdu2K2Mk"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-69df5352d0eso2436616eaf.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 11:07:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780250847; cv=none;
        d=google.com; s=arc-20240605;
        b=WPbssmFyNsV+xA5Rjyyu81sUtOhVudyYBrLXF76Tc35BmEYwxVy6V9EohKsK7GNCQ5
         xmiyxvcaDAXG2GPnUFEd+vzEsAISMUYHHpaTBWcusNE4J0YDHZo9tYWmcDF1MGxRMsx3
         qt3pFo2dTF7CbcvYt8m0Etgw/uul+eCWId8wLrqnRCT02Wpo5Z3GZXciGqAEbRj5Jwle
         lskuegCGB7eLrl1IXuFqhLmBD+CoFLiIV0Rts1DjUQJr6Q4I+723t9A2P98RLdABsZXs
         w96FdkTdKNEmgXbzqpqnvxy/jskXtACdzFT9Am3r2DWcgFQja1vYHR7ojEQvvbKBR648
         B80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:dkim-signature;
        bh=LZc97weh0eWBhJyNzOmbeJErfp0SaAmgASjtQQ6XYcM=;
        fh=dqGTiKvLlZQS89kfQwwopR70O7YdgQoSdGhR3YmT0J4=;
        b=ROwYWlXXmp4jCC9ZHxYa07Tr30XKkc3d2ovmoROLFGJT/VAjnJPstAkxoGcvIpcw3f
         UUBT0sB5QQeOq/xIpORQr0Mead4BcjnWV/HhADG36bnWHOnacI7aL8fr0hOd+wfZQTw2
         Hrwap48UFVXGQaRBHxAdRxKu/YwsFZFqz6y7m+asFTrcHc3euDpWcOb4mYfM4AjLR3sm
         Ozo8s/c3Xm0FIHEQ34K3I2aeuKQ90LYB7H/yfU+SvqKqwNYAdtkJwfUZBDVJYAKN0v+S
         +x1SAFByWpuxg1YX9geh3eaq0NryOa8K3OA1OQi2eWpjxGDXXjC6y5hmqco5UUPYubvi
         QXiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780250847; x=1780855647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LZc97weh0eWBhJyNzOmbeJErfp0SaAmgASjtQQ6XYcM=;
        b=Gdu2K2Mkd6uqlctixN/lE7A13yq9qJIdUzE8DGSYRiyHArgWrKfJYj+pL4+tZeGUSQ
         kLPMZE19J8/wOG8l5X/3gJqZjVQWLLsReFXVNIO8HechT8ETteIDGjr+IWR6C8F3dAtT
         FzubDR6fsgUXVBFYgTdu+wz7z/rUiG59YaNJQAC8FYoiLltVmghYK4JYysiFlsp6Fr4Z
         DKoXv8tyC+8KgC2leInTTvXxuGWl9cymSSAYyosIYGj963SuTyInPpQ3oEz8TFsDbQWj
         /VbDQrC9MGBPe5/Od6WIcXhjUH0LfL+oCJn0SOcZhb6WFXT6SZbIUXcnqvDzqJPIyhX7
         s8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780250847; x=1780855647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LZc97weh0eWBhJyNzOmbeJErfp0SaAmgASjtQQ6XYcM=;
        b=XuJgD/69JXpy+FIiY3W9GYgnoVoVey3IwguzoMZJzxDqXzzi0mgo0AXUtw4fbyg1yJ
         y5F6dclH/vyyLLwBAgdH/CTH1rhgpYQMxOPHUmkM0eNIRjw3Qd1EI0uTQLR9H5k+xfqU
         HaA+9XtzIhatQ4vGvnv9pOLCzZPzDwXm1WDz7GITsPtQ5cb5ySbWw1XsRXyzh9gt19yq
         GCv3ucxHw5WwSx872D5VvcBCYqqDxYIvQvPTJc9P57kdemzHLpbwfJtcoJCOreUn/b0T
         goAtFqZaXudYlGlaTa9w/av+zLbTbk6AViwLoHq4mbS3MTsq2qa2cgl1sfuMznYl962I
         LGAg==
X-Gm-Message-State: AOJu0Yxk5maJt0EkKuB0MbpgqJzV65C/t0JX5+1aHsWGXixOyEJUcGR1
	I2U5rBEFIJMWYzS6+6BQ3CWOBpDsj6Dp5qkhapNf5oeZKu2qDu1SD0/S/kANH/M93ZpdmMq3zta
	Q0Kkx4CZ/wCl/+K9SNCmUqXOtwVJ71hHjQKI=
X-Gm-Gg: Acq92OF9b+8nPIu0OBpHWB0S56OkJRxGumqKSgCfG2kx1zJpNP9RDhzfE1k26dJpsSi
	5l+g951KlIh5FNtaR9CfmTdMfoqXNHcUe32Ws2mhybyHgAW/AEQk+AntNyoIEBUPnwCKP5Xi68z
	9pVaaP27/DmTB6aCwmHSo9kFwAq4p1CZkZIPzIyghBdqCJf1MPomCJC8inbNsb8c+8VytI6xPo2
	1M+VqmbNvmftLpAIhNkzL6r1nYthMe+5FdRjjX15s5VwyTph0U1OzrLP1zgUWrSS0zKIfh3AAhI
	0mWRsv5qRLwQ3Q==
X-Received: by 2002:a4a:ee05:0:b0:696:1dbd:9827 with SMTP id
 006d021491bc7-69e102ca138mr3796741eaf.12.1780250846874; Sun, 31 May 2026
 11:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: messinadm@gmail.com
From: Danny Messina <messinadm@gmail.com>
Date: Sun, 31 May 2026 14:07:15 -0400
X-Gm-Features: AVHnY4KtqnTC_wGdgzieSiM0cOeasEIlvg-WuzhRgGiQh24FA77vp_PrJCZohtI
Message-ID: <CAJAa45g30APLE4avbWg6EfkcUATR1rDh7a2DOM6dBOYbdF-a1Q@mail.gmail.com>
Subject: [PATCH] Bluetooth: btmtk: Fix MT7925 WMT command timeout due to sleep protection
To: linux-bluetooth@vger.kernel.org
Cc: peter.tsao@mediatek.com, marcel@holtmann.org, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

  The MediaTek MT7925 USB Bluetooth device (0e8d:0717) fails to initialize
  with repeated "Execution of wmt command timed out" errors:

    Bluetooth: hci0: Execution of wmt command timed out
    Bluetooth: hci0: Failed to send wmt patch dwnld (-110)
    Bluetooth: hci0: Failed to set up firmware (-110)

  USB capture (usbmon) confirms WMT commands reach the device =E2=80=94 the
  Control OUT transfer completes with status 0 =E2=80=94 but the device nev=
er
  responds on any endpoint. The control IN polling URB returns zero bytes
  indefinitely until HCI_INIT_TIMEOUT expires.

  The root cause is the MT7925 BT core's sleep protection register
  (0x18011100, bit 1 =3D SLPPROT_BYPASS). When SLPPROT is active the BT
  processor ignores incoming WMT commands.

  Two additional issues compound this:

  1. After repeated driver load/unload cycles without a hardware reset,
     the BT subsystem's WMT state machine becomes stuck. A subsystem
     reset via btmtk_usb_subsys_reset() restores it to a workable state.

  2. After btmtk_setup_firmware_79xx() activates the downloaded firmware
     (which ends with a 100ms activation delay), the chip re-enables
     SLPPROT. The subsequent FUNC_CTRL WMT command therefore also times
     out unless SLPPROT is bypassed again.

  Fix this for dev_id 0x7925 in btmtk_usb_setup():
    1. Call btmtk_usb_subsys_reset() to clear any stuck WMT state.
    2. Set 0x18011100 |=3D BIT(1) before firmware download.
    3. Set 0x18011100 |=3D BIT(1) again before FUNC_CTRL.

  Tested on a System76 Thelio desktop with MT7925 PCIe combo card,
  USB ID 0e8d:0717, kernel 6.18.7.

  Signed-off-by: Danny Messina <messinadm@gmail.com>
  ---
   drivers/bluetooth/btmtk.c | 33 +++++++++++++++++++++++++++++++++
   1 file changed, 33 insertions(+)

  diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
  --- a/drivers/bluetooth/btmtk.c
  +++ b/drivers/bluetooth/btmtk.c
  @@ -1326,6 +1326,24 @@
        case 0x7922:
        case 0x7925:
        case 0x7961:
  +             if (dev_id =3D=3D 0x7925) {
  +                     u32 val =3D 0;
  +
  +                     /* Reset BT subsystem to clear any stuck WMT state =
*/
  +                     err =3D btmtk_usb_subsys_reset(hdev, dev_id);
  +                     if (err < 0)
  +                             bt_dev_warn(hdev, "BT subsys reset
failed (%d), continuing", err);
  +
  +                     /* Bypass sleep protection so WMT commands
reach the BT core */
  +                     err =3D btmtk_usb_uhw_reg_read(hdev, 0x18011100, &v=
al);
  +                     if (err < 0)
  +                             return err;
  +                     val |=3D BIT(1);
  +                     err =3D btmtk_usb_uhw_reg_write(hdev, 0x18011100, v=
al);
  +                     if (err < 0)
  +                             return err;
  +             }
  +
                btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev=
_id,
                                      fw_version, fw_flavor);

  @@ -1342,6 +1360,19 @@
                if (err < 0)
                        return err;

  +             /* Re-bypass sleep protection after firmware
activation for MT7925 */
  +             if (dev_id =3D=3D 0x7925) {
  +                     u32 val =3D 0;
  +
  +                     err =3D btmtk_usb_uhw_reg_read(hdev, 0x18011100, &v=
al);
  +                     if (err < 0)
  +                             return err;
  +                     val |=3D BIT(1);
  +                     err =3D btmtk_usb_uhw_reg_write(hdev, 0x18011100, v=
al);
  +                     if (err < 0)
  +                             return err;
  +             }
  +
                /* Enable Bluetooth protocol */
                param =3D 1;
                wmt_params.op =3D BTMTK_WMT_FUNC_CTRL;
