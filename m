Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0973AAF4A
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677960; cv=none; b=RNGNMfMPjNUQeuJ2LX/tM/giXyTXB7cLpQ/oeyhc+T2byOgNW/ehOM72raYV1fzBgfUoozUBrI/xO1Wv0jT+VGKu3raKwbSsUPANJzLnd9AVS8NhMW227SDWjC2Qlz00akRuMNY8x54UWxHzIp9nDrxQv58srXn/G9MWDASu99c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677960; c=relaxed/simple;
	bh=/8BP7zMEot7gKMdMZaQobTNb9S/PPX40rtlbUgG5cd4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeKj0ii4h/yHybGivp/eUkRCKd0WZw3RNOZkwvqCzf0xlX2xqEDIkB2LPGUHLqs3Gby4SJUjiKMvtd0jrb5na+FNmFAcOIdnlErDnugG45dK7pAdLuARSW1e9e4uPyFzEhVcCBTjycTKDTyMrOIdc6pWL5Dj66+jPk+dhyLvQLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mfy0SIOw; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mfy0SIOw"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-78a4c5c582eso27827137.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 13:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789677957; x=1790282757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+5SuJkXEARG6PFouTixa0nuOgu8kx3ooH94LbK5pA+A=;
        b=Mfy0SIOwwZpQpyaKCKRbbe2hMkdIIgOkJk98yW1T3jbFbXUe71fscwh/dGuHC8wMil
         E2EsMoZ96URX94vK2Wni/5h9AvIrATSVYYPHFC4yvn7Jcfp8kDyH8GeaX81U7Y93Roem
         dUz5GbUYXXRdbK04JEo+bBEr9UiorlD3hLlZtiP5yIiVUCSfOxehNIl0tjz6Ks+vJ3mB
         PFgUgeWcccML9PGtrCrEgZNVJbSAtj84jxFLBgwKLO/1NLrq8N4tEdOiefqfV7vPphi0
         XBELOXt8E4VfmR55G1DaY31vhbj2uOxVcxoMPcBtfvyQU2DL691GWiuIBkzotEiEzk2G
         iXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789677957; x=1790282757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+5SuJkXEARG6PFouTixa0nuOgu8kx3ooH94LbK5pA+A=;
        b=019Hg2svPymeBW5NgQ8HH8snRLxN9TWGkdRBlWrtWQVxirW/tp9jcJ7NpqWrgkPZpj
         9yJxJ56gLQk2ylt9CwSQnx8gVVfnNfWu0SEMCdUlNNVuU1+OUfmO5u42HyOQogLP80RO
         N0F0DUh3CC6KP7oU8ec9K8CzwnaOkcvvWk0np23QAi3ado3Isqr99LEo7S8MATwpoH0R
         b/jLQl390d9yrwWugc4X8Vaz50YfbhI4d5Vz4msLtSmQoeFBAdlZLBZletmwROHubP3L
         9To8IIfROsPxvsV8maknsbMFaIQ0lgjFQlNKexrNkyUMlTVK/UJNnS+z9meQGTOEdadv
         5B4w==
X-Gm-Message-State: AFuF++koPxp2o+2A3hA1Vs48ZfPEBaDhCZDWmezQr13rgqU2XRzQdHT1
	0nfA/kwedr2f9yb6G7Haz1vAd5bHsOevFOeqHlmZK6Lj4bVdBBuhSMU/Qj7ZqjqEAgXEMw==
X-Gm-Gg: AYBFou3THHcnTWXNGgjkRly5Vg5NdPnKpRvM4BxKAuTOoLwGiHu2bglcih/JCiYDXs4
	+R4+jaJhxMDiSSJ43HI4g4Vnw9a35rRfeKhKSTm3xfHrAIAL2/YQReaOmFCeD+31lXjXihSeXxL
	hAnnGsFJGNdl92jDZUDMpSVrz9HniF1DAyt1eWZCBywDSktc5J9R52TRzOChou4/f9VAyZ+a5cz
	IfOCHQcjpqjiU773LdhXA5MLPJ+W0ClLzlwROyKEt8R+zej9HIjmjYvsPiF+fhYC0zxeS7A+pek
	QOaZnxDSCy9KZmKrWKWlqAhbw6b6YVpKe5xmTYcbs4TaWdRiSHxvCzUXKwKq381aZiJXsq7rZ3N
	7eb7YopgE8GF3UHykUE4UAeRyZjbuyOlCQz4d0UWgUrXw065b5UTS7m5NVPoMIzNQ1tBWRm94yL
	4Sef2UGYQkwedS8EA33BkbKCwAjP02tNr+v65Jcz+OtUdTHR4dTwmfy5Aaue1EwpwnNQYacPuC4
	GiC4SEB+aDZpN0rJLdNqRwDR8BnLLJcknP/57kEyV5ijT3O0t2k3BLPaMwYsEn6Zg==
X-Received: by 2002:a05:6102:54a4:b0:7a1:f7d2:e82f with SMTP id ada2fe7eead31-7a55a92920fmr133576137.15.1789677957520;
        Thu, 17 Sep 2026 13:45:57 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a1dcea8a67sm4584833137.0.2026.09.17.13.45.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:45:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 6/6] doc/btmon: Document the pager choice
Date: Thu, 17 Sep 2026 16:45:41 -0400
Message-ID: <20260917204541.2176720-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917204541.2176720-1-luiz.dentz@gmail.com>
References: <20260917204541.2176720-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Describe that fzf is used when PAGER is not set, the options it is given,
and that it needs --ansi to render the colours when named explicitly.

The model drafted the text, which the author reviewed against the actual
behaviour.

Assisted-by: opencode:claude-opus-5
---
 doc/btmon.rst | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index 163289bd1ef0..d01d563ba0e9 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -639,7 +639,9 @@ separates the lines within one and would otherwise show as a blank line at
 the end of every entry.
 
 Nothing is separated unless it was asked for, so a pager reading lines,
-such as ``less``, is unaffected and never shows the separator.
+such as ``less``, is unaffected and never shows the separator. Redirected
+output is never separated either unless ``--print0`` says so, since nothing
+is then reading it as records.
 
 Searching a running capture
 ---------------------------
@@ -657,8 +659,17 @@ Whatever arrives while the pager is up is printed once it closes, so the
 trace on the terminal has no gap. The capture is never paused, as anything
 not read in time would be dropped by the kernel.
 
-The pager is taken from ``PAGER``, falling back to ``less``. Setting it to
-``cat`` or leaving it empty disables the pager, as elsewhere.
+The pager is taken from ``PAGER``. When that is not set and ``fzf`` is
+installed it is used instead of the plain pager, as it suits a trace far
+better. Wherever ``fzf`` is used it is given the options it needs, adding
+whichever of them are missing::
+
+   fzf --ansi --read0
+
+``--read0`` is what makes an entry a whole frame rather than a single line
+of one, and ``--ansi`` is what renders the colours instead of showing the
+escape sequences. Setting ``PAGER`` to ``cat`` or leaving it empty disables
+the pager, as elsewhere.
 
 Frames are only collected when the output is a terminal, so a capture that
 is piped or redirected behaves exactly as it always has. The terminal is
-- 
2.55.0

