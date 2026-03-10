Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE4B3B0AE4
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178411; cv=none; b=Z0oM3JsEwiree60a1BpkKowkunHW9bBJOy/e753Beeph8gGqOgINcUNRFE9uUkNqaiS05GN5YSEis7kfGT+fmyS8QMLlPURTdA4vz3YBHoitsLcujSn5tCeYd9GcuauZa+WxQIhanJ8iQu69H4RbKGVrTSJ1fU/uKGeIkJp8CJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178411; c=relaxed/simple;
	bh=K/LNEdV+29ZGp58fbHi9FGuQWhJkWFEkyTD85MSaZwc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzwSIK77Xyvd+yGu1crRAuM66QiP2S2wjzM5HL4kh5I71+vcwM8Wra3DdWKaTH5a9Cu2voQby6G/bNWv+wpgfOe+PU6j+ihzMwV1gKKdqa9m9fUWG1+joSvZBf6d9XOBuC4jK0NDkV0mSWXzxeWhctPzUB9Dy9C5Fd99wMnsGKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGjekfkZ; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGjekfkZ"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64cb577e79cso14476184d50.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 14:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773178409; x=1773783209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LoVSyXpwkNEYW42Rog7eRbI+l5jyaMso4oeJJ7gkRU0=;
        b=CGjekfkZs6bt3bycgnrYFiKOvkyDMvWZb1ByILdnfAsX//mjL8WqbRAto3VortMqmt
         X3E0cHgIFo+aO267D42rnFkNeohXsL+hMRAAjv1F6Gffa+Yxu+QozQeOuO4Cinj8Lx9X
         GijpS0MMfeNWYbxcF4Yl0DsSYd9MNMuCcGAiSwpqgBPB9r5/uXyp+UT4vQ43C2WL4tQ7
         d9JD2D4RUx/Z7OnBiWrHrAOUGMqaxr4Ckwq4umfmcwmlVJj1RZ1G37RyHxmFATSB7NLU
         FN8XjTnq3+Npi6NwnEIqoL/h0XHJklzh+4u3Aw5Q2AuQjXG3lHe4z1QJBmvxIZKelO1t
         fPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773178409; x=1773783209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LoVSyXpwkNEYW42Rog7eRbI+l5jyaMso4oeJJ7gkRU0=;
        b=GLeW0Rc8JEAAlhqttV50fCgOyPVNlno9RD3gKGpfqEcNr5bORJdscdxcrDt4lEYQZx
         bL84qbu2qmz7PwgZqkKMX4nTjxsEOeStIGBQQJCdNuHXaez6t5angoNV09xkxnB20Rke
         Vnx6zfyvg9yEXiWylRIAtezsDbOqSfSTaZg52ig6IaRRY5Ybkn34SMKfKzNvvxKetJmr
         MSLPEgWeaJYDD+OtLpMXJtNDEtj3f9rIl35q92GJ5RtQd3HRvyiSkKJH0PtGwrmOpo4X
         WWv0+g+wA/5AR1DoVry3FJNc/jos7nT8K7uCeYac0jIzJAPuabXuD5PV0do8CwBho97w
         SyBQ==
X-Gm-Message-State: AOJu0YyLTd9PF/1U1aOMCv3FBgn1TPqDFAkHSgXVCg36kgTjlWDYB2D2
	6B8ycd5DT6DTep+X5oXEkNk8y4elzDjhbG5CH70dgF6angFA5GAmosSHEYfGM582
X-Gm-Gg: ATEYQzwvsE335DscOTggzhtNZmp4rVsVQ9VtTJ0J+fCBxxj9DMutVLtMDUeXduWexFW
	5xahs5kW+zaOnlNpRtWjfY36Uil7Xei9YAlkq7mLupOsz0YZCo34F8QoZypSm7hcMsF4u8zWESO
	z+IyqheqSjzPbXGBuxWW8jR+NXU05yNKo0OQUunsNgIQgaA5y+xVVw60KCy7w2JhTPmTpA19RUd
	JpR+ROILJsRsuVUPFn2eo1rzieCDE9k4zyN21dH1XHZaT34nXtslsbTbTQ24FPMRbZWZQ5i3dV0
	Giyxb8cpbxp+qKUTmLe8coK1qkbFTuyB9VS7kyk0vw8mWMDgW0e6Xd6ueXNbhYYX/Db+cZmxjBQ
	vKJJVFxfP+RJDz601hUzsZZcugEBIfpDiev1WSiwsxMgYV7eD9fHPS4YlF2k/sQiRtbaBQ+OcWy
	VP3hxN2QJi/8ESx+pvRyfGLE2AhnSe2kuhnPuP21FjMskremMt5J9XsY/AR07R2D7suflc9GDIr
	1RQmVM6AD6LHJbvSlJRTO8KcNDi
X-Received: by 2002:a05:690c:2704:b0:796:4004:d1d5 with SMTP id 00721157ae682-79917fd4eb9mr1796277b3.59.1773178409084;
        Tue, 10 Mar 2026 14:33:29 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917f1ecd9sm952777b3.45.2026.03.10.14.33.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:33:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/7] doc/btmon: Add protocol error codes documentation
Date: Tue, 10 Mar 2026 17:33:11 -0400
Message-ID: <20260310213314.729718-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310213314.729718-1-luiz.dentz@gmail.com>
References: <20260310213314.729718-1-luiz.dentz@gmail.com>
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

