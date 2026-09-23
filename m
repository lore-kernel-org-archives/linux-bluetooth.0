Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48EE46E01D
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790157243; cv=pass; b=IZIZWNCq7rnqG6mpSvkqIeBcOtFbv4NRo+cfxhjJpCMsX+QzUSO1OhlTXngdhsXYkKi4J101c6hua0y5an3JcqSnvHJsy/TuXZWYZL9kOiKSgqUonyGVAXQ4MDaHNelqzy0GhK0sX07BkwkdIb3mzqXpxHl/1CyPOlTMXN/mhGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790157243; c=relaxed/simple;
	bh=AXXVx5XU+TB9L5Q8qwCBL6GPvaVFbZgEuiAnwyAkIQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLoMCEKhYyqz8mWtgYDec9Rn0jqeSk+YTPrgCLZ3+JczioL/8UndbzQ4+CxcnD/5f+1TFi1SlbNj8f4RfTDgEjhxgIz1hSHzR28nhONX6ob5TqRLKHmRik0B6hWZ3NqVYGQCJ4Pf+0hqE91mmhgPhvf+86PdcDB/BmYbU94MMUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=atN66gT6; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="atN66gT6"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85e68bdbcc1so7934347b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 02:54:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790157240; cv=none;
        d=google.com; s=arc-20260327;
        b=l/TaTBvgQerO9zXijF4CzNesg4GQQFnH2Ur0ym882Umc16BKpxxIITivEtbO5FgO5x
         6F7NMYVUAkV08Dis/2zwRTGYv/4J6vhWQ6IprOg/Tz96bscSkxRRrNx+/cPk/S5S3NBn
         uthFHurci9Pob8OaF7WTs/FdmOPjdL/zJZMi6vkzOzgzNSh03X/7ubqtKU3ZD5hF/IW4
         z5e1lZgu8pvTDmS6LsZ/P1dYRA6mIrseJe+b/Gy1eSr00uchoV+ePtP918jWfdQB6FjG
         VI+tkqiLpqdiCFRnASep5MZvXurQkpJ2ikNThyG9iniEzbUP/MUSwLFpAmuTJVXx3mRk
         PQRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=geMBxQ+5OMnk+zqMUGg+MADS8D5tDZgkCZyUCSU4ou0=;
        fh=BbROVSzcVzsIZo+IChsSZ57qq7rDZNHYckAmwiPHKa4=;
        b=ObOW3a6yw5XB20dJ0TbjkWa59goPdQMDQCGmoHc01VP6oXgMBOmEwNhf27nvlFFtBJ
         Xnro9cV122CAtmKWK4p+ikByvNQS7rKSYQ8KBiW16NJUyX9zdI7NFXfxGmpHysLAbUD+
         1xUwwLpu4X+/LwGjOpKWDKyHQNvncizYT0bUtf9cDJT+NkFkxdq+PGOR8oEhl14XzQUq
         A3jU96pqutAVAl8MewV1TZD90iw6Ktt1hXnT7NlDLWJNp4qVM85+Pw0ZS8LS6NahDeFc
         Qsi5s3PETFLf2eTpdu65JrbI4J+IwqjgXnnGZ6UdOOf5HBf/kOuMwU/rl3vi9WvP1Xse
         96RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790157240; x=1790762040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=geMBxQ+5OMnk+zqMUGg+MADS8D5tDZgkCZyUCSU4ou0=;
        b=atN66gT6bnNKklAIcVHzeU9pOFj/S3Nyb9J56sQEB305+t3NHsN5DYtD/xUA+Km3BZ
         7BiUFacVdWq7pT1113uWeiDYLrMZKY+C0Eht+VKYXu4pYLdgiyr/ptzLlIJoXzR5nBlL
         U62JRFkdJBvbv23nwif42YkmJUpcrv0Opq7D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790157240; x=1790762040;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=geMBxQ+5OMnk+zqMUGg+MADS8D5tDZgkCZyUCSU4ou0=;
        b=NfDOG8kKXdJch4yl4SZDY6SgSGEz6o0NtPWoBgvmlM1mCfhViKam11XMvfySdgNCmO
         7cFTtFU+N1OfWe/zZUs4poxL7PEU9SNu+jEC9ngrdFmQMqkUEYlgQRywNbZVCqKcUwRS
         amRvGEPfx8ON+/uboFgr8jRZOnUOjCkwiRWGOvg2+/TqfQyyBBHvYAkogtg+VzNx3ziX
         0g26vpTPvOu9/YOV4BNClmd/xNJhJxLFNMFRVQIvLVINnCPvZCi+KhMC5CGgOgREyXoD
         YybIub+Ja9xeclOPW2wforr5IiC0hmqRU9hanWZkNokzD4Ypo9np8sSOIYAUl//4v6rF
         FFSA==
X-Forwarded-Encrypted: i=1; AKwUvBwfhkUuvkhhGbp6ncAYA0toMvnGguZWJDwOByznu3/7otFOQKO+Es3Fyp+ttvZXzglBHMnF10ZxWBVn3CT8Sdc=@vger.kernel.org
X-Gm-Message-State: AFuF++lbKqCVvTTxIZ2XQZhtk867yGzj8hs3ZxDO0hdes+U9mAE8QZDk
	Mnsa6Fb0Rb3Ykg5r6XnHEi6FqkdS17+AHtuZKGtp1QVDMjIxwI+CtcHnNu1aJxuXcm69X3eXTSm
	WyyqIuOnEVE/8R4J4+CGT81Nmm9YZOgMXM/G4WGiw
X-Gm-Gg: AYBFou3/aUYbA+2Z6UPKXe75an63aWzmUf9aJAgHjYDk0rxgN0v6Go7ke0QqJXsIEt7
	6O14F/CfK5xF7mMvvo+HfCtgpD2B6x3kT/pm93aPdt6Byymtwb5B06rLb+YU18JUNpcU8c25+rX
	yww4lOrFxW7Io9lce3QuEKCA7FtP51T+0W70m3KrMKF0eTN64k6b4cU04OvneumIAz+octOvjz2
	8oOsWNJFY2XZH5n/06xssqAyFKk+NIXK/Ia3JtLYnttXBEFLf8TnFLIh6f0VQV7KF0CuhXtm7G/
	Dud1f6R2uNluX57ptxi2H80Thixqv1If/2Rsx46JNu0LuLVJfU5O9iFQ
X-Received: by 2002:a05:690c:7011:b0:89f:4c20:73d5 with SMTP id
 00721157ae682-8a457891187mr16275917b3.6.1790157240628; Wed, 23 Sep 2026
 02:54:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dac8ddf07cb1bb79c70d5a516f0ff7baf41eb462.1788507854.git.liujiajia@kylinos.cn>
 <dae8ba2edf89e35c44748912aa466f3b9c8df75b.1788507854.git.liujiajia@kylinos.cn>
In-Reply-To: <dae8ba2edf89e35c44748912aa466f3b9c8df75b.1788507854.git.liujiajia@kylinos.cn>
From: Ying Hsu <yinghsu@chromium.org>
Date: Wed, 23 Sep 2026 17:53:49 +0800
X-Gm-Features: AcwNN1XyckWCvbLuUPclr9L84lJ4nL1-DpksFwXIj_myJJABSYaeMKkWJtFwAPA
Message-ID: <CADwQ6b6626zB1+Ms5JOSjp3fP0RJrE5BiQFqMh8Ra1c_QFVgmw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] Bluetooth: btusb: Fix leaked runtime PM reference
 in btusb_reset
To: Jiajia Liu <liujiajia@kylinos.cn>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Archie Pusaka <apusaka@chromium.org>, Abhishek Pandit-Subedi <abhishekpandit@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Jing Cai <jing.cai@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Chris Lu <chris.lu@mediatek.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Another way to address this would be to let the USB core handle the PM
bookkeeping instead of doing it in btusb.

On Fri, Sep 4, 2026 at 4:04=E2=80=AFPM Jiajia Liu <liujiajia@kylinos.cn> wr=
ote:
>
> btusb_reset calls usb_autopm_get_interface to resume the device
> before queuing a reset of it, but never calls the matching
> usb_autopm_put_interface.
>
> usb_queue_reset_device ends up in usb_reset_device(), and since
> btusb provides no pre_reset/post_reset callbacks the interface is
> merely unbound and rebound: the interface device object survives
> this cycle, and so does its PM usage count, which is not cleared
> when the driver is unbound.
>
> As a result every reset permanently leaks a PM usage reference,
> preventing the interface from being runtime suspended again until
> it is unbound.
>
> Set BTUSB_RESET flag before usb_queue_reset_device so that
> btusb_disconnect drops the reference. If the flag is already set,
> drop one reference.
>
> Fixes: c9209b269afd ("Bluetooth: btusb: Introduce generic USB reset")
> Assisted-by: Claude:qwen3.8-max
> Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
> ---
>
> Changes in v5:
> - no change
>
> Changes in v4:
> - do not return if BTUSB_RESET is set in case the first reset failed.
>   (sashiko)
>
> Changes in v3:
> - handle multiple reset requests int btusb_reset (sashiko)
>   set BTUSB_RESET after usb_autopm_get_interface. If the flag is
>   already set, drop newly acquired reference and return.
>
> Changes in v2:
> - Fix the race window (sashiko)
>   set BTUSB_USB_RESET_ACTIVE flag before usb_queue_reset_device.
>
> Changes in v1:
> - add usb_autopm_put_interface after usb_queue_reset_device
>
> ---
>  drivers/bluetooth/btusb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 6f7946709266..61c18402911a 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1068,13 +1068,15 @@ static void btusb_reset(struct hci_dev *hdev)
>         int err;
>
>         data =3D hci_get_drvdata(hdev);
> -       /* This is not an unbalanced PM reference since the device will r=
eset */
>         err =3D usb_autopm_get_interface(data->intf);
>         if (err) {
>                 bt_dev_err(hdev, "Failed usb_autopm_get_interface: %d", e=
rr);
>                 return;
>         }
>
> +       if (test_and_set_bit(BTUSB_RESET, &data->flags))
> +               usb_autopm_put_interface_no_suspend(data->intf);
> +
>         bt_dev_err(hdev, "Resetting usb device.");
>         usb_queue_reset_device(data->intf);
>  }
> --
> 2.55.0
>
