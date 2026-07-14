Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A6728751B
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032944; cv=pass; b=rcl/WlQqDBy47vVRU1AOeggbNKEBiQRcAHrq7rNz1LxuTo0nA671STKraXr4sJ0O0w2bhc0kldWvugzBThjgE/KRdIzVIaBVyxUz6ogo/Za2Avj89CjqHxcGnhTQ2ciga3yjxUB1jTRIHiircJ9vySD24pVB5mgfFafR2RD11Po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032944; c=relaxed/simple;
	bh=Q02fasoEx743KNWC3sJ06EbS84NB6pnvoF3c3X5gMPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCld3UOwv5UPdg2Bx+JkKt9tbvmvZHPGpTHhFxlhJ3J4HcjWW3y3wpV+vT47vgsYAULG8BES/RwmIcPhCw54C5BSBJKMXgsfcqtCpDoWHBrOaStGbAKJtrpFjk6LHkfxxWrU5M6iGq4cpyYy41nfWIa1Ef5O1LB+raaOOWkP0Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkHWEOdI; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkHWEOdI"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-664e3ed58bcso1335216d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 05:42:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784032942; cv=none;
        d=google.com; s=arc-20260327;
        b=RBx2EQ7CE6vS/5R+0i4cQZ76I+D6HsFmHHtvS3bSPCMR3u7TAY+m75qKlqMcpgU5Xt
         TBad02ZeomICLzXOgOQvj+vvnza1sixbD7WEwvWkIOVes2jnI+CVzXJub17XGfbC1ent
         BmtXvh2IiiIhAH2Tz2i0SsRaIgU9He3OSYzymAFCg9xhl0cNU4HNBkGbgniNwckV5vwZ
         gfJvooeUKI8BwGfHVk45vCk/PERSncOJHSBUt0G8+aS9hWS+bJydONGBX+YJfpyTCGlz
         /38FgqjOLfJsVLJZBQKz0UUWOkmXDgUC94M55hEE3Wqj2abZhBcacxWqHoFVkuWAUnRU
         uJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QHNFQwGwvPNhEiSWHD3Kb+fp/5rmXxMz+PlfsCaIDUI=;
        fh=kuWs0MQdxjKAKHnVbu79j2bwH32LhwsN8SkwwMg2OYU=;
        b=m2hmQpHogF7K4baWC4NoreNAt4ke9Q3gOLvNCv6rCKOf9HGREsGccNW4AbZTFGdZkG
         Z0Szjuh6RpVBjLsXBXf3ajxS3QM7A+7H3ypfW2XGxzsPdAak0he93CmduP8Q+Rkmc8p0
         9G3f2DwaDEC4ApqDHS5YOPlfliMEY5GZuktWzBMc274lspW2/vjlXrPyNpsQFNM7EGHR
         5lpZuHWBeJMqTO9d473ZIRBQ3cEskIvo0eM0uHXwHO5r9Jx65fcHZX+8dUY1lQ2qswm1
         AvxhkMPtTZbz0aTpAcRFHcFK3i85FqhZVnYzLJAJCce2pA12R8nK0OqUMcp2q7TuEbes
         xOVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784032942; x=1784637742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QHNFQwGwvPNhEiSWHD3Kb+fp/5rmXxMz+PlfsCaIDUI=;
        b=ZkHWEOdIinH2dRwQJnlpL/uZQG3WM2R+5G5hj/ModoeGUq5R+3NXtao26QuAxCE2iN
         TATSqIvjlD1C3mFWNwOHsj8Pmq+ytize4nDL0R0gfRBSOvmuZCWyCzlk7v7Jot9P7Gh8
         NCPXew/FxGj97CrLZmN+dTnWl+f+q0PCOUrAHD5zV4DnF4NlOEa1ni+tvZMplUFk6Lfg
         p9oRRPjJFXaALhgbcI/K0LCmQEpkQQetQLQIMt+OC94Rdos7Cdgw4Oj4crSifmNu6TRc
         EI2OnlpKyne0XLY6VL9SGjHhteZR45s6OhsGtLmYDAGjDUshoMBoql+Er5nZ6aL1Qf9y
         Xjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784032942; x=1784637742;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QHNFQwGwvPNhEiSWHD3Kb+fp/5rmXxMz+PlfsCaIDUI=;
        b=NvDBQDGdUlcaRgXK2ByScVxh/XiaQH4SFTxEJAPBWwpGSBEQxyQYRp8D6pyu2h/xKz
         mdFktb/5yMi2j0zv+AtsxhZ/Bv81izWS97OFcCfq85Shn3BCUpFxr3mBv20AeND+B8t6
         4/FCVeytr9KXPaDF6lHXePG21g/y7lE+xJgbqqRf0MFP9GuuJ40vW7vNH7Y9iOyV+g0L
         q/t+lyuPWYpgnT+sljeeV2cr8mo83W2a7sIWPkZT+pHOu0nKv0xFUGhr6PZ+2HF633Gt
         jjY/oS8Teh+8jp3Pyl0DydZorq24lj0QTOs/hcb0WpGFFARd1T7dXVTyjGQm3uGAsHT+
         P0kg==
X-Gm-Message-State: AOJu0YzwMlH1/jWj7xahLxrgwMS2aVnTvgggsGpw32/8Op+tkombuq6x
	vOEceASPmhqX3ny7UiX/avE4h3eQUnnSlO45qjdZOnqqho/fuo9byMesdS8bqBsWQicADQn/Ka0
	kAl9gu+kmK1T6zf7gr9R/YUOmWh0XMg0=
X-Gm-Gg: AfdE7cnKmxIFmD7CuzuFntU0PKLnliQHI49cNMQm8pWf/eRwOAEnq6a15BGQ3jT5y4Q
	0gIRVyB3vZmNcMN4SCGNd0+mg2j71R08mjldf2fz8sasGiNN2wP1ZvqOrhniOLwgtGGjUfqBFmq
	KRv4+34N2VhcI+mdpORMHb0v8W0tXrtt9fjSaIiMINHjgOtCSvuRU4Cf4Gq187mOWGpPqhBYOSM
	xfJixcm9KseaG919roiK7zqDBKYOkdKLN6MJcFlJpzyHnrP4I+Nxy3482PC75xUrukNgPw2cTAt
	XWETNaSFHuxbRmiUCbuUrFmfc/uH8HWIIs74GWToNls8J2uoa9biq+8v
X-Received: by 2002:a05:690c:e3c1:b0:81e:ba51:9098 with SMTP id
 00721157ae682-81eba519101mr26012467b3.8.1784032941758; Tue, 14 Jul 2026
 05:42:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_A9E80607A55CCF00F26DBE8D8CB605EA5707@qq.com>
In-Reply-To: <tencent_A9E80607A55CCF00F26DBE8D8CB605EA5707@qq.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 14 Jul 2026 08:42:08 -0400
X-Gm-Features: AVVi8CeECIR2cw6qOpmwZNyud9zuIlgnumFDpqya30LctMzNBFEVtAIuGUDqJiE
Message-ID: <CABBYNZJjQDDTHO8=tMGmGmBi9Cgddf4rq=t1iOBgM_Uiyo-czA@mail.gmail.com>
Subject: Re: [BUG] start_discovery_internal forces mutually exclusive BR/EDR
 and LE scans on Intel AX210
To: caitao <294305068@qq.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	caitao <caitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 13, 2026 at 11:18=E2=80=AFPM caitao <294305068@qq.com> wrote:
>
> From: caitao <caitao@kylinos.cn>
>
> Dear Bluetooth Maintainers,
>
> I am reporting a limitation in the Bluetooth MGMT layer that prevents
> independent control of BR/EDR inquiry and LE scan, which persists even on
> hardware that clearly supports such operations.

That is a design choice, you either scan on one bearer or both. It
does not allow independent discovery sessions exactly because you can
discover simultaneously on the bearer.

> [1] Problem Description
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The function start_discovery_internal() in net/bluetooth/mgmt.c enforces
> mutual exclusion between BR/EDR inquiry and LE scan by requiring that
> hdev->discovery.state =3D=3D DISCOVERY_STOPPED before starting any new di=
scovery.
> This prevents:
>   - Starting LE scan while BR/EDR inquiry is active
>   - Starting BR/EDR inquiry while LE scan is active
>   - Independently controlling each scan type
>
> This limitation exists despite the fact that many modern Bluetooth contro=
llers,
> including the Intel AX210 in my system, support independent and simultane=
ous
> scanning as evidenced by the ability to use hcitool commands separately.

The kernel has the following quirk to enable simultaneous discovery:

    /* When this quirk is set, LE scan and BR/EDR inquiry is done
     * simultaneously, otherwise it's interleaved.
     *
     * This quirk can be set before hci_register_dev is called or
     * during the hdev->setup vendor callback.
     */
    HCI_QUIRK_SIMULTANEOUS_DISCOVERY,

    case DISCOV_TYPE_INTERLEAVED:
        /* When running simultaneous discovery, the LE scanning time
         * should occupy the whole discovery time sine BR/EDR inquiry
         * and LE scanning are scheduled by the controller.
         *
         * For interleaving discovery in comparison, BR/EDR inquiry
         * and LE scanning are done sequentially with separate
         * timeouts.
         */
        if (hci_test_quirk(hdev, HCI_QUIRK_SIMULTANEOUS_DISCOVERY)) {
            timeout =3D msecs_to_jiffies(DISCOV_LE_TIMEOUT);
            /* During simultaneous discovery, we double LE scan
             * interval. We must leave some time for the controller
             * to do BR/EDR inquiry.
             */
            err =3D hci_start_interleaved_discovery_sync(hdev);
            break;
        }

static int hci_start_interleaved_discovery_sync(struct hci_dev *hdev)
{
    int err;

    bt_dev_dbg(hdev, "");

    err =3D hci_active_scan_sync(hdev, hdev->le_scan_int_discovery * 2);
    if (err)
        return err;

    return hci_inquiry_sync(hdev, DISCOV_BREDR_INQUIRY_LEN, 0);
}

So it does start LE Scanning and BR/EDR Inquiry simultaneously if
supported (driver sets HCI_QUIRK_SIMULTANEOUS_DISCOVERY).

> [2] Hardware and Software Environment
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> - Kernel: 6.6.0-58-generic (Ubuntu)
> - Bluetooth Controller: Intel Corp. AX210 Bluetooth (USB ID 8087:0032)
> - Firmware: intel/ibt-0041-0041.sfi (loaded successfully)
> - BlueZ version: (please run `bluetoothctl --version` and fill in)
>
> Relevant dmesg output:
>     [ 3.839316] Bluetooth: Core ver 2.22
>     [ 3.839335] NET: Registered PF_BLUETOOTH protocol family
>     [ 3.986759] Bluetooth: hci0: Device revision is 0
>     [ 3.986810] Bluetooth: hci0: No support for _PRR ACPI method
>     [ 3.988198] Bluetooth: hci0: Found device firmware: intel/ibt-0041-00=
41.sfi
>     [ 5.749096] Bluetooth: hci0: Waiting for firmware download to complet=
e
>     [ 5.749738] Bluetooth: hci0: Firmware loaded in 1720250 usecs
>     [ 5.775405] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-00=
41-0041.ddc
>     [ 5.780803] Bluetooth: hci0: Firmware timestamp 2023.48 buildtype 1 b=
uild 75324
>     [ 5.859917] Bluetooth: MGMT ver 1.22
>
>
> [3] Code Analysis
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> In net/bluetooth/mgmt.c, start_discovery_internal() contains:
>
> static int start_discovery_internal(struct sock *sk, struct hci_dev *hdev=
,
>                                     u16 op, void *data, u16 len)
> {
>     ...
>     if (hdev->discovery.state !=3D DISCOVERY_STOPPED ||
>         hci_dev_test_flag(hdev, HCI_PERIODIC_INQ)) {
>         err =3D mgmt_cmd_complete(sk, hdev->id, op, MGMT_STATUS_BUSY,
>                                 &cp->type, sizeof(cp->type));
>         goto failed;
>     }
>     ...
> }
>
> This single state check treats all discovery types as a monolithic operat=
ion,
> rather than tracking BR/EDR and LE discovery states separately.
>
> [4] Expected Behavior
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> - Allow independent start/stop of BR/EDR inquiry and LE scan via MGMT com=
mands.
> - If hardware supports simultaneous scan (via HCI_QUIRK_SIMULTANEOUS_DISC=
OVERY),
>   allow both to run concurrently.
> - For hardware that does not support concurrent scans, either:
>   a) Automatically interleave the scans, or
>   b) Return a clear error indicating the specific limitation.
>
> [5] Actual Behavior
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> - bluetoothctl scan on starts both scans, but cannot control them separat=
ely.
> - Must execute scan off before switching scan types.
> - MGMT_STATUS_BUSY is returned for any scan start request while another s=
can
>   is in progress, regardless of hardware capabilities.
>
> [6] Steps to Reproduce
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> 1. Start bluetoothctl:
>    $ bluetoothctl
>
> 2. Start discovery (both BR/EDR and LE):
>    [bluetooth]# scan on
>    [CHG] Controller XX:XX:XX:XX:XX:XX Discovering: yes
>
> 3. Observe that both scan types are active.
>
> 4. Attempt to switch to LE-only scan without stopping:
>    [bluetooth]# scan le
>    (This fails or requires scan off first)

Why? scan on starts either interleaved or simultaneous scanning. Why
would we need to allow another scan session to a single bearer for the
same client?

> 5. Stop all scanning:
>    [bluetooth]# scan off
>
> 6. Now LE-only scan can be started:
>    [bluetooth]# scan le
>
> Alternatively, using MGMT commands directly (if mgmt-tool is available):
>   # Start BR/EDR inquiry
>   $ mgmt-tool -c "start-discovery"
>
>   # Try to start LE scan while BR/EDR is active
>   $ mgmt-tool -c "start-discovery-le"
>   (Returns MGMT_STATUS_BUSY)
>
> [7] Evidence of Hardware Capability
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The Intel AX210 controller can perform independent scans via HCI commands=
:
>
>   # BR/EDR inquiry
>   $ sudo hcitool scan
>
>   # LE scan (can run simultaneously or independently)
>   $ sudo hcitool lescan
>
> Both commands succeed without requiring the other to be stopped, confirmi=
ng
> that the limitation is purely in the MGMT layer policy, not in the hardwa=
re.
>
> [8] Potential Fix Directions
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> 1. Introduce separate state tracking for BR/EDR and LE discovery:
>    - hdev->discovery.br_state (BR/EDR inquiry state)
>    - hdev->discovery.le_state (LE scan state)

Nope, we allow a single discovery session per D-Bus client. Allowing
independent control doesn't work on some controllers which means
clients would still need to use interleaved scanning anyway.
Independent clients can start sessions independently, though.

> 2. Modify start_discovery_internal() to check only the relevant state:
>    - For BR/EDR inquiry: check br_state =3D=3D DISCOVERY_STOPPED
>    - For LE scan: check le_state =3D=3D DISCOVERY_STOPPED

Why would we want to add this complexity to MGMT?

> 3. If HCI_QUIRK_SIMULTANEOUS_DISCOVERY is set, allow both to be active
>    simultaneously; otherwise, the existing mutual exclusion remains.

Ok, so the model knows about HCI_QUIRK_SIMULTANEOUS_DISCOVERY and
stils argues that is not supported, priceless.

> 4. Update the HCI event handling to properly update both states.
>
> [9] Additional Information
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>
> Please let me know if you need any further details, such as full HCI trac=
es
> using btmon or additional kernel logs.
>
> Thank you for your time and consideration.

Btw, this is a total waste of my time to read an AI-generated message
that argues given your prompt, this sounds more like a question about
why scanning is not done simultaneously which generated this whole
design change based on a question.

--=20
Luiz Augusto von Dentz
