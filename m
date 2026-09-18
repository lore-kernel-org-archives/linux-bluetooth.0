Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FFA515880
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748073; cv=none; b=ktpvSTw7gD9dBavnU9FR9p/BNSt8HY62NECoyuuQRNj3qbohx5fGCmDtvb3cFwvCASwh1+s0Y+8/248qd4DphphkpZRoI2X0rEhUb/r9KxvHCluOjZpJqEFOkBQgFcIHfCo3EWLRsezurgkZoUg2w9jGkPtaxFWQaEkUGPseE/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748073; c=relaxed/simple;
	bh=AIwVd7wEw4oO+8i1T4qI6TeDQeVguw+nRkq7R8WjUss=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4IjBrKtBqELMdU67WkgGYZyVTTkEOZvA1Rc0EOE2DIo8I3/aOlkhBYfaAuHY3FLt7Bhw92nsCJa0ub+/EIGJwPYHr3xo4lHC2ZLqr58uAHB46trOxtWXlEp2vub3LfkWZ8E2/ZVuiIWAHYOtvDPC/YgR/k4lddTU/VV6XbSOO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebz4/ZD2; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebz4/ZD2"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97eaa1155fdso235452241.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 09:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789748070; x=1790352870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6wzCD51wqaW5RigTchV9JnVkXxMg9HcDk2oTaJNPsD4=;
        b=ebz4/ZD22riBP9trDk385H5He+SknJIzS2gNIh8oKtPdWs6khfziHXDKmjn4/+AqoF
         Ln5WiiXJDT9XaS+pIvGnSPslJlMjPNwJpcwlvgDmeDhZVVUH2Oc5EA/CCALlL73W+jqe
         bM5jZek+FWwjKsdWy39PE/VUR1jf9oiOfno5cAySnN4WvYym5W5TEpXIZBQMnt+m7rnZ
         pTk9YeavpOwBpmUo6/6k86291XRLloJ1bxBYD6TIw0wlnWHloVQP5GNI15VOX1uQdAJi
         GHyIU/I26upbX7/EzNsHR94EZE0/7gTA5sWJut7jEkvVzA6g7ljTxGYh9HYL8mIKlgz0
         gfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789748070; x=1790352870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6wzCD51wqaW5RigTchV9JnVkXxMg9HcDk2oTaJNPsD4=;
        b=afkZCWMeH9pBsDYmj5QeGd/V1c6KCI7D6zneDeuP9e2Emuo6qgC1xCwQEFWqQcTC8r
         tK4/mCB9eAtPFcmvCzZDCM3X81jewkE9sf7fxA7bPOhR+dkQQm5yY+cikk+/6+/p6XNk
         nGIZ0FxQdFMMIhZOKJt3t+jyS7/ALMKqNgAEgyX0797qeSfCSCk1+P5xgo3PUydOHL47
         VH6jR/OU02fSGjDbmujSUBhx9bVOBQ8UDmNm17b1rAZb7s9kEDMdwv5MdWrKKmAeEskD
         exB4qm+Dca0/ozUQoaXFRcRxTAvIbPoViDux55Yg/WYvRsf1N4Ca7DqVzeMwNgrjCWit
         GOoA==
X-Gm-Message-State: AFuF++lu8ojj0gIELB7mAKM6B9mTH+ZsnXVFGu476LrHxSeIpvRcsBZ6
	oI21u8XUZOd0Xk72Dxtpx5m4cQ8v5NQ/Wr8Z1fVR33Czj6mN9wihqaXfsaHgXM3j
X-Gm-Gg: AYBFou29ZLGMESl0esK4jRzte71gURsiNEZ8BitAQhK+BJbcz0KOP9UPzGIYk6OTzZq
	7ETyJG7NuQ9dWHzQFc6ZDa6ZwF/Og6+mCs1pmuNhIhgFhyHP6h2XbekuwmaNJaTfWkpKsESyUaO
	CELkb8Bg+KudFKx4K3MrUY8S2okMBD7XMECcySgA0YXKJadXoxaRHLI6QGDb+8L9MC7Z+bkTl/E
	1d9Rfu0znp7qsuDYZJTqka/pt/2jd+czuOYilQZ4syCgFP2v9vdchipS3vHd6wjwXiytCHRMS+b
	D370O8g6Pk4qEnUgTERK6P3ZCt/K5dn03+oFLbPZ3pZ7ejWo2CfVPxY38EmtmPk9G91F7FbLDr1
	HizCyS2W+ZLvxxYE6paKh1Rkws5/KEhxi+JiRfp5LjGqv2hpr9rf3nJ0gzYaFqDCJAAvx6essa+
	D7Z/qJpx+ogptfK7f/p3Ju1MRa9XHdez3hNaC14PqF+3CSOkdC9obALaAYxSZpkvsfeV7/muOZj
	ckOhDnGXuFLew0pFjBf/pQLQmz2mmrOeWUyL/ciajjQsaGlQPzXlQ0pgKqPpEHO
X-Received: by 2002:a05:6102:f14:b0:79e:482b:123b with SMTP id ada2fe7eead31-7a55a82856amr1240069137.8.1789748069879;
        Fri, 18 Sep 2026 09:14:29 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a59c569181sm2104078137.11.2026.09.18.09.14.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:14:29 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 7/9] doc/btmon: Document searching the frames
Date: Fri, 18 Sep 2026 12:14:06 -0400
Message-ID: <20260918161408.2464981-8-luiz.dentz@gmail.com>
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

Describe how the frames are separated for a pager reading records, how the
ones seen so far are handed to the pager while capturing, and that they
are only collected when the output is a terminal.

Assisted-by: opencode:claude-opus-5
---
 doc/btmon.rst | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index a08a6afa43f4..163289bd1ef0 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -96,6 +96,9 @@ OPTIONS
 -E IP, --ellisys IP         Send Ellisys HCI Injection.
 
 -P, --no-pager              Disable pager usage while reading the log file.
+-0, --print0                Separate the frames with a NUL, so that a pager
+                            or a tool reading records rather than lines sees
+                            a whole frame as one entry.
 
 -J OPTIONS, --jlink OPTIONS     Read data from RTT.  Each options are comma(,)
                                 separated without spaces.
@@ -616,6 +619,56 @@ The kernel forwarded this as a MGMT Device Connected event. bluetoothd
 logged its ``connected_callback()``. Then data exchange began -- an L2CAP
 parameter update and ATT MTU negotiation over the new ACL connection.
 
+SEARCHING THE FRAMES
+====================
+
+A frame spans several lines, so a pager that works on records rather than
+lines has to be told where one ends. Asking for that with ``--print0``, or
+by having ``--read0`` in ``PAGER``, separates the frames with a NUL so that
+a whole frame is one entry::
+
+   $ PAGER='fzf --read0' btmon -r hcidump.log
+   $ btmon -r hcidump.log --print0 | fzf --read0
+
+Without it each line becomes an entry of its own, so searching finds the
+line reporting an error without the header saying which controller, handle
+and time it belongs to.
+
+The newline that ends a frame is left out of a record, since it is what
+separates the lines within one and would otherwise show as a blank line at
+the end of every entry.
+
+Nothing is separated unless it was asked for, so a pager reading lines,
+such as ``less``, is unaffected and never shows the separator.
+
+Searching a running capture
+---------------------------
+
+While capturing, the frames seen so far can be handed to a pager at any
+time by pressing ``Ctrl-R``, in the manner of the shell. The capture keeps
+running underneath, and closing the pager returns to it.
+
+.. code-block::
+
+   $ btmon                          # then press Ctrl-R
+   $ PAGER='fzf --read0' btmon      # then press Ctrl-R
+
+Whatever arrives while the pager is up is printed once it closes, so the
+trace on the terminal has no gap. The capture is never paused, as anything
+not read in time would be dropped by the kernel.
+
+The pager is taken from ``PAGER``, falling back to ``less``. Setting it to
+``cat`` or leaving it empty disables the pager, as elsewhere.
+
+Frames are only collected when the output is a terminal, so a capture that
+is piped or redirected behaves exactly as it always has. The terminal is
+switched to reading keys as they are typed, but signals are left enabled so
+``Ctrl-C`` still interrupts the capture.
+
+They are held in memory and the oldest are dropped once 200000 are held, so
+that a capture left running does not risk the monitor being killed for
+using too much memory.
+
 ANALYZE MODE
 ============
 
-- 
2.55.0

