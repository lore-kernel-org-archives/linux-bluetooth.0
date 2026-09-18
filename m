Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42E7511E6F
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748061; cv=none; b=ii413UlaXXq/+9WWUki7+fYwdhuoEoT5feNu990kp3DfEyH9OiVnlQMy27dlZk0hT6o55YiBj8EtPNHOrYCDkkdYlW06mFIE5I1Gh4HEZqhM22DEU2pb8r/Nr2WOmHWecrfsQr1p8bKHGosTnfbY5uLXU+Puc+ZFr+iXrdTZ6iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748061; c=relaxed/simple;
	bh=J9q6r3EsbD4h+5pbKDOLa5CcK0IeOPwtHy1wjToP5ng=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Tu11OnuLc0BGBJw1G37rrAxhSNMyNeNgVk/Q/CnhpjF3XjldPDZjPClbI66OrcMDEhMEyRoFC1UJV6kHi03PozxOxtVw1sTJrd6lhmGMqyajVRYs56nrU6WSBJrWDYpeesu6pn58Qkd147Zk0OKbgFz7enQfMkzMTqwLX2kDwHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5Tx97BU; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5Tx97BU"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-982dd15d169so470724241.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 09:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789748057; x=1790352857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x8NcPIBPYp4rwuWn05XAbEcQ73SaZCJHwvuBiqqbTRw=;
        b=E5Tx97BUjtLZ7DPyRH39abzgFWLu3n/5Iuj+v/XybZBDo+6awAYprO7SA+Oxnso1Kq
         7lubdL/ifgkdtaMYLA+FqbNOBQk+JZ4xof9BZMMM62ipAzvZmdmcddFkRuXP2GK+g5LL
         6Ui2O1LeEiNgjN70W7RaIIujLX/yT5rKVAH83cX8wpB9BUHyTKio1XSOgNE8+vK7ErWd
         iFKVCbeVU8DiIUgdbECHl9BKwYafS682AxopWScIcTPM2QarXvP0ZbjjG8mAeiZUSP9D
         tElPGA+X6deSse0i0s6BnwnCJCviKWpERHMRiRjCMervVjcbjNtzc4gCTrAKPpCF5iPc
         LoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789748057; x=1790352857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=x8NcPIBPYp4rwuWn05XAbEcQ73SaZCJHwvuBiqqbTRw=;
        b=aJxpeeZtgBk8LpTjvdddknVhfGO5CFyqrGHG5mxrOQ+7Tgfd55ka8w6oeNLg/jyEJ2
         4BYxBbaECQb0UxFeXvKcg2LJlxruyJgoWRIdNf8gj3+NYi3aD54SvypOm4/OqqaFcDoS
         JsnCCNu8VSIf4R8bgzZw2FvGfki6oge2dPo1vpRPq52dVxKkgeWHKOPfeZKJz8UGrZ/r
         lXBcMjtA7c8d9R+vR8JiED84MF8Rrlkx6txAae8Xi0PH2Syhfhq+UBw1+2BfUkjCJnr5
         kD5NY8lrDSBnnMPs3KcCS2k5pHaYXj9fbeaVXCk8kXfkBIuA8NKoDWGT3HB8IlxAsjCc
         qM8A==
X-Gm-Message-State: AFuF++lEY+Afznk2VbxITvrD4j0Lyibbe6CezH1fdg04YRim/oht3SLF
	Cp7eqWdQUxcQPx/oumWleLSXcolmPVJ2o/RDsbfKqBHw2MLoHO4PDzKR6U78KJMK
X-Gm-Gg: AYBFou2YPsjqswGF8n8ppqMy1MpEJ3sWgGdSZuJ/mu8z+VkzrV/SxXKqKzcYiAEYRvA
	Z+rwQgVeIP1Fvqn89Smp4kKBku1Y9VRfeOnPgqLhCXj88KCzFCA9nZnvq5tCZyO32IXpxUL791g
	DSS5Dhm/aYCy9J4zGVo4fXKYN2ljCLlhp6T6MxGwPGYVgezZSDJmHDI6yMOcistO6uYtc5wtZmw
	MDyMVc1zj9+GFqaJ4PW3HJBye0D38nvmXcyaNZk6rtK3h6xIaJPpYv8Jkjeq3YCkaan+g+GFjE/
	3S69hIbUwkdAKkKXHrTTvly4n7Zm1aSQwsZrZ+cIgsFgTZBQFJ66qlKwfdmQfzhzU1SMhrTdKY7
	K3qgV71stbUiM2HndzKAzb005zCA6G1zkhIGPuuuwSH7WhRue4XKeN8wus2JiE6xExbsVtt3tmW
	/m7l1Q0kq6Nf6aRDQpIWy2WV+H7UaUuEEyNC81for2KX8iaMOqy5jUcogB6AuoywOCM7aP86VMZ
	zuJndQyVqFcB9xg2wtqj32qjsBEW/4DxQNsA6/RGJ9YBkK+NJfpCfDy498sT+LybmZdWWkVvbI=
X-Received: by 2002:a05:6102:8609:20b0:7a5:7282:19a5 with SMTP id ada2fe7eead31-7a572822659mr1103019137.13.1789748057181;
        Fri, 18 Sep 2026 09:14:17 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a59c569181sm2104078137.11.2026.09.18.09.14.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:14:15 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/9] monitor: Search the frames with a pager
Date: Fri, 18 Sep 2026 12:13:59 -0400
Message-ID: <20260918161408.2464981-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

A frame spans several lines, and what identifies one is spread between
its header and its contents: the header says which controller and when,
the body says what happened. Searching a trace a line at a time finds the
line reporting an error without any of that context.

This series makes the frames searchable as whole entries:

  $ btmon                            # then press Ctrl-R
  $ btmon -r hcidump.log
  $ btmon -r hcidump.log --print0 | fzf --read0

Patches 1 to 3 are unrelated fixes noticed on the way: a channel leaks
its latency plots, the channel latency is the only one of the three not
reporting its deviation, and a count of control messages is printed with
a stray space at the end of the line.

Patch 4 sends the decoding output through one function so that a frame
can be observed as a whole. It is a pure redirection and the output is
unchanged.

Patch 5 separates the frames with a NUL when something is going to read
them as records, asked for by --print0 or by --read0 already being in
PAGER. Nothing is separated otherwise, so a pager reading lines and
redirected output are both untouched.

Patches 6 and 7 hand the frames seen so far to the pager on Ctrl-R while
capturing. The capture is never paused for this, as anything not read in
time is dropped by the kernel, and whatever arrives while the pager is up
is printed once it closes so the trace on the terminal has no gap.

Patches 8 and 9 use fzf when PAGER is not set and it is installed, since
it suits a trace far better than a plain pager, giving it --ansi, --read0
and --tac wherever it is used.

Recordings of both, which expire after a week:

  reading a file      https://asciinema.org/a/FEetnoeF5H6NNOmZ
  a running capture   https://asciinema.org/a/pGZpLhPlJFPyO4I3

The first one searches a 39 frame trace of two LE connections:

  'ATT:            every ATT frame                        19 of 39
  'SMP:            the pairing exchange                    4
  'L2CAP:          the signalling                          2
  '0x0025          every frame touching that GATT handle   5
  'ATT: 'Write     two terms, both must match              2
  'ATT: !'Error    everything ATT except the failures     15
  'Handle\ 65      just the second connection              4
  '#20             one frame, by its number                1

A leading quote is an exact match, a space separates terms that must all
match, and ! inverts one. Matching itself has no regex, but --delimiter
is one, and with a newline as the delimiter every line of a frame becomes
a field, so a search can be aimed at the header or at the contents:

                            whole frame   header only   body only
  'Handle\ 64                       21            21           0
  '#20                               1             1           0
  '0x0025                            5             0           5
  'ATT:                             19             0          19

A frame number or a connection only ever appears in the header, and a
GATT handle or a protocol only inside.

The second recording shows Ctrl-R during a capture: the frames seen so
far are handed over, the capture keeps running underneath, and what
arrived meanwhile is printed on return.

Changes in v2:
- Added the three unrelated fixes as patches 1 to 3. The trailing space
  is its own patch so that patch 4 stays a pure redirection.
- Rewrapped the lines that went over 80 columns, which the rename to
  display_printf() pushed past the limit.
- Dropped the NULL initialiser on the static output stream, removed the
  trailing semicolon from the print_space() macro and used ARRAY_SIZE().

Luiz Augusto von Dentz (9):
  monitor/analyze: Free the channel latency plots
  monitor/l2cap: Report the channel latency deviation
  monitor/analyze: Drop a trailing space before a newline
  monitor: Route the decoding output through a single function
  monitor: Separate the frames for a pager reading records
  monitor: Hand the captured frames to the pager on Ctrl-R
  doc/btmon: Document searching the frames
  monitor: Prefer fzf as the pager when one is not set
  doc/btmon: Document the pager choice

 Makefile.tools    |   1 +
 doc/btmon.rst     |  64 ++++++
 monitor/analyze.c |  47 ++--
 monitor/avctp.c   |  68 +++---
 monitor/control.c | 176 ++++++++-------
 monitor/display.c | 139 +++++++++++-
 monitor/display.h |  14 +-
 monitor/find.c    | 534 ++++++++++++++++++++++++++++++++++++++++++++++
 monitor/find.h    |  19 ++
 monitor/l2cap.c   |  41 ++--
 monitor/lmp.c     |   4 +-
 monitor/main.c    |  28 ++-
 monitor/packet.c  |  19 +-
 monitor/rfcomm.c  |   6 +-
 tools/l2test.c    |  10 +
 15 files changed, 994 insertions(+), 176 deletions(-)
 create mode 100644 monitor/find.c
 create mode 100644 monitor/find.h

-- 
2.55.0

