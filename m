Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD62818B0F
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002161; cv=none; b=N+PQ2gASb2PzPRdA0VI+ryWcGci7AQTjJAG2eip3WmQiBkf1yEkJKl8MKqNZaPt+E/oNvDc1zPhkXLfdkm/HDN9M2dfxjpitLTemFt3q7tVaYEjINNudQKLwED8Gbf/g/IayY82csk9p+byQEw+AM/d/3H4if/K4Od3sfwrHlkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002161; c=relaxed/simple;
	bh=9tGCuyDdb7HOsZmNQwNUZfLvEh8NWWwoc3Uews8n38k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CWZ4ps/souf/jDcZt9q0U9s3pE+qblxi/njzrOrlMpf5KV8LNOq7KymySl2usEdtU+fKh6OrhNVEIWMegP/Hoh6jIocokG0RsSWjoLMSLgnco+qUhtLPhItVZ+43Mi5qt0Q0eiSMo/hvj0u4LGrl1BjY0tCYYY4rEo5quncIbEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=N1TlwG4l; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="N1TlwG4l"
Received: from github.com (hubbernetes-node-77eba50.ac4-iad.github.net [10.52.222.28])
	by smtp.github.com (Postfix) with ESMTPA id E5D8C6411C7
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 08:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1743002158;
	bh=SQ8O+E8XyHwKyw7djHLTz9UFeniKYRGUdAO7ZdGrLQc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=N1TlwG4lCQjYVk/81lNeVpVQIdzwTf3WWPRIOkz/a3HEGEjg+fFIXa4Fgo71Qpcjv
	 DWR6jQb0EJkV2oPljSG9N5j4ojJrvnhEKYzwcLFjozqNWDHCSne3GViRZZmijwvOdZ
	 gJUvyHN5gTnqHzwjBz+IU5miA9l52sPw1PjCamTY=
Date: Wed, 26 Mar 2025 08:15:58 -0700
From: Yao Zi <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/912e2f-0f0039@github.com>
Subject: [bluez/bluez] de22ef: bass: Add support for selecting multiple
 transports
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: de22ef2bac4ab332dcb27611d86d8f62ccbb9cb6
      https://github.com/bluez/bluez/commit/de22ef2bac4ab332dcb27611d86d8=
f62ccbb9cb6
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-03-26 (Wed, 26 Mar 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Add support for selecting multiple transports

This adds support for the BAP Scan Delegator to select multiple transport=
s
added by a Broadcast Assistant and to acquire them one by one to receive
the streams.

Fixes: https://github.com/bluez/bluez/issues/1139


  Commit: f2120e3ded0656c8eda3d8058ee35654aba3fd09
      https://github.com/bluez/bluez/commit/f2120e3ded0656c8eda3d8058ee35=
654aba3fd09
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-03-26 (Wed, 26 Mar 2025)

  Changed paths:
    M profiles/audio/avdtp.c

  Log Message:
  -----------
  profiles/avdtp: Fix reply for bad media transport format

Currently the avdtp_setconf_cmd() fails to check the capability length
of the Media Transport Service Category, which should be 0, because
caps_to_list() doesn't add it to the list of services as it should
be bigger than packet boundary.

This commit adds an &err parameter to caps_to_list() and set the error
to AVDTP_BAD_MEDIA_TRANSPORT_FORMAT if Media Transport capability as
invalid length.

This is required for passing AVDTP/SNK/ACP/TRA/BTR/BI-01-C PTS test
case:
To verify that the IUT (ACP) is able to issue a set configuration
reject response to the INT if the format of the media transport is
incorrect.


  Commit: 05ede13d22df024a0cdc4d449d8329da36950995
      https://github.com/bluez/bluez/commit/05ede13d22df024a0cdc4d449d832=
9da36950995
  Author: Ludovico de Nittis <ludovico.denittis@collabora.com>
  Date:   2025-03-26 (Wed, 26 Mar 2025)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Preserve pending flags when setting the Device Privacy Mode

If there are already flags that are pending to be applied, we should
keep them to avoid overwriting them.
At that point we only want to add the Device Privacy Mode on top of the
existing flags.


  Commit: 41cfe55ea759d528db7a0042056eb39e3bab84a6
      https://github.com/bluez/bluez/commit/41cfe55ea759d528db7a0042056eb=
39e3bab84a6
  Author: Ludovico de Nittis <ludovico.denittis@collabora.com>
  Date:   2025-03-26 (Wed, 26 Mar 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Preserve pending flags when setting the wake allowed

If there are already flags that are pending to be applied, we should
keep them to avoid overwriting them.
In device_set_wake_allowed() we only want to either add or remove the
remote wakeup flag, while keeping the existing flags as-is.


  Commit: 12b3acbeb2022a97e976cf502ddcfe089ea20b41
      https://github.com/bluez/bluez/commit/12b3acbeb2022a97e976cf502ddcf=
e089ea20b41
  Author: Ludovico de Nittis <ludovico.denittis@collabora.com>
  Date:   2025-03-26 (Wed, 26 Mar 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Try to set the wake_allowed property only for bonded devices

When the function `device_set_wake_support()` is called, we don't have
the guarantees for the device to be already bonded.

For example, that function gets called by `hog_probe()`, that is also
triggered when bluez scans for new devices. In that instance, we don't
want to try setting the `wake_allowed` property, because those devices
are only in range of the host and are not connected, paired or bonded
yet.

This fixes the following Bluez error when we scan for new devices and a
new hog or hid is in range:
```
src/device.c:set_wake_allowed_complete() Set device flags return status:
Invalid Parameters
```

Additionally, because that initial `device_set_allowed()` call can fail,
this commit fixes the issue of hog and hid devices that, after the first
pairing, were unexpectedly showing `WakeAllowed: no`. And it required a
reboot to let that property be set to the expected `WakeAllowed: yes` by
default.


  Commit: 1a9012fe57b69a14d6293edeb4466c431e91639d
      https://github.com/bluez/bluez/commit/1a9012fe57b69a14d6293edeb4466=
c431e91639d
  Author: Amisha Jain <quic_amisjain@quicinc.com>
  Date:   2025-03-26 (Wed, 26 Mar 2025)

  Changed paths:
    M obexd/plugins/mas.c

  Log Message:
  -----------
  obex: Add base implementation for get_mas_instance info and set notific=
ation filter

This change is required for passing below testcases-
1. MAP/MSE/MMI/BV-02-C
   Verify that the MCE can return user-readable information about the
   MAS-instance to the MCE
2. MAP/MSE/MMN/BV-06-C
   Verify that the MSE correctly responds to a request
   to filter notifications.

We are adding the raw skeleton implementaton for PTS certification.
Although the functionality can be added later as per requirement.


  Commit: f8219bccb485a23af7d61e4542fd4725c85e77bd
      https://github.com/bluez/bluez/commit/f8219bccb485a23af7d61e4542fd4=
725c85e77bd
  Author: Amisha Jain <quic_amisjain@quicinc.com>
  Date:   2025-03-26 (Wed, 26 Mar 2025)

  Changed paths:
    M obexd/client/map.c

  Log Message:
  -----------
  obex: Add supported-features tag in MAP Client Connect Request

This change is required for below PTS testcase -

1. MAP/MCE/MFB/BV-06-C
Verify that the MCE sends its MapSupportedFeatures in the OBEX Connect
request if the MSE declares support for the feature MapSupportedFeatures
in Connect Request in its SDP record.

If Server's SDP record contains the field 'MapSupportedFeatures in Connec=
t
Request' as supported then include the supported features
apparam in obex connect request.

Tested-by: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>


  Commit: 0f0039045088e41f3cebea620ba9ef6d13592faf
      https://github.com/bluez/bluez/commit/0f0039045088e41f3cebea620ba9e=
f6d13592faf
  Author: Yao Zi <ziyao@disroot.org>
  Date:   2025-03-26 (Wed, 26 Mar 2025)

  Changed paths:
    M client/gatt.c

  Log Message:
  -----------
  client/gatt: Fix pointer assigned with character literal

A character literl, '\0', is assigned to the pointer. The corresponding
comment doesn't make any sense, since '\0' represents zero and this
statement does the same thing as assigning value with NULL.

Initializing value with NULL (or zero) is safe and correct here: the
only case that the initial value of the pointer is passed to
write_value() is that the if branch isn't executed, where len keeps its
initial value, zero, as well. With src_len equal to zero, write_value()
will bail out and src_val won't be dereferenced.

Let's clean up the misleading comment and change right side of the
assignment to fix compiler warnings about the wrong type,

Fixes: ee750bbaf68c ("client/gatt: proxy_property_changed: check for NULL=
 iterator")
Acked-by: Christian Eggers <ceggers@arri.de>


Compare: https://github.com/bluez/bluez/compare/912e2f54fd57...0f00390450=
88

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
