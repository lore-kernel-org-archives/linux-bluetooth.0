Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB82524B17
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867468; cv=none; b=ghBhMXqBRg6yDGmqHALSK6KhgtIXgy4sQwfv9QzPbt0n8Q4xnit9TYdxzddj5+ANRPXbLHvR/lK/tGLPaYSMkIuKQU3zc60bnKO6SUmjDKt62SCxCuuw8sDpPtNmkFImZn61tR4ps9v38lw7OrAiFuNUUQvyrfsQBzMwdp59F+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867468; c=relaxed/simple;
	bh=hoBSblLwZwfSf6Avzae6hhAG8QmRRu1juM+ANbdsyg4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hET5ZMOUyMvW5fMk5rW4FJLZwEP0HXhSb/YRD/1jijJbm9t4tyXLHd31/4H8RftmSwwlYrEphiZcR+8y5mcJuCN+G3GDmsrJ+bCbRgZ2fA/zcgqcTGKZo3dYkdWVAN+UElXhvFmFjRbUv81gEIqHc/7wIIXWt1Y2CMLJW43hMz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf6OINe6; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf6OINe6"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-67375a844dfso6245589d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 08:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790867465; x=1791472265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kGBCWLeP60k9FTD5PxDO2gxo0a8wLHKTrhR+iqB9o20=;
        b=Yf6OINe6Fe1XRlWW+gUh+NBnHeR6UjNc+0YBB2VVPgKI8Q1IdeQ0heXxSHMX/R3MEJ
         nYqzP2llZ7fqsQnABd7GUGod5BgbSULbrjeR3OOfGUBwMI4X+IGcLRRWDaZRYv2ZkW3+
         +qIZ+PMrOOs7JTTlc6w+s3GwK3OWqsNluEGUGZCo2menMxvmI9Z3T5pAy/9v+BDWCmFO
         P+gFAgbWoQpacy45Jy+8O+G8zJoGCeHyBEYXaSUZJA0iW3yH0hWuKe4ZJ4l2mhpUnxb2
         APpUZa28WyCf4bYJzhtCt1CHpmDx1jJ59RQR+nVzDcPnVI2EV/lvTfQBTM6MMFeXqj/A
         JHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790867465; x=1791472265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kGBCWLeP60k9FTD5PxDO2gxo0a8wLHKTrhR+iqB9o20=;
        b=KxvCkkfzCiLntUpQnej/Zi/aX23SOMpSHHDGb4mROQEBcNHdDTIK2SX8lmmQ7Twy4J
         7KIHNkPiqx0EwnhLiaJzHSIrE1wI2eL5RDUeo0kQzqfL7ICvZHllAexICQVSSGCSbU6k
         EItyMPUMBmb2lWuxnh5DzM/AHhhTTZPITXbJV5ZgDYOlAXFfyDXaiZBLkpNK8LNh1dbO
         pXXLBUbLexb4G12hHZZuEslhZlDp6KhLdiUPbUeRr3Immjo797LKYXQQ4DOStKD7ajDJ
         dxsj5DEjkYHWWUdPjNkdUUqqejae/H41vdd8d4Q6lCZgpAnHVToLWtVeT7K7UGz7vM6e
         0QbA==
X-Gm-Message-State: AFuF++mYJLf9s3C7uO3i+DwRH2bn94lEOKLlNsr/5v6ljhj8EZxdinXB
	Atiy9IwWzU4kM9Xq4Ki+2hQFnM4310xcEdlLTBJP06scVPmexwDql+incHvzz9iONJQLLQ==
X-Gm-Gg: AYBFou3wMBionYhDxljp3ekTbtJGKP0Vrk1TK/GknlElJ4NTfX3fAiWgHyRs4CUUvtm
	DM5SEZigbXMJyYtx3T8VxnOnHY3YfwlwVgAlMo4UrO2NV/78Vvqo67MHvj9ApAJcikfwAz+aS4c
	m+9tCZ0a2AgN/5jyWnPzjv1BiG4b3qRyZR8bsl/D4osUPJl3EF5SZTda9R1sZWNoAfXuXa6ryrG
	lwzgYu7X9qjgi5xJ9vC5WbMl9YdL4vp7/FOicFVg4Dk+dusvS8SoR7CHKCXNisnG9j3gQtiRtj7
	PS5X1XF9nPL4v3N8L6ZHJf6q/yeDSW2jzIoY1qQjUIu7X2q/Q3yJRKy+UjwXK/izzWWxB8pb7Qn
	ZMuY/eyMM9IUKf/sPjA2/jgEAiKf1MFfeTjnH1ZO5RxlZqh51O35+4vNwhFHswWMz3vobS5Wh8a
	HxwIwyQXrgecelh5sfkmvBdCiEOsykYQmO+dLGF7HG12+Tl9JHw9SFK8zeXLNokrlHORmgmkaUm
	FSFipME9xcfluVmYJMohV3/MNj3PRkgGA6kMK65ZImQQ++95eeu7RRybfYSNJZO
X-Received: by 2002:a05:690e:438d:b0:675:4453:fb27 with SMTP id 956f58d0204a3-6768e0eb67cmr1597498d50.9.1790867464401;
        Thu, 01 Oct 2026 08:11:04 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-676917cee9asm1171933d50.3.2026.10.01.08.11.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:11:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] doc: Add bug fixing procedure for AI coding assistants
Date: Thu,  1 Oct 2026 11:10:53 -0400
Message-ID: <20261001151054.2422165-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001151054.2422165-1-luiz.dentz@gmail.com>
References: <20261001151054.2422165-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Require AI assistants fixing bugs to verify them with a reproducer, test
the fix, state what could not be verified and leave any submission to
the human, with vulnerabilities following SECURITY.md.

Adapted from the Linux kernel's
Documentation/process/coding-assistants.rst.

Assisted-by: OpenCode:claude-opus-5.5
---
 doc/coding-assistants.rst | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/doc/coding-assistants.rst b/doc/coding-assistants.rst
index 778b3e6d81b3..6b81d740cd65 100644
--- a/doc/coding-assistants.rst
+++ b/doc/coding-assistants.rst
@@ -67,3 +67,36 @@ Additionally:
 * Use a subject prefix consistent with the history of the files touched.
 * Verify factual claims in the message (file counts, symbol names,
   paths) against the actual diff before committing.
+
+Procedure for finding and fixing bugs
+=====================================
+
+When an AI assistant is used to find and fix bugs, it **MUST** follow at
+least these steps:
+
+1. Before starting, read the whole process documentation listed above,
+   as well as any other document mentioned in the request. Do not rely on
+   isolated parts found by keyword search.
+2. Note the commit ID and locate the bug as instructed.
+3. For any bug that is not trivial, verify that it is real by writing a
+   reproducer, preferably a unit test (unit/) or a functional test
+   (test/functional/, see doc/functional-testing.rst). Unverified reports
+   are often invalid and may be ignored. Stop here if the bug turns out
+   not to be real.
+4. Write a fix for the bug. Fixes written in the same session that found
+   the bug tend to be more accurate, as the reasoning context is still
+   present.
+5. Build and verify that the fix works, using the reproducer or by
+   re-running the analysis; drop any fix that doesn't work and try
+   another one. The fix must not add build warnings, must pass
+   ``make check`` and the checkpatch.pl checks (see doc/coding-style.rst).
+6. Commit the fix with a message describing the problem and the solution,
+   following the Commit Messages section above. Add a Fixes tag pointing
+   to the commit that introduced the bug and an Assisted-by tag as
+   described above.
+7. Indicate what could not be done. If the fix could not be built or
+   tested, or no reproducer could be produced, say so explicitly.
+8. Determine whether the bug is a vulnerability. Vulnerabilities must not
+   be reported to the mailing list; follow SECURITY.md instead. Regular
+   bugs are sent to linux-bluetooth@vger.kernel.org. Leave the submission
+   to the human; the assistant must never send anything itself.
-- 
2.55.0

