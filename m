Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459063D88F6
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789507118; cv=none; b=NfpvDvtGRko/3W+izFdglZAJb8ebFjMoilo0ITVqgas+T1WoXVKUI+lnYzs7YELEPOfIEdc9fTiprgIr9OJM20t2zblkWLHbDJPila2hBVIHfvW2ffqroNNiJSq+aqRcWvRQiPmvYnG4+A2z8nXTrlAnz+LrUDHhlXJIk87k+X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789507118; c=relaxed/simple;
	bh=Kgu9k/fNNRBpkv0mEbg6t9YtTgz4m7dpnBL8FO+u4/Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CTrkZ+MK7oC6BqOaNsAaCLPrHY0BgIJoXLfHdhEODV4SiHwPgOEYUw3Nc+/oEoD7qtodGzNKfZpqMn5FUjGEvMiXU4JirrZx3SiOjOLHTB6aDAU6zBW0GOrTIym902PrVVe3BFkRouedUjeNrygcP7zU0iMm/geDUh+eRsEAnQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GJnW3Hf5; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GJnW3Hf5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789507116;
	bh=gOJfYHRgVqYxriUS+pIdrKl7LJhJ9sfED8p2w147wpU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GJnW3Hf5SUONdWhxkiTWEMw021vynY2uxiz5aPaNDFDOGhTZkcEwo+99yCy89a1ku
	 FawmRWKv/FYPOAZTx6+7PGwLPl5jzoCZ5oa+asYUoemj7McsqcGAOp6ZyeGhduziz3
	 dgMGcFnbfG4C0JsABCTF8C707vhrHz01sI4ZQ3pY=
Received: from github.com (hubbernetes-node-c7061e7.va3-iad.github.net [10.48.174.61])
	by smtp.github.com (Postfix) with ESMTPA id 5146C50170A
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 14:18:36 -0700 (PDT)
Date: Tue, 15 Sep 2026 14:18:36 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/action-ci/push/refs/heads/main/e0b8a6-603489@github.com>
Subject: [bluez/action-ci] 835f93: action: change action to pass --device
 /dev/kvm to...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/main
  Home:   https://github.com/bluez/action-ci
  Commit: 835f93fdb418a577f3583b52f9940f5cf1fefe27
      https://github.com/bluez/action-ci/commit/835f93fdb418a577f3583b52f9940f5cf1fefe27
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-15 (Tue, 15 Sep 2026)

  Changed paths:
    M action.yml

  Log Message:
  -----------
  action: change action to pass --device /dev/kvm to docker

GitHub-hosted Linux runners can provide `/dev/kvm`, but a Docker
container action declared with `runs.using: docker` cannot add Docker's
`--device=/dev/kvm` option to the container created by GitHub.

Use a composite action instead. The composite action:

1. Enables access to `/dev/kvm` using GitHub's documented udev rule.
2. Verifies that the KVM device is readable and writable.
3. Builds the Docker image.
4. Starts the image explicitly with `--device=/dev/kvm:/dev/kvm`.

Link: https://github.blog/changelog/2023-02-22-hardware-accelerated-android-virtualization-on-actions-windows-and-linux-larger-hosted-runners/
Assisted-by: GPT-5.6


  Commit: 60348956fc7bad52a64e802f3e90f90c03ba8860
      https://github.com/bluez/action-ci/commit/60348956fc7bad52a64e802f3e90f90c03ba8860
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-15 (Tue, 15 Sep 2026)

  Changed paths:
    M cleanup_pr.py
    M libs/email.py
    M libs/patchwork.py

  Log Message:
  -----------
  email, patchwork: if token is "TEST_TOKEN" skip actions

Allow doing partial dry runs by setting email/patchwork tokens to
"TEST_TOKEN".

This allows testing of the CI with Github actions development setup
only, without live patchwork/email environment.


Compare: https://github.com/bluez/action-ci/compare/e0b8a65c9865...60348956fc7b

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/action-ci/settings/notifications
