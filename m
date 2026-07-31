Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B913A43D4EA
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511549; cv=pass; b=g9DJDNh0VWkdlWYyRftPRoCFG2f+NMFRC1TThPm+SaT7OBJ2yUUXCWEC46+FqVn1BfMhfPGzC/IghAzrO03oAJsqqJcYT2gF4NNa8BS7bq6CTLVrtXaZBCv7Kd8fDet+nN3QXYMIlicrQ8QEjdRbPgqSoV/re8XGa2bHSghjALc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511549; c=relaxed/simple;
	bh=r3BGYhuAYAfTixk0FCpnDsR6p4q7mVxOkENcHc5JNeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUNh7XDujMgUYtGmimr/ryBtEDi8xccv13TaZwxidWp7heZbnFMAeAGkU7gh0ODMTOLIU3pvtmH9ajWGh+G5kdEiRoMy38s/TRC6+/inJ///ZA5aB3fiGfscH/LSWLKyCwvV+cMYopFPi7EhIb2//MfSxIb9eM8U5xsa3BQ9cIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNGd0gLt; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNGd0gLt"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6685483aad2so1564964d50.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 08:25:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785511543; cv=none;
        d=google.com; s=arc-20260327;
        b=JjD+5hLGy/tqT5/rCCDBlW+k3HhmvmLzqq2Zf3DGSYRNpIPW8d210NT0owMy5ah6nh
         kZXqnNAL4Tqi5V8NDqEPLUR362aM/9pBbGchMqSRwiXTxSkd1ZFPa0dAuFfebI/1Yeio
         j1co67SGFwlUyX9lVwX0w3GChM0ocaUqoBSScotTDhGUWLRWFANWA5XdFh2g8cr4irbD
         V3HIyK23eyUq1hQBuuLiYBU8yXsyrdyeWj1pqFql23wSaV2Ag3TNS9sleAvoCOSxNEXD
         KXnP22GoQc7ZlVUG0bzViMTKasPLcnR71Tq2gW2QdhXyd0E89C+QnqcQ3Fd5E+iucDBF
         AdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aeXGsNobYcCbssuhzV+aneWfZNBxdavhRmXzGbjYdbc=;
        fh=cviAZDt6O0OtJE7KLAzDvV53h3YNu5RM6XG4+12jMXQ=;
        b=AvwrwVDMs6BGxDt9NFl66by8Ubaw1fyHLT31q/+QquNBgBnlEC+JakoTSKuWs1dU1B
         pIjOKZ0ZCO2Gzj8rzZUj34b2LnDIa5UQQ3Hr0FjmMYSXHqQrhTtdM9Dixm4K2YDCzWFR
         a1ezsK8BCC9nbwP/lXTXpWG3ef6M7FrZUIv06SVO9v3Xr7o4vmohCN2Ci/BkpYrKUXEk
         TjgObkxLUCtKu1Bm7VgNZ/k2gj/GPwQCUs8zfXrVgd+dyfzEpuId4ha+Jnv72zAVaYXA
         ipS8M5YeYxP1v60/dJznMms+euSlE6Vb/NLERVNc/7EvaTq4jKRrf9XhAeZPvCV9lGq+
         1nYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785511543; x=1786116343; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aeXGsNobYcCbssuhzV+aneWfZNBxdavhRmXzGbjYdbc=;
        b=QNGd0gLt5biSDdt1mfZ49OhAm/vuE7vZkny3azIe/YhS2XVcUEk99eXICqqcGyG3Cn
         XE+/ofg3kcImvIoWvD3M0laJPybFyAAZ/G9PfoArywh7syCfPixUPk6HfSv9dozElakt
         ztyYjK1rV874UtR21l4EwIo5Zqtq0vHZeQmGfsyNzMOoTdMAJB1ESaT8/6Y11Dz3j6Ev
         VpudTKc6iTd8O680r0bg2CVfpI1LjPFeJk5WaGOJ6lPECWyPFBmqyWOHi0uXvKfe5khV
         0T7zw1tmTNN3hQN/4gVUkXmCI/RWgxiohd9UepHsoTjco32yOS7z3LA8ba9Z79OH4d3s
         Ctow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511543; x=1786116343;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aeXGsNobYcCbssuhzV+aneWfZNBxdavhRmXzGbjYdbc=;
        b=lQT/dgSeaF73ALFyELpojd+PK+dDo21+YzDETG/60StCeW8unSkD6mCYTDcQaFq1JH
         Ty6oCOUZQ4ecTXutE9xWCAOo21zQ4tDIHD7d9D4epQLA+Pj2uJ25YRLCQMHFEuY+Zd9L
         jKKSMGYrs+ETnlHWjfsuqI3VQqMnWYEiFUpyGKcOhzh0jtXtSiv90Kg4aC0LMiCnhO8+
         Y9KJWfdicil9hMLSAQQYLmCPlrRnlykj/g4B3y4Gn76SQADXuwHG6E2RfHl7qtyv69TJ
         SaohPJtA6QtkcGgUhkbJgB/L1T9i4nlk3bLF+wKJ8g80gm2QW5hKgE6zbn0od70/dE/X
         kMeQ==
X-Forwarded-Encrypted: i=1; AHgh+RotQoMgLt88x9T7WTDmzC2ZDRBX4974Ftfu45cPSNaJDrGfYcHtVoj7VVN59CPf3zDnHxgWokCOZfXTOUv/lz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjpNDkPi2ocsrSrEg77Ig5e5/ayHzpZTQ8oSwXBKh0CulvUgb9
	R+LdH3cf3ca0I+NXziY7eBhjqzr3/sa0RPGd5QYLRLhRLDj22Wmh9wVokA7Bi8TzSQz10jmPBRj
	N4jNfwvoH2CLfFAGntaQE7jtyYrOgYH4=
X-Gm-Gg: AR+sD11Qwy7DcrNRxBazmUuI5AGt6SK/FoUdsOdonK7cLJ6Umad4cAYj++bEIOBDaz4
	zX6/KcEl3LA+Pt6DIsselyjD8eD3MDiprwwVeVfa3n/xtsDTAow6iVBT9Mhtuc+aGW33/MPcuav
	g+l8n9ESBW7P4mGr77ahQjE2rXxfZcbbu4XMSII32aBNPBaR0OLFT5IFn3+ExXTVB4qCuG8R6N8
	tmsfN1DxJL1rOSvlgioEMkD7h8Ntooo9PWQCqduhEUYD4ZC7UIBfhtoFwQrWwLvbcIO2xhMHfzu
	jcmJ7RPVN5jqBzzwDFJICpS+u5s9IniC0T05XXiy3ZC0YRuZxRf9xzJ+KeEM5bEvx/TNzgJCfMe
	d5zeyD6JnGvXvwOk2Af7or/cdzIjf0kDrB8w=
X-Received: by 2002:a05:690e:23db:b0:668:434d:a2f5 with SMTP id
 956f58d0204a3-6694efe1128mr419973d50.1.1785511543228; Fri, 31 Jul 2026
 08:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731042920.2431343-1-shuai.zhang@oss.qualcomm.com>
In-Reply-To: <20260731042920.2431343-1-shuai.zhang@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 31 Jul 2026 11:25:31 -0400
X-Gm-Features: AUfX_mxNSOCDAeGLeIjPAMPEEY6vriJ4fIIQAzX8I6gPSwfUMPUdB1nzVJokPr8
Message-ID: <CABBYNZJuenvKSvHuf6DCkt9hpdhuECm3gf5hiV+FyS2E9AM7nQ@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: mgmt: always reply when a queued mgmt
 command is cancelled
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	chejiang@qti.qualcomm.com, quic_chezhou@quicinc.com, 
	wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com, 
	mengshi.wu@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Fri, Jul 31, 2026 at 12:29=E2=80=AFAM Shuai Zhang
<shuai.zhang@oss.qualcomm.com> wrote:
>
> On boot, the kernel's HCI_AUTO_OFF timer powers a newly probed
> controller back off after 2 seconds if nothing has taken ownership of
> it yet. bluetooth.service is expected to take ownership within that
> window by powering the adapter on, but on slower boots bluetoothd can
> start late enough that the two race: HCI_AUTO_OFF fires and the
> controller is torn down and re-initialised while bluetoothd is still
> in the middle of its own adapter setup sequence.
>
> When that teardown happens, any mgmt command bluetoothd had already
> queued for that adapter is cancelled - but userspace is never told.
> bluez's mgmt command queue is strictly serialised, so a command that
> never receives a reply blocks every command queued after it on that
> adapter indefinitely. In practice this means bluetoothd gets stuck
> before it can register the adapter, and reports no controller being
> available at all, even though the controller itself is healthy and
> fully usable moments later.
>
> Fix this by treating a cancelled command like any other failure
> instead of silently dropping it: always send a reply back to
> userspace, using the existing "cancelled" status value. This mirrors
> how other mgmt commands already behave when they fail for other
> reasons, and lets bluetoothd's normal error handling take over
> (log the failure and continue) instead of hanging forever.
>
> Verified on a QCS6490 rb3gen2 board where this HCI_AUTO_OFF vs.
> bluetooth.service race was reproduced: before this change, hitting
> the race left the adapter permanently unavailable to bluetoothd until
> the service was restarted; after this change, hitting the same race
> no longer affects adapter registration and the controller comes up
> normally.
>
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>  net/bluetooth/mgmt.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 167d75e34..9031b5d5d 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -301,6 +301,8 @@ static u8 mgmt_errno_status(int err)
>                 return MGMT_STATUS_ALREADY_CONNECTED;
>         case -ENOTCONN:
>                 return MGMT_STATUS_DISCONNECTED;
> +       case -ECANCELED:
> +               return MGMT_STATUS_CANCELLED;
>         }
>
>         return MGMT_STATUS_FAILED;
> @@ -1338,7 +1340,7 @@ static void mgmt_set_powered_complete(struct hci_de=
v *hdev, void *data, int err)
>         struct mgmt_mode *cp;
>
>         /* Make sure cmd still outstanding. */
> -       if (err =3D=3D -ECANCELED || !mgmt_pending_valid(hdev, cmd))
> +       if (!mgmt_pending_valid(hdev, cmd))
>                 return;

On set_powered_sync:

    mutex_lock(&hdev->mgmt_pending_lock);

    /* Make sure cmd still outstanding. */
    if (!__mgmt_pending_listed(hdev, cmd)) {
        mutex_unlock(&hdev->mgmt_pending_lock);
        return -ECANCELED;
    }

Which is why we consider -ECANCELED as a NOP, also if you dig deeper
you will see that hci_power_off -> hci_dev_do_close ->
hci_dev_close_sync -> if (!auto_off) __mgmt_power_off ->
mgmt_pending_foreach(0, hdev, true, cmd_complete_rsp, &match);

So the reason this is not working as intended is because we are not
clearing HCI_AUTO_OFF once we receive Set Powered command only once we
run hci_power_on_sync which create a race where the likes of
bluetoothd will be trying to power the adapter but power_off work is
still pending, so we should probably clear HCI_AUTO_OFF whenever
setting HCI_MGMT as at that point we know there is a user already
there is no point in powering it off.

>         cp =3D cmd->param;
> @@ -5651,9 +5653,6 @@ static void mgmt_remove_adv_monitor_complete(struct=
 hci_dev *hdev,
>         struct mgmt_pending_cmd *cmd =3D data;
>         struct mgmt_cp_remove_adv_monitor *cp;
>
> -       if (status =3D=3D -ECANCELED)
> -               return;
> -
>         hci_dev_lock(hdev);
>
>         cp =3D cmd->param;
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
