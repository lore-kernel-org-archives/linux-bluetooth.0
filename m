Received: from mail-vs2-f20.google.com (mail-vs2-f20.google.com [74.125.227.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCC73914E9
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677959; cv=none; b=nqG/FRnxh++XgoQCjH5kzrMCgFycICS4Xu321j2lUkrkXzGEeB/F6KTq+AAYMWR03CISvc46j8O2T7B8Sccg2SrEPnAOb6kUWdiiZr4OV+NJKxFIk+rt+jv35xunyRfx5cwSMLzeJCcsZYBt0rF5r4OjnCr2qsYbwqulginD7gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677959; c=relaxed/simple;
	bh=xbMgtXJSCrcLgtNbtToXP8rbijjOl9VHPc9MqIG4FtY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3IBrcgyxho6vBaCLS1pXhxDygdpDtAjaNhSSAIXTRcWF3CHEi6n6tkm3TO9Y61HP3e/DJkFRJ2PlPxR/GqCLOCcnPtul06qx8cEVLUonXKNM3l2x7d/tSH41YG+EARK5VckJlsvA04KUc0AT0uxgH0mDfQp2UJHnQpW2HMuGQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vnd3HDO8; arc=none smtp.client-ip=74.125.227.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vnd3HDO8"
Received: by mail-vs2-f20.google.com with SMTP id 71dfb90a1353d-5c67e4fff62so406012e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 13:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789677956; x=1790282756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m8ugKuKSEAgsBFcK0F2MfHh9VGA6xC2VvZT5fTYos08=;
        b=Vnd3HDO82TpuV5vY6Fe9W/k4ZvQBA5W5buOsC0+V7Hzw7nHqccoaxsZQs2fkrQ6zAu
         gYXn2u1ij86dUxwMOaUkqmL7RSGNxmzrLPA4GcTQpqzgF0suE7OuDMNFoOh3LMHYcfJ5
         hOSZJD9oNCAj/ZBUlSOrCMh5oKK0ZLyCgOsCdLppyCWoczzxqQiTuBoqThZPbY39V0+n
         4RKWVul5jpsmIU8klcdib1mS8K8QtRuRRRfuao7j23mbePIzDru3oT5iFr9D5B2/UApu
         CNIAcB2CxKGW43QWXMorIrbqirTIB0vjHYjFLZTBtWSsTAo2WacGMlDMJIre6XeE9fnJ
         BoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789677956; x=1790282756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=m8ugKuKSEAgsBFcK0F2MfHh9VGA6xC2VvZT5fTYos08=;
        b=QB0Pw524QyU85iK0ngLIMXWAVRwK80eHFIGzdc9jtHE9kvgnICxvdoQmU9QR3FGaBv
         gmWawZa0eoQfBlYGyAPCQrUa5P3PpJ9i4HlmstGkTvsjor5sZ7Aqrz4SnIP4jy7AmDo6
         eMaofxeO2K3PGz86uV4h/DEiRYsVyRCA3MLRwirnCPYWI+4B7SVrdXNzw4pUV+HNmDmI
         S0feIXJ9paQK5GqWQK0k/UHiI0hKh4bPzlYEP2RzL8Wtu5lbh2FpxD75ibDfoNBLN282
         rwzVmTWSBu1POM7qwSC0VIViloB0wg5zPJoiJYBBSgV7o7IkSJNaozy1jrF+hkoLEKya
         jxfQ==
X-Gm-Message-State: AFuF++nvc41TS+tYmGGQ1exorx9pba4PI0MV5V4BKhbIHi8hotyychCh
	4rRcd5ekAuhDDKP5ouGbw4IWnJf/Z93c/4poz2qaLqYC4fNoC3JaldVIBnVQ+Zh5a0okkg==
X-Gm-Gg: AYBFou1V43AvlkvVJt1n+CyUh6nS+7YHn8decRe9Dr3PPF/3x49KK8jUR+nOO2sPYhQ
	WRyF+q3Z0zFC8Xn79sFkGtu6D/+n/95UDDlBogEi8bzoohDEJbP091C/uAm99JgSeJmds0SFwer
	etiU7LkLiqvIBC0uxaHImqt2DqSr0rJ5gUa7F76qlHM4tHq3Les1XWpULrhkv50TLE+BqJD/FcX
	IwAOPA/19L6m+xJ+ckkZamkI/8FyC+vRe5Q9L/ePwP/Ous9a2J7ZZ1GWx39UJgpV652E5huAzrd
	1WdSWlJiHP+fXoos5nnKqafaaigAO0BkRa11rtxnuJeJ95qEiySpPIuJdVdEKjhdi9z4ie57H5f
	3n9uxX8k63EvDZ/enMaR0Vq7MaxL46/lOhxlxk3V4QfSY9RxEJyID1HjoQFpMgHhBfP/oohxvmj
	IeKWofyh1J1g8KnCx0aERY5aVAEzgIh4PtDOq8JF1YjHJSBrMIsR7tQrpMi93v9ftDJBEIOGKLq
	vIDk/rdxyG05ozMTxlYREOLr7qKivLU14FinfIjUlMzVvNIUPWfmjq8s2PZt7AEXg==
X-Received: by 2002:a05:6102:91d:b0:777:4e99:6f84 with SMTP id ada2fe7eead31-7a55a226487mr152779137.1.1789677955962;
        Thu, 17 Sep 2026 13:45:55 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a1dcea8a67sm4584833137.0.2026.09.17.13.45.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:45:55 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/6] doc/btmon: Document searching the frames
Date: Thu, 17 Sep 2026 16:45:39 -0400
Message-ID: <20260917204541.2176720-5-luiz.dentz@gmail.com>
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

Describe how the frames are separated for a pager reading records, how the
ones seen so far are handed to the pager while capturing, and that they
are only collected when the output is a terminal.

The model drafted the text, which the author reviewed against the actual
behaviour.

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

