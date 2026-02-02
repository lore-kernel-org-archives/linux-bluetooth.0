Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B67369992
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Feb 2026 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042413; cv=pass; b=UwblVTLihD0IvPPz6BmeLQQJB47kYGt1ERm26jNPHdixhmwT3O0FxuxdRm3t/YBm2ns/utdp4RnylFGJffJl0vOdD6f2HrLq5oKAsrZIEonCcDr+mPTaau0G2Kme47apkky84buMRnfunQLXE4cLr7jvfy0TEf4+kfyy/h8hv4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042413; c=relaxed/simple;
	bh=BZJSfD56mHcQhB9yyzLSKgRoX51nc3/T8h48MJtBmD8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DfRTn738hzWPjRGFIbO2NRzbpTxotY9Tl+ufIHhDmJjtKx1ZrmNAIZL5QvQVRc7P/O8fI43DY2mW198CAhXZdrEGV8Qt+hBPIkb0Ri+JgDzP90igUZtTu/SWDBE8ssPX2qWcGgIVXkWIQtv5TUCCmkLA2XbnZehw1Tr1Cz6rY7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=students.rowan.edu; spf=pass smtp.mailfrom=students.rowan.edu; dkim=pass (1024-bit key) header.d=students.rowan.edu header.i=@students.rowan.edu header.b=ReiHVp72; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=students.rowan.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=students.rowan.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=students.rowan.edu header.i=@students.rowan.edu header.b="ReiHVp72"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79456d5ebf9so42854607b3.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Feb 2026 06:26:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770042411; cv=none;
        d=google.com; s=arc-20240605;
        b=d1AEXjqfERhqGcUlpDU782PNKiZRM8rrRye3568UMAjTuebJBIVyTiwEOw9EKGbxHW
         hwaVVGsPfeM6oHCCNnanghkaBqjWtk9i2QSyFLT+7VLH8vVeFuXUORJZpMbIpwiN1lQT
         tgYmEtKxgC2ubGgWfI7HkmENQqedSWjWSGhjJlzuzhJT00rKxtnY4tGNU8CE5wuicBb1
         PcEANdomunIk+IItEIeN8jlU7zQrdYxhNn+GOKeoGOAWlcvuUlXktdAKfS9EdP5T5GTI
         tDAhfQYVpdQz79hFKf1sjvXqpRphE/Zp8YGW2so4xTJg170DuRNU7cf5tBE3g/TZMa9+
         mSrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=BZJSfD56mHcQhB9yyzLSKgRoX51nc3/T8h48MJtBmD8=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=OXQDero6J7ZOtcj4oIffog5r4Hr254TSm+rx2DqYkd6qvjeH1NVq9jmKF7oPsGbKhm
         ps0nYu4eNUMO5B1RVLg5YY0ttkKw4f7JbIBZVgfM0DQhCyrJPKGBbt+lMz8JQwaFRqdc
         X7O8bajcgz11ciTLdrp3kHwVZY+n/ytgBNpHo6HmMBwXyXvAjanMdfjyOaVEv4GxNO5W
         TfjuIJMmGcvTSZ5HCB4a0CBLt5zArPo3vyKyVaJVlk6pA9CO8bUoA+TQpjLIpjiam4tY
         fbIhAaf1GFV+R1u6HUS6lNp3n71MV3v7SOWji75az/QwNsN2KZ6kgJKUin/8rw/xlXVt
         sYJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=students.rowan.edu; s=google; t=1770042411; x=1770647211; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BZJSfD56mHcQhB9yyzLSKgRoX51nc3/T8h48MJtBmD8=;
        b=ReiHVp72gwUsRoC7ib0zqqm6Tt3G0GGY27OsgQ49yHKCwV4V4ULzIHtGKbYpfclBpj
         WWFmifKyR6HO3Jq9deWImPm7oRzcbBr2JZDap6HBzExS3lXPFBQxiHsnX5ZYIX4+YnEQ
         jl6c9gxnpR6BGq2Fjiw6v47FVMD4HYpdgZ21E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770042411; x=1770647211;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZJSfD56mHcQhB9yyzLSKgRoX51nc3/T8h48MJtBmD8=;
        b=wSD091LN++on2F99DbJfe3/cl45qCj+8aOWSg6b2O+JussmRO+VPhHBhfwyVMPY2ZS
         QSjgtjch/lOzhk2fLeTo9NaO0aUYTAk1iBKUexSyNrSU0dwf40rDn8/+88ZJCpj374J2
         w/ycT3pKznfYRbf6AlbervPCVx1wli5idBwV+ZJomuxZ0/c9pZro+WxwhilDXUZsFJFw
         ynr/6vHeepu40DlOk0hBgFVxvwN5LqiP2XrCO+68Nv0vjLB0Wbpcs01v9TJ9troNopJM
         +S7vF72sr9xcy1jGRWwEnTriRySNlSadlkQwCLkfGgsgJYI7XNAXbicMvrHjW/kkG0RQ
         lV7Q==
X-Gm-Message-State: AOJu0Yyo6A9XRwPgSCX+NdrykYpkHHGhZaD+bWq9xrgNzODy5GNV4WH/
	CspgaxP5O1alQlHpF3jMq/H5FhVKrrOTz8Hw6RwIJ21Ig0qpK3n1OvLi9P9oLG4LXrCZoeJi/ji
	TlvutrN4NRHv3CvhQ/AJlUWxOrWhCYs78aqK/I/kdE7klFAT4fr68Re6Wmg==
X-Gm-Gg: AZuq6aLEe/rkH8h7qzzdBPzw/WjLO4F35+DhgveTAUrXsjchmpoyU+gjFvL9n+wXmbT
	rDBkLle43hLZ2VCN1rS7yAFkZFNka92jMEzfXv59zLaZEVHmbnLNyShB42BKctAZH7dpu/WLw/+
	wF4zCvSoX8oAjaGyZ5HY5SL9e5ATz4XY7qB6XHWNmfnDvcLcPNGQ1lnBZexccFXxIwrs7cgKmR9
	IK2cGlS8tXR947bBjaurVnNg8+pD5+Win2h9XGJrG3/7cJJ/RkS+c/x1CVpZGg/9qy087Vc362O
	G5aBBmoNdHBhTEdzcH8FXDwhy3P0wv0BIkkgfA==
X-Received: by 2002:a05:690e:b47:b0:649:b536:d72 with SMTP id
 956f58d0204a3-649b5360f7cmr5194132d50.18.1770042410816; Mon, 02 Feb 2026
 06:26:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Khaleeli, Adnan" <khalee27@students.rowan.edu>
Date: Mon, 2 Feb 2026 09:26:39 -0500
X-Gm-Features: AZwV_QhNG2Ifs1IWpmCzOcWg3A6sF-u77igmlYXR78_OJifxQPP-1E_r0gtZF7U
Message-ID: <CALpOmYvQUnA6YGinVxfDzqewP1dcL_-X7NVfto4YsMtZL3x2og@mail.gmail.com>
Subject: Bluetooth not booting with MediaTek MT792
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am having an issue with Bluetooth not being detected on a new Ubuntu
PC using a MediaTeck MT7921 Wifi/Bluetooth combo adapter.

The Wifi interface works correctly, but bluetooth is not detected at
all. Running bluetoothctl results in "No Default controller
available". I previously managed to bring Bluetooth online temporarily
by running:

sudo rfkill unblock bluetooth
sudo systemctl stop bluetooth
sudo modprobe -r btusb
sudo modprobe btusb
sudo systemctl start bluetooth

However, this workaround no longer works after reinstalling the
linux-firmware for bluez. If I can get any help with this it would be
greatly appreciated.

From, Adnan Khaleeli
