Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F95425CFE
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770666292; cv=pass; b=k4brzhvbOj+ZQfjYB5MBgbQ54lQRCaIBlq8o+EWX3X1q6TpseYcsvOt3BsKu8SHpcpWB41OgPpOV11IX3R7UwMCs3oGAu+sg0L4/1ZBlUUqTBV4aRNfoURJnyHwYLYZozce2uNmkC3gPTE4d9BEpiRieO3+zaK2Y5bjWp999Yd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770666292; c=relaxed/simple;
	bh=J3MbyPv0lCyPVi/uq2YooRkROSskRqaASkpUjrsTvug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvbQHgueMgDcqQzaj8js3en/kKIQf/NJNnz4gRD0j0hfvrQmQlXXuJkQ1iJS8t3JT0g4/3Il0V6X3mK5KLe12Su0BxlMl4o4pCGetGwPSuMR3/ngIMhfTfKbuw5SJJc7W5MFxHKi3hoEQGWIYJ75YTWvG5l1XlxxXCgAMmfIpIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRIUwRnN; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRIUwRnN"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7964f1405a0so12117577b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Feb 2026 11:44:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770666291; cv=none;
        d=google.com; s=arc-20240605;
        b=ia16XZjqxH6pJxs6CO7kvT+xROyEf2lioMOKo9uotiwBh3MclC9t3bxKwmB4ad5prx
         3u2J28qdCna/KhDIQfHNgnOn20jQ/CSVGu+5/PcC22OFK2zK9q8VqCM5lR3b2FK2VOCw
         yT3EVOWEAZOXulKvSYbkGQ5nDwvIsn3J0vySGmOaFJ3aq5matnPHbO5apUVLmJyQJlKT
         02MFZu/i5iXkUmHiZVTzxdShCvlP6OhuAcW3bQKOJHKSKdwIzWn01IQCXybvaAz5eBfc
         21kDruBREWpAfX7hjmDVphE4jXTk7e99p+Aw0oPchKgNaiqEPQUVm8S1h4DhvnfGYjM9
         O2/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+XVopxlUjwe0ZGRyKBFk4NtFVNYbSzhBngi+dhAbvuU=;
        fh=haWHdn/+NbmFbFvaRBIdUO98KwOHRM9I0eHVF0p8O3o=;
        b=CZYIEf6sE0vajib64qW1d+C3TH0MUdbP9NkchelBfUk1Qee3MSmTiAqUckGH5w2W80
         1IyddvhJl9PamJ0UW6I5OwbpvRliktbHTjdhkyyr0hqckCZ9nDdjrfvIe782Fv9gN8+4
         5aVGJ551jDsOvM6Pe/U+OtSGM4RyVwKPVKonjY0ow7rLqBvHnhjz9ctsmSmEa4T0mKRA
         mGet9bo5KV5mSOieZ9LwpS1S3Ks4SmCmGeuGixZTAd1u59OZiBZLdgAkfRvp73Ash/cd
         9mkP+h1OT8G5i6tIsfS4K/H5XE1us5U8x0usCT6F90v0m1qmJaQlNB/tw/32lFpS9ka0
         YAug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770666291; x=1771271091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XVopxlUjwe0ZGRyKBFk4NtFVNYbSzhBngi+dhAbvuU=;
        b=bRIUwRnN2/jmUGq8Yd89UaJNHEnOfnGal4pzs9tbxDlFTiv+AoIjxTq5PXlhYRmodo
         E6bAyVLbzxHi1DOov6GnLdLoTziLI7QqkwUqdl2Kr4CYMlLWSKloYSYy3/lt5fCQcT1o
         igVjgFWNaO7IE2vSRQEdZtudwHqZG08AVKqAPbUn6qE+LyklIcD9BefFaWFQ8xF2Euhl
         pCnPCvBLedNK3ilpHheYtszncZefQKYSV9nCIWhh7EcHG44WK5xZJzmqW4yB9b6iQUeU
         CM89udsqw3SWN8YyvJ3NI2xb6m8hfOaNfkd7I4X57CK5bA5sFZ8U1hYeyYa0lTATm3aJ
         INYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770666291; x=1771271091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+XVopxlUjwe0ZGRyKBFk4NtFVNYbSzhBngi+dhAbvuU=;
        b=vzSW+sJeRM4yVRs2w1sdbaNL8Lz2w5x8hg4rmmmsQCtEThPKiKXd7K7dmZTTFdmLc1
         IWnR+UAqa2SMftm1AcuBnA+IrD2QDK7b7nnJsqIOIKVgWWTAawDmN7nar8Nb4WZGgAmO
         BCtF8eM1zYbqmPs5vGOTOKd9th99P+4868LmHuTUu8vXRw73Y2wn8hn+bzlLPocJ08+w
         7+rJj63j5fHyi8izsqAI43gAG/1Ij4tP1XdnAFfECAfB+C0hqJEIQHd28Qp2194Ug0DS
         A3dM8OJhvN9YgQ9mrbmA3l4rEK/Ix/PVu0xTfNzanuSHacEg+wgABruYiUaIHy3aaAxW
         1wCg==
X-Gm-Message-State: AOJu0Yz03K4eDr0sj/uQHk6v/MCogTi07iHpJVXPNzjE7XTTiNpOEzuJ
	2XIC93s//BXXrviqXc/WXYtAzZMCV/g+oPL/kZDNwzLSNMFDKuOsy3cYjlR+l9s9mEBpkPXx4+w
	ZjlHn8K7/MPBilj4ejB7CfkFWsHvrLBDD26PiScs=
X-Gm-Gg: AZuq6aLvR9yEHJQdJix5yWkVxRcnIHz9W0pqFGjmB9XAr/vF+7hjbUfpTBTkg0j0Q9Y
	bOtowpPd5DMnRVSZ1Bln5+BtMEh0tc36VmQVEAs1bYEJdUc3exJG2x2tXM45OurSCycyKwy8JeX
	VTW7umthh2jTCLvV1Gk6udMxlfkB9+bnXwPY92tj6sov8TY+AQYuY5MkLtZuh8ghT0A3Fw5Vt84
	5C1eoeWzHhtoZmy9tGWPampJuU7B4FTNPjHMm4dJKc4hDQedUrbfQgXswQdcizQ+w5dwEvF39R+
	wnMko74AMVhy53xXFjj+9w8kTj4FNSE2857j9+qG/R/kA2sGsLoMSwX3i8mtGZcQPt70
X-Received: by 2002:a05:690c:4c0f:b0:796:3fcf:7807 with SMTP id
 00721157ae682-7963fcf9cc5mr52328247b3.0.1770666291104; Mon, 09 Feb 2026
 11:44:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208081559.44983-1-maiquelpaiva@gmail.com> <20260208081559.44983-3-maiquelpaiva@gmail.com>
In-Reply-To: <20260208081559.44983-3-maiquelpaiva@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 9 Feb 2026 14:44:40 -0500
X-Gm-Features: AZwV_QiABDPCiJ6ESRJXtgjeierW7QPvNMzPdLV0CmoUrewx8L8qzCoK0fW___8
Message-ID: <CABBYNZKqJ2pqCd+FBxjLgsezn5A-9QG8vCEUNNKU52ahSxLi9Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] Bluetooth: mgmt: Fix race conditions in mesh handling
To: Maiquel Paiva <maiquelpaiva@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org, 
	marcel@holtmann.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maiquel,

On Sun, Feb 8, 2026 at 3:17=E2=80=AFAM Maiquel Paiva <maiquelpaiva@gmail.co=
m> wrote:
>
> The functions mgmt_mesh_add and mgmt_mesh_find modify or traverse the
> mesh_pending list without locking, leading to potential race conditions
> and list corruption.
>
> Use guard(spinlock) with hdev->lock to protect the critical sections.
> This ensures atomic access to the list and reference counter, preventing
> race conditions and avoiding sleeping in atomic context (which fixes CI
> failures).
>
> Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maiquel Paiva <maiquelpaiva@gmail.com>
> ---
>  net/bluetooth/mgmt_util.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
> index bdce52363332..af9194e44943 100644
> --- a/net/bluetooth/mgmt_util.c
> +++ b/net/bluetooth/mgmt_util.c
> @@ -397,8 +397,7 @@ struct mgmt_mesh_tx *mgmt_mesh_find(struct hci_dev *h=
dev, u8 handle)
>  {
>         struct mgmt_mesh_tx *mesh_tx;
>
> -       if (list_empty(&hdev->mesh_pending))
> -               return NULL;
> +       guard(spinlock)(&hdev->lock);

Not sure why you switched to use hdev->lock and not mgmt_pending_lock?
And that is a mutex still, not a spinlock.

>
>         list_for_each_entry(mesh_tx, &hdev->mesh_pending, list) {
>                 if (mesh_tx->handle =3D=3D handle)
> @@ -420,6 +419,8 @@ struct mgmt_mesh_tx *mgmt_mesh_add(struct sock *sk, s=
truct hci_dev *hdev,
>         if (!mesh_tx)
>                 return NULL;
>
> +       guard(spinlock)(&hdev->lock);
> +
>         hdev->mesh_send_ref++;
>         if (!hdev->mesh_send_ref)
>                 hdev->mesh_send_ref++;
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
