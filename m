Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6BB4A0F1E
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 21:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679998; cv=none; b=QgwBGFa2EOwVU1BYsXRTPizHpexNUvJhzNMMJN0F3cVtDm1xzmsaPe7fpjGuzzSREWjIbRKYnFiIJjMM8qJCUs6bMRI8T0EVHNh9EaAdN3O0gjWaRiragZfMaqpPoTkh0CViII90rdHht8ZNUAeCrXeTgK2ZOa22MaJpdKKf0nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679998; c=relaxed/simple;
	bh=Nud/csu0oALfIk1in+qukSgwsXbRJOhFLKs42ieJzoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DEtNqr/po3F0LUg0UApcrAFGAnuPmwe1K2HsL+39BELgyAhEXG5YnqxGXDiw6pQawlpPpsXaQLUOEMiDy0Bj8u32p93Tb8cj0jucpOp2rhUYxPxJW3tD2Oo8u3pTy5azTUvpTOChC9j9Qb6BHdeofcocM4U1JoUUpwUB4ZpdlxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=yWQ/8B49; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="yWQ/8B49"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48437356d60so7643f8f.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 14:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1789679994; x=1790284794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mAKu+XW/083rrHRSYL83FHRHaXFQr80wRG7HvCbx4Qc=;
        b=yWQ/8B49TCOtompHhU8h6uE1Lzln68IhfC92B4TkZ9O0kGtAAfAlf4J09K41+5vWxc
         BsD/z4lM0USSvtv3l0xLSOENtrYC+Ge0TiHKs1wGYSgI+Fc1XahAxpiV/1+x1sXid5Bu
         95QGJSNgRUgjK5u3E4iCpym/9d5o5Jj1Dl6dJBOk6yxWOR5+UKSD2ymjtJBgAl3FZ+OI
         VnffBDNyjfh5gJ0qApaZTmMq+5YtD9Jcd3CO7ni+EnPETdrQTFXvsukn+iMBf47Z5dyX
         cDtuZ488RD5T6Kkk2m+qFiQ3M7JnF8O7P0QHd5eDEgLFwVzFoRpHpJ/kTpJYDP0067oM
         EiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789679994; x=1790284794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mAKu+XW/083rrHRSYL83FHRHaXFQr80wRG7HvCbx4Qc=;
        b=hUqFQRnvlosJ5s9xLJoT+pusJTzbCs/vskTglpcEQ0DmUP55lNvoZH+IidF2Ix1W8N
         G93eL8jOHOVoveycz9MOAr2Eek5i/j0YISPJ9Oqiwomvv7sZ+iPAXLjl8zJzH8d1okmo
         eJZVzRmhmtpWKnzoItfonWSJUZPzJgWHfVb0/Nyk8X+7Reqm32ImYl5ZGMj9gs2Q+B4Q
         XIC7uEpfBN96GCOWp5OBw4xlDJfNqXIkwxcp6+8XIImrMl4fE+BV8vZ0ZAa4h3+V0BeJ
         9wjJS4C3TyjzDekx6g1TE6iuoTzTvefJ2NDWeQSB0AxklTOXEppgx7JuffXPP4BbdFAj
         AcRA==
X-Gm-Message-State: AFuF++lMruWjfu3Fo26W31+tSr/phfOndvukSkxLLui8hL8KLtat8WaX
	TFjnrErQ5i9aNUiR/YzIBCX67BDgV1A6+6PqMdkVk5BsXcLVMb5a4BNBCYhg79v4jUtnhNtif2/
	1cIQ4gw7Y
X-Gm-Gg: AYBFou0VW0nL2a6mMJmyTsEy6ViCCcIzsAPWw61uyIKNvLcQYSBrv8mvcfyuv84H833
	DJIAW5u/xHRAI2hmOuCrZHfb1G1YtDmsJeTRkLjM9D1CVcUO8fwPKa8jGNpE0H/gqpUdqFu7dt4
	AlP1Mg87ywTUtzvLEafmirbUuGeguMlwPSrbXK2mxfRQ363X0ijX24GqhJAu9Gvf/hDnBwN1JI9
	VI42mqBDBjSSmGJaCqagLJmjD/Evbop0BikgGCJXd9r8eeaATd7euynXxtUoCVATR/ayZoMu98w
	1/LJXQi65b9lVK9+MZbG7/hGACipQi6In4ARjozWWNPW4iD/Wg+6Mhwb2Me9+wduNqbl4XgywyP
	pIZMYPgpgSol0e4PHWSna0S+BoC+Mv5Df0kTlM6yXcmLKjNIe9CvFMb4c3QkKcK+hbu+EWGpqYx
	8vV0VNGAafljytjN+ZTej+XSlJ1dngdWvaT5zw0UjK3qcXQT5qxPQf7BnE1yX0HpEgfrr/UpOzM
	bMRBXi2dtfOKZbDvQmNqnkm35R0/1s4SLeBzA==
X-Received: by 2002:a05:6000:70f:b0:487:b50:101c with SMTP id ffacd0b85a97d-4871e215a94mr246855f8f.5.1789679993956;
        Thu, 17 Sep 2026 14:19:53 -0700 (PDT)
Received: from fighter ([217.155.46.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1f6cfsm19086828f8f.13.2026.09.17.14.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 14:19:53 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-bluetooth@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Rhodes <sean@starlabs.systems>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	Kees Cook <kees@kernel.org>,
	linux-usb@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v2 0/2] Bluetooth: restore powered-off Intel adapters
Date: Thu, 17 Sep 2026 22:19:50 +0100
Message-ID: <cover.1789679980.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPI-managed internal USB ports can lose power while the Bluetooth adapter
is closed. Intel controllers then lose their RAM firmware, and btusb's lack
of a reset-resume callback causes the interfaces to rebind.

Preserve the binding only for a closed, fixed Intel combined adapter on an
ACPI-power-manageable port, then rerun Intel setup when the adapter is next
opened. Other adapters, and resets while HCI is running, retain the existing
rebind behavior.

The first patch fixes detection of ACPI port power management while USB ports
are being registered. The second adds the restricted btusb reset-resume path.

Tested on a Star Labs Lite Mk IV with Intel 8087:0aaa. Three Bluetooth off/on
cycles reached ACPI D3cold, restored the same hci0 without a USB disconnect,
and discovery found nearby devices after resume. With Bluetooth powered off
before S3, the controller also reset in place and powered on successfully
after resume.

Changes since v1:
- replace the open-adapter remote-wake policy with closed-adapter recovery;
- split the USB registration fix from the Bluetooth change;
- restrict recovery to fixed Intel combined adapters on ACPI-managed ports;
- add runtime testing covering D3cold, discovery and powered-off S3.

v1: https://lore.kernel.org/linux-bluetooth/48576c0c4615c9f34f44935216e63d48518f9d46.1785838429.git.sean@starlabs.systems/

Sean Rhodes (2):
  usb: core: check ACPI port power during registration
  Bluetooth: btusb: restore powered-off Intel adapters

 drivers/bluetooth/btusb_main.c | 33 +++++++++++++++++++++++++++++++++
 drivers/usb/core/port.c        |  7 +++----
 drivers/usb/core/usb-acpi.c    |  7 +++++++
 drivers/usb/core/usb.h         |  6 ++++++
 4 files changed, 49 insertions(+), 4 deletions(-)

