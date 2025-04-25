Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCEE194A60
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599481; cv=none; b=C/dlWRqK+5VO3WZ9IKqRKL66JlrJ3VD9FfLTQzL3O8haRuFAMjRHqhzl1vhQEqgNS77u/NnPaeUu7Ai482u62rBJxoUECNRMPeygZbGV3vE0qW+1vukoMOoatjWutt8PUbg5EwAuz2JUMEz0unZ/7yEkpeEF8GnhqVHE1dmvscI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599481; c=relaxed/simple;
	bh=5Kedj0ZJx0i/SMekTl4aMFkX52bQXG/DkiVXe8q25IY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SLhs1UUiIJvj3dakt0Bcf52tVQlch2+M40inVvKR+fLaXfal2cnugrwWxWl6nuO2MPjcJAaw6vTfzj/S6PyKv+Tsce0KIFEqwAIXwMbSajuFSa7pTNn9//aI13G5OaTppg9monmUTpYuhZWERQyXS9vcR+00YbB4AYiOmyQjgb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muRcTi7d; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muRcTi7d"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5262475372eso1190304e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 09:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745599478; x=1746204278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vEl4Bf8xdenr6VjwyqUJUYJ2/NPcBwyCEEhNYedTmOA=;
        b=muRcTi7dPjy+2aB2BiGcT4x2tVRbT1Py08Zx495UovMgbgnaniSB3X++n6JV36b8PH
         czyKn+uMNeh/zJbk62tMnMs3duJPXkQKTEWCvJiQz27V3apq2mGhk7Mh91vtFoelMGVp
         menDIuTPmQzEvgPRatL/V98jeWzkEKSoiovw/ymD7o3o9ok52LEuNRZixHdh1HhUB/Ju
         Zh7w8P0FzNR+rLHPyqrjkQ929r0htcInj0rvbF/+4hr9/wp+jrrLuzWXCAf8dIPYGH5l
         wQ4geMpbQ503wFGlD8kbliIEKSQ2DUntyCf1AALkuvEmuVPuR7fbKHKtIVb+rXFqoTxS
         Gc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745599478; x=1746204278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEl4Bf8xdenr6VjwyqUJUYJ2/NPcBwyCEEhNYedTmOA=;
        b=h63B7G7WYzobNHuQVskbbEVwTIupmo1VEulqXkzL1fiS5qUsvh4MSqLc+9qb+rOEIK
         75JhtJm3xUnUDjtnhcpMygwYbRS1e/dXmB8tt5Uv8TcVgO1d0ojtf+saG0kLEExFGM4m
         +3w+nYLI76bmx0W+yjwjuDXc5pscEALltt/I4ezCjchVsgTDUdVl2yB29BjML7OrkBmB
         8kZT38u4/6reCAYF/JCDNqAKc1kPFBQ3H9sLWeqA9C9VKfvtfFp2jjCVxGslBLWAQG3C
         QhvjVC7C2E6E3HWbPDooziUC8vMuip5wq5eDlagdY31OCbNm3DoIeB4bVxZaGIjltxQa
         Bh7w==
X-Gm-Message-State: AOJu0Yz+ZCNlav5GMTeesBiy9TO+smD4xueV2gBVqxiUPgOXI/fNWUt7
	GauRJF//qPQAXW/ZxvHFoIxXZzz3ULFfCGL4ePlAv9LYKZfO86p9+2qd8kDLU+0=
X-Gm-Gg: ASbGncvOOpN1lshZvNA+euptgzTmY7BtuZ+qcIrqcl9txC55K5NkS2La33tAR5E99fk
	ryhV9UIz+f5FIWlYmal1yJZwk6H9r7cfM6ah3UBHsbv14aJIKofat+lKK8ym0TuZf5GPxeo4v8D
	46IfvnTlmtL0QX7BZ358NK+drzPtiof8AjahDIHaHP1vSD5sArTDZTBoHUCgWets+C2mEB6NzlP
	SpYyb9wl2+I/OU9hXKW19OmSg7jwi1p4BohmhJgj4wnq7H3PffeamWMmoJVCZY/BBGxPFBAAJaE
	yrbf4KSdvITA2gJBekMasz2h/GrHTgwyS65gRJJBPIqd7cCR7teiYCNglvxz0CbtV9u3JNkfnb1
	q91Y03dg25g==
X-Google-Smtp-Source: AGHT+IFrzcygw4TqZLC3KgUObrExR14Xrx9sUZfWpgDuZH0KnHDTPynumi4Sib/lVKcmPWUIae1m+Q==
X-Received: by 2002:a05:6122:d99:b0:520:61ee:c814 with SMTP id 71dfb90a1353d-52a89d2c8c3mr2112013e0c.1.1745599478407;
        Fri, 25 Apr 2025 09:44:38 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52a7a12bd62sm719879e0c.43.2025.04.25.09.44.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 09:44:37 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] Add support clang-format
Date: Fri, 25 Apr 2025 12:44:34 -0400
Message-ID: <20250425164435.1482617-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds .clang-format (based on kernel) which can be used by linters,
editors, etc to check the coding style.
---
 .clang-format | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 .clang-format

diff --git a/.clang-format b/.clang-format
new file mode 100644
index 000000000000..6a0dea43d3e1
--- /dev/null
+++ b/.clang-format
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# clang-format configuration file. Intended for clang-format >= 11.
+#
+# For more information, see:
+#
+#   Documentation/dev-tools/clang-format.rst
+#   https://clang.llvm.org/docs/ClangFormat.html
+#   https://clang.llvm.org/docs/ClangFormatStyleOptions.html
+#
+---
+AccessModifierOffset: -4
+AlignAfterOpenBracket: Align
+AlignConsecutiveAssignments: false
+AlignConsecutiveDeclarations: false
+AlignEscapedNewlines: Left
+AlignOperands: true
+AlignTrailingComments: false
+AllowAllParametersOfDeclarationOnNextLine: false
+AllowShortBlocksOnASingleLine: false
+AllowShortCaseLabelsOnASingleLine: false
+AllowShortFunctionsOnASingleLine: None
+AllowShortIfStatementsOnASingleLine: false
+AllowShortLoopsOnASingleLine: false
+AlwaysBreakAfterDefinitionReturnType: None
+AlwaysBreakAfterReturnType: None
+AlwaysBreakBeforeMultilineStrings: false
+AlwaysBreakTemplateDeclarations: false
+BinPackArguments: true
+BinPackParameters: true
+BraceWrapping:
+  AfterClass: false
+  AfterControlStatement: false
+  AfterEnum: false
+  AfterFunction: true
+  AfterNamespace: true
+  AfterObjCDeclaration: false
+  AfterStruct: false
+  AfterUnion: false
+  AfterExternBlock: false
+  BeforeCatch: false
+  BeforeElse: false
+  IndentBraces: false
+  SplitEmptyFunction: true
+  SplitEmptyRecord: true
+  SplitEmptyNamespace: true
+BreakBeforeBinaryOperators: None
+BreakBeforeBraces: Custom
+BreakBeforeInheritanceComma: false
+BreakBeforeTernaryOperators: false
+BreakConstructorInitializersBeforeComma: false
+BreakConstructorInitializers: BeforeComma
+BreakAfterJavaFieldAnnotations: false
+BreakStringLiterals: false
+ColumnLimit: 80
+CommentPragmas: '^ IWYU pragma:'
+CompactNamespaces: false
+ConstructorInitializerAllOnOneLineOrOnePerLine: false
+ConstructorInitializerIndentWidth: 8
+ContinuationIndentWidth: 8
+Cpp11BracedListStyle: false
+DerivePointerAlignment: false
+DisableFormat: false
+ExperimentalAutoDetectBinPacking: false
+FixNamespaceComments: false
+
+IncludeBlocks: Preserve
+IncludeCategories:
+  - Regex: '.*'
+    Priority: 1
+IncludeIsMainRegex: '(Test)?$'
+IndentCaseLabels: false
+IndentGotoLabels: false
+IndentPPDirectives: None
+IndentWidth: 8
+IndentWrappedFunctionNames: false
+JavaScriptQuotes: Leave
+JavaScriptWrapImports: true
+KeepEmptyLinesAtTheStartOfBlocks: false
+MacroBlockBegin: ''
+MacroBlockEnd: ''
+MaxEmptyLinesToKeep: 1
+NamespaceIndentation: None
+ObjCBinPackProtocolList: Auto
+ObjCBlockIndentWidth: 8
+ObjCSpaceAfterProperty: true
+ObjCSpaceBeforeProtocolList: true
+
+# Taken from git's rules
+PenaltyBreakAssignment: 10
+PenaltyBreakBeforeFirstCallParameter: 30
+PenaltyBreakComment: 10
+PenaltyBreakFirstLessLess: 0
+PenaltyBreakString: 10
+PenaltyExcessCharacter: 100
+PenaltyReturnTypeOnItsOwnLine: 60
+
+PointerAlignment: Right
+ReflowComments: false
+SortIncludes: false
+SortUsingDeclarations: false
+SpaceAfterCStyleCast: false
+SpaceAfterTemplateKeyword: true
+SpaceBeforeAssignmentOperators: true
+SpaceBeforeCtorInitializerColon: true
+SpaceBeforeInheritanceColon: true
+SpaceBeforeParens: ControlStatementsExceptForEachMacros
+SpaceBeforeRangeBasedForLoopColon: true
+SpaceInEmptyParentheses: false
+SpacesBeforeTrailingComments: 1
+SpacesInAngles: false
+SpacesInContainerLiterals: false
+SpacesInCStyleCastParentheses: false
+SpacesInParentheses: false
+SpacesInSquareBrackets: false
+Standard: Cpp03
+TabWidth: 8
+UseTab: Always
+...
-- 
2.49.0

