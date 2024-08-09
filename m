Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC921DFE1
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Aug 2024 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217078; cv=none; b=n+jwE+PSWdfMpSbO3uJFavsjMKHa+yr7u4cwh3s1G+qmhI/Udh3EZq001jdbHuzwHsPwRCQYjaPtYxaqpK+9+OqPYP4v0Din+2oCjQ2Ywn1b3awr2Wvjc6JBEwSQICIuuyDQUzF4oiPPs1Z3BEBSxD8pTZzngXwgdr82jGZV/iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217078; c=relaxed/simple;
	bh=2n1YqKXfqUXIDEoTFTJbKI9JpdaC4+oQ262HO41L66E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmRUhW6VsEfVdTNt9tb2Qx0ON7H8KHg66TDaji72C/PSzbtR7ZgDJkUpEV/MhREPRyrKAN1O0idHNSy2BvCY3oJwb+rbnOtGsQ9IX+XT5M19DlAaaC12uT6Sw5lg3ULEpG8s8NBN21wDe1IrgJcqr+jaJ2mKM096JrNdHmqAM5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T17q9ePu; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T17q9ePu"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f183f4fa63so18453211fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Aug 2024 08:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723217075; x=1723821875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmN2F25Jn7XHk7rhZzKm50c0FqTWnNo5WI3HIdOW8EQ=;
        b=T17q9ePuSuQBv25XHo5PnrBTvhk25SY9w2tKJLylqFivsWrwvMonTNc/fk1kRJk9wd
         X5FYaNAnt/lUoIWy37WH1VUG7O6ta0Xsr5LCGNYjP+nsZI60sLLuEbMdptcCbwAY4EPJ
         1m+0JL/sZDY7cU1lAxMR4InO78hzBzD5Apz6N4P7YZ1MzLF3K2XXyElVgw4yd5bnf//j
         HbXBIuIguUAcQRHEOPd4kM0MCPVWC/SlQu3JPY8c5hZn30+Q46xJAspI7EoJ8cKLtbkc
         KxkBmyuME1eIOq/L5AuiTYfg/EDo8Pqc9LfrCP2+/ARoFlhb3nEXOPM5OY+rCPPCJLTD
         yBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723217075; x=1723821875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmN2F25Jn7XHk7rhZzKm50c0FqTWnNo5WI3HIdOW8EQ=;
        b=Wu5GsX9npjVNt2WxhR2rEyWPvN21wpvOFMVmttcW5DOZosQN5jitGfHneEu3KmMtlI
         VAbQqZqQ/XXAl5cprcw4Xk/yYmmoGypfn7Sb7u1cuxTIptcnoe++UhGhNtIpPWXVsMzY
         bSZnx5A1W0ofEw7Z/O8RoxRLV+sD5JyfLGhZgt/yrQgAD8M1XAICISeQbcmeMnUjGk/2
         sQV+KDs4b8+SFUPnQzsDSGQ5HOrG+309I+9XwO3W7YS5xzbmkKabsioDGwy/y+p9GBH9
         NmsH6rsObqMOAGYhR/BeO9OjaXbMlXjb0dwu2FO2Z0spQqpKrRoTMwQlxRGXMUsxSZmw
         2gWg==
X-Forwarded-Encrypted: i=1; AJvYcCX1eNDmOJs5Mify86vGiOyThNRuGnJNsLvY5bU6Qek/KKrFtP+YP8fQUBCttFi57fDo2/FHkRopKIvk43DdXueRDquacoXbnH5NPZbfDkNY
X-Gm-Message-State: AOJu0YzRXOpckyTw1LhEOOF0A4smP64FTR9eiGWkxs4aLDDtwTCDTu45
	1peKlvscbRoUxQF0WLf+AVg324EXXSXnfW2/fIYHFCZXco48L33QFjiXpY2oY8u1fuM3GQutw89
	x5lyKmcha9UaetUk6iZBkG9DRReGIXg==
X-Google-Smtp-Source: AGHT+IG4zolrmBFuEEoaOgsgHe7oWTHV0Y/jaDYn1J/5oHrCWleVhgBq+gQnvXS6NBjY2CZT1h93mXqfnlEknrR66z8=
X-Received: by 2002:a05:651c:881:b0:2f1:6519:4000 with SMTP id
 38308e7fff4ca-2f19e3faf37mr19380261fa.23.1723217074143; Fri, 09 Aug 2024
 08:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809081613.12aa21d5@hermes.local>
In-Reply-To: <20240809081613.12aa21d5@hermes.local>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 9 Aug 2024 11:24:21 -0400
Message-ID: <CABBYNZJjNpZzeRCBicvFcmDE+=eKUBDvt_vH+MC5-zXbzmZsxw@mail.gmail.com>
Subject: Re: Fw: [Bug 219142] New: Potential Null Pointer Dereference in
 pair_device() in mgmt.c
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Fri, Aug 9, 2024 at 11:16=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Network bugzilla bugs get routed to me and I forward them to the mailing =
list.
>
> Begin forwarded message:
>
> Date: Fri, 09 Aug 2024 07:10:04 +0000
> From: bugzilla-daemon@kernel.org
> To: stephen@networkplumber.org
> Subject: [Bug 219142] New: Potential Null Pointer Dereference in pair_dev=
ice() in mgmt.c
>
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D219142
>
>             Bug ID: 219142
>            Summary: Potential Null Pointer Dereference in pair_device() i=
n
>                     mgmt.c
>            Product: Networking
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: Other
>           Assignee: stephen@networkplumber.org
>           Reporter: yiweiz.evie@gmail.com
>         Regression: No
>
> The details of the bug are as follows:
>
>
> 1. Affected Components
> Function: linux/net/bluetooth/hci_core.c hci_conn_params_add
> Function: linux/net/bluetooth/mgmt.c pair_device
> Module: Bluetooth connection parameter management
> Code: https://github.com/torvalds/linux/tree/master
>
> GitHub - torvalds/linux: Linux kernel source tree
> Linux kernel source tree. Contribute to torvalds/linux development by cre=
ating
> an account on GitHub.
> github.com
>
> Version: the newest version v6.11-rc1
>
> 2. Description
> The hci_conn_params_add function is responsible for adding connection
> parameters for a Bluetooth device. It first attempts to look up existing
> parameters using hci_conn_params_lookup. If no existing parameters are fo=
und,
> it allocates a new structure using kzalloc, which will return NULL if the
> allocation fails.
> However, the pair_device function, which calls hci_conn_params_add, does =
not
> properly handle the case where hci_conn_params_add returns NULL, indicati=
ng a
> failure to allocate memory. The immediate dereference of the returned poi=
nter p
> without checking for NULL can lead to a null pointer dereference, causing=
 the
> program to crash.
>
> 3. Technical Details
> struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
>                                             bdaddr_t *addr, u8 addr_type)
> {
>         struct hci_conn_params *params;
>
>         params =3D hci_conn_params_lookup(hdev, addr, addr_type);
>         if (params)
>                 return params;
>
>         params =3D kzalloc(sizeof(*params), GFP_KERNEL);
>         if (!params) {
>                 bt_dev_err(hdev, "out of memory");
>                 return NULL; // [BUG] return here
>         }
>
>         bacpy(&params->addr, addr);
>         params->addr_type =3D addr_type;
>
>         list_add(&params->list, &hdev->le_conn_params);
>         INIT_LIST_HEAD(&params->action);
>
>         params->conn_min_interval =3D hdev->le_conn_min_interval;
>         params->conn_max_interval =3D hdev->le_conn_max_interval;
>         params->conn_latency =3D hdev->le_conn_latency;
>         params->supervision_timeout =3D hdev->le_supv_timeout;
>         params->auto_connect =3D HCI_AUTO_CONN_DISABLED;
>
>         BT_DBG("addr %pMR (type %u)", addr, addr_type);
>
>         return params;
> }
>
> static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
>                        u16 len)
> {
> ...
>         p =3D hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type; // [=
BUG] P
> is NULL
>         if (p->auto_connect =3D=3D HCI_AUTO_CONN_EXPLICIT) // [BUG] NULL =
POINTER
> DEREFERENCE
>                 p->auto_connect =3D HCI_AUTO_CONN_DISABLED;
> ...
> }
>
> Vulnerable Code Stack:
> pair_device calls hci_conn_params_add at line 3458 in
> linux/net/bluetooth/mgmt.c
> hci_conn_params_add is called and may return NULL if memory allocation fa=
ils at
> line 2280 in linux/net/bluetooth/hci_core.c
> pair_device does not check if p is NULL before accessing p->auto_connect.=
 at
> line 3460 in linux/net/bluetooth/mgmt.c
>
> 4. Potential Impact
> Denial of Service (DoS): If the system encounters this null pointer deref=
erence
> during runtime, it could crash, leading to a denial of service.
> Security Concerns: While the primary issue appears to be a potential cras=
h,
> depending on the context and how the function is used, there may be other
> security implications such as unintended code execution or information le=
akage.
>
> 5. Exploitation
> For an attacker to exploit this vulnerability, they would need to:
> Trigger a condition where hci_conn_params_add returns NULL (such as exhau=
sting
> system memory).
> Ensure that the pair_device function is subsequently called with the NULL
> pointer, causing the null pointer dereference.
>
> 6. Mitigation and Recommendations
> Null Pointer Check: Add a null pointer check after the call to
> hci_conn_params_add in the pair_devicefunction. Ensure that the function
> gracefully handles the NULL case, possibly by returning an error code or =
taking
> other corrective actions.
> Example:
> p =3D hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type);
> if (!p) {
>     bt_dev_err(hdev, "Failed to add connection params");
>     return -ENOMEM;
> }

That sounds like a very trivial fix actually, not sure why the
reporter didn't just send a patch.

> --
> You may reply to this email to add a comment.
>
> You are receiving this mail because:
> You are the assignee for the bug.



--=20
Luiz Augusto von Dentz
