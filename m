Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8343CA487
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 22:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164976; cv=none; b=YiiZnFsf6Zx55OSg+Ifybe1V8Bw5sOzET6xzG2IB+JPMC6s35zmZ2F0cTE9NNcLF+d4PjkIgM1L3QfHKBzBU9vro/gN1u3SaIgcb9hntnLDNxOy34XeH/EsRys4juWcVh9mqjN/TwTcUuixtNiuY7VzmfLcqD0e+/wngZ2Ra6eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164976; c=relaxed/simple;
	bh=jhiUpOpEVbeWSe5lC0TfYNIQa0DAg2CVM2DzEoTBtfM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=da2y0lO+RJkPCjrWP9IqftkjWr1GcDOxddwgiwIecUMNx8g/NnSMg+kdQVe6flITHTmQSPl19eDuUSfqIeakIOFdrcJcoGdw7k696eUuMhurl8t1+bzdoIacsQZVHn3n+fIqqF0MkJ+QpBXo5nqIQgzvvVAMaKTJX6niI499c74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 35F353E997;
	Fri, 11 Sep 2026 22:16:04 +0000 (UTC)
Message-ID: <404c7f2b4a6bcaf61422d6a350201df0093f6105.camel@hadess.net>
Subject: Re: [PATCH BlueZ 1/1] org.bluez.service: enable D-Bus activation of
 bluetooth.service
From: Bastien Nocera <hadess@hadess.net>
To: Grant Moyer <dev@grantmoyer.com>, linux-bluetooth@vger.kernel.org
Date: Sat, 12 Sep 2026 00:16:03 +0200
In-Reply-To: <20260911213253.766659-2-dev@grantmoyer.com>
References: <20260911213253.766659-1-dev@grantmoyer.com>
	 <20260911213253.766659-2-dev@grantmoyer.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTEbYbffFYos11rtF8MS7KM1BBpClZKz/uzk0+wB4jeXrWMbu31vjkgLqpAYoVFhjSn+oJtDeqjsRiHD7t9xG9GpmlOD8/8Xdbdv5OEfjNKL9Y5Z5Ft4GvRMED/DRhcMB25lG1JNeaY41KM2N6uBD0VagJ2iFneytbfFE3ZOX7PEpOXhCmHWECiz4Aw8lRFD7e8P8GRFDt1kfxV8j33cJdk2bSMg/gL6cUQK0be+qXQGLPSMC+g9A6gFMKXk1e3oAS69j2dJVHYWuUmk/Vch2nvVmon8XnSgFxsn9Jd0MBJDx/oVx0hrjaO6kqhj1EKJZGkI0uC4DADzyON5i0102MKmaaGbJ5kjvfW6fAJzvuPzFoe2H0EtkC5FHiqgYQnBGdoa7jzr48SMpJ7DKPXr1lKgyyw5/QeoJWO63GElgBjmwC53nKXYxKlxcbWrJv5CkLgbHVmQrHTVEQxJl5qt/Wh3ndtqOCysX2MMSqxj3gWc395qMJShoAI0LskCSe4CvWMsiH193ZwSLGJ3vf8epHUAntyNzmQhd7X+/yQZtaI4vqDbpb5Mx1JYHAx0WTYznKfzqB+6my/FApvfUy3CPOjjGDlVz3j+2b+grnvvVosrThgzJajCRa60/1q0UcwugKRL+5/86C9E1TColcTAOa5H5kbvRXmyofJvhgya3ZolYg
X-GND-State: clean
X-GND-Score: 0

On Fri, 2026-09-11 at 17:32 -0400, Grant Moyer wrote:
> D-Bus was configured to activate dbus-org.bluez.service, which is
> only
> an alias for bluetooth.service, and so isn't resolvable unless the
> service is already enabled. This means D-Bus cannot launch bluetoothd
> on demand in most cases (for example when running bluetootctl without
> the bluetoothd systemd unit configured to run at startup). This
> changes
> the D-Bus configuration to activate bluetooth.service itself, so that
> bluetoothd can be launched by D-Bus on demand.

Which would mean that bluetoothd would get started on system where it
is disabled, but somebody runs bluetoothctl as you mention?

Then that's a no. We do not want bluetoothd to get started unless the
system configuration says that bluetooth.service is enabled. Otherwise
it effectively makes it impossible to disable bluez without
uninstalling bluez, which is very very complicated for integrated
desktops.

> ---
> =C2=A0src/org.bluez.service | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/org.bluez.service b/src/org.bluez.service
> index dd7ae8f1c..2a3b05758 100644
> --- a/src/org.bluez.service
> +++ b/src/org.bluez.service
> @@ -2,4 +2,4 @@
> =C2=A0Name=3Dorg.bluez
> =C2=A0Exec=3D/bin/false
> =C2=A0User=3Droot
> -SystemdService=3Ddbus-org.bluez.service
> +SystemdService=3Dbluetooth.service

