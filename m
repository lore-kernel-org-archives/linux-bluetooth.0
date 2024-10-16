Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84B516E86F
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729104683; cv=none; b=LqeEbH8Jb9g5Xx/FVgDsoNGmDXwYNwJXC/yYpP5OiZgd5zOg7ZByq0B+rmPndduZnkFFinLC+jY9EcoKxJ0MFb+XRXkC8WSwvymspcMUwtSQOCD85tstI53KOBQF0tVvpMeqjbNwgwO6LQnrzNd5AK50RWRS7ljxVlkWhb7tJGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729104683; c=relaxed/simple;
	bh=OS6e+CjkI4NyGpW3tC62Mr63Mc7IIVLhDs9F9msjJbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJ30HrvIjD8j64jFblBK44Fw8cKiVDrV69msoAT5Yme1W6QEuah3g9CzrL6Si65Hl2iOK1bbKuHpHzYX7q2LMof5TUanrnO2IwF5aEM/yYY1dxK77YJ0/3kmb2lxcGTz64yJdKQU651ZxB8osyyUF8571GdJSXIyeTuRTiBtFDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9EzXYRZ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9EzXYRZ"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso2730941fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 11:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729104680; x=1729709480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdmqZ1gid2nrcqceKA2afnlwQTBt0CD1Z9NPEggCkx0=;
        b=f9EzXYRZVgCLrfVDxEOtDkdFS4SOfnvw9r9/zAmyFHfDnmFa7PpuCcqycofYli0JjI
         YnHV1CWGI1huK/fezcOMyojwMErZWepm1SjTtXKMqTE7YnVWuk24WyOGeSvdYoMo6S2W
         Nu3j7lTHgNPHzpEYl601fcRjXQ8GXl4pCmXq85Fzlef1ZH+pdtW+u2ZZxYuKkxRxZz2q
         8GBY4MB5P404lxYBrpv1YeFRgNDOScseWwwLs4t3pVH2RZpmJB+PXrG9Ej0LbtCOzrER
         g2PxmeZFtGcR0GZeU6rmhmb7FaiqRIazcCpGaLGtXiTKAdQJOe56BLuCmAX3GvTGHTaf
         TKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729104680; x=1729709480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdmqZ1gid2nrcqceKA2afnlwQTBt0CD1Z9NPEggCkx0=;
        b=ixoUg7mZEVuP5m2YlBSXEGxj9A1tchtdOpPBNciy5mn0bgTfsaBiqMaizkw+OUeHtL
         kD7L9WUSGzvgsFcDlV5pBhyfHm3QadZKfa0uwkaZgJ1ezUMgmY7mXm5US88jq1gbODN0
         mAQsS00i/x7bn5mWSwjz5m16kdyA3mymv/G9YNQ6Ea716naiJMOu4aTgth0TMf/iMvJp
         aEueM3UB4UCU3MHBSbyNvnSAim4iYOLOfthExEwFJJCZxlGf3uWfcOQ4dJJrYTXmsG1h
         J5wkqGz0fjfWAPRV45XOlVzw8tWEaxw0mGn4FLgfIJsbmC7RLvKi+O0lPx9txjdwxwb9
         v29Q==
X-Gm-Message-State: AOJu0YyOF9nKPgedKskdzR1WeWFEjaH5Apoj8gxODWymlJTujmk5mv93
	GSIEm6bJZwhU5pxjYkVFXGDk47DtsvTMhw/5QRa2PDkq70ZQhVLilutfFYOQythPGw8wLAHwNT8
	4UXKlEb25W8aRrLFpxhz4MVwLVuNeAX/rgjs=
X-Google-Smtp-Source: AGHT+IHnsW/WrmGed+aZGS2xwAc++xTFrRDhA8itVumE7xAHjbKsfD1UOold50/Kz8ZkDxhzwL/yB5M7Z3l/yyYaHVc=
X-Received: by 2002:a2e:be23:0:b0:2fa:fdd1:be23 with SMTP id
 38308e7fff4ca-2fb3f2c7269mr96104251fa.28.1729104679393; Wed, 16 Oct 2024
 11:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhaqxrW=0g9E2qWdEXTGkjv5cxZLAu-6UGDO5tGLxZDdQXvJg@mail.gmail.com>
In-Reply-To: <CAAhaqxrW=0g9E2qWdEXTGkjv5cxZLAu-6UGDO5tGLxZDdQXvJg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 16 Oct 2024 14:51:06 -0400
Message-ID: <CABBYNZKu465GRDOCGepyckgrk4CZF4tOwbzUN6HQyG8ZKfg=8w@mail.gmail.com>
Subject: Re: Bluetooth not working on 13d3:3585 IMC Networks Wireless_Device
To: Grimoire April <aprilgrimoire@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Grimoire,

On Wed, Oct 16, 2024 at 3:28=E2=80=AFAM Grimoire April <aprilgrimoire@gmail=
.com> wrote:
>
> Hi. I have a laptop with an integrated bluetooth adaptor recognized as
> a usb device. However, it fails to initialize properly. Searching for
> other instances on bugzilla, it seems others had success with
> 13d3:3585 adaptors.
>
> (base) =E2=9E=9C  ~ sudo dmesg | grep Bluetooth
> [    0.422244] Bluetooth: Core ver 2.22
> [    0.422254] Bluetooth: HCI device and connection manager initialized
> [    0.422257] Bluetooth: HCI socket layer initialized
> [    0.422261] Bluetooth: L2CAP socket layer initialized
> [    0.422265] Bluetooth: SCO socket layer initialized
> [    0.530052] Bluetooth: HCI UART driver ver 2.3
> [    0.535346] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> [    0.535355] Bluetooth: HIDP socket layer initialized
> [    3.556068] Bluetooth: hci0: Opcode 0x0c03 failed: -110
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218472
>
> I updated to 6.11.1 and the issue persists.

Well it looks like the reset command is timing out, but the issue was
originally the PID:VID was not supported in btusb so perhaps something
else is happening, perhaps another manufacturer that don't support
short-transfer which was introduced by 7b05933340f4 ("Bluetooth:
btusb: Fix not handling ZPL/short-transfer") so try reverting that to
see if it helps.


> Thank you.
>


--=20
Luiz Augusto von Dentz
