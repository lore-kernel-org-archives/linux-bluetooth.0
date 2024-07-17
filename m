Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836FD11CA1
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2024 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721218639; cv=none; b=i9DHlW5q56mIsF5Snyw4A6dpEyqgtWX9UAfBh8dTyPGVB/LQSsTKqpKO56UjcR4KOVYNB+cwshRtpHzPMqEF+ik0I4N/9sHJoZS7O3jHUNqNaiqoFuSu562oQRC5HIy4ehz47E7UVz2p3F2cGJAVN5m4WiluamkW69XRG56w6oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721218639; c=relaxed/simple;
	bh=qRzRu4Dd+qO4O2uPECPMRSbLfaIGR1Lzyj+5bvwd7oI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qZAazyaduYxD1/5SCxq7tczr7uKC/IRZ5qhPQeJtkg2BIFzos8+LwkjvC+H72UbyF8jJUn7Tk2NC5Ci3ly0B0I2x4Kd9zE5y8VRW2jGvrPNJS09/1ojK77ri5hoH+I7j8qTP+WTdsYf8O+7eVUGPttc2Z6vc2HqCbYMV+faEne4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=softeq.com; spf=pass smtp.mailfrom=softeq.com; dkim=pass (1024-bit key) header.d=softeq.com header.i=@softeq.com header.b=ueGYjyr+; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=softeq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softeq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=softeq.com header.i=@softeq.com header.b="ueGYjyr+"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52e9a550e9fso788250e87.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jul 2024 05:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=softeq.com; s=google; t=1721218635; x=1721823435; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n14dUx85KPbri5I4Yb8fwOOzOiRso1F34VUE6Cy7T2k=;
        b=ueGYjyr+fidjKs7Js7O6puFKKuCB5b2HTyfOWJw2b9PHE+8TwAyq4Zt9GlkX6ilY6E
         COFF2GSOjbkwkZN+19/vOEe/fs590rAxKK80tLTFNxocqxpGfVmX6xFw54X5RiQAtuX6
         FYCEg6xHDraE8v6h/g7xzVVo36tMAwJf8U3fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721218635; x=1721823435;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n14dUx85KPbri5I4Yb8fwOOzOiRso1F34VUE6Cy7T2k=;
        b=ElREsej1Pc2ZmGwFyKDwrJTUFYnWPJdFqc3ma7XmYPc4DZaxCQDtD3B78Q35sn+qaP
         QcmgMSCyn9x0/kdVbRynrBf5+YYwUlYg7c4k41n2seGYnGcxoYvasHo0JEFMpYhBOnar
         wwTGVWo5VX5VaZTOAJoFfVY49nq4U5CAN4ycvvoHP/7IrRIG2F1nNA+SvGNdDrQDv6Tv
         lRaeUMSAResU1z/L21Su6Cs3aKz2LuaGq1bdYduFZTWimpvscao1Vv6YWasVP3/COwju
         GlgKQ2MqOxZItKYWs7MKpAne/RYMnqaMFDos16dTpMZyXFa/cdoGIjXYhZgWPpmT4dIt
         bzjw==
X-Gm-Message-State: AOJu0Yw/lxuBQrZMavv3SCwYmdXHfsowDjQzuhaikOoGhoI/eeHJdW4p
	Qm/tO8e7j7iVOe7P75i+8qIXiINi6sm8rJr94HmrZNbjdgZ44iQFD/nTPjQOoi+jPnIrHDdOzIy
	Y5cuXXdJ3xSkU4SluXpkbGJiD79ukUQEdTBaPaylcYUR5xzp2MGncow==
X-Google-Smtp-Source: AGHT+IGcVZBkc0oP+fuXWdn//j4akFDN6JzGgTj6v6EDZFhdvFHNMG4vW6HZOtw4c4NZOFv6aSIFEE61nlLFc2/nJ6Y=
X-Received: by 2002:a05:6512:3188:b0:52c:8b11:80cf with SMTP id
 2adb3069b0e04-52edf8b704fmr1536031e87.8.1721218634695; Wed, 17 Jul 2024
 05:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yauhen Kharuzhy <yauhen.kharuzhy@softeq.com>
Date: Wed, 17 Jul 2024 15:17:03 +0300
Message-ID: <CACJudGOw+d7pkwMg4szUw8WChDQJH6g9wDN72aL_Wkcy66ZAhA@mail.gmail.com>
Subject: Repeated bonding after deleting a bonding info from client
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I am implementing the Linux-based device controlled by BLE (so, my
device is peripheral and uses linux 6.6.20/bluez 5.73 stack onboard).
To pair with it I set up an agent with NoIO capability (the device has
no controls available for the user). When I enable pairable mode and
try to send a pair request from the client (a mobile phone, nRF
connect app), all works as expected. But if I remove pairing at the
phone side and try to re-establish bonding, the bluez refuses it with
'auth failed' (0x5) status in the log.

As I understand, it is expected behavior because the bluez has old
bonding information and tries to use it instead of rewriting by new
one.Is it possible to automatically override old bonding info in such
a case and accept this pairing request? Looks like bluez service
doesn't send any information via D-Bus in this situation.

Bluetoothd log fragment is below:

Jul 17 15:12:08 raspberry bluetoothd[735]:
src/shared/mgmt.c:can_read_data() [0x0000] event 0x000b
Jul 17 15:12:08 raspberry bluetoothd[735]:
src/adapter.c:connected_callback() hci0 device F0:39:65:2A:5D:F4
connected eir_len 0
Jul 17 15:12:08 raspberry bluetoothd[735]:
src/gatt-database.c:connect_cb() New incoming LE ATT connection
Jul 17 15:12:08 raspberry bluetoothd[735]:
src/device.c:device_attach_att() Elevating security level since LTK is
available
Jul 17 15:12:08 raspberry bluetoothd[735]:
attrib/gattrib.c:g_attrib_ref() 0x55556e447e30: g_attrib_ref=1
Jul 17 15:12:08 raspberry bluetoothd[735]: src/device.c:load_gatt_db()
Restoring F0:39:65:2A:5D:F4 gatt database from file
Jul 17 15:12:08 raspberry bluetoothd[735]:
src/settings.c:btd_settings_gatt_db_load() Unable to load key file
from /var/lib/bluetooth/2C:CF:67:43:20:E3/cache/F0:39:65:2A:5D:F4: (No
such file or directory)
Jul 17 15:12:08 raspberry bluetoothd[735]:
src/device.c:gatt_client_init() Reverse service discovery disabled:
skipping GATT client
...
Jul 17 15:12:11 raspberry bluetoothd[735]:
src/shared/mgmt.c:can_read_data() [0x0000] event 0x000f
Jul 17 15:12:11 raspberry bluetoothd[735]:
src/adapter.c:user_confirm_request_callback() hci0 F0:39:65:2A:5D:F4
confirm_hint 1
Jul 17 15:12:11 raspberry bluetoothd[735]:
src/adapter.c:btd_adapter_confirm_reply() hci0 addr F0:39:65:2A:5D:F4
success 0
Jul 17 15:12:11 raspberry bluetoothd[735]:
src/shared/mgmt.c:send_request() [0x0000] command 0x001d
Jul 17 15:12:11 raspberry bluetoothd[735]:
src/shared/mgmt.c:can_read_data() [0x0000] event 0x0011
Jul 17 15:12:11 raspberry bluetoothd[735]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr F0:39:65:2A:5D:F4
type 1 status 0x5
Jul 17 15:12:11 raspberry bluetoothd[735]:
src/device.c:device_bonding_complete() bonding (nil) status 0x05
Jul 17 15:12:11 raspberry bluetoothd[735]:
src/device.c:device_bonding_failed() status 5
Jul 17 15:12:11 raspberry bluetoothd[735]: src/adapter.c:resume_discovery()
Jul 17 15:12:11 raspberry bluetoothd[735]:
src/shared/mgmt.c:can_read_data() [0x0000] command 0x001d complete:
0x00
Jul 17 15:12:12 raspberry bluetoothd[735]:
src/device.c:device_remove() Removing device
/org/bluez/hci0/dev_6F_6F_75_1D_A8_AC
Jul 17 15:12:12 raspberry bluetoothd[735]:
src/device.c:btd_device_unref() Freeing device
/org/bluez/hci0/dev_6F_6F_75_1D_A8_AC
Jul 17 15:12:12 raspberry bluetoothd[735]: src/device.c:device_free()
0x55556e447410
Jul 17 15:12:14 raspberry bluetoothd[735]:
src/shared/mgmt.c:can_read_data() [0x0000] event 0x000c
Jul 17 15:12:14 raspberry bluetoothd[735]:
src/adapter.c:dev_disconnected() Device F0:39:65:2A:5D:F4
disconnected, reason 3
Jul 17 15:12:14 raspberry bluetoothd[735]:
src/adapter.c:adapter_remove_connection()
Jul 17 15:12:14 raspberry bluetoothd[735]:
plugins/policy.c:disconnect_cb() reason 3
Jul 17 15:12:14 raspberry bluetoothd[735]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr F0:39:65:2A:5D:F4
type 1 status 0xe
Jul 17 15:12:14 raspberry bluetoothd[735]:
src/device.c:device_bonding_complete() bonding (nil) status 0x0e
Jul 17 15:12:14 raspberry bluetoothd[735]:
src/device.c:device_bonding_failed() status 14
Jul 17 15:12:14 raspberry bluetoothd[735]: src/adapter.c:resume_discovery()
Jul 17 15:12:14 raspberry bluetoothd[735]:
src/shared/att.c:disconnect_cb() Channel 0x55556e447e90 disconnected:
Connection reset by peer
Jul 17 15:12:14 raspberry bluetoothd[735]: src/device.c:att_disconnected_cb()
Jul 17 15:12:14 raspberry bluetoothd[735]:
src/device.c:att_disconnected_cb() Connection reset by peer (104)
Jul 17 15:12:14 raspberry bluetoothd[735]:
src/device.c:att_disconnected_cb() Automatic connection disabled
Jul 17 15:12:14 raspberry bluetoothd[735]:
src/gatt-database.c:btd_gatt_database_att_disconnected()
Jul 17 15:12:14 raspberry bluetoothd[735]:
src/gatt-database.c:att_disconnected()
Jul 17 15:12:14 raspberry bluetoothd[735]:
attrib/gattrib.c:g_attrib_unref() 0x55556e447e30: g_attrib_unref=0

-- 
Yauhen Kharuzhy
