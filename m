Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7E37E9
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 22:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745964741; cv=none; b=db8+/x6/E2kEsc198wUC0GgcuOM9R0U0eg4wabAm2hSSkNd74xqhclRxAf2j/2jchgclHAGBEB9DohNpGxC9HLFqYm8+p41NFwYgZbjh0kEKgMt5wHsX9Yr1GbKEYibbVpbC0rpbE4CBBKZNXsFR+I1okSZZ7KCGURnmG8N50xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745964741; c=relaxed/simple;
	bh=X8vsD3VUOzsHW39CL5dkBwFRD51W3t/PWQlVHCq3tPI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=apCOa3QHsU7BtH3qTWpe956qRkUuGP2ZAxSWZuHKEqaKUZSxGdU/kzok7MzPuJRFCmR1FRTu0LH82Lj2qm3aThoywMOkefMJR9UXHV/i3M03sOEymtQCMfx1JKY/nJru7fj/9XNZW+KfbJMaUZm8NYLQZb5v2SR/mfU+eZvNFnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wy1/r4wg; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wy1/r4wg"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86f9c719d63so2605205241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 15:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745964738; x=1746569538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfdpVzQ80euUCuBvIjDfQKkPOKUmshnkibWLgB69KI0=;
        b=Wy1/r4wgzHEQ226XQEkfvPzJhouXd1pkAZEnqHnDwvpc8I2ZSxgdBX7lKzymPxmt79
         eHKeQBgQxYJoRkiKm65Pa+AKjh6FnN0yq4na3Z0M59gfhlFUoRoG56qZLTPQpz8DPs8k
         9ZgvS5THWGSBdmSLlgzmVT9CavckPcf9S8R4DKeKmspVUFxCIv68PMDK2OAf3D+92Xvj
         6ZjV83tq36SUKDJt4hkEauzAFEWDbQ4bpdFCshUXEnhykA12p0Xw3Bm73D6sS7icdl+A
         PgOJvpHDbd866vCguLSMs0aNdlaMKOk3uXXsqQSnT/+4TPtV5tPnnFXSvkFqIfRFb/Vz
         gxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745964738; x=1746569538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfdpVzQ80euUCuBvIjDfQKkPOKUmshnkibWLgB69KI0=;
        b=FXikMQwKg7XTqjMhJAvDsQRB1laASoq3c6yHyhbDya09t+aRgicbaWP2LJFsexrG9s
         8fpMdBJ1sXZo4ceulukUzmqNrpeB/rDjzg+G7Op+wXcPdwxaDCWXoCR3BlFzdj+j6OWj
         SDh1divHeROMva/a4TB6d9Di4Ax3KTYhjYH6sbpsztDL+87AxH5CcICWJAnrWy10RJBV
         dOESkm8YpiiuIA8G9XZAPOKC9VwxWAPet6mOf2hAWL4N/YhlOOJBTTvvPhraOZTkIBSK
         MNeew0FQ8Y73Ak8zxoDfVvM2Igxhi5cDqw/EciI0i3S3q3s6WcuT5vyW91uqT+FV40qG
         Pweg==
X-Gm-Message-State: AOJu0Yy3WskAGCaQH8BBbqjf78fZN3RGV8kj90A1C2YeFVXX4Q6sndEU
	tz4FaEA6hJYMn70lFVjmbt8jMem/LzXRklvzaFz2uWh4MmCRMdgxuE1Umg==
X-Gm-Gg: ASbGnctDRj3uJpJUxCjI3GC8a9gajHFZLoHJYWIvlcr0wIvjKP+emlssB0bK7eFd7Ba
	SOWQWs2JffCBXC0XwxdWVUQ5CwYB5kIMSzzlOKABZ10D+wcswsh30tyOjKsPRsNnWdgWMWj30XR
	tshgAVHydgm3jb6zj31TtUJ8P+MJSC9AhTWxXrhs8CGYq7w0zNqxe9nExnLd3QhR69HYerj+mcy
	g+UVicQoO3ILrHQPMTvHIvMPmYHL3LaSIaY3ukfvhIUx8Ke8/zyIlKfLOP3XZ/O1bfIWfRYsHzX
	HatOYGG3h6eIs7G/29GEoprv1I7TjRrRS2Sk+W9Szfc+UlO3yhUpj+W16jBXerQk3R1XfIjUZwh
	PjUfcLVUxZ7i4k2hIg1aK
X-Google-Smtp-Source: AGHT+IGE/XrP9u7OO/A4pQp18LUoUi/gPHZEYyTxmSjJYnzL7w6jEbqKmIxnq2zuI6s+GRexCF3a5A==
X-Received: by 2002:a05:6122:1e06:b0:520:5185:1c31 with SMTP id 71dfb90a1353d-52acd88839fmr885088e0c.9.1745964737961;
        Tue, 29 Apr 2025 15:12:17 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52ace4efa57sm71347e0c.37.2025.04.29.15.12.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 15:12:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] workflows: Add codacy action
Date: Tue, 29 Apr 2025 18:12:15 -0400
Message-ID: <20250429221215.2253885-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 .github/workflows/codacy.yml | 61 ++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 .github/workflows/codacy.yml

diff --git a/.github/workflows/codacy.yml b/.github/workflows/codacy.yml
new file mode 100644
index 000000000000..58504e1f9783
--- /dev/null
+++ b/.github/workflows/codacy.yml
@@ -0,0 +1,61 @@
+# This workflow uses actions that are not certified by GitHub.
+# They are provided by a third-party and are governed by
+# separate terms of service, privacy policy, and support
+# documentation.
+
+# This workflow checks out code, performs a Codacy security scan
+# and integrates the results with the
+# GitHub Advanced Security code scanning feature.  For more information on
+# the Codacy security scan action usage and parameters, see
+# https://github.com/codacy/codacy-analysis-cli-action.
+# For more information on Codacy Analysis CLI in general, see
+# https://github.com/codacy/codacy-analysis-cli.
+
+name: Codacy Security Scan
+
+on:
+  push:
+    branches: [ "master" ]
+  pull_request:
+    # The branches below must be a subset of the branches above
+    branches: [ "master" ]
+  schedule:
+    - cron: '18 8 * * 4'
+
+permissions:
+  contents: read
+
+jobs:
+  codacy-security-scan:
+    permissions:
+      contents: read # for actions/checkout to fetch code
+      security-events: write # for github/codeql-action/upload-sarif to upload SARIF results
+      actions: read # only required for a private repository by github/codeql-action/upload-sarif to get the Action run status
+    name: Codacy Security Scan
+    runs-on: ubuntu-latest
+    steps:
+      # Checkout the repository to the GitHub Actions runner
+      - name: Checkout code
+        uses: actions/checkout@v4
+
+      # Execute Codacy Analysis CLI and generate a SARIF output with the security issues identified during the analysis
+      - name: Run Codacy Analysis CLI
+        uses: codacy/codacy-analysis-cli-action@d840f886c4bd4edc059706d09c6a1586111c540b
+        with:
+          # Check https://github.com/codacy/codacy-analysis-cli#project-token to get your project token from your Codacy repository
+          # You can also omit the token and run the tools that support default configurations
+          project-token: ${{ secrets.CODACY_PROJECT_TOKEN }}
+          verbose: true
+          output: results.sarif
+          format: sarif
+          # Adjust severity of non-security issues
+          gh-code-scanning-compat: true
+          # Force 0 exit code to allow SARIF file generation
+          # This will handover control about PR rejection to the GitHub side
+          max-allowed-issues: 2147483647
+
+      # Upload the SARIF file generated in the previous step
+      - name: Upload SARIF results file
+        uses: github/codeql-action/upload-sarif@v3
+        with:
+          sarif_file: results.sarif
-- 
2.49.0

