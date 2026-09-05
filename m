Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D57931716D
	for <linux-bluetooth@vger.kernel.org>; Sat,  5 Sep 2026 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601067; cv=pass; b=nuBm2ouEzFhduVw/1e/cgpJi9g5dwgfxMo/Nt/exMsgVhuG4F+R8iv7mcy2ln1gYMEQCKmy2TlCIeO1/aT1Fam6Wf9Q9FELG6/928QayZdQ822tSGcLaIgYtJLp/om3QHQ//SwfSjIPeKHMtzVy6X9Y0J9+OvQHaeTMgqrd6Oqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601067; c=relaxed/simple;
	bh=viOlLAejjQ5Jf9qpy8TFTmuwLYIhYmdeFPvIw1AhBdk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LOLZNbgQnl+E5cdBI3Ub7rnlbauqB5aaoM5SyMHpeRsLkgxpk/5voxZ5xtzPrnEARFi+y+Q6qaVaw9gKXw9k2lgpiN1k9uTYgOnLJywyb0D7KUt5yIWHdNU1nVWlp6EZJfS1C1c9eNeBUU8IfweJdhXp4FMaihYKIXNHW7vA710=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDEotBwd; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDEotBwd"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b6188a2c0eso1332321e87.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 05 Sep 2026 02:37:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788601064; cv=none;
        d=google.com; s=arc-20260327;
        b=Rr8lzmuAC3Ct9CIgelm5PFzt6xG+KDrN6K/mcYZikO8dYvHFoowCx2JlxkO2GM/0qM
         JXUfDKzzDogQs2kGBhbGnYy8Ubo1puU0pmQ1A9nSdSmeTI79NyxOUl2b/7WomB3gGZjO
         AY93VAFUJFiYV+oIssFucNfiYioYsxDOyc0M7oWoJJ/BNZzbdoLspGYrRo9ZwOGA2hUF
         p5LjG8K6VKd/wDbnkFyhs8tM0uW5H3L9yjtdF0pbxmzdjUzz8+/Txga275FogMZpf9XZ
         NldzQJDJ5XN2YmZhk4xFp8i4uRODah1mGlJHuBksCaM40uF7/vFp0zybQcQfrlAknrcX
         zvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=T5gONqD7BOM2oqOrs3fJTQUsN2XiTa2sHV4w1kNrsGE=;
        fh=57qyEZNdGrDPmxvVGEykGBW4sEu+txlrN6w+N80qi4o=;
        b=kFsNQ/ZZT+IEDjyMy79AgWcVuxplHVM1COTPISiiFyh1QysS1WvAoJa8SEEXD1WjeV
         lG6PR4Lqc+jYyosBmiKnFxOq+7hjEs3GXw2mI1EMLhqGoWW273H5cC6mM0ZUSGDBMMk2
         Jhp1jqtBHxwbRD8xT8KDkLjDYAyLfgiaiB0lsHH7ihdcPTjm4o1CzubGXZlnkSpaYRsI
         g2+/j9AiNBLbu1/ud1jGPigmE3n0y61U+EEpuhgbOAhbe817Ar4w+rdSoMWnLEXMTX9/
         vXW9dLBfnitl++P78DEPE81zTW78G0Knp0uJ0JVmpR+fjx4XdrwZ4F8ys88sqksehDm6
         TGtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601064; x=1789205864; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T5gONqD7BOM2oqOrs3fJTQUsN2XiTa2sHV4w1kNrsGE=;
        b=eDEotBwdrFPgVSBchFDZUNDw4zFyRS+JBiuhlmXabrKflR/4PyboiWG6MEqYOJKeZM
         gl4//3cYX8CQMWxXRuLBVjbKy0zQnPx1yVMOOYXuMFN1FhZoz29XwO4F0K7PP0iunnlu
         HaONr/FRl2pjTj1HEma2uIHPzOCtgDyekiIhb2bcPzDs5xRAK0CjttO9P7V2bzR763hf
         PzpdCWYNY6rc4ybHUMG35jWdhKkXDKXU+rk2cjII7WWneAWo4l6s80/7GQfXhtahh0pD
         70T7Ijc0xnJ5d8shWrR0zlGUK6TeAZO9VSeiQFmhXGIZlh0sH2lcM5bpBIUVUklD4WJh
         b6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601064; x=1789205864;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T5gONqD7BOM2oqOrs3fJTQUsN2XiTa2sHV4w1kNrsGE=;
        b=fwz51CgF9enwVOToMtfK23RbT+VbJdSx2uavm07ZF2mapcyBcY+zFwUXeAN/k+GEBP
         LTO+Dy7CLax+6jhMWDrsEL6w/B28xVidJA45sVOpGZbV/j2OXMoJDATv5n93wCfypiUr
         WJgzjQKlpDe1kB0OEaClTa/eOlwh7qUAwnk0k5gcQt/ONdpKjRgLZD7TVTqd9im8UbvS
         rE/xO6NAofzPURMcwSK2vImD+qlsge+T/66nKWzu87tAxR/sStgOFNsCeOvVAsKSdX3H
         nmJmZuxtrR5ERkar2vS6Okc9CGDEhFKyRoq+xFI6N3N+a+WtFxj1DQR8Cx8nJOrFOghy
         kxXA==
X-Gm-Message-State: AFuF++ny2UhKDBGfzzZGGEYjxxiBb6MplJchsqtaYCDurkoSCZOn+So/
	lAuyumFGbJY87MtN4cVutYVxXRSgj67j30rcpwske3C8FHszFeXBY8V5AJTu09+ummKTbGxagEI
	JqTOWhOx/an7DgYi3RZv3Ua+8LFG5ES6yHt3fOCI=
X-Gm-Gg: AYBFou0bZns6JPXLlZUHukTkdvVa3uJ80LaP5G/lnM/uwNzF+XVDw6GpFH1hWSHUYW6
	AHyJttz1fGaYGJmU1rl251SeP/P+0gZdVGfoWWsQ+ftnU65qZFoouAkuiGnSLvk6qMyn1A+WsP/
	05DKE6q3k4jxd1t2CpMBb6u9JxVCMLLkLl27eOpIbLrzxrs/KKHzg6If49nBp1Bs9wzEAD9mNMA
	/VqBNg316yx6SWhOfXUwZzoq9XY/DbNtiuy8+/CpTMVHFVo4ysVp1TPeSK4cQh8LphHCj0sl/rF
	bJWj/QwSRvGb2s2fjg1YaKax2e81uzhC7zk297z/TjOzxdc=
X-Received: by 2002:a05:6512:3b0f:b0:5b6:1a7c:fd7f with SMTP id
 2adb3069b0e04-5b61a7cfef6mr1820143e87.37.1788601063533; Sat, 05 Sep 2026
 02:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sandip Makhal <makhal.sandip1999l@gmail.com>
Date: Sat, 5 Sep 2026 15:07:16 +0530
X-Gm-Features: AcwNN1UpLcnfyjkeyljsYD08j5UFQkzBNoO_KEunJQJKkGXlFEkXbxhfQPXYRXQ
Message-ID: <CAENgahUHbkA-TX7JbjnBHRasvf_UuLE2U1kKdXC1D5P2GW-R5w@mail.gmail.com>
Subject: [RFC] Architecture & BlueZ API interaction for vendor-specific
 headphone daemon (ANC, wear detection)
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

I'm Sandip Makhal. Over the past few years, I've been researching a
standard way to bring advanced Bluetooth headphone controls (hardware
ANC, transparency levels, wear detection, custom EQ) to the Linux
desktop.

Right now, standard audio streaming (A2DP, HFP) is handled reliably by
BlueZ and PipeWire, but ancillary features remain scattered across
one-off reverse-engineered tools (for Sony, Bose, Nothing, Samsung,
etc.).

To fix this, I am drafting a vendor-neutral userspace daemon (aiming
for an org.freedesktop.* D-Bus interface) to serve as a translation
bridge between desktop environments (GNOME/KDE) and these devices.

To be clear: this daemon lives completely in userspace downstream of
BlueZ; the intent is explicitly NOT to put vendor-specific byte
protocols or parsing into bluetoothd.

Before moving from design into an upstream implementation, I would
appreciate feedback on the following integration points with BlueZ:

1. External Profile & Socket Handling
   Modern headsets send accessory payloads either over Classic
RFCOMM/SPP or BLE custom GATT characteristics.
   - For RFCOMM/SPP, is registering via org.bluez.ProfileManager1 with
an external fd the recommended mechanism for an external helper daemon
running alongside an active A2DP/HFP session?
   - For BLE GATT, is acquiring file descriptors via
AcquireWrite/AcquireNotify on org.bluez.GattCharacteristic1 robust
enough for concurrent telemetry (e.g., continuous battery/wear
events), or are there known race conditions during profile reconnects?

2. Device Discovery & Probing
   Some headsets only enable their proprietary control service after
specific handshake packets or SDP queries.
   - What is the canonical BlueZ pattern for detecting device
capabilities without disrupting PipeWire's default A2DP/HFP profile
switching?

3. Scope Demarcation
   Has the BlueZ project previously considered any generalized
"accessory" or sideband data channel interface, or does the team
firmly view this orchestration as the responsibility of an independent
external daemon?

Any advice, pitfalls to avoid, or pointers to existing reference
patterns in the tree would be greatly appreciated.

Thanks,
Sandip Makhal
