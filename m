Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9713BF69F
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773162704; cv=none; b=ELldNuQ66rs/XPQ4rm2hm/idkKS6AFRa8azBYb1xYiG4Wlz8MukottixhdP+TYGSWlEX5CNk34wlQ802WQUWKQoQIFEXWvhzC/jOjB1I/ZRytVr3M3X0DGVtqwmx84HbKdu/pkRF5llnvyu5nErDVq+8W7zHq57WkYYIQHyWi2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773162704; c=relaxed/simple;
	bh=K/LNEdV+29ZGp58fbHi9FGuQWhJkWFEkyTD85MSaZwc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o32oinK47AnCYl6KzysBwfPwaBBtvo3rBCTZyEXgszHFVh0zf+M21qnHMV24tl3qkAorpbpBPtEFZvMk5S39582KR2IuQkJzli8fC2JNFiRZTP9xVkdPkb+qK6z3dVV6hF0beqygJtAQw5ZbL3+dJ2JFJ6qpaTfRM5BIFbUL08Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rb4eCmnU; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rb4eCmnU"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79800183233so1694327b3.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 10:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773162701; x=1773767501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LoVSyXpwkNEYW42Rog7eRbI+l5jyaMso4oeJJ7gkRU0=;
        b=Rb4eCmnUJyadGYGDrBpa/caGSxSTu1bflDHK1UCHOWps3ppc3A43Z64pylSoaTQBq2
         XEl832IyF/b4cvW8evFjaflNfX52gFnrxkCO7A3TsjQ9HRQqdV/Vx8esnq68Io9vLRjh
         wNukHoLp80OMIM+lcnlwoFDxppyF3HeWMQGOZjH93dKadahkDHG0Q/ndMB2dgz+tmqVV
         vRHjzz2yGP2yjaxNpnAs4LyJX97FarVHavAsSRoGEiWLtfi4kklr1jsGJOSx6vZBn5rJ
         ynKMju+zZkW2YpXVD6aOh/XWeJvGxwGnaaoVoq0rkxRZsnr7B5GRaSTfCcx76lEH5WTO
         e2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773162701; x=1773767501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LoVSyXpwkNEYW42Rog7eRbI+l5jyaMso4oeJJ7gkRU0=;
        b=Bvp/BFWM1m9suSBZqxSFN4ETK+nCDGBXSW4046L4qR+eD+kTDmHrxVJLcFO67KGV/M
         pDf+6UquYz2pa35qHu8O057Mk3l6xq289qcHfhxPktBnEnZwCzuMgMxKGFCzdqbaPyyV
         Q4OsKGrPOW4LbHNRqMaUn1oDp0M8VkS/lbzsN59+9sqriBlK44mzNHrSaeKeoBKkC7Wd
         UOBSY6hsgz7YXhYOLxWtP6Fqq9cZqUGvtQdKPbz0zDrmm8nhKFWld4HFccMI/lQzRv77
         eLjFUTU5nVB5+LFZkY3ATKXrNyMpH4gcGc71i4wRgEduFp2kbCyrQhn/13bQ2qJeNPXo
         g1NA==
X-Gm-Message-State: AOJu0YyrYsY6yyq9nKkLF+FAB0BIjhQxThFtfa8sPp98YCrzwjzWWv0/
	donuPlGiPm/3JwsKA1RmjU08FN13GLkCIOtq0rgN91gk0152X790xdfoTSotGg==
X-Gm-Gg: ATEYQzyuoVlM0OH2BRLtB1MgXFnIdJ6zPmRKUFLgjx8J6nieFtVVkz9VtV9d+qum6wO
	Oo4nCdzjjViIkddgBIdw09LkmlGI41944N6CDqE98qTeQ5QuAgeVM4JWEp0hO7ZH99VKUPYsL8b
	ObNSqGviTg+cubAPB8gjdrDQV1IC6tFh/f1FC/Sz2q3K0vZRuplv9BskBNdBRsJEFkSMpWKNWD1
	q56HM543GF2+5u98CGLDcaH9aDtN8Bqenep110pkuOAt/0Z8AFBOD0ExqN32ba11rWdQBEsYCG0
	VNcmLov3Ky2RkDlJ1rO5NFwyQ6YikanmUFuiA9oZQIAJF0uoMgtwsnPX33MzKkCcbue2gq7mgi7
	F2I9w3uCVP3GOBC4rYzqfGOAZ/Uc5VadAlCZ+gIuMcEsaA54l9oRZ6/6Yjxohlg3ynQluC426kw
	nQsWlOTaPA1ZO2VR/aLPSe6PWt0MHwE2kI7OM1a5WbOIUGVYR4+WqxEwfa+upTEASQbscCcryAm
	4XSm6OVVlJK6FIn8w==
X-Received: by 2002:a05:690c:18:b0:794:bc47:df1 with SMTP id 00721157ae682-7990a86995fmr41333247b3.22.1773162701314;
        Tue, 10 Mar 2026 10:11:41 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7990a51a245sm19745357b3.5.2026.03.10.10.11.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:11:40 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 5/6] doc/btmon: Add protocol error codes documentation
Date: Tue, 10 Mar 2026 13:11:18 -0400
Message-ID: <20260310171126.342447-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310171126.342447-1-luiz.dentz@gmail.com>
References: <20260310171126.342447-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add protocol error codes reference covering:

- ATT Error Codes: Complete table (0x01-0xff) with diagnostic
  meanings for Invalid Handle, Read/Write Not Permitted,
  Authentication/Authorization Insufficient, Attribute Not Found,
  Insufficient Encryption, Application Errors (0x80-0x9f), and
  profile-specific codes (0xfc-0xff).

- L2CAP Connection Response Results: Result code table (0x0000-0x000c)
  covering successful connections, pending, and all refusal reasons
  (PSM not supported, security block, no resources, invalid CID,
  insufficient authentication/encryption).

- Automating Error Detection: grep patterns for ATT errors, security
  errors, and L2CAP rejections.

- Cross-Layer Error Correlation: Common cascading error patterns
  across ATT, SMP, HCI, and L2CAP layers.

- Updated Automated Trace Analysis: Enhanced error check step with
  multi-layer grep commands, added error cross-references in
  connection lifecycle, and GATT operation rejected debugging
  scenario.
---
 doc/btmon.rst | 209 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 206 insertions(+), 3 deletions(-)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index 3084acad7107..fdd54148daab 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -1881,6 +1881,187 @@ Then examine the following line for ``Status:``.
 8. On failure, check ASE Control Point notification responses for
    error codes (Response Code and Response Reason fields)
 
+PROTOCOL ERROR CODES
+=====================
+
+btmon automatically decodes error codes from multiple protocol layers.
+This section provides a reference for interpreting errors seen across
+ATT, SMP, and L2CAP layers.
+
+ATT Error Codes
+----------------
+
+ATT errors appear in ``Error Response (0x01)`` PDUs. Beyond the GATT
+discovery context (where ``Attribute Not Found`` is normal), these
+errors indicate real problems:
+
+.. list-table::
+   :header-rows: 1
+   :widths: 8 35 57
+
+   * - Code
+     - Error
+     - Diagnostic Meaning
+   * - 0x01
+     - Invalid Handle
+     - Client used a handle that does not exist
+   * - 0x02
+     - Read Not Permitted
+     - Characteristic does not allow reads
+   * - 0x03
+     - Write Not Permitted
+     - Characteristic does not allow writes
+   * - 0x05
+     - Authentication Insufficient
+     - Operation requires an authenticated (MITM-protected)
+       bond. Triggers SMP pairing if not yet bonded.
+   * - 0x06
+     - Request Not Supported
+     - Server does not support this ATT operation
+   * - 0x07
+     - Invalid Offset
+     - Read/write blob offset exceeds attribute length
+   * - 0x08
+     - Authorization Insufficient
+     - Server requires additional authorization
+   * - 0x09
+     - Prepare Queue Full
+     - Too many prepared writes queued
+   * - 0x0a
+     - Attribute Not Found
+     - No attributes in requested range. Normal termination
+       for GATT discovery procedures.
+   * - 0x0b
+     - Attribute Not Long
+     - Attribute cannot be read with Read Blob
+   * - 0x0c
+     - Insufficient Encryption Key Size
+     - Encryption key is too short
+   * - 0x0d
+     - Invalid Attribute Value Length
+     - Write value length is incorrect for this attribute
+   * - 0x0e
+     - Unlikely Error
+     - Generic unlikely error
+   * - 0x0f
+     - Insufficient Encryption
+     - Link is not encrypted. Triggers encryption setup.
+   * - 0x10
+     - Unsupported Group Type
+     - Attribute type is not a valid grouping type
+   * - 0x11
+     - Insufficient Resources
+     - Server out of resources
+   * - 0x12
+     - Value Not Allowed
+     - Value is not within permitted range
+   * - 0x80-0x9f
+     - Application Error
+     - Application-specific error; meaning depends on the
+       profile/service. ASCS uses these for ASE-specific
+       errors.
+   * - 0xfc
+     - Write Request Rejected
+     - Write rejected (CSIP, ASCS)
+   * - 0xfd
+     - CCC Descriptor Improperly Configured
+     - CCC must be enabled before certain operations
+   * - 0xfe
+     - Procedure Already in Progress
+     - Another procedure is already running
+   * - 0xff
+     - Out of Range
+     - Value is outside valid range
+
+L2CAP Connection Response Results
+----------------------------------
+
+L2CAP Connection Response and LE Connection Response include a result
+code:
+
+.. list-table::
+   :header-rows: 1
+   :widths: 8 35 57
+
+   * - Code
+     - Result
+     - Diagnostic Meaning
+   * - 0x0000
+     - Connection successful
+     - Channel established normally
+   * - 0x0001
+     - Connection pending
+     - Connection in progress (BR/EDR only)
+   * - 0x0002
+     - Connection refused - PSM not supported
+     - Remote does not have a server for this protocol
+   * - 0x0003
+     - Connection refused - security block
+     - Security requirements not met
+   * - 0x0004
+     - Connection refused - no resources
+     - Remote ran out of channel resources
+   * - 0x0005
+     - Connection refused - invalid Source CID
+     - Source CID is invalid or already in use
+   * - 0x0006
+     - Connection refused - Source CID already allocated
+     - CID collision
+   * - 0x0007
+     - Connection refused - unacceptable parameters
+     - LE credit-based: MTU, MPS, or credits unacceptable
+   * - 0x0008
+     - Connection refused - invalid parameters
+     - Parameter values are invalid
+   * - 0x0009
+     - Connection refused - insufficient authentication
+     - Not authenticated
+   * - 0x000a
+     - Connection refused - insufficient authorization
+     - Not authorized
+   * - 0x000b
+     - Connection refused - insufficient encryption key size
+     - Encryption key too short
+   * - 0x000c
+     - Connection refused - insufficient encryption
+     - Link not encrypted
+
+Automating Error Detection
+---------------------------
+
+**Find all ATT errors** (excluding normal discovery termination)::
+
+    grep -n "Error Response" output.txt
+
+Then check whether each error is ``Attribute Not Found (0x0a)``
+within a discovery sequence (normal) or a different error code
+(problem).
+
+**Find all authentication/encryption related errors**::
+
+    grep -n "Authentication Insufficient\|Insufficient Encryption\|Insufficient Security\|security block" output.txt
+
+These indicate the link needs pairing or encryption. Check whether
+SMP pairing follows.
+
+**Find all L2CAP channel rejections**::
+
+    grep -n "Connection refused" output.txt
+
+**Cross-layer error correlation**:
+
+Errors often cascade across layers. Common patterns:
+
+1. ATT ``Insufficient Encryption`` (0x0f) → triggers HCI
+   ``LE Start Encryption`` → ``Encryption Change`` success → ATT
+   operation retried
+2. ATT ``Authentication Insufficient`` (0x05) → triggers SMP
+   ``Pairing Request`` → pairing completes → ATT operation retried
+3. SMP ``Pairing Failed`` → ``Disconnect Complete`` with reason
+   ``Authentication Failure (0x05)``
+4. L2CAP ``Connection refused - security block`` → triggers SMP
+   pairing
+
 EXAMPLES
 ========
 
@@ -1951,10 +2132,21 @@ Recommended Workflow
 
        grep -n "ASE Control Point\|CIG Parameters\|Create Connected Isochronous\|CIS Established\|Setup ISO Data Path" output.txt
 
-7. **Check for errors**: Search for non-success status codes::
+7. **Check for errors**: Search across all protocol layers (see
+   `PROTOCOL ERROR CODES`_)::
 
+       # HCI-level errors
        grep -n "Status:" output.txt | grep -v "Success"
 
+       # ATT-level errors
+       grep -n "Error Response" output.txt
+
+       # SMP failures
+       grep -n "Pairing Failed" output.txt
+
+       # L2CAP rejections
+       grep -n "Connection refused" output.txt
+
 8. **Extract GATT discovery**: Filter the GATT service/characteristic
    discovery traffic (see `RECONSTRUCTING A GATT DATABASE FROM SNOOP
    TRACES`_)::
@@ -1991,8 +2183,10 @@ pattern in the trace:
    precedes this.
 4. ACL Data with ATT/SMP/L2CAP -- service discovery and data exchange.
    See `RECONSTRUCTING A GATT DATABASE FROM SNOOP TRACES`_ for GATT,
-   `L2CAP CHANNEL TRACKING`_ for channel setup.
-5. ``Disconnect Complete`` -- connection ended, check Reason field
+   `L2CAP CHANNEL TRACKING`_ for channel setup, and
+   `PROTOCOL ERROR CODES`_ for error interpretation.
+5. ``Disconnect Complete`` -- connection ended, check Reason field.
+   See `HCI ERROR AND DISCONNECT REASON CODES`_ for reason codes.
 
 For LE Audio connections, additional steps appear between 3 and 5
 (see `LE AUDIO PROTOCOL FLOW`_ for full details):
@@ -2030,6 +2224,15 @@ Common Debugging Scenarios
 5. Check ``Setup ISO Data Path`` -- was it configured?
 6. Check for ISO Data packets -- is audio actually flowing?
 
+**GATT operation rejected** (see `PROTOCOL ERROR CODES`_):
+
+1. Find ``Error Response`` -- note the error code
+2. ``Insufficient Encryption`` (0x0f) → expect ``LE Start Encryption``
+   to follow
+3. ``Authentication Insufficient`` (0x05) → expect SMP pairing to
+   follow
+4. After security is established, the ATT operation should be retried
+
 **Connection parameter negotiation failure**:
 
 1. Find ``Connection Parameter Update Request`` (L2CAP level)
-- 
2.53.0

