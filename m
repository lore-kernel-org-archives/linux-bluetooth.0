Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872FD515982
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748078; cv=none; b=nGaX1QgmwCcSewzGIyMs3aKJ9EpMvO0qKYozXmRQ9BT6kkaWin6StGztoXB0cCmIUVzvNlqBauI9yMNFAYpTIJcqSQVD8NmpYEsdqnQYK2LU8iYMmcMUpt0l50FKX0XZf2kdU5GijG0np2lDRS9jfwtkjH0wJFrqAKVuPa+CIGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748078; c=relaxed/simple;
	bh=x8UmwSXqVIE2dBhK1kRHEU06FEePyOGiR6VBgnacKQE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UeaiTWE7j0bO7nH84YT/P63QJKeI/e5DDCzU13x0sMwoO9N/RBASkpSB4RKeU7qgS+hMnEhgRPA1S++RKRDzSkA9XZq9lGsJIGrNJNJV82l7FImUmf12Y/yVnItQwc99WMgkmCX6rrbQzd/mmPrnQAD4h47EEqR6Sp8S5Znj5PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7hcB2nd; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7hcB2nd"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-78565b4db79so495162137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 09:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789748075; x=1790352875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DI6DLxKdBCo8DHw5/kJAQks7ELgBwsb1MmOkLxNciQ8=;
        b=W7hcB2ndZ8t0AoyLpq+ftG0BGeoQk2OuEtXHDzbSRC7PRsCANXSkO77My+Cs3BQWwn
         BKLS4ecf4TeUhx8F2UQKqF0e7uXewtugDD8cEdBeqmjU7++oZkAulSj4fSQq7Q/vqE2T
         60JE5GUSctVAjvvA2MNkedcpGqyP2ehP/RUvpNkweM33Q6QRfMa3+xfUcFKldgC6H/lS
         RqJL9t0FowH8psEdHbX8KHwE+0pq7hQNgxUOBP8KeF4MAbcGVNTuf5kNlri3vohM93Uo
         8aW7y4CIZ5TC1zz8WYM9VL6V58FufWjj2n7m/GOLMc4bRiug5RH4zC23iRFb1tKs0b3i
         6Q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789748075; x=1790352875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DI6DLxKdBCo8DHw5/kJAQks7ELgBwsb1MmOkLxNciQ8=;
        b=QgOzZc68n/KbCWkmyM6ZlAtsIhjvaBJryoFIBCZ3GhgdtbBNfvtFM0RGZ3oUm91ThQ
         W0N3b04N2szpykClrXVcmz/3/PE08SyrrjKBNXaU2lG+WbIKYbQEw/cLcqZ2O9lCLh0F
         ROD1TudoZ0KNm6VEK9fVDFSz6VpT/3C0w0u1TYLPPqg3ZvALyJydPkjaUFN101pYtwpq
         17qrhmv/zKAedpjk5gbSe8wJRp8c8rNqe12bNY2wNX31IlmszOF9lupdtuxKSlVBybW9
         7g2IixlBcwS1DIC25G7t+fSD4mXRloETljygO5xJwb5EFWnZXg7cIaWluNL6vV6f21at
         2nMg==
X-Gm-Message-State: AFuF++misd6XqsYNIiruB/MU0Q5sSpbYh5ApR5suWQxySZ/SAQMBeBeg
	K8a2xZnkn5Hfh5VXhBnXAObk4IlODGiQCPbS4UxkJHf1NI3dz5mLHjCkJkqNZT8G
X-Gm-Gg: AYBFou1jayq7XEq5Z+M9PgoXeTaO086W3NX9xQqJW1bwFXXnwbo1MVgefWW9YgnqHM/
	TBK9At1N8T6x81o16J6iqDFX+t+1HjEwqPiuGm5FF0i++OokVKlLg7QJ0AprpCGrFQL3jnrvXPl
	motDBRIR3kVcCHV24eqLPOVrSQMScHrqRoegKoe3BUqXYrTKl1fBj94NHTNcX+BW7Ikxu9mknlP
	FKk2kLXzRy2k82yCGE6TjM+Krc1L2aTdytXD8yb0oT9mA70A51xqAOTOx/qgMkwqtp6w6iWzx9r
	iHVC8l51hI4H2tu7UDmsMTO+cWibQMq6RHpPQf0z0f4MLcxJUl+As/PGvhkraCVIJwKlv5baoom
	N42MQrgzl7XagnCLic40MMewcqmHoH1i7D2obHYeN+l1jQBs5m6SKvjfgm1PdFD9HHgPq+wTRfO
	h5ayZldBrCUe/HIqmoUe9qyVxEfBTfouzaqRy5gcB9gGTiMTeElPY+Jsush3O6wqbMORfUBUpRs
	LYopG/i4AHe2iKWDbWjD03sgV3nG9lHFMynHvyvk6YTLuglfyY4oK4cufaBfbfw
X-Received: by 2002:a05:6102:54a4:b0:79e:b1cd:86f7 with SMTP id ada2fe7eead31-7a55ab35d7fmr1771811137.1.1789748075365;
        Fri, 18 Sep 2026 09:14:35 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a59c569181sm2104078137.11.2026.09.18.09.14.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:14:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 9/9] doc/btmon: Document the pager choice
Date: Fri, 18 Sep 2026 12:14:08 -0400
Message-ID: <20260918161408.2464981-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918161408.2464981-1-luiz.dentz@gmail.com>
References: <20260918161408.2464981-1-luiz.dentz@gmail.com>
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

Assisted-by: opencode:claude-opus-5
---
 doc/btmon.rst | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index 163289bd1ef0..1129ceb2e616 100644
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
+   fzf --ansi --read0 --tac
+
+``--read0`` is what makes an entry a whole frame rather than a single line
+of one, ``--ansi`` renders the colours instead of showing the escape
+sequences, and ``--tac`` puts the most recent frame first. Setting
+``PAGER`` to ``cat`` or leaving it empty disables the pager, as elsewhere.
 
 Frames are only collected when the output is a terminal, so a capture that
 is piped or redirected behaves exactly as it always has. The terminal is
-- 
2.55.0

