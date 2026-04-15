Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC143199FAB
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776277343; cv=none; b=Ge6BOilAd3rXujHLqt+ej43LqdxUxvOOpsW5Yqp3NYqTm6qAxfGDOBEoAHP98irGRWrlw4wgh/yUQE4u09dtOPHawdr5NDbj9qtvYlL48MnS3l23gFkWJVHofh0axNSFbF50Dx9KXDB+OTxk2umQeN4OTqZ1bF839XWEm9C7zqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776277343; c=relaxed/simple;
	bh=+Omtng5BxShGgwdwU7cNCPYZD7L8Le2AQRc99kIMIWE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ADBMYgbEYyOkLfVWL9xD7rQR/HBb11aS7UOy7t1l1jPYnbxMGXw4bWTIMPHmNMFNgU+3fMIgBYmC0YS1HLqHU93m/s403Jg8r5a9MpYuY7OpK2vx5y9HABm2Asr6AwbC8NK/CmTeYs717NhWVse+6EsarhR8/9EBWpjcbWBt9PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3YORc1W; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3YORc1W"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-60fea0840f3so2079680137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 11:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776277341; x=1776882141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EBy1oJ/3+PHmL/l4lXJ0Wg/wjzwAakJnrlw+GiJc54s=;
        b=j3YORc1W4bHd1mBkr1qMwUIuduef5nIoolJQw6vC8VT1NCC5D4aKb1jR+TkqRxPH1I
         +da5n/EELGllRRPngsejWAqLaIRCvF38j+LRYuvXYpFSSn5yeRorKJLDaqd0uQhw9qI0
         QF4mUWIzsM30HXiVi0cxLkSCg/85AASJqgqFfhHFfrLDjAP0FH4nMMfjswkmZJJqxdb0
         6SNgbIb/2/ImnH5kCpqDI0sfTZNiQFRI8TgdhHeQjB+UBvpHNm5o7CDvpUwfhcc+VPPM
         +XDfY6qbYs6To8wWoRxcNgFLQpXAuHtZcWTkYuTbSPPnGvypAS9rFdfJaOjy534Lt4Cx
         ev/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776277341; x=1776882141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EBy1oJ/3+PHmL/l4lXJ0Wg/wjzwAakJnrlw+GiJc54s=;
        b=JU78UQ9BjIn1v5gwZN+d2RhbAmyIpLrxRQIAgbAgT4ErXyJlvBLjQpVDR2VmqDOXGr
         HWd5m38Qd32RmokPfcpioabwQyyYuyPTX/Jh5ddrJRTe3I/bgEY3N4poTD4/1jxxWuc7
         WR3vG1AyNhWnBBbFwPy0DiHs6N7IiF3Qe7KTwsEIDGoAr6VA2T8ivIUDzA+vFRMdf61E
         D/3N/Vp8z3HCV9IOfjk2jW02wlm6Ztm7nLhHVxKGETV+hdPUSOp8cKPKh4z+R0ALgKc3
         2w6DaeCKUvRQKPUOjj3TTAQf8MD8FT1ifkZ1DgKvzZEEVvHL9AEfbQq5fWBGM5t2ScaZ
         QDIg==
X-Gm-Message-State: AOJu0Yw2py42IbEpMLi2TK3CzPhmgZQ3dufPOu3NKb8ntFcNbqhu3DVU
	PXRW7RxkLiTwkd4VX2QBiJHqcefKfC3x9hBfyNvufRNgGvzR8JuG9Y/bvm8tv7nLyQ8=
X-Gm-Gg: AeBDieuE4aPCzZreQ7PstAbResXIT9PwHBNc6MUdDbWEbFi6LMT74hOyBQp7dV9UbiG
	xRthRq0TUzO5HrEps5YZ+qZ0lropvED0h848CSlSrnLO8UoXjNwZ+hoAbpE4J3MjZubV8kCpP4e
	C/3R19lQNl7pe6Z/YAAjoYl4vHwLOfz2uovPVMFMUVKh/eDR+8lQFa5NCoJzRrjOtMVTTd5e2pL
	5XuAKQXFbO7/5aO4aSVAHCokBhJKP8Ub5SGBSKBjPsgui18UcTKlRf1n8YupqPytQBd3a5Qjj0S
	70q1S5RZAIvKFf8FG9jEu7fzSW7fg1J/x+x/Lc+Dg9b7ReiejmF7pDje1JzJ+MJGfpR2sB5zk+U
	ETpOyF24popbylBTl2gIhw2bm5KfZdk7h7ELEDpifFEjLKeJRXevNiBVVLMjkWS3/DiI/PnN/MA
	zNnLS/i4Bpj0ZLQyko2ZCcoMwYuvqQMw0wsl9IMlkRKxu/zAGsroemnhQfNK/5aWil6Sp3Oqg0O
	D84l1Tly9qOdhRj8M5zvvsRiQEiK//EwMdVlJ8=
X-Received: by 2002:a05:6102:e07:b0:60f:b19b:e52c with SMTP id ada2fe7eead31-613bcf4d544mr331197137.17.1776277340448;
        Wed, 15 Apr 2026 11:22:20 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-612cf10e76csm1219063137.8.2026.04.15.11.22.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:22:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] github: Add YAML issue template and btsnoop-analyzer workflow
Date: Wed, 15 Apr 2026 14:22:07 -0400
Message-ID: <20260415182210.514686-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Replace the markdown issue template with a structured YAML form that
includes fields for description, reproduction steps, btmon trace upload,
analysis focus area selection, and privacy consent checkboxes.

Add a btsnoop-analyzer workflow that automatically analyzes btsnoop
traces attached to new issues using Vudentz/btsnoop-analyzer action,
posting results as issue comments.
---
 .github/ISSUE_TEMPLATE/issue.md        |  41 -----
 .github/ISSUE_TEMPLATE/issue.yml       | 108 +++++++++++++
 .github/workflows/btsnoop-analyzer.yml | 202 +++++++++++++++++++++++++
 3 files changed, 310 insertions(+), 41 deletions(-)
 delete mode 100644 .github/ISSUE_TEMPLATE/issue.md
 create mode 100644 .github/ISSUE_TEMPLATE/issue.yml
 create mode 100644 .github/workflows/btsnoop-analyzer.yml

diff --git a/.github/ISSUE_TEMPLATE/issue.md b/.github/ISSUE_TEMPLATE/issue.md
deleted file mode 100644
index ba384e120bac..000000000000
--- a/.github/ISSUE_TEMPLATE/issue.md
+++ /dev/null
@@ -1,41 +0,0 @@
----
-name: New issue
-about: 'Report a bug or other problem'
-title: ''
-labels: ''
-assignees: ''
-
----
-
-### Description
-
-<!-- A clear and concise description of what the bug is -->
-
-<!-- A clear and concise description of what you expected to happen -->
-
-<!-- Include any other relevant details -->
-
-### To reproduce
-<!-- Steps to reproduce the issue, if possible -->
-1.
-2.
-3.
-4.
-
-### Logs
-- btmon log: <!-- Bluetooth traffic dump: (usually needed)
-                  0. Power off connected device
-                  1. Run: btmon -w btmon.log
-                  2. Connect device, reproduce the issue
-                  3. Ctrl-C btmon
-                  4. Attach btmon.log to the issue -->
-- bluetoothd log: <!-- Run: journalctl -u bluetooth --boot 0 > bluetoothd.log; if relevant for issue -->
-
-<!-- Any other logs etc. relevant for the issue -->
-
-### Versions
-- BlueZ version:  <!-- Run: bluetoothctl --version -->
-- Kernel version:  <!-- Run: uname -r -->
-- Problematic device: <!-- Device model etc information, if relevant -->
-
-<!-- Any other relevant information on platform / hardware here -->
diff --git a/.github/ISSUE_TEMPLATE/issue.yml b/.github/ISSUE_TEMPLATE/issue.yml
new file mode 100644
index 000000000000..0f069858eeaf
--- /dev/null
+++ b/.github/ISSUE_TEMPLATE/issue.yml
@@ -0,0 +1,108 @@
+name: New issue
+description: Report a bug or other problem
+labels: []
+body:
+  - type: textarea
+    id: description
+    attributes:
+      label: Description
+      description: |
+        A clear and concise description of the bug, what you expected
+        to happen, and any other relevant details.
+      placeholder: Describe the issue...
+    validations:
+      required: true
+
+  - type: textarea
+    id: reproduce
+    attributes:
+      label: To reproduce
+      description: Steps to reproduce the issue, if possible.
+      placeholder: |
+        1.
+        2.
+        3.
+        4.
+    validations:
+      required: false
+
+  - type: textarea
+    id: trace-file
+    attributes:
+      label: btmon trace
+      description: |
+        Drag and drop your btsnoop trace file here. If a trace is
+        attached and the privacy acknowledgment below is checked,
+        it will be automatically analyzed by
+        [btsnoop-analyzer](https://github.com/Vudentz/btsnoop-analyzer).
+
+        To capture a trace: power off the device, run `btmon -w btmon.log`,
+        reproduce the issue, then Ctrl-C btmon.
+      placeholder: Drag and drop your btmon.log file here...
+    validations:
+      required: false
+
+  - type: dropdown
+    id: focus-area
+    attributes:
+      label: Analysis focus
+      description: >
+        If you attached a btsnoop trace, what aspect should the
+        automated analysis focus on? Select "General" to auto-detect.
+      options:
+        - General (full analysis)
+        - Connection issues
+        - Controller enumeration
+        - Pairing / Security
+        - GATT discovery
+        - Audio
+        - Audio / LE Audio
+        - Audio / A2DP
+        - Audio / HFP
+        - L2CAP channel issues
+        - Advertising / Scanning
+        - Disconnection analysis
+        - Channel Sounding
+    validations:
+      required: false
+
+  - type: checkboxes
+    id: privacy
+    attributes:
+      label: Privacy
+      description: |
+        btsnoop traces contain Bluetooth MAC addresses and may contain
+        device names. By default, MAC addresses are anonymized before
+        being sent to an LLM for analysis.
+      options:
+        - label: >
+            **Skip anonymization** — Send the raw decoded trace to the
+            LLM without scrubbing MAC addresses or device names.
+          required: false
+        - label: >
+            I understand this trace will be processed by a third-party
+            LLM API and I have the right to share this data.
+          required: false
+
+  - type: textarea
+    id: logs
+    attributes:
+      label: Other logs
+      description: |
+        Attach bluetoothd or other relevant logs.
+        Run: `journalctl -u bluetooth --boot 0 > bluetoothd.log`
+      render: text
+    validations:
+      required: false
+
+  - type: textarea
+    id: versions
+    attributes:
+      label: Versions
+      description: BlueZ version, kernel version, and device information.
+      value: |
+        - BlueZ version:
+        - Kernel version:
+        - Problematic device:
+    validations:
+      required: false
diff --git a/.github/workflows/btsnoop-analyzer.yml b/.github/workflows/btsnoop-analyzer.yml
new file mode 100644
index 000000000000..3bbd963004cb
--- /dev/null
+++ b/.github/workflows/btsnoop-analyzer.yml
@@ -0,0 +1,202 @@
+name: btsnoop-analyzer
+
+on:
+  issues:
+    types: [opened, reopened]
+
+permissions:
+  issues: write
+  contents: read
+
+jobs:
+  analyze:
+    # Only run when the user acknowledged the privacy statement
+    if: contains(github.event.issue.body, 'I understand this trace will be processed')
+    runs-on: ubuntu-latest
+    timeout-minutes: 15
+
+    steps:
+      - name: Parse issue body
+        id: parse
+        uses: actions/github-script@v7
+        with:
+          script: |
+            const body = context.payload.issue.body || '';
+
+            // Extract trace file URL from issue body
+            const urlPatterns = [
+              /https:\/\/github\.com\/[^\s)]+\.(?:log|snoop|btsnoop|cfa)/gi,
+              /https:\/\/github\.com\/user-attachments\/(?:files|assets)\/[^\s)]+/gi,
+            ];
+
+            let traceUrl = '';
+            for (const pattern of urlPatterns) {
+              const match = body.match(pattern);
+              if (match) {
+                traceUrl = match[0];
+                break;
+              }
+            }
+
+            if (!traceUrl) {
+              console.log('No trace file URL found — skipping analysis');
+              core.setOutput('found', 'false');
+              return;
+            }
+
+            // Extract description
+            const descMatch = body.match(
+              /### Description\s*\n([\s\S]*?)(?=\n###|\n\*\*|$)/i
+            );
+            const description = descMatch?.[1]?.trim() || 'No description provided';
+
+            // Extract focus area
+            const focusMatch = body.match(
+              /### Analysis focus\s*\n\s*(\S[^\n]*)/i
+            );
+            const focus = focusMatch?.[1]?.trim() || 'General (full analysis)';
+
+            // Check anonymization preference
+            const skipAnon = body.includes('[X] **Skip anonymization**') ||
+                             body.includes('[x] **Skip anonymization**');
+
+            core.setOutput('found', 'true');
+            core.setOutput('trace_url', traceUrl);
+            core.setOutput('description', description);
+            core.setOutput('focus', focus);
+            core.setOutput('anonymize', skipAnon ? 'false' : 'true');
+
+            console.log(`Trace URL: ${traceUrl}`);
+            console.log(`Focus: ${focus}`);
+            console.log(`Anonymize: ${!skipAnon}`);
+
+      - name: Post "analyzing" comment
+        if: steps.parse.outputs.found == 'true'
+        uses: actions/github-script@v7
+        with:
+          script: |
+            await github.rest.issues.createComment({
+              owner: context.repo.owner,
+              repo: context.repo.repo,
+              issue_number: context.issue.number,
+              body: '**btsnoop Analyzer** is processing your trace. This typically takes 1-3 minutes.\n\n_Decoding with btmon, then sending to LLM for analysis..._'
+            });
+
+      - name: Run btsnoop-analyzer
+        if: steps.parse.outputs.found == 'true'
+        id: analysis
+        uses: Vudentz/btsnoop-analyzer@master
+        with:
+          trace-url: ${{ steps.parse.outputs.trace_url }}
+          description: ${{ steps.parse.outputs.description }}
+          focus: ${{ steps.parse.outputs.focus }}
+          anonymize: ${{ steps.parse.outputs.anonymize }}
+          provider: ${{ vars.LLM_PROVIDER || 'github' }}
+          model: ${{ vars.LLM_MODEL || '' }}
+        env:
+          OPENAI_API_KEY: ${{ secrets.OPENAI_API_KEY }}
+          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
+          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
+          GH_MODELS_TOKEN: ${{ secrets.GH_MODELS_TOKEN }}
+
+      - name: Post detection comment
+        if: steps.parse.outputs.found == 'true' && success()
+        uses: actions/github-script@v7
+        with:
+          script: |
+            const fs = require('fs');
+            const detect = fs.readFileSync('${{ steps.analysis.outputs.detect }}', 'utf8');
+            await github.rest.issues.createComment({
+              owner: context.repo.owner,
+              repo: context.repo.repo,
+              issue_number: context.issue.number,
+              body: detect
+            });
+
+      - name: Post filter comment
+        if: steps.parse.outputs.found == 'true' && success()
+        uses: actions/github-script@v7
+        with:
+          script: |
+            const fs = require('fs');
+            const filter = fs.readFileSync('${{ steps.analysis.outputs.filter }}', 'utf8');
+            await github.rest.issues.createComment({
+              owner: context.repo.owner,
+              repo: context.repo.repo,
+              issue_number: context.issue.number,
+              body: filter
+            });
+
+      - name: Post annotation comment
+        if: steps.parse.outputs.found == 'true' && success()
+        uses: actions/github-script@v7
+        with:
+          script: |
+            const fs = require('fs');
+            const annotate = fs.readFileSync('${{ steps.analysis.outputs.annotate }}', 'utf8');
+            await github.rest.issues.createComment({
+              owner: context.repo.owner,
+              repo: context.repo.repo,
+              issue_number: context.issue.number,
+              body: annotate
+            });
+
+      - name: Post diagnostics comment
+        if: steps.parse.outputs.found == 'true' && success()
+        uses: actions/github-script@v7
+        with:
+          script: |
+            const fs = require('fs');
+            const diagnose = fs.readFileSync('${{ steps.analysis.outputs.diagnose }}', 'utf8');
+            await github.rest.issues.createComment({
+              owner: context.repo.owner,
+              repo: context.repo.repo,
+              issue_number: context.issue.number,
+              body: diagnose
+            });
+
+      - name: Post analysis comment
+        if: steps.parse.outputs.found == 'true' && success()
+        uses: actions/github-script@v7
+        with:
+          script: |
+            const fs = require('fs');
+            const analysis = fs.readFileSync('${{ steps.analysis.outputs.analyze }}', 'utf8');
+
+            const footer = `\n\n---\n<sub>Analyzed by [btsnoop-analyzer](https://github.com/Vudentz/btsnoop-analyzer) using btmon from [BlueZ](https://github.com/bluez/bluez). MAC addresses ${
+              '${{ steps.parse.outputs.anonymize }}' === 'true'
+                ? 'were anonymized'
+                : 'were **not** anonymized (user opted out)'
+            } before LLM processing.</sub>`;
+
+            await github.rest.issues.createComment({
+              owner: context.repo.owner,
+              repo: context.repo.repo,
+              issue_number: context.issue.number,
+              body: analysis + footer
+            });
+
+      - name: Post error comment
+        if: steps.parse.outputs.found == 'true' && failure()
+        uses: actions/github-script@v7
+        with:
+          script: |
+            await github.rest.issues.createComment({
+              owner: context.repo.owner,
+              repo: context.repo.repo,
+              issue_number: context.issue.number,
+              body: `## Analysis Failed
+
+            The automated analysis encountered an error. This could be due to:
+            - Unsupported trace file format
+            - Trace file too large to process
+            - LLM API rate limiting or downtime
+
+            A maintainer will review your trace manually.
+
+            <details>
+            <summary>Debug info</summary>
+
+            Workflow run: https://github.com/${context.repo.owner}/${context.repo.repo}/actions/runs/${context.runId}
+            </details>`
+            });
-- 
2.53.0

