Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74BD3D99E
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932148; cv=none; b=QHHpKffTI429gaMtMZA5XNqfOTFfAz6VMiuoFXZjAVCaeHdPwGcf2+psT/sZzZlwKI9ndOHw5JnJoOdwoseCQqleulLoTsfzTkgSHCs29pNLRU+VDdEPQ8taQJBrKt6gG5CfhZU6nQM6exsrvmXvVkC/849bW+A9Xt0ZUhkIEmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932148; c=relaxed/simple;
	bh=VTUDh5llQyTP88F+MNbFo0TqNam+c7DrJIXvizHLOqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQpRKNNYTfGer/kINIiuVmushh2KB4jGl/4Lk/bYJ1piGlfEChH3xse82aFAGjejmsT+E2CPZCsm0/+jWkrRNNfbQfC/6QZTgjMlMB2tKv21T3+MChyFQgY6VHBEmdmcaExKKhVVgC2XvgFJHuWrf36j3GNrnMAucX2S99l5dpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8CzSiJd; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8CzSiJd"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cd1a1c5addso36431821fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 06:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705932145; x=1706536945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIUzhVrNcd2fIcbxhqP54PRrItxXJ6aTZXRHQHA/0ws=;
        b=H8CzSiJdplrpvXb5JBKN2nKKhEnBAEYBZGgGswXFzTCM9nEOy/XmoL6WekvkI1NtMD
         I09+PAD63k+MlodnRAZxRTyJaqXNLq6N/dNiXDN23Guc1D6kEuhvSZVnRPIl9zcAFSV7
         wWDqwckfzHqXyiCyhF5AzJBgILejR+B07TrbQGmJXrlImPispj+LD9ki+14YYGoMU5U2
         bnLe5+O3g3zZMhGomfeOG/ALJvGlrqdaFsZaMOid3nnFEaKf29gT87IzmoEjRoFYLcVs
         bTltqBC3/RnDzF8/bd1ct2oJ+yVN/DB14xs7I5jym5BCPVbSSjSqmm6GXZmTTeD/veZ0
         22ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705932145; x=1706536945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIUzhVrNcd2fIcbxhqP54PRrItxXJ6aTZXRHQHA/0ws=;
        b=fnUJvW2MvWp5YJlFRUf362FJWKeLvhDipbp70SJEtumYrCdUTuRe0KRzQS4f3/6RtI
         d6Lkdixs9hk3dALMaR0lVNQPQ5A3wjkNQPGWL4Xmg+uvtrOh5MgjLbpEyGxPJlow5dD2
         TuXCMpENhepwLJTNcDHv7fyN5TyVnM3+9wWTai3liekKoSQwetwTN/IqndytR4Uj0Fc8
         5rh07g4TKPX9Cdbp2mcM+FEirXB3XN2iAj8sjQ6XKd5EnbIQf4ZpRTrq26Adk8Mb7rr4
         nq/snyIRK372FUwoqja4l3Fb/eCb4ssKzQiratHy8IQimBtXzL+qZw1dBWdJVPQgq0SY
         iGjA==
X-Gm-Message-State: AOJu0Yz6YBDa9wDsjcobKJYSNq8FZt4T4TBguxVwMGBPSK3dfpouVb1i
	2Og3AgAx1xI7EPgMCtIRAYCvz+YBcpbDFtX0sC8jMxDLzMfuVsUUJNT2UjqUlixwsJdOOmHxOEz
	Uu3Gndrse9gdE6iRZOLeRJdsB2oAT7KoZtzM=
X-Google-Smtp-Source: AGHT+IHBMORG3qlSwv1uQ6fjg/QtdQm2qHmAi9VKTIYwIlnWHUEh1TT6cUgCa/QWqvIcvZOW0N12pqplaE1NjxYwVx4=
X-Received: by 2002:a2e:940c:0:b0:2cd:46d8:12a8 with SMTP id
 i12-20020a2e940c000000b002cd46d812a8mr1717421ljh.95.1705932144398; Mon, 22
 Jan 2024 06:02:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a3a31b2d-6039-4b50-af81-47f7ea1a0461@munic.io>
In-Reply-To: <a3a31b2d-6039-4b50-af81-47f7ea1a0461@munic.io>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Jan 2024 09:02:11 -0500
Message-ID: <CABBYNZ+9UdG1cMZVmdtN3U2aS16AKMCyTARZZyFX7xTEDWcMOw@mail.gmail.com>
Subject: Re: regression in c7f59461f5a78: Bluetooth: Fix a refcnt underflow
 problem for hci_conn
To: Andrei Volkov <andrey.volkov@mobile-devices.fr>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrei,

On Mon, Jan 22, 2024 at 7:18=E2=80=AFAM Andrei Volkov
<andrey.volkov@mobile-devices.fr> wrote:
>
> Hello,
>
> Lately we've bumped with regression introduced by commit:
>
>   c7f59461f5a78 ("Bluetooth: Fix a refcnt underflow problem for
> hci_conn", 2023-10-04)
>
> The regression related with adding "hci_conn_ssp_enabled()" check in
> "hci_io_capa_request_evt()" handler, and broke pairing process initiated
> by the external device.
>
> Precisely, some ext. devices, like any phone equipped with Android ver <
> 14 (we have not latest one, so we didn't check), always send "IO
> Capability Request" before "Read Remote Extended Features" command, as
> consequence the flag "HCI_CONN_SSP_ENABLED" not yet activated at the
> time of "hci_io_capa_request_evt()" execution  and
> "hci_conn_ssp_enabled()" always returns false in time of the pairing.
>
> As a result, pairing always fails. The quick and dirty fix is revert the
> ssp check introduced in the subj. commit, like below:
>
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5329,7 +5329,7 @@ static void hci_io_capa_request_evt(struct hci_dev
> *hdev, void *data,
>          hci_dev_lock(hdev);
>
>          conn =3D hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
> -       if (!conn || !hci_conn_ssp_enabled(conn))
> +       if (!conn)
>                  goto unlock;
>
>          hci_conn_hold(conn);
>
>
> However, a more thorough and correct fix requires discussion and
> testing. Therefore, I would like to get any comments/suggestion from the
> community before doing this.

I think we need to do something like this, so we consider only the
local SSP flag when evaluating if we should proceed to respond or just
drop:

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6130c969f361..a15924db83d9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5327,9 +5327,12 @@ static void hci_io_capa_request_evt(struct
hci_dev *hdev, void *data,
        hci_dev_lock(hdev);

        conn =3D hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-       if (!conn || !hci_conn_ssp_enabled(conn))
+       if (!conn || !hci_dev_test_flag(hdev, HCI_SSP_ENABLED))
                goto unlock;

+       /* Assume remote supports SSP since it has triggered this event */
+       set_bit(HCI_CONN_SSP_ENABLED, &conn->flags);
+
        hci_conn_hold(conn);

        if (!hci_dev_test_flag(hdev, HCI_MGMT))


> Regards
> Andrey VOLKOV
>
>


--=20
Luiz Augusto von Dentz
