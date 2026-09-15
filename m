Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEC53876A4
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508662; cv=none; b=J9BN9YAiOulvLvrlwNK5FtN0uP3UTuwrtJatciVDreY4OQHb/A5r9aBLIEp2d4wbZ2ZByLRmr4AdwCXJn4YrEce6vBQJS0VMefuVv/CyUy5sRxFPnpMBJ5ldvcLYJN4hxGTyQdYMkd+4s3mJ6jublihuNXwedNt1bLxPSrEd0V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508662; c=relaxed/simple;
	bh=4JoyzscH0FB5NzENebDQ1tU1/vuzVawuVtpvu1nrfUw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=N9TyUu14gknoZqhmg3T8MHWNXIxQpRU+H2mQ882jssVxR8RJLfucAfSV/HBNekyjX+zpQ0q6RUwo2EAAzaxsYSDtHE5P9NdlYZ77GOgLe9yhIsR2JOeDB1Vc7sWXARRsX5cOaSTei/c26XvnvrBa33rKlaDZVSnE7QSkHpUvTF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+N3U/+D; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+N3U/+D"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-785692e5907so130417137.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 14:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789508660; x=1790113460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RISvfu9brbu8BRgdXNW7I+5aM7d3ATfZ1btBBRNs8jo=;
        b=S+N3U/+DnlJtuC9ImUQlVAC7XEjODwvDD1mHhnS+bID8GZVv7n0QactWNF2ILduRfm
         633jkWm9oGC2mjeZSzBxYDUpo3xiiZLY13BOLsQm86gmVAo+4AZtJ4NSOP6Ahz6liHMJ
         giGBda6i5uy72dovSQXT1Xrki5o3rhaAujLwQKgrcSe1uR2FbU4V7FgUop0oax6QIsW4
         NFP6So4obpUhRAOIbOVgy4Q5hfdM4vfPtc0QxYavmyMpzr8zVt3b9VfXhM/A3gme7BgE
         T/7iLQ8iZPKC1tby5dVZhJ/Pp9juorOjvTu5o50Jvci4hCCMxFLHKYamdaO4UDV5+QHn
         ev6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789508660; x=1790113460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RISvfu9brbu8BRgdXNW7I+5aM7d3ATfZ1btBBRNs8jo=;
        b=eDtQfoFEot/5cFSRuG/u249S/qJ/9CftJKe5lzbEV90iw6YEHDKOhyBw+cRvxXFHp0
         IukZ7ojV/iN/J2F3dzp++icncGEPAGV43jKI7Ir4bJFbFypR8x2BX3+zJ4u7Xi8FQ+Mn
         ISY3cPQC4zq0TqlAlo8MebXlY8NXdJvCeRe7Oy+alI4SDJohSIfyQjUcmeGERnuVVUT5
         XxlVvIj8XmaxEZ6Tp/ofREnnDhy8+ZdeKaCjrYGR+EU761g6rfpkherq/uqcWF8/nZcS
         Y0tFo20a9kUtZd6CV8+D5hxdg8eEMkjX8mJzfD3YalkC7eYfEKBSH8oYVKAq9EQkGYD5
         bSQw==
X-Gm-Message-State: AFuF++m70g0D1nnl4daMpB2D+PqPU4iZ1QGIDmg8dMMlEilmp+d9uMtP
	CN0KD/pGsxRa+57tRB8mnLUBesfAiPYPAeWKeOA/auiDHyehFg+VyN4x9ZEfgN7r
X-Gm-Gg: AYBFou2p91VBUc6be75sKHO/DPg+GO75YUEd5m3a0qvoIOKJYZ43Si9+kC93C9nQsH3
	ZdVSP3FX5FyuKhM5nuIsuidXuQarPsUxJqfdH91Z2wDEOC0Y/ZdtgtbAI6b4M+bJk4S2EkYgpmm
	uX36BD4cY9o6gNSrXify2TmiKpo70wr72e+VHLL10waKSl51RdktPJ2I3fa5yzndd/owyiYFQM+
	Z/d8jGsUInTgcUHrzeErgqTpwiC+Awx01CQkud7ehEVTSQ8+F6S4h1Va9Zdi8vYyGr9sAguD37Q
	KQ9v5tDyK1ZklU0AMhL6erWV/2A9Vzeee3scrrTzAqq1RxkwMoJcSloZSmkG6ubf5yLFoECzwqv
	nZdFERHaFrH5wNFkRrpXcQuvd+V085qxLeaw7O8L8r1aUWpHlIDNhle4X5ehIwvn+wuoIiOfOqV
	Ep1SaqblnZ12mBS/4jtEFGYT3Kf+IjqsXGjqvaBG3GIGCAb/Mf8qAjKj3wAPIpOMAECL/fA1O9q
	xUIqFdmQRYJuPLRPnCirEAF0pkb5jViiWNY/ZTntD+0S2NkpAog28QzqHQUHBBOxg==
X-Received: by 2002:a05:6102:5089:b0:79c:d125:9bfb with SMTP id ada2fe7eead31-7a02dada529mr561953137.10.1789508659822;
        Tue, 15 Sep 2026 14:44:19 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-79fb2ce4f3fsm1036389137.11.2026.09.15.14.44.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:44:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] doc/test-functional: Document PCIe controller passthrough
Date: Tue, 15 Sep 2026 17:44:10 -0400
Message-ID: <20260915214410.1250646-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The tests needing a real controller can now use a PCIe one with --pcie
and --force-pcie, in the same way --usb and --force-usb use an USB one.

Unlike an USB controller, which only needs its device node to be
readable, a PCIe controller is bound to vfio-pci while a VM host uses
it, so the tests have to be run as root and the controller has to be
alone in its IOMMU group.

The model wrote the option handling in pytest-bluezenv and this section;
it was reviewed and tested by the author.

Assisted-by: Claude:claude-opus-5
---
 doc/test-functional.rst | 51 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/doc/test-functional.rst b/doc/test-functional.rst
index 4a784e7850a3..3ffcbf6dec5c 100644
--- a/doc/test-functional.rst
+++ b/doc/test-functional.rst
@@ -107,6 +107,20 @@ The following additional options apply:
 ``--force-usb``
         Force tests to use USB controllers instead of `btvirt`.
 
+``--pcie=hci0,hci1``
+        PCIe controllers to use in tests that require use of
+	real controllers.
+
+	If not provided, value from `FUNCTIONAL_TESTING_CONTROLLERS`
+	environment variable is used. If none, all PCIe controllers
+	are considered.
+
+	Passing a PCIe controller through binds it to vfio-pci for
+	the time a VM host uses it, which requires running as root.
+
+``--force-pcie``
+        Force tests to use PCIe controllers instead of `btvirt`.
+
 ``--bluez-build-dir=<path>``
         Path to build directory where to search for BlueZ
         executables.
@@ -139,7 +153,7 @@ The following additional options apply:
         Git branch to build from.
 
 
-Tests that require kernel image or USB controllers are skipped if none
+Tests that require kernel image or real controllers are skipped if none
 are available. Normally, tests use `btvirt`.
 
 VM instances share a directory ``/run/shared`` with host machine,
@@ -224,10 +238,10 @@ socket, also bridging the air interface between them::
 
 See **test-runner(1)** for how the socket is attached to the VM.
 
-With ``--usb`` the ``btvirt`` process is not started; each VM host gets a
-real USB controller passed through instead, and the VMs talk over the
-actual radio.  Tests still prefer ``btvirt`` unless ``--force-usb`` is
-given.
+With ``--usb`` or ``--pcie`` the ``btvirt`` process is not started; each
+VM host gets a real USB or PCIe controller passed through instead, and the
+VMs talk over the actual radio.  Tests still prefer ``btvirt`` unless
+``--force-usb`` or ``--force-pcie`` is given.
 
 Writing test code that runs in the VM, and the available VM-side
 facilities, are documented by `pytest-bluezenv
@@ -306,6 +320,17 @@ USB
 
 Some tests may require a hardware controller instead of the virtual `btvirt` one.
 
+PCIe
+----
+
+A PCIe controller may be used instead of a USB one. It is bound to
+vfio-pci for the time a VM host uses it, and bound back to its own
+driver afterwards, which requires running the tests as root.
+
+The IOMMU has to be enabled on the host, and the controller has to be
+alone in its IOMMU group. See **test-runner(1)** for the kernel config
+the passed through controller needs.
+
 EXAMPLES
 ========
 
@@ -422,6 +447,22 @@ possible.  To force all tests use the USB controllers:
 
 	$ test/test-functional --usb=hci0,hci1 --force-usb
 
+Redirect PCIe devices
+---------------------
+
+.. code-block::
+
+	$ sudo test/test-functional --pcie=hci0,hci1
+
+Unlike USB controllers, this requires running as root, as the controller
+is bound to vfio-pci while a VM host uses it.
+
+To force all tests use the PCIe controllers:
+
+.. code-block::
+
+	$ sudo test/test-functional --pcie=hci0,hci1 --force-pcie
+
 Run tests in parallel
 ---------------------
 
-- 
2.55.0

