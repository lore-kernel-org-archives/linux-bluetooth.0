Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB382153F1
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753300442; cv=none; b=AOmLphOC/rOq3igu0yHZos0/2TwkYdp3SPhqMuNnol/XbK1pMXGGi3Aq0ZHpFkBXiIahbOE27g0pPEskmWmWXbNh0WlhaVH/zBIv2c0/MPlq3MMWboFZiOGZtQ0FxKZzHuepYRmpIY27JGBs7AjtMccXcm2r4zYQZByouO54beQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753300442; c=relaxed/simple;
	bh=IK9n4Xo4LjTxAV7ptSLaGh+h4N9HIqwMf0gkU5WpsEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jm1yPCd5Qk0u3c1OEcmLZIyyxgxngOHAZpK0Bn1SLulbw0E2RbnqJ4ZNK8KZQZSQJba5k83xvXnSdoUlMqdltkNSywy26Ds7ZXPb8EaFazEJ1unnPVzlqX6XxosTYlNlDsHygLtpGfHwc6of1vkeHH3cSVz8rebUCLDXsNPm0N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VW4zzJyu; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VW4zzJyu"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-558facbc19cso175254e87.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 12:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753300439; x=1753905239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxKftiO1qrHyaZfmP22o7aBCjP2p/zUq5xqkX1T9U3o=;
        b=VW4zzJyuegZhf1sG96qJkbX6jTopTg/DeA1QWB80P1xBfa+BkhukBwH2ek7PwHYDpN
         VRkAmeIKuWprFy7iAWdpeHr8Ma4CpZjrVZczTVNvtbCRYU013TWNVWNNdimAMiGbDLwM
         uNYz6k+keaok7oB/dr90d4AH0OUV2bldq0RH5qWN1E03EIb+8BnyF2yymD4N/jJX/6it
         LjJyzw1FxSpVMWLoziTVua2Bnj2IAAyHotySPU5/SPPNZUnsjZalK6X7SFYOSmAOOFjS
         TX2Gop9SkCIT8CzdemWQLJD4TJG4Xnmc6xdB25P++y+0KlOyOElnCr34+RFZUpuhgpc6
         IJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753300439; x=1753905239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxKftiO1qrHyaZfmP22o7aBCjP2p/zUq5xqkX1T9U3o=;
        b=oeVFURB46x6k12Y1mF204O/GvmJluzi6mCbFvpv60fkmzOdckmhA0iJOl3f6AGmIfR
         ZwALdrfI20t3PyIpjJxYXHkAv0qko4GHsgyLruRKwsKJ7TiwTODRw4dVrS5ZCyfdCCOD
         b2EQfOjjA+eHQtL6Wy7fQRbqZ68pisQxVDjtImDue0jZMg77Bl8QkpHnBAo/0/no97BC
         7OBq2mthql6yt1rRrgYYI4XTYRfiO9NytHbZL3XEkdW+x4XLmYhQaqjf36/yX/TnqkSe
         AeADBAp7sykfmkUtQ+aLte9aQiz7vcuEzDia7mLdfu5z5VBYHI3zqcg7WtJvHYe0/usc
         AP2Q==
X-Gm-Message-State: AOJu0YyXtUhbCynmnkMCjHGICgPCEt8niUovRGEJ8HvxpRdB3W2AqVuL
	jtQXy5lA5QrsTBiz7pdUJrX7CTX+YnAHqfVDKdwsrrAPLs0D9VfpvPxT1cGQWQzkuwfCeGYpHFg
	f524Ys3yikmtf9R8pfILphhQejXc9nXX3t7Px
X-Gm-Gg: ASbGncsOLx61bfTDAD+3xBDghADjbZmHL+eADwJf1oIbXVEF28676rqENBQbQ1kqaAv
	M/Cs2n5SRPvJZevZH737S2MO4GtZHUFFKrHvCrTlES3mQYGfHFJf3ReLHMgTBDT9mhqQb/NCWla
	nSWwBf5nwP9EhLnjg1QpejHNJjf1PhJBZuv7vMmT1cS5tJR4r7Hr+NntA0mSFSqirvoW3fVvRXR
	RlBa0Il8Br5qxv/
X-Google-Smtp-Source: AGHT+IHdzC9J6Kq7yg4C+WG8uZ48B3Z9loedFSfLIDyj9O0jd1N6qmzQF5jikjVFcgw88YIh+e92NdUcHf3hpJUOYyo=
X-Received: by 2002:a05:6512:1044:b0:553:2f72:9ce0 with SMTP id
 2adb3069b0e04-55a51432ademr1393868e87.52.1753300438150; Wed, 23 Jul 2025
 12:53:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723134453.1301750-1-kiran.k@intel.com>
In-Reply-To: <20250723134453.1301750-1-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 23 Jul 2025 15:53:45 -0400
X-Gm-Features: Ac12FXyRVUsL1Z4j2mYotYC8saKTi0Hv6ITCvi2dNUErs5qTV8K18UZ1ZfJr46c
Message-ID: <CABBYNZJ-Ypx-EqrFijnzpbEXwaCSCxeNDLchV_QU0Z00BRpZVQ@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel: Add support for BlazarIW core
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	Vijay Satija <vijay.satija@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Wed, Jul 23, 2025 at 9:34=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
>
> Add support for the BlazarIW Bluetooth core used in the Wildcat Lake
> platform.
>
> dmesg:
> Bluetooth: Core ver 2.22
> Bluetooth: HCI device and connection manager initialized
> Bluetooth: HCI socket layer initialized
> Bluetooth: L2CAP socket layer initialized
> Bluetooth: SCO socket layer initialized
> Bluetooth: hci0: Device revision is 0
> Bluetooth: hci0: Secure boot is enabled
> Bluetooth: hci0: OTP lock is disabled
> Bluetooth: hci0: API lock is disabled
> Bluetooth: hci0: Debug lock is disabled
> Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> Bluetooth: hci0: Bootloader timestamp 2023.33 buildtype 1 build 45995
> Bluetooth: hci0: Found device firmware: intel/ibt-1190-00a1-iml.sfi
> Bluetooth: hci0: Boot Address: 0x30098800
> Bluetooth: hci0: Firmware Version: 184-28.25
> Bluetooth: hci0: Waiting for firmware download to complete
> Bluetooth: hci0: Firmware loaded in 67426 usecs
> Bluetooth: hci0: Waiting for device to boot
> Bluetooth: hci0: Device booted in 2248 usecs
> Bluetooth: hci0: Waiting for device transition to d0
> Bluetooth: hci0: Device moved to D0 in 0 usecs
> Bluetooth: hci0: dsbr: enable: 0x01 value: 0x0f
> Bluetooth: hci0: Found device firmware: intel/ibt-1190-00a1-pci.sfi
> Bluetooth: hci0: Boot Address: 0x10000800
> Bluetooth: hci0: Firmware Version: 184-28.25
> Bluetooth: hci0: Waiting for firmware download to complete
> Bluetooth: hci0: Firmware loaded in 510990 usecs
> Bluetooth: hci0: Waiting for device to boot
> Bluetooth: hci0: Device booted in 39057 usecs
> Bluetooth: hci0: Waiting for device transition to d0
> Bluetooth: hci0: Device moved to D0 in 88 usecs
> Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-1190-00a1-pci.ddc
> Bluetooth: hci0: Applying Intel DDC parameters completed
> Bluetooth: hci0: Firmware timestamp 2025.28 buildtype 1 build 96440
> Bluetooth: hci0: Firmware SHA1: 0x34b85c16
> Bluetooth: hci0: Fseq status: Success (0x00)
> Bluetooth: hci0: Fseq executed: 00.98.00.05
> Bluetooth: hci0: Fseq BT Top: 00.98.00.05
> Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> Bluetooth: BNEP filters: protocol multicast
> Bluetooth: BNEP socket layer initialized
> Bluetooth: MGMT ver 1.23
> Bluetooth: RFCOMM TTY layer initialized
> Bluetooth: RFCOMM socket layer initialized
> Bluetooth: RFCOMM ver 1.11

lspci is probably better than dmesg when adding new models since what
matters here, or there is no change in the lspci? If it doesn't them
it probably better to add the response of Read Version TLV, we do have
decoding of it:

https://github.com/bluez/bluez/blob/3c0693c5d22606f786da4389103740424a04213=
b/monitor/intel.c#L297

Perhaps we should add a decoding for the version code name rather than
just print version number, anyway dmesg is just not useful in general
and we actually should reduce the amount of information we print there
using bt_dev_info.


> Signed-off-by: Vijay Satija <vijay.satija@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c      | 3 +++
>  drivers/bluetooth/btintel_pcie.c | 1 +
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index be69d21c9aa7..9d29ab811f80 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -484,6 +484,7 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
>         case 0x1d:      /* BlazarU (BzrU) */
>         case 0x1e:      /* BlazarI (Bzr) */
>         case 0x1f:      /* Scorpious Peak */
> +       case 0x22:      /* BlazarIW (BzrIW) */
>                 break;
>         default:
>                 bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%=
x)",
> @@ -3253,6 +3254,7 @@ void btintel_set_msft_opcode(struct hci_dev *hdev, =
u8 hw_variant)
>         case 0x1d:
>         case 0x1e:
>         case 0x1f:
> +       case 0x22:
>                 hci_set_msft_opcode(hdev, 0xFC1E);
>                 break;
>         default:
> @@ -3593,6 +3595,7 @@ static int btintel_setup_combined(struct hci_dev *h=
dev)
>         case 0x1d:
>         case 0x1e:
>         case 0x1f:
> +       case 0x22:
>                 /* Display version information of TLV type */
>                 btintel_version_info_tlv(hdev, &ver_tlv);
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 6e7bbbd35279..d08f59ae7720 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -2149,6 +2149,7 @@ static int btintel_pcie_setup_internal(struct hci_d=
ev *hdev)
>         switch (INTEL_HW_VARIANT(ver_tlv.cnvi_bt)) {
>         case 0x1e:      /* BzrI */
>         case 0x1f:      /* ScP  */
> +       case 0x22:      /* BzrIW */
>                 /* Display version information of TLV type */
>                 btintel_version_info_tlv(hdev, &ver_tlv);
>
> --
> 2.43.0
>
>


--
Luiz Augusto von Dentz
