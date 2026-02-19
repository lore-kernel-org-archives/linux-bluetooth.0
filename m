Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B7226ED25
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771517787; cv=pass; b=PSTg1kMC9w8KiBOL1kLwxq2TsL7+EivM5FTXVGONyaSXjhrOGcGzq+3bLfsmZk+0RQR76FGEOFyGaJ8RwFdwplDGIjHxbJg4UMyQLkrP5lddW2cFcTI4A+Td9qVY7MWRmkbPOsXcxijQfhkMNYoHqfArsOh1Ro3WwpE40hgOGj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771517787; c=relaxed/simple;
	bh=zOIRLawsYZ+W3itGuhJxFEilIfJwYHNIHJIzlKHhcaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7rc3h63W0DNArFeXw7Cgnw5DZHplpvRZx3ggiDxhZ0D1/6ZBJkGH/XO+Grhval+305fScYb80FMoIxlzM1UaGRxCzGDCPDpRR3L7Cv53HZrBb9S6jWptmWQOZVcS+7T3A7V2AShEXkz9GgbI+Q0rQIM87xLP8x1+5W7J3Rg7b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8QPnvWQ; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8QPnvWQ"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64c31ca77b4so1005734d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 08:16:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771517785; cv=none;
        d=google.com; s=arc-20240605;
        b=keJY3uV5SMI9lqq5Zsk5o9paBoBCOJeyX4WzUin6ffslqgfFUSiXeILzclzhqUm1N2
         5lnVA0bO/CcmM7W3zJkvIk9xBpXHs8tLX85iGHewZr9K692eZhZBPetqr/okDtgYCt/D
         ObYFwM9m8LkEPhGKQjObRvU3czbK4YOp93abpIgKOb1qEfzwapTuE+QhWCiUOHLJjjry
         F/EbldLcGYEwYsdSTFQyYhYF1mgacpfuoy3uvY0dRblfQsaWTR70k7vK+NY3D3sf5axp
         rXr4iDuiO8KWZgLpn3V+FYOoeHtYIjb/A6rqqJ1zD7C6859WIsQEAgKeql5hZBD5C3HJ
         nyFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3wg+vKqYtXz46jjz22+jIAy3md1p+mu/01FpEpqGKtQ=;
        fh=lTRBQrph/dg4foHxC8Dty20hOd5lAhLfXH97PYHGfDc=;
        b=NOeNbUFyK9zLm49tkDJE5bfvxn7kCfae/7+LlwVgLlcMeb9/Ba/Dq1XlrHNDT2l2mj
         gU7yfe0IBQzzd9idtwzjoStRDdKYm8itS3DCO65wmH381+wiRjQiEGUkenoSJRzSj0pV
         ow3f2mdoVmHjSPHriP06MrM18BSLc5QYagCm2ZKxh6sqWPO+mJAdmJV6xpEs3iYQqnqF
         7udR69e6wzn2J851YZhiQNF8cTh6MUhU0vpCvtJzxZQrQxla6zaORSCt6mg+R33h/P/l
         efGQ4jRK0nZpks8uwDKPKO7Fj+wIEtqHF7dFSt1/CFfd0VzW5E7lIMvKZ65c5drFqbQk
         JYpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771517785; x=1772122585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wg+vKqYtXz46jjz22+jIAy3md1p+mu/01FpEpqGKtQ=;
        b=a8QPnvWQVXiQ3vCrw57hF6k3Ua6BccPZWSlIZNgxvf3P2ZzxgMHbBFK6iEe7z+bB+O
         PPWvIAYJ/zqsFYDrRBPM+qaDeGE4N8HFf+WIXirOfvjpMPj473duT32y9GPFjeUmNSqb
         Ai5CSGsXm/k2jn+nkBcBwkbRudMC9hvYS4stFOjE9RhVrcnhr+uBCvlGMtZjd8mG9lKZ
         r4mXX979/2blLWH2LM5vXuN1Tef/AG7kMOG9z+PAwCjlGs0KHi+KsY6cJNtXTvbSnbAx
         joctbWXIFD0759fXuezhNkZAs8mWJT3YBxv1KHDICzIhe2KSb1FGG+qVcalBYkfyDZy9
         RZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771517785; x=1772122585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3wg+vKqYtXz46jjz22+jIAy3md1p+mu/01FpEpqGKtQ=;
        b=g8LpNU0FiFjaDlzHKR/342hbXCpPKDf18ZiFaTDmIyEcQ/dhqyHtMuVDKJefNaIHLs
         d9gSAiuX2EqiAEBmAZTsa462TZrFTk+lOUp76dhxS7wQiduEDdYg/vCF3ne5Ur/P1+zG
         Hpky7O3kehNq1nCr9NKD7b4GKKx/vodsDu7sauXPzIcwJ3z+8kgWIYZVMR38i65V59AJ
         /XCVy0zakz2UKkyesn4SRAArwQJDVsyd8ffY1lExxsRQuwhWuB97zVoE7CZZ6u87kkn1
         wTHxCU+joqT/F/tY8wBhFUlWS3MmeFdSvZuANKHMn0Tc/eChtCplFanSR0HUnqoGs/bI
         v4Xw==
X-Forwarded-Encrypted: i=1; AJvYcCW9L9n85TVLLKLO930gTJhydj+VzcUDqhWAJgwdp3qikEnJ7oPH/jXu8rZ3fg/PN7cyaZMPotFunbiHgKmO1z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVy2LkeeWbQ9omk9bN5A+1rHtJ9WaBiVKNBnYo1cNIoexZvxpx
	U4hKuqojaJfDg9A6OH/ZenJtwWSDfqMbIrGl7YSpcQK+2AWdwgbMmSQugdFy9fLq64pTCU2eVEI
	Nkw0rmeFvt60hysvAr+19ijJ/JmcvXHg=
X-Gm-Gg: AZuq6aJyPATrNfthnLK4XZF8n3/lDIn6RAA4vzHXghONG6sfvmcsrkosJ3bwP3wTxOF
	Vi4AOTlae8ztEp3JPe/am6MtkipoYKDiieySouYcAuzDeWDY3eHnrInzTPMCs/32LJlVnvBb3Xt
	Q8IsQ0fIQJ44lmWGj9wUT5h01EQHfrJprTwbHZp8MfGXDzHxKwxR5cq0kN1+xgzuScvUfwoMlmc
	UjxCjTZW5hEWx4RRPNNIWurHIhKkJIV8XYSfRF6dEYRJ1rrAdFDIJ4oQOjVyFjzkYxDyGk2QWs0
	RigSdQDyhc1prwXGZmaMTRXH9i2GeZYfCHUe01tWdDZGYLWm80xsrId+1q5yXuFKjTxuUQ==
X-Received: by 2002:a05:690e:400c:b0:64a:dbe0:897c with SMTP id
 956f58d0204a3-64c21b7660amr13040987d50.79.1771517785449; Thu, 19 Feb 2026
 08:16:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADbaWgHykWB_EBiqp15W1C+v0OUMG2RXWv7zG_gocp2kgmkcew@mail.gmail.com>
In-Reply-To: <CADbaWgHykWB_EBiqp15W1C+v0OUMG2RXWv7zG_gocp2kgmkcew@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 19 Feb 2026 11:16:14 -0500
X-Gm-Features: AZwV_Qj7w7XpM4qKGYq59O1NQ2mRjhWHR2kGdv__vKpEOvmlN5Nbn82WRJoPHGg
Message-ID: <CABBYNZKPyi=qz-XfiNex2oS3DaJUQq-JN7uOxip90jaaHC2cHg@mail.gmail.com>
Subject: Re: Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add
To: Daniel Matsumoto <me@celes.in>
Cc: luiz.von.dentz@intel.com, maiquelpaiva@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Tue, Feb 17, 2026 at 1:09=E2=80=AFPM Daniel Matsumoto <me@celes.in> wrot=
e:
>
> Regarding commit ac0c6f1b6a58 ("Bluetooth: mgmt: Fix heap overflow in
> mgmt_mesh_add"):
>
> I reviewed the call path for this patch and the overflow condition
> appears to be unreachable in the current tree.
> The only caller of mgmt_mesh_add() is mesh_send() in
> net/bluetooth/mgmt_util.c. The length parameter is explicitly
> sanitized before the call:
>
> if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED) ||
>    len <=3D MGMT_MESH_SEND_SIZE ||
>    len > (MGMT_MESH_SEND_SIZE + 31))
> return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
>       MGMT_STATUS_REJECTED);
>
> Given that mgmt_mesh_add() allocates sizeof(*mesh_tx), which includes
> the param buffer sized for this maximum length, the bounds check
> introduced in the commit is redundant.
> While defensive programming is valid, tagging this as a fix for a heap
> overflow is misleading for backporters and security scanners, as the
> overflow cannot be triggered.

Yeah, well I would say it would only be valid to apply defensive
programming if that function would be marked with EXPORT_SYMBOL so it
could be used outside of net/bluetooth context.

> Please consider dropping this from the stable queue to avoid
> unnecessary code churn.

+1, will drop it entirely, it seems I will need to ask for more
evidence as apparently people are relying too much on LLVM nowadays.

--=20
Luiz Augusto von Dentz
