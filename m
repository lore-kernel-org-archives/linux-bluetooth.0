Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0B81F17E8
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Dec 2025 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766243083; cv=none; b=J9kggzd97L7k2QAQkNEFOGGTtjE1kP7vTV5OHQy1Sd4uOqhNoeEScsamM7Y4mvtldbltnPSkjWTb8+E5bweNMsGFCKbOhbA5l8sQ0PPKTBo6JOJDX4GCXEGgPkhzbAOcM02Yfyzys1vMS47XkgJe36T/Ngwzt77lJtdRWXpMhNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766243083; c=relaxed/simple;
	bh=hr1Ddi1UGq2tZe610QFB7i8qIBTORCFUVY3d8KN+Q2E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=M/rEl2nMtYEVnOxqxB9archGLHk5TNmg0yZwtccstvuptaf96ZXJgfqRusalB4VjdaT+22zWbJ+6NO18/7bhO5C0DukJqRuHLc9s1+ndamdKS3MioPyYBdNpWRT08MUFk36lW/Sw4KyIztcimdTrIR0K8IShFxcrbJjaZf6Pd1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mikemestnik.net; spf=fail smtp.mailfrom=mikemestnik.net; dkim=pass (2048-bit key) header.d=mikemestnik-net.20230601.gappssmtp.com header.i=@mikemestnik-net.20230601.gappssmtp.com header.b=d8siOaS5; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mikemestnik.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mikemestnik.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mikemestnik-net.20230601.gappssmtp.com header.i=@mikemestnik-net.20230601.gappssmtp.com header.b="d8siOaS5"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-37d275cb96cso26138871fa.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Dec 2025 07:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mikemestnik-net.20230601.gappssmtp.com; s=20230601; t=1766243079; x=1766847879; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L7fPF6bvc+gKi1yAIPQOc1p9wgIzqd6aQnqYd6gvPNc=;
        b=d8siOaS5AzPEZPEjIfNHKtO/FUEBEJtvq3M6/61+eb/E7xqe5Q28RCWjU0cOu/4foY
         KSVij6Qhff7wAOm0EXz2hf+uTntzlwvKgFknaxtq7r+k89PXAN0VG/yN4qZibwz2/qR9
         wgKvvfqXLm4pkvztH3w3A/3mfbq4JPz+heUMKOfTCZO0PWmLXESq0Jk4YxCHscJSe0kY
         HUUKvfHzQtfGCXvPZmzpyBu5ppOOGwxecZ1Lt6Y0epw0Hoep5519+wSdaL/N7WdKZYge
         3x73Ukq2IbnFxv3OVdsDy0LPtnpTb+QUik/JO6rtcgVQqF0/gqptDaWARSXYdZ8CaCwq
         N44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766243079; x=1766847879;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7fPF6bvc+gKi1yAIPQOc1p9wgIzqd6aQnqYd6gvPNc=;
        b=ZFluicsZnJsJEsFwWJUD27tpIOpS9C/iaFww2stAb/Dcap0MADo5kpnQpCHEGwXR9u
         8aNLUUXdtRon813ZP89IPwcKZBs6zwDSu6nE3zcKgNKcQLLiFIKOxjeHad0z3crvll5U
         7cWrboSuLZC9G4zg9i9YRi/GgfPD+q0Yu+zN/+1aSQWZlzzZx23N/tuhk4mBmuwAwcZB
         h6UG3fqinRAw8ugj7ukZZO0NwtDFPRuAb1jU1BB/CsvuME2vY/oHqfQ7D9QrOjE07kMJ
         Tjw9VaRjY+e16ERBE54xsU/sv0pv+F+yzxAbA9eGfKjVmBi1HAo248G8SolxuwJm2hyM
         0LKg==
X-Gm-Message-State: AOJu0Ywl1bzSJxdMVquPBewO8uvjy0vPfllBAwZU5ectNPBfuU9/XeQX
	sO0sovaZNAPm1VQe9JwE+WwIjyGrX4Qq89iAL8vnF9nSJraoU6iEbTaBPdx9RePT7RuJ3pS62MA
	TMwnDeHrEAhzlJg1FYuICr4Sp191FJcWxlCOn3ONDvgk0R7equV3xJ1mr7w==
X-Gm-Gg: AY/fxX6RFLq7RWvVDiuArNzmbRmF6K9qDpx0TcJsMkg9Am6r6xcu0ww0fYXEB3pAUE5
	SzkSq52hR4Bfs7EqRUvWF54NqeLtToa7MH2QC/3dmn8ltsawzyM0yDftbpMK2dbrUaHlueB/uS9
	/GLoks2jgNdbqvTXcNj0u2vytUiL6OvyIWiuFOmHe/ZeQfdFuKRu4sP+jRdutNuSkkTSrGb8ha8
	3WrS+rJJiuPTCHzAUM18JrvUeGQyDUQ9PKyoV1YeA5a7Ep4Pv5zjkxMINMsd53IoZOXWtmO6TC3
	Hpi9BZbgQ+m24gn1Mh6dRrwZ89LeflC5dl0o8gCjfP9ZGS+GeCvUg+9T17LKNujTH7lKONgTD9y
	2vN2KuxYgmxnz4hVEdp7tPV2cisxiOCBRw/kLyeLmVUdL
X-Google-Smtp-Source: AGHT+IGhSAZoLzgxBKuhQ76aCl4IdOPtXiDHDIMgGhbg2PKAuDIyeJK1m2zaxbbvMUNRYwlR5vyVT4HrJ95gkZhoShc=
X-Received: by 2002:a05:651c:1507:b0:373:a3e2:b907 with SMTP id
 38308e7fff4ca-38121582da0mr18435001fa.10.1766243079088; Sat, 20 Dec 2025
 07:04:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Mestnik <cheako+debian-kernel@mikemestnik.net>
Date: Sat, 20 Dec 2025 09:04:27 -0600
X-Gm-Features: AQt7F2qFb1gdyUpy7kuINrZZ3QH6iBFq5_1C8S4o_HTlcFOTOqn_EyBH6jxwF5c
Message-ID: <CAF8px56B22OPhgzaGp3PuyXBLyCqs-gS5uN=GxGhiV0kFn_gxw@mail.gmail.com>
Subject: btusb: Device disconnects, Failed to send firmware data (-19)
To: linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org, 
	ibm-acpi-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

History of this message: https://bugzilla.kernel.org/show_bug.cgi?id=216936
I'm guessing what's happening to ppl is, like me, it worked after one
test and they were just happy for it to be over.  So I'm writing this
email to document my journey, give tips and next steps.
Last test:
I added `blacklist thinkpad_acpi` to `/etc/modprobe.d/wifi.conf`.  Let
me be clear AFAICT this is random so there is a 50/50 chance that
thinkpad_acpi is fine/bad.

What to do if you get the `Failed to send firmware data (-19)` error.
Make several changes, for debugging purposes, and then reboot.  For me
the ritual of watching the power button go out and back on after 5
seconds being off, then hitting power, waiting 2 seconds and turning
it back on...  Seems ohh so much to help.  However the *fix* for me
happened from just running `$ sudo reboot` from xterm and waiting,
watching the "shortened" grub timeout, watching the autologin,
watching the xmessage autostart and being surprised that it was
working.  If you have this issue setup all of those.

For testing add NOPASSWD to sudoers.
```text
==> /home/cheako/.config/autostart/xmessage.desktop <==
[Desktop Entry]
Type=Application
Exec=sh -c 'sudo dmesg|grep -e hci0 -e iwl -e "usb 3-1: " |xmessage -file -'
Hidden=false
X-GNOME-Autostart-enabled=true
Name[en_US]=xmessage
Name=xmessage
Comment[en_US]=xmessage bt report
Comment=xmessage bt report
```

I'm convinced the random nature of this issue makes you think rituals
help, but they logically cannot.  Make sure to do a lot of testing if
you think you've found something that helps.

This is what was failing the download for me every time, I guess.
`kernel: usb 3-2: USB disconnect, device number 3`  If this happened
b4 `btusb` was loaded I'd get *nothing*, but sometimes it would happen
during the firmware xfer...  leading me to think ohh man cold boots
really do help.

Let's turn up the logging, there are a few of these, do them all then
reboot!! If you do get it working run `echo 'module btusb =_; module
usbcore =_; module xhci_hcd =_;' | sudo tee
/sys/kernel/debug/dynamic_debug/control` to turn off the dynbdg
logging, without having to reboot.

```text
==> /etc/modprobe.d/wifi.conf <==
# Some of these settings were suggested, I say don't bother.  YMMV
# options iwlwifi bt_coex_active=1 11n_disable=0 power_save=0 uapsd_disable=1
# options iwlmvm power_scheme=1
# This one is great for ruling it out as the cause of the
disconnection!  and it does, the device disconnects with and without
btusb.
# blacklist btusb

# This is the big one, it logs the xfer so you can watch the whole thing.
options btusb dyndbg=" func btusb_tx_complete +pmfl; func
btusb_send_frame_intel +pmfl; func btusb_bulk_complete +pmfl;"

# This was the fix for me, YMMV.
blacklist thinkpad_acpi
```

To make this active on reboot, rebuild/update your initramfs.  On
Debian that's `update-initramfs -k all -u`.

Add this to debug USB, a kernel cmdline.  Debian: `/etc/default/grub`
then `update-grub`

P.S. To read the slow ftrace, quickly run `sudo cat
/sys/kernel/tracing/trace >trace &`.  To stop ftrace run `echo
nop|sudo tee /sys/kernel/tracing/current_tracer`, replaces `function`.
```
# Essential
usbcore.dyndbg="+pmfl"
xhci_hcd.dyndbg="+pmfl"
trace_event=":mod:btusb,:mod:iwlwifi,:mod:iwlmvm"
tp_printk
log_buf_len=4M

# This may help, did nothing for me
usbcore.autosuspend=-1

# These kill performance, adding a minute to get to the desktop.
 ftrace=function ftrace_filter=":mod:btusb,:mod:iwlwifi" trace_buf_size=256M

# There is no point in removing these as the bug triggers while the
desktop is hogging the display.
quiet splash
```

The only other thing I can suggest is to tweak the `dmesg|grep`, the
dyndbg(some modules are built-in and some are loaded by modprobe), and
the trace_event(`:mod:` is designed to work for modules that have yet
to be loaded as well as loaded).

The 2 technologies used:
Dynamic Debug
https://docs.kernel.org/trace/index.html

I'd be curious to see your logs and good luck!
