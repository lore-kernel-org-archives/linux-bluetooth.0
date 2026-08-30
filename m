Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8D7184540
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788127736; cv=none; b=TqRkhzUA7iRcwZbbx8ithXZ1NBTlGYvNnQ286dELk1+sBp9eibvH/R5jtI3M7CSrcekXbOvnmUS4xkqRn0+thTWD4TUQBPTbWdWL/L3xzzUHFPsd8FG0YggMk+7EcXPyncB951jJnIBmP2ILTXm3dUwDczVWxoIS7Z3bA/e12nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788127736; c=relaxed/simple;
	bh=g2j2IeNJMHer59oMOyYclwy/ipajJKHP0i7mhbRiyR0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=rbL7wwLX00mcm5sVWi1Xs3AFvs/VwkWPuYnuOJ3dX8F1gG+tHKaMb/WQDst6NOTnAOCQ8FzpGIWWtFjHnokjACxhQWb3gQtFJXgSUuynUCDVwiHy2Md+HW2hm/87lk8OqbT8EQr05Z+1HbukbUM7lgrysLJZx/uglAvN9gm+vzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMHU1fso; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMHU1fso"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49954b88fffso19297285e9.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 15:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788127733; x=1788732533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from
         :content-language:to:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bkEvr74vBzbiXy0alwmTTIUWhfdGz3Dq/F8qxJ4w52A=;
        b=NMHU1fsogQgPNN/Hw2FcifBLwqPGM7/+vpJTqHNCUqd9mfOIiZLD2iYv7YKUM5ryJK
         C4H532O5Qa/dgRMnn6ZZAl+GEZ4A476yxiao9EY0O2NaKkiJMe4cpq/rd56kRNA8plc/
         xbgQf9hG7A95xtppmhKWWqVjIF2K6T64i6k2wGoh3XET1oiVQ1thRpYPhh9pkSTufke7
         BFPysVJg5m0sLT8HHHd8tlLtdoFfcYZuI1dzzxl3oCem0kYa9q9NNOK+T4RefxNXhdkN
         zn6veeja1CNcU8FhrfH1+E9TB+frw2fUS2YJVDAZQA+CriHYtc84ofpYrDdba/B6yKzY
         1Vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788127733; x=1788732533;
        h=content-transfer-encoding:content-type:subject:from
         :content-language:to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bkEvr74vBzbiXy0alwmTTIUWhfdGz3Dq/F8qxJ4w52A=;
        b=aYckx2wVikF4PChwI+PSZoqcsfF4XI5orI2fvepDixYRRD9xLI02b4ynjsu/EagMfO
         lIBQW5V/ZfDqAYJlRDYQ5rOTepygrRpinVZJGLEm3/k3rRWIBzcQWEd7kXi1EGfDGBY1
         w04AN0YCJ7TMNnbz5u24TGXdbGHzGVkJPfqE0rrcX+FfJaKkJf5hepLfXeXqtI+oziUV
         TjuUJLPQJLr/yH6tNHZiWs7fQQ/C3ClMDScpIJuewqK51ZFhAC49/ysVTjSKkObSKysM
         aRekSDIxlo9p6syLwyJt5t311M/hZTqz/AR2k/1Dq7XY5c10OGzc71uODY74ACIZo6WL
         AvWg==
X-Gm-Message-State: AFuF++l+jLnILmo+GFzjokPnoC8SjtT8CPlWOFTMd1rs/a8uUctMurdG
	uL0s4fwVF9DmumPfISHML5qEIXe3TFXYGxbNAOtyz6CWlRIgmFOfL9h57gIj6A==
X-Gm-Gg: AR+sD1126oLKOvPkaDwFyHwqrYfy0PZbPLULD2guMGLkkwz57DcePpLzyCLfwLSI+hX
	kpKpK/UpVqT9v/gvuXcQuqmrozxXP60rr2OAB2oE5kzugaU2J1/KmLn3egr4mcmssnyRjjmRbgM
	N1vVf3uSCV5pUP6M9N2aU5+jcEnr1bOUpcRrfPYN4KeEP5/AiJCJUD9X24fBSszipxbTiBlC70q
	JarpspadZtJJNrxAKdHspDmsvHC4gZAg8Ur6LNYNPTtoLumslvRjoKVfe7rQitpzNLu/xn5pFbw
	40YAsgaGL06K0bn5mJVbTL8m53VqbNVB1XbdosNl3fXMYnCmcFwFUtO+qr03m6dyIk7kxgyPAfF
	FN9Tnrgs9Gf+Xdt/4TPlcnZLu3S89Uidy4wGX37amGV6/JL02IA8VliVvrcHKUu9YetmVMZA7mi
	HKw9F25uOF1/NysdxpF4b/fztY1HJQIJ1R38OPqwTOGw+ueSLTTJzZNIjOOL/ZdgOYCHv4vE4X1
	Ki+PUkLqw==
X-Received: by 2002:a05:600c:4443:b0:499:d63b:a6da with SMTP id 5b1f17b1804b1-49b91c17149mr309786465e9.2.1788127733019;
        Sun, 30 Aug 2026 15:08:53 -0700 (PDT)
Received: from ?IPV6:2a02:8071:5383:42a0::1012? ([2a02:8071:5383:42a0::1012])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ccea6b814sm128132785e9.0.2026.08.30.15.08.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 15:08:52 -0700 (PDT)
Message-ID: <7d7d0ef5-1ac1-45f8-8e95-0a94435b17bc@gmail.com>
Date: Mon, 31 Aug 2026 00:08:51 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-bluetooth@vger.kernel.org
Content-Language: en-US
From: =?UTF-8?Q?Marvin_G=C3=B6pfert?= <marvin.goepfert@gmail.com>
Subject: btintel_pcie: -EBUSY from PM callbacks aborts system-wide
 hibernate/suspend
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

# btintel_pcie: -EBUSY from PM callbacks aborts system-wide 
hibernate/suspend

## Summary

On an Intel BE201 (`8086:a876`, PCI `0000:00:14.7`) the `btintel_pcie` 
driver
intermittently returns `-EBUSY` from its PM callbacks. Because the callback
fails, the kernel aborts the *entire* sleep transition and rolls back — 
after
the hibernation image has already been written. The machine silently stays
powered on. For a laptop this is a real hazard: closing the lid appears 
to do
nothing and the machine keeps running in a bag.

The proximate cause is visible in the log: the driver times out three times
waiting for the "alive interrupt" for D3 entry, then gives up.

## Hardware / software

| | |
|---|---|
| Device | Intel Corporation `8086:a876` (rev 10), subsystem `8086:000e` |
| PCI slot | `0000:00:14.7` |
| Driver | `btintel_pcie` |
| Firmware | `intel/ibt-0190-0291-pci.sfi`, Firmware Version 107-8.26 |
| firmware pkg | `linux-firmware-intel-wireless 
20260319.git217ca6e4-0ubuntu2.1` |
| Kernel | `7.0.0-1011-oem` (Ubuntu 26.04.1 LTS) |
| Machine | Dell Pro 14 Plus PB14250, BIOS 2.16.0 (2026-08-03) |

## Steps to reproduce

1. Boot with Bluetooth enabled and the controller in use.
2. `systemctl hibernate` (also reproducible via `systemctl suspend`).
3. Observe that the hibernation image is written completely, then the
    transition is rolled back and the system returns to a running state.

Not deterministic: the same kernel and firmware succeed on many attempts. It
correlates with the controller already having logged `Controller in error
state`, which on this machine happens frequently at driver init.

## Actual behaviour

```
kernel: PM: Image saving done
kernel: Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D3 
entry, retry count 0
kernel: Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D3 
entry, retry count 1
kernel: Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D3 
entry, retry count 2
kernel: btintel_pcie 0000:00:14.7: PM: pci_pm_poweroff(): 
btintel_pcie_hibernate [btintel_pcie] returns -16
kernel: btintel_pcie 0000:00:14.7: PM: dpm_run_callback(): 
pci_pm_poweroff returns -16
kernel: btintel_pcie 0000:00:14.7: PM: failed to hibernate async: error -16
kernel: PM: hibernation: Wakeup event detected during hibernation, 
rolling back.
kernel: PM: hibernation: hibernation exit
```

The same `-EBUSY` was also observed from `pci_pm_suspend()`
(`btintel_pcie_suspend`) and `pci_pm_freeze()` (`btintel_pcie_freeze`) on
2026-08-23, i.e. plain suspend is affected in the same way. Those journal
entries have since rotated out; the hibernate case above is from 2026-08-30.

## Expected behaviour

A Bluetooth controller that cannot reach D3 should not veto a system-wide
sleep transition. Either the driver should recover the controller (it 
already
has a reset path) or force it down and return success, so the transition can
proceed.

## Additional observation: rfkill makes it worse

Soft-blocking the controller before sleep (`rfkill block bluetooth`) as a
gentler alternative to unloading the module does **not** help — and 
appears to
trigger the failure. Immediately after the block, and immediately before the
`-EBUSY`:

```
kernel: btintel_pcie 0000:00:14.7: reset done
kernel: Bluetooth: hci0: Controller in error state
kernel: Bluetooth: hci0: Intel Soft Reset failed (-62)
kernel: Bluetooth: hci0: Controller in error state
kernel: Bluetooth: hci0: Intel Soft Reset failed (-62)
kernel: btintel_pcie 0000:00:14.7: PM: pci_pm_poweroff(): 
btintel_pcie_hibernate returns -16
```

So the rfkill-induced reset is one way to put the controller into the error
state that then blocks the PM transition.

## Related instability at init

The controller frequently fails to come up at boot on this machine, 
requiring
one to three `modprobe -r btintel_pcie && modprobe btintel_pcie` cycles:

```
kernel: Bluetooth: hci0: Firmware loaded in 776747 usecs
kernel: Bluetooth: hci0: Controller in error state
kernel: Bluetooth: hci0: Timeout (3000 ms) on alive interrupt, alive 
context: intel_reset1
kernel: Bluetooth: hci0: Failed to send frame (-62)
kernel: Bluetooth: hci0: Intel Soft Reset failed (-62)
```

Firmware load time correlates with the outcome: successful inits load in
50–110 ms, failing ones in 540–780 ms. Occasionally no number of module
reloads recovers it and a full power-cycle (AC removed, power button held
~20 s) is required. This may or may not share a root cause with the PM 
issue,
but it is the state in which the PM failure occurs.

## Workaround in use

Unload the module before sleeping and reload afterwards, via
`/usr/lib/systemd/system-sleep/`:

```sh
case "$1" in
     pre)  modprobe -r btintel_pcie ;;
     post) modprobe btintel_pcie ;;
esac
```

This is reliable, but forces a firmware re-download on every sleep cycle,
which in turn is the main opportunity for the init failure described above.
