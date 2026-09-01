Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA3940EBB3
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274320; cv=pass; b=R4LkqXV3n7m+pleP28qk3g6NJuxAYBUJX7Ga3x4lZC6L9nf0v7MtS4Sivi8R9F+BzNGmjeQnM9ZI+ISF0LdYsuHavZ987Ds08x60YHuWolDjRgYD80f/dvd22SQyBDV1lwY5XVUxNgaJUmW6cTkGToVwgoLu8T2mtAlwhI7FmYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274320; c=relaxed/simple;
	bh=NIxKP6TZ2tnFViW03A80ROCVjYwpvgXFgLDGX0G5DlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3Dti+a27+mpuBCLR18G5m8c2FhNRGaIDNFCSUYWkGlZh5nC1pAsEDVosgXjsNTLnrxGISX8ifr7or+IsfWFt9lNsgHF2K29TTUarwTAq38e7HQssQSi2vtFKq8lNh2Lz9eVmVE5cbam6mPBvNhAMg+MaCSWpYlt5q5oDyZ0UPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFC4uFwB; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFC4uFwB"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-861a2ae9c51so9445057b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 07:51:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788274317; cv=none;
        d=google.com; s=arc-20260327;
        b=ap2PYr1cSbIZEEj/r9/6CLEPjWidXrgd9rBlFf+5Jp8b7N3aSDbZi73ckzKemQTDfm
         QGZZ6pho9Mw6NQNOJUi3ZmTOZR0Rc/uPuwLxixuE8wYl2bhLFRWrDtZl+yzR0L/wpwt6
         buhTxdeg5QZXLw/0o57SqAa6ZSKxhPZhg4KX6UOwUT8YdHczVrOaJdJhnqCuYRGaATVv
         DpGSPcpF6+XBTey2g46digHFGS1O3kW8yCRWGUGfSy85wvMM3rMWXOEDiOzZze8avTAX
         Te+MYK7MilzeinB7CbvZZl/1YNIAf0DVUGxjujvDOrRA/IGwfLNTuDPmm/A1XAp9nV82
         l0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7zEecowGV0URQUsGJB/9dYqORlnjv4pnsG8QOqOs5tM=;
        fh=+Qn5MvUE9KQK3P2J9RgLcpUvl5JaNAJPH7s3l36hIbQ=;
        b=DtfN40cyi6NaZTZPQoX0AHrV7on9UXcPa0JliOuFYBC7s0MXnOrMpN58sc1YKk2dsp
         vh+yO7/bLoNavHOHlvLlyXspZmGXw6ePOUPO3eG68Xq5St8WDZi3Ypjt97bUnxfIEldy
         wDAYBBvOaTNwHjaZPpuNuexXHmhCoOUBIcoTJq1B+dTfyI7VscZ/Y32pQ3IQRjvUv1sm
         9KXDdkV6djnF2zNyYQAni3535kxJzqZz3wPXWKpUYtBOu+WU75CNnhh9xIdNoaAsnHo9
         Epa8fpzd1dpNtI1yh/gdhV3lErVWVfCoHEr4as4/SbM2FYfgAPT69m4hcDFWshy/vSDo
         cUIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788274317; x=1788879117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7zEecowGV0URQUsGJB/9dYqORlnjv4pnsG8QOqOs5tM=;
        b=TFC4uFwBZ8vt70wQxkNT1YRMIM+4KNpQ11GJH7r6MK+9n2bt0NQkqnSJqoSbyWfiv7
         2RBg7DmAzdfsZkDAPrHfPy10970vUvRc6HjDnUdPWbNVZu7I1txhaEY5VcRsNSGTmCoO
         qP6OXZ04RzMZUhCkxyAthZ9nFjFdMundMP+84XWpBjUWTtdxfNOm3/l+jF59tjXu6tAW
         fIfTObJopb3BLPb1GXOdufm8e3CDdHuxnSi8hKSNPEMgzC/O4AsTFg25jsrPDQFBTD7m
         uCUKjcfRXAkNotWQ90tr32liskDn6cptUSDfadASdWZkPLLod9Ua0Zt8cpE4MDb6rwCe
         5g2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788274317; x=1788879117;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7zEecowGV0URQUsGJB/9dYqORlnjv4pnsG8QOqOs5tM=;
        b=LVxieH9vcRSBx/d7JPMXKDpaipKO9l42XaPy20QyoU3+xqeaHAajDl3884nfARvH2A
         4dDlCk20s3rKRyzZ/gG1RJ0Th21CwVUBoJsnjgp9Q7TFqly59Vncn/D098XaM5XxLW3L
         hGVK7S4+TwqGnoy7oqHo0ISIH/Vsvn33mCk65NOnbbEs060jcRFgXMAP67AhF3QcO/od
         eZ43jvKuChnN1Er/loUPlYov2eN0nz35teoZ3dxSI4VTYRRyrjD/Z8lD1sQzuDPVaNro
         ee0UoD84FprIymlFEIZVi2siWPbnpRwtT+ce43zki5R60/2/fqIpzLy2cdmXdOTJEbWR
         R7Zw==
X-Gm-Message-State: AFuF++n8z7Uoqs3SUNFKC8Ex9GMUsbnTZsBj9qIon0J4lNC2q/7uV1ai
	ug7NiVsroKOuhyQJ7JLaOdZzay3VT+DK8zvnjhc4jCPnbMLjyV6lwxZADb39fVO2jG3qBZuvPfE
	ZdYvq7wvMjRpgzAQcahSe8OHaM+0laoI=
X-Gm-Gg: AYBFou3Y05QGhudOYfVVMnSxp5WGTXCxgZhX4iwd2hScrzDpIUZpk9bYOPupS58gS8W
	/dfV5pJJ9E3XveKzyYVQT2V5PRpHm6V9d9fwjfpDQdXrEv/ns9AbaJ4DeG1R8PlPlk/cOlYUocW
	oMbQ34oGym6KAac0yWLxLgJXK68EfpWikj1Vcu1fiFly/NE9k/XH1eqbbm29q3cZWspgOphgyya
	t+4FfWesxRN4QuqlngB9mk1vOsufdAVsNmKM9sbY4OQGPDUsC/klCS//sa23QBg/b/LdNUbfLPp
	MzB2mxuYxZ7T756g6p90G986iY9txePFWoahvj0xM4A9jPkUUOyOpIKLMuGhcQ1504r/AUrOCXf
	Ct6QsNG3BtGDZI22oQark9S+AjSP3
X-Received: by 2002:a05:690c:c3c4:b0:81d:c233:aea0 with SMTP id
 00721157ae682-85d6a2e184fmr110198737b3.18.1788274317111; Tue, 01 Sep 2026
 07:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831090232.1726063-1-valentin.kindschi@fiveco.ch>
In-Reply-To: <20260831090232.1726063-1-valentin.kindschi@fiveco.ch>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 1 Sep 2026 10:51:44 -0400
X-Gm-Features: AcwNN1WJq7njKzkqAQuAxRsZa-_LfUiBoeox2YdRn2bi-oxKnMKFo1GT_Jvq8ys
Message-ID: <CABBYNZKp=a8+YQDj_b=jcmA1tVxW8HJG8yvsCFQHuDghZPmFzw@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: hci_sync: pause advertising for the scan
 address update
To: Valentin Kindschi <valentin.kindschi@fiveco.ch>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	johan.hedberg@gmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Valentin,

On Mon, Aug 31, 2026 at 5:03=E2=80=AFAM Valentin Kindschi
<valentin.kindschi@fiveco.ch> wrote:
>
> hci_active_scan_sync() calls hci_update_random_address_sync() with
> require_privacy set on every active scan start, which generates a
> non-resolvable private address and programs it with LE Set Random
> Address.
>
> BLUETOOTH CORE SPECIFICATION Vol 4, Part E, 7.8.4 states the controller
> shall return Command Disallowed (0x0C) for LE Set Random Address while
> legacy advertising or scanning is enabled.
>
> Advertising is only stopped beforehand when LL privacy is in use.
> hci_pause_addr_resolution(), called just above, returns early when
> !use_ll_privacy(hdev), so its hci_pause_advertising_sync() never runs.
> On a device that advertises while active scanning - a peripheral that is
> also a central - every scan start therefore issues a
> command the host can already know will be rejected:
>
>   Bluetooth: hci0: Opcode 0x2005 failed: -16
>
> The address write is not retried either: hci_set_random_addr_sync()
> defers only when hdev->random_addr is already set, and it never becomes
> set because the write keeps failing, so HCI_RPA_EXPIRED is not used here.
>
> Observed on a BCM43455 with Privacy=3Doff, one advertising instance and
> continuous active discovery, at the scan restart period (~10 s):
>
>   < LE Set Random Address  Address: 02:16:91:90:F1:D4 (Non-Resolvable)
>   > Command Complete       LE Set Random Address, Command Disallowed
>   < LE Set Random Address  Address: 26:90:57:96:9A:3E (Non-Resolvable)
>   > Command Complete       LE Set Random Address, Command Disallowed
>   < LE Set Random Address  Address: 16:32:01:BC:B5:CE (Non-Resolvable)
>   > Command Complete       LE Set Random Address, Command Disallowed
>
> Pause advertising for the address update regardless of privacy, and
> resume it on every exit path. Previously the resume was guarded by
> use_ll_privacy() and only reached on the error path, which matched the
> pause being privacy-only.
>
> One caveat this widens: when HCI_ADVERTISING is set,
> hci_pause_advertising_sync() also clears HCI_DISCOVERABLE and zeroes
> discov_timeout, and hci_resume_advertising_sync() restores only
> HCI_ADVERTISING. That side effect previously happened only with LL
> privacy; it is now reachable on every active scan start, so a device made
> discoverable through mgmt while repeatedly running active discovery would
> lose discoverability. Restoring it belongs in the pause/resume pair rathe=
r
> than here, but it is worth flagging.

Sashiko flagged this, so I think we need to fix it; otherwise, the
controller will not be considered discoverable upon resume:

https://sashiko.dev/#/patchset/20260831090232.1726063-1-valentin.kindschi%4=
0fiveco.ch

> With the patch, the same scan restart on the same hardware:
>
>   < LE Set Advertising Enable                            Success
>   < LE Set Random Address                                Success
>   < LE Set Scan Parameters                               Success
>   < LE Set Scan Enable                                   Success
>   < LE Set Advertising Parameters                        Success
>   < LE Set Advertising Enable                            Success
>
> Over 35425 records / ~4 min of btmon with continuous active discovery and
> advertising enabled there were no Command Disallowed responses of any
> kind, against one per scan restart before. A central could still connect
> to the device, confirming advertising is restored after the pause.
>
> A second capture on the same device, 221 s with an out-of-range peer
> causing two cancelled outgoing connections, shows the same result under a
> different mix of traffic: 2 LE Set Random Address, both Success, and no
> Command Disallowed of any opcode.
>
> Tooling disclosure (Documentation/process/generated-content.rst): an AI
> coding assistant was used to investigate this and to draft the change;
> the patch text and code are its output, reviewed by me. Inputs were btmon
> captures and kernel logs from the affected device, with the request to
> identify what re-issues LE Set Random Address every ~10 s and to fix it.
> Three earlier explanations it proposed were discarded after being checked
> against the captures: bluetoothd restarting service discovery; RPA
> rotation (excluded, Privacy=3Doff); and the static-address branch of
> hci_update_random_address_sync() (excluded, both random_address and
> static_address read 00:00:00:00:00:00). The cause was only established
> after decoding the command payloads, which showed a freshly generated
> non-resolvable address per attempt. Testing is as described above, on the
> device, using btmon and a second device to confirm connectability.
>
> Fixes: abfeea476c68 ("Bluetooth: hci_sync: Convert MGMT_OP_START_DISCOVER=
Y")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5 btmon
> Signed-off-by: Valentin Kindschi <valentin.kindschi@fiveco.ch>
> ---
> Changes in v3:
> - Resend, no code change; v2 had no reply. Rechecked that it still applie=
s
>   to bluetooth-next.
> - Added the second capture described above, taken with the two patches fr=
om
>   the "endless adv params retry" series applied, since in bluetooth-next,
>   confirming the fix holds with cancelled outgoing connections in the mix=
.
>
> Changes in v2:
> - Rebased onto bluetooth-next: mainline renamed use_ll_privacy() to
>   ll_privacy_capable(). No functional change.
>  net/bluetooth/hci_sync.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -6244,6 +6244,14 @@ static int hci_active_scan_sync(struct hci_dev *hd=
ev, uint16_t interval)
>         if (err)
>                 goto failed;
>
> +       /* LE Set Random Address is disallowed while advertising is enabl=
ed, so
> +        * pause it for the address update. hci_pause_addr_resolution() a=
bove
> +        * only does this when LL privacy is in use.
> +        */
> +       err =3D hci_pause_advertising_sync(hdev);
> +       if (err)
> +               goto failed;
> +
>         /* All active scans will be done with either a resolvable private
>          * address (when privacy feature has been enabled) or non-resolva=
ble
>          * private address.
> @@ -6272,13 +6280,18 @@ static int hci_active_scan_sync(struct hci_dev *h=
dev, uint16_t interval)
>         err =3D hci_start_scan_sync(hdev, LE_SCAN_ACTIVE, interval,
>                                   hdev->le_scan_window_discovery,
>                                   own_addr_type, filter_policy, filter_du=
p);
> -       if (!err)
> +       if (!err) {
> +               /* Advertising was paused for the address update above. *=
/
> +               hci_resume_advertising_sync(hdev);
>                 return err;
> +       }
>
>  failed:
> -       /* Resume advertising if it was paused */
> -       if (ll_privacy_capable(hdev))
> -               hci_resume_advertising_sync(hdev);
> +       /* Resume advertising if it was paused. hci_resume_advertising_sy=
nc()
> +        * is a no-op when hdev->advertising_paused is not set, so this c=
overs
> +        * both the privacy and the address-update pause.
> +        */
> +       hci_resume_advertising_sync(hdev);
>
>         /* Resume passive scanning */
>         hci_update_passive_scan_sync(hdev);
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
