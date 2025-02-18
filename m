Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D673A1B6
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 04:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739852676; cv=none; b=qqoa9K3A61QHLVc07hxbGu3ZIoUYSoTAuDbvRI62ATVJUrTfvGCUpEGApL25MXHwC426NwWrXHdAIl2fZCN+QeJXjz1PfoAe0cIL6HgYhPx5C0prkbec4C7/VdrrID1yLYpQ/mZAHSiIHTA1GgoRZdjkS+GyXLVrKg31YdLaWBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739852676; c=relaxed/simple;
	bh=fw/Kh4vFp+mf2JGXgSm3+iHZaIffmUvILlDOJqLbf5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQbYO7Y3iwmUMRnhXQclo67ihZ980ZrTOfUTBDoydkyLjliZzuHuHeP7WpEn8ZIcCWRnScK4Q2po4iQryvn8n8vFd9aRIyRO4gcaxogWhljzM7+YUpQmHD7NmhPb6RqFRJBApqOAZIV7CCvRkAnjgpCuhlwr51B2ZZCNNHk5LQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0acIJGvw; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0acIJGvw"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6fb2a6360efso33459437b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 20:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739852674; x=1740457474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJo+0ZlAdHOz9Gg66XFjfUOilGx/xXuy04+cDUSNa8o=;
        b=0acIJGvwOf2IQLNQNXiiTalC2+klLp8RQeAgjqwi3XqiT3extSAA1whfl4OQ6YY8ll
         W9BV9abUgvdZ9wLtVp1hFjJ8JzPG7/uM2W0xHNBaxHK0OQFXf4YY/mEObVTuG84HTS6I
         pLB03nn5nz8CYC0qW0qkspgR6M+iwHqE/EXKc7B2KtwHWcgfY+cHdZ4Pykvqoz9FIWSt
         f9RopfN6ZdJHjdMwdQya1wreaHBThCP68hyWIZ6j3FdniTtsNQbgAvkk6T+r5pWsrMOS
         LbabxsGZVIednAzFJu5FLMgQlPabpGxDks9ZV+kJumMEq6jkyc3Q66pu6PELAfGQ6Bec
         pXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739852674; x=1740457474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJo+0ZlAdHOz9Gg66XFjfUOilGx/xXuy04+cDUSNa8o=;
        b=j0RngMUAYNfS8BmdF72mrUh5HBxAMDDlO5f0ELlGjdXuG4Nh+jC+oA6hVWPnDoLfXU
         7JiqN7WgbCzrshw2mnkVIJlvJ1/zPppGf/gHRn/C0wuGVyY7sBEneTrekMaDjZYi6jPu
         pmvoPHoi2/eRXWz+KV17vqRwycfdaLXcg3vHe0tNSnTBUT5zlsHZyLqkcTIBkDZ970K9
         7+XPipDI+c+NgjkLNvsSDKxmyVAzehFv9vRj/z0lnxFVwQwZhN2KOHj8L9bXFvl206qu
         pp+8CtqJvQ2+YdVv45qiwEN+hP4qFWsTQjVbX7M4a8PrYMg8VHmjg66taapvg6sPLblX
         gBbg==
X-Gm-Message-State: AOJu0Ywx6yCSOJYP56sMabQJp9//DMsOYanmTyrlOKq2RW6rH+SZwxcp
	7ymK6Auip6YNkC+Q6KJ+aRSk+0CoQYVsAni6XyfhqaeaVOsWl8nmN7GnwJPVHVFluc0X1e3une9
	Pu3dWaucOFSICU1zSGSMsqgJw3f6JjFo1VlWb
X-Gm-Gg: ASbGncvSPG0gn9TrEBva6ftjEt5mDm5u+qv/WtgErTpBFJF2V2WMBzlOwdh6drxBkey
	CPi9PIIUe9WiDUbbVwlchaVX5weeHZ8/vsvvUmN2VkXENg5TlnABWhekNLej2u0CTFvK+fHTrHA
	==
X-Google-Smtp-Source: AGHT+IExoJCNXHIjUMVk1sdBiV9SOyDr6EnWbd2vk6ze6NK5ER5srFACy3NEeD9n+dKZJD+IoaCx+f6NH1ljb6VUDmI=
X-Received: by 2002:a05:690c:6887:b0:6fb:974e:dac3 with SMTP id
 00721157ae682-6fb974edd76mr6172817b3.13.1739852674014; Mon, 17 Feb 2025
 20:24:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214191615.v5.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <2025021425-surgical-wackiness-0940@gregkh> <CADg1FFd3H0DLV-WX8jTB1VGyOZYEzchP99QvYxWmg1XCOo1ttg@mail.gmail.com>
 <2025021717-prepay-sharpener-37fb@gregkh>
In-Reply-To: <2025021717-prepay-sharpener-37fb@gregkh>
From: Hsin-chen Chuang <chharry@google.com>
Date: Tue, 18 Feb 2025 12:24:07 +0800
X-Gm-Features: AWEUYZknjZnpnPXU3RpJnqSIGHgESMJNEzhEO9EeUs6CxWq63gqYeGuK79ATGwY
Message-ID: <CADg1FFf7fONc+HJT8rq55rVFRnS_UxnEPnAGQ476WVe+208_pA@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Mon, Feb 17, 2025 at 4:53=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Feb 17, 2025 at 04:44:35PM +0800, Hsin-chen Chuang wrote:
> > On Fri, Feb 14, 2025 at 7:37=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Fri, Feb 14, 2025 at 07:16:17PM +0800, Hsin-chen Chuang wrote:
> > > > From: Hsin-chen Chuang <chharry@chromium.org>
> > > >
> > > > Expose the isoc_alt attr with device group to avoid the racing.
> > > >
> > > > Now we create a dev node for btusb. The isoc_alt attr belongs to it=
 and
> > > > it also becomes the parent device of hci dev.
> > > >
> > > > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to cont=
rol USB alt setting")
> > >
> > > Wait, step back, why is this commit needed if you can change the alt
> > > setting already today through usbfs/libusb without needing to mess wi=
th
> > > the bluetooth stack at all?
> >
> > In short: We want to configure the alternate settings without
> > detaching the btusb driver, while detaching seems necessary for
> > libusb_set_interface_alt_setting to work (Please correct me if I'm
> > wrong!)
>
> I think changing the alternate setting should work using usbfs as you
> would send that command to the device, not the interface, so the driver
> bound to the existing interface would not need to be removed.

I thought USBDEVFS_SETINTERFACE was the right command to begin with,
but it seems not working in this case.
The command itself attempts to claim the interface, but the interface
is already claimed by btusb so it failed with Device or resource busy

drivers/usb/core/devio.c:
  USBDEVFS_SETINTERFACE -> proc_setintf -> checkintf -> claimintf

--=20
Best Regards,
Hsin-chen
