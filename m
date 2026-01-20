Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF15C4418FF
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925305; cv=none; b=l+p0Hz7yQJqRKXGAaF3LwM72d7hJ5hHj0Riq15zyENAdeCO4LGQSoeVo2UdHvACen/kYuy6HmHJM5DVIjx57qgLvDOWc4pv2L7G0H/M+6SqxH/Tq/RutZxMht/lZU8uFCX5p6Q2nBSaDyRmsxxT+sJ1KP5E0do00yuRWeGM500g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925305; c=relaxed/simple;
	bh=zwrGl7lw3asglMEBbkCsuqNspds7Q4tdL+7mNg8JkT4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ktpdc2olS1K992pJEFJpxMGQ6PCcER/GghfGnqwdVObrmo/UeDIsbVWF69tpYKcxgNqd+Dbk2X+5oAkf3lazFa/4/28WHcfbeHteK0SWqSgctsTuYNqYaXDOfSWiKPLWFRCRSPi/vdXzqX0jf+7MPpvfpg3uD1FQoM5h3VV2Lf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 14C1F44380
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 16:08:20 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 4/7] doc: Port coding-style.txt to RST
Date: Tue, 20 Jan 2026 17:05:50 +0100
Message-ID: <20260120160811.3394320-5-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120160811.3394320-1-hadess@hadess.net>
References: <20260120160811.3394320-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeevudfgjeevveekgedvjefgffefjeeitdekgffffeegiedtveekvddvueffkeffueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepudegveduhfeggeefkedtpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-State: clean
X-GND-Score: 0

---
 doc/coding-style.rst | 349 +++++++++++++++++++++++++++++++++++++++++++
 doc/coding-style.txt | 279 ----------------------------------
 2 files changed, 349 insertions(+), 279 deletions(-)
 create mode 100644 doc/coding-style.rst
 delete mode 100644 doc/coding-style.txt

diff --git a/doc/coding-style.rst b/doc/coding-style.rst
new file mode 100644
index 000000000000..91250e867f09
--- /dev/null
+++ b/doc/coding-style.rst
@@ -0,0 +1,349 @@
+==================
+BlueZ coding style
+==================
+
+Every project has its coding style, and BlueZ is not an exception. This
+document describes the preferred coding style for BlueZ code, in order to keep
+some level of consistency among developers so that code can be easily
+understood and maintained.
+
+First of all, BlueZ coding style must follow every rule for Linux kernel
+(https://www.kernel.org/doc/Documentation/process/coding-style.rst). There also
+exists a tool named checkpatch.pl to help you check the compliance with it.
+Just type ``checkpatch.pl --no-tree patch_name`` to check your patch. In theory,
+you need to clean up all the warnings and errors except this one: ``ERROR:
+Missing Signed-off-by: line(s)``. BlueZ does not used ``Signed-off-by`` lines, so
+including them is actually an error. In certain circumstances one can ignore
+the 80 character per line limit. This is generally only allowed if the
+alternative would make the code even less readable.
+
+Besides the kernel coding style above, BlueZ has special flavors for its own.
+Some of them are mandatory (marked as ``M``), while some others are optional
+(marked as ``O``), but generally preferred.
+
+M1: Blank line before and after an if/while/do/for statement
+------------------------------------------------------------
+
+There should be a blank line before ``if`` statement unless the ``if`` is nested and
+not preceded by an expression or variable declaration.
+
+Example:
+1)
+
+.. code-block:: C
+
+        a = 1;
+        if (b) {  // wrong
+
+2)
+
+.. code-block:: C
+
+        a = 1
+
+        if (b) {
+        }
+        a = 2;	// wrong
+
+3)
+
+.. code-block:: C
+
+        if (a) {
+	        if (b)  // correct
+
+4)
+
+.. code-block:: C
+
+        b = 2;
+
+        if (a) {	// correct
+
+        }
+
+        b = 3;
+
+The only exception to this rule applies when a variable is being checked for
+errors as such:
+
+.. code-block:: C
+
+        err = stat(filename, &st);
+        if (err || !S_ISDIR(st.st_mode))
+	        return;
+
+M2: Multiple line comment
+-------------------------
+
+If your comment has more than one line, please start it from the second line.
+
+Example:
+
+.. code-block:: C
+
+        /*
+         * first line comment	// correct
+         * ...
+         * last line comment
+         */
+
+M3: Space before and after operator
+-----------------------------------
+
+There should be a space before and after each operator.
+
+Example:
+
+.. code-block:: C
+
+        a + b;  // correct
+
+
+M4: Wrap long lines
+-------------------
+
+If your condition in ``if``, ``while``, ``for`` statement or a function declaration is too
+long to fit in one line, the new line needs to be indented not aligned with the
+body.
+
+Example:
+1)
+
+.. code-block:: C
+
+        if ((adapter->supported_settings & MGMT_SETTING_SSP) &&
+        	!(adapter->current_settings & MGMT_SETTING_SSP)) // wrong
+
+2)
+
+.. code-block:: C
+
+        if ((adapter->supported_settings & MGMT_SETTING_SSP) &&
+	        			!(adapter->current_settings & MGMT_SETTING_SSP))
+
+3)
+
+.. code-block:: C
+
+        void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
+	        			 btd_adapter_pin_cb_t cb) // wrong
+
+4)
+
+.. code-block:: C
+
+        void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
+	        						btd_adapter_pin_cb_t cb)
+
+The referred style for line wrapping is to indent as far as possible to the
+right without hitting the 80 columns limit.
+
+M5: Space when doing type casting
+---------------------------------
+
+There should be a space between new type and variable.
+
+Example:
+1)
+
+.. code-block:: C
+
+        a = (int *)b;  // wrong
+
+2)
+
+.. code-block:: C
+
+        a = (int *) b;  // correct
+
+
+M6: Don't initialize variable unnecessarily
+-------------------------------------------
+
+When declaring a variable, try not to initialize it unless necessary.
+
+Example:
+
+.. code-block:: C
+
+        int i = 1;  // wrong
+
+        for (i = 0; i < 3; i++) {
+        }
+
+M7: Follow the order of include header elements
+-----------------------------------------------
+
+When writing an include header the various elements should be in the following
+order:
+
+* ``#include``'s
+* forward declarations
+* ``#define``'s
+* ``enum``'s
+* ``typedef``'s
+* function declarations and inline function definitions
+
+M8: Internal headers must not use include guards
+------------------------------------------------
+
+Any time when creating a new header file with non-public API, that header
+must not contain include guards.
+
+M9: Naming of enums
+-------------------
+
+Enums must have a descriptive name.  The enum type should be small caps and
+it should not be ``typedef``'ed.  Enum contents should be in CAPITAL letters and
+prefixed by the ``enum`` type name.
+
+Example:
+
+.. code-block:: C
+
+        enum animal_type {
+        	ANIMAL_TYPE_FOUR_LEGS,
+        	ANIMAL_TYPE_EIGHT_LEGS,
+        	ANIMAL_TYPE_TWO_LEGS,
+        };
+
+If the enum contents have values (e.g. from specification) the formatting
+should be as follows:
+
+.. code-block:: C
+
+        enum animal_type {
+        	ANIMAL_TYPE_FOUR_LEGS =		4,
+        	ANIMAL_TYPE_EIGHT_LEGS =	8,
+        	ANIMAL_TYPE_TWO_LEGS =		2,
+        };
+
+M10: Enum as switch variable
+----------------------------
+
+If the variable of a ``switch`` is an enum, you must include all values in
+switch body even if providing ``default``. This is enforced by compiler option
+enabling extra warning in such case. The reason for this is to ensure that if
+later on the enum is modified and one forget to change the ``switch`` accordingly, the
+compiler will complain the new added type hasn't been handled.
+
+Example:
+
+.. code-block:: C
+
+        enum animal_type {
+        	ANIMAL_TYPE_FOUR_LEGS =		4,
+        	ANIMAL_TYPE_EIGHT_LEGS =	8,
+        	ANIMAL_TYPE_TWO_LEGS =		2,
+        };
+
+        enum animal_type t;
+
+        switch (t) { // OK
+        case ANIMAL_TYPE_FOUR_LEGS:
+        	...
+        	break;
+        case ANIMAL_TYPE_EIGHT_LEGS:
+        	...
+        	break;
+        case ANIMAL_TYPE_TWO_LEGS:
+        	...
+        	break;
+        default:
+        	break;
+        }
+
+        switch (t) { // Wrong
+        case ANIMAL_TYPE_FOUR_LEGS:
+        	...
+        	break;
+        case ANIMAL_TYPE_TWO_LEGS:
+        	...
+        	break;
+        default:
+        	break;
+        }
+
+However if the enum comes from an external header file outside BlueZ, such as
+Android headers, we cannot make any assumption of how the enum is defined and
+this rule might not apply.
+
+M11: Always use parenthesis with sizeof
+---------------------------------------
+
+The expression argument to the ``sizeof`` operator should always be in
+parenthesis, too.
+
+Example:
+1)
+
+.. code-block:: C
+
+        memset(stuff, 0, sizeof(*stuff));
+
+2)
+
+.. code-block:: C
+
+        memset(stuff, 0, sizeof *stuff); // Wrong
+
+M12: Use void if function has no parameters
+-------------------------------------------
+
+A function with no parameters must use ``void`` in the parameter list.
+
+Example:
+1)
+
+.. code-block:: C
+
+        void foo(void)
+        {
+        }
+
+2)
+
+.. code-block:: C
+
+        void foo()	// Wrong
+        {
+        }
+
+O1: Try to avoid complex if body
+--------------------------------
+
+It's better not to have a complicated statement for ``if``. You may judge its
+contrary condition and ``return``, ``break``, ``continue`` or ``goto`` as soon
+as possible.
+
+Example:
+
+1)
+
+.. code-block:: C
+
+        if (device) {  // worse
+        	memset(&eir_data, 0, sizeof(eir_data));
+        	if (eir_len > 0)
+        		eir_parse(&eir_data, ev->eir, eir_len);
+        	...
+        } else {
+        	error("Unable to get device object for %s", addr);
+        	return;
+        }
+
+2)
+
+.. code-block:: C
+
+        if (!device) {
+        	error("Unable to get device object for %s", addr);
+        	return;
+        }
+
+        memset(&eir_data, 0, sizeof(eir_data));
+        if (eir_len > 0)
+        	eir_parse(&eir_data, ev->eir, eir_len);
+        ...
+
diff --git a/doc/coding-style.txt b/doc/coding-style.txt
deleted file mode 100644
index e73158840ff6..000000000000
--- a/doc/coding-style.txt
+++ /dev/null
@@ -1,279 +0,0 @@
-BlueZ coding style
-******************
-
-Every project has its coding style, and BlueZ is not an exception. This
-document describes the preferred coding style for BlueZ code, in order to keep
-some level of consistency among developers so that code can be easily
-understood and maintained.
-
-First of all, BlueZ coding style must follow every rule for Linux kernel
-(https://www.kernel.org/doc/Documentation/process/coding-style.rst). There also
-exists a tool named checkpatch.pl to help you check the compliance with it.
-Just type "checkpatch.pl --no-tree patch_name" to check your patch. In theory,
-you need to clean up all the warnings and errors except this one: "ERROR:
-Missing Signed-off-by: line(s)". BlueZ does not used Signed-Off lines, so
-including them is actually an error.  In certain circumstances one can ignore
-the 80 character per line limit.  This is generally only allowed if the
-alternative would make the code even less readable.
-
-Besides the kernel coding style above, BlueZ has special flavors for its own.
-Some of them are mandatory (marked as 'M'), while some others are optional
-(marked as 'O'), but generally preferred.
-
-M1: Blank line before and after an if/while/do/for statement
-============================================================
-
-There should be a blank line before if statement unless the if is nested and
-not preceded by an expression or variable declaration.
-
-Example:
-1)
-a = 1;
-if (b) {  // wrong
-
-2)
-a = 1
-
-if (b) {
-}
-a = 2;	// wrong
-
-3)
-if (a) {
-	if (b)  // correct
-
-4)
-b = 2;
-
-if (a) {	// correct
-
-}
-
-b = 3;
-
-The only exception to this rule applies when a variable is being checked for
-errors as such:
-
-err = stat(filename, &st);
-if (err || !S_ISDIR(st.st_mode))
-	return;
-
-M2: Multiple line comment
-=========================
-
-If your comment has more than one line, please start it from the second line.
-
-Example:
-/*
- * first line comment	// correct
- * ...
- * last line comment
- */
-
-
-M3: Space before and after operator
-===================================
-
-There should be a space before and after each operator.
-
-Example:
-a + b;  // correct
-
-
-M4: Wrap long lines
-===================
-
-If your condition in if, while, for statement or a function declaration is too
-long to fit in one line, the new line needs to be indented not aligned with the
-body.
-
-Example:
-1)
-if ((adapter->supported_settings & MGMT_SETTING_SSP) &&
-	!(adapter->current_settings & MGMT_SETTING_SSP)) // wrong
-
-2)
-if ((adapter->supported_settings & MGMT_SETTING_SSP) &&
-				!(adapter->current_settings & MGMT_SETTING_SSP))
-
-3)
-void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
-				 btd_adapter_pin_cb_t cb) // wrong
-
-4)
-void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
-							btd_adapter_pin_cb_t cb)
-
-The referred style for line wrapping is to indent as far as possible to the
-right without hitting the 80 columns limit.
-
-M5: Space when doing type casting
-=================================
-
-There should be a space between new type and variable.
-
-Example:
-1)
-a = (int *)b;  // wrong
-2)
-a = (int *) b;  // correct
-
-
-M6: Don't initialize variable unnecessarily
-===========================================
-
-When declaring a variable, try not to initialize it unless necessary.
-
-Example:
-int i = 1;  // wrong
-
-for (i = 0; i < 3; i++) {
-}
-
-M7: Follow the order of include header elements
-===============================================
-
-When writing an include header the various elements should be in the following
-order:
-	- #includes
-	- forward declarations
-	- #defines
-	- enums
-	- typedefs
-	- function declarations and inline function definitions
-
-M8: Internal headers must not use include guards
-================================================
-
-Any time when creating a new header file with non-public API, that header
-must not contain include guards.
-
-M9: Naming of enums
-===================
-
-Enums must have a descriptive name.  The enum type should be small caps and
-it should not be typedef-ed.  Enum contents should be in CAPITAL letters and
-prefixed by the enum type name.
-
-Example:
-
-enum animal_type {
-	ANIMAL_TYPE_FOUR_LEGS,
-	ANIMAL_TYPE_EIGHT_LEGS,
-	ANIMAL_TYPE_TWO_LEGS,
-};
-
-If the enum contents have values (e.g. from specification) the formatting
-should be as follows:
-
-enum animal_type {
-	ANIMAL_TYPE_FOUR_LEGS =		4,
-	ANIMAL_TYPE_EIGHT_LEGS =	8,
-	ANIMAL_TYPE_TWO_LEGS =		2,
-};
-
-M10: Enum as switch variable
-============================
-
-If the variable of a switch is an enum, you must include all values in
-switch body even if providing default. This is enforced by compiler option
-enabling extra warning in such case. The reason for this is to ensure that if
-later on enum is modified and one forget to change the switch accordingly, the
-compiler will complain the new added type hasn't been handled.
-
-Example:
-
-enum animal_type {
-	ANIMAL_TYPE_FOUR_LEGS =		4,
-	ANIMAL_TYPE_EIGHT_LEGS =	8,
-	ANIMAL_TYPE_TWO_LEGS =		2,
-};
-
-enum animal_type t;
-
-switch (t) { // OK
-case ANIMAL_TYPE_FOUR_LEGS:
-	...
-	break;
-case ANIMAL_TYPE_EIGHT_LEGS:
-	...
-	break;
-case ANIMAL_TYPE_TWO_LEGS:
-	...
-	break;
-default:
-	break;
-}
-
-switch (t) { // Wrong
-case ANIMAL_TYPE_FOUR_LEGS:
-	...
-	break;
-case ANIMAL_TYPE_TWO_LEGS:
-	...
-	break;
-default:
-	break;
-}
-
-However if the enum comes from an external header file outside BlueZ, such as
-Android headers, we cannot make any assumption of how the enum is defined and
-this rule might not apply.
-
-M11: Always use parenthesis with sizeof
-=======================================
-
-The expression argument to the sizeof operator should always be in
-parenthesis, too.
-
-Example:
-1)
-memset(stuff, 0, sizeof(*stuff));
-
-2)
-memset(stuff, 0, sizeof *stuff); // Wrong
-
-M12: Use void if function has no parameters
-===========================================
-
-A function with no parameters must use void in the parameter list.
-
-Example:
-1)
-void foo(void)
-{
-}
-
-2)
-void foo()	// Wrong
-{
-}
-
-O1: Try to avoid complex if body
-================================
-
-It's better not to have a complicated statement for if. You may judge its
-contrary condition and return | break | continue | goto ASAP.
-
-Example:
-1)
-if (device) {  // worse
-	memset(&eir_data, 0, sizeof(eir_data));
-	if (eir_len > 0)
-		eir_parse(&eir_data, ev->eir, eir_len);
-	...
-} else {
-	error("Unable to get device object for %s", addr);
-	return;
-}
-
-2)
-if (!device) {
-	error("Unable to get device object for %s", addr);
-	return;
-}
-
-memset(&eir_data, 0, sizeof(eir_data));
-if (eir_len > 0)
-	eir_parse(&eir_data, ev->eir, eir_len);
-...
-- 
2.52.0

