Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0CE3033E4
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615766; cv=none; b=JofEM0cbj6AbpV3ZVYQ853FQhcXG16uC9q9tMiyvabtJfwgngYqhsQu5HVLzv9kMARzxITru9SV5yPBz+KspJTjMvwjT70M0ppJKNbK6yHcs/9lLZNoMfENvgEKqOCJiHvUBAo21FA9tnJlPyqeum9nCR8Dmo4KcRzkOfjWfgq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615766; c=relaxed/simple;
	bh=CrEWvX6/vZW/JINsIuxibAHLN2y3b+hNRm3BGSnnkw0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUNQUQ/1MDev7RVq2QPErfBO3A1Tf4uWiYIvIFVuvxg6sAEK2hqF8fhzE0cKSk9emwfhT2nxsJoVuuQ2Ygr6IeDAfT0cqQ8TzOHTiUcS/6eOsI7dce6Z3xm8P3JFUJ8o9e+3f1y2Pwk5tCIBtjHhiXWZINTY93W9bubQm9DixJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9312543FF4
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 15:55:57 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 03/20] doc: Add "C" code-block markers for coding-style doc
Date: Wed, 28 Jan 2026 16:11:41 +0100
Message-ID: <20260128155548.2025252-4-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128155548.2025252-1-hadess@hadess.net>
References: <20260128155548.2025252-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieefjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeelfeduvdehgeefhffhgedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-State: clean

The file isn't processed by rst2man, so this doesn't add a new
dependency as was the case in 0ea4e4d52c55 ("doc: Remove Pygments
dependency from manpage").
---
 doc/coding-style.rst | 46 ++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/doc/coding-style.rst b/doc/coding-style.rst
index 585d14fd86d9..91250e867f09 100644
--- a/doc/coding-style.rst
+++ b/doc/coding-style.rst
@@ -30,14 +30,14 @@ not preceded by an expression or variable declaration.
 Example:
 1)
 
-.. code-block::
+.. code-block:: C
 
         a = 1;
         if (b) {  // wrong
 
 2)
 
-.. code-block::
+.. code-block:: C
 
         a = 1
 
@@ -47,14 +47,14 @@ Example:
 
 3)
 
-.. code-block::
+.. code-block:: C
 
         if (a) {
 	        if (b)  // correct
 
 4)
 
-.. code-block::
+.. code-block:: C
 
         b = 2;
 
@@ -67,7 +67,7 @@ Example:
 The only exception to this rule applies when a variable is being checked for
 errors as such:
 
-.. code-block::
+.. code-block:: C
 
         err = stat(filename, &st);
         if (err || !S_ISDIR(st.st_mode))
@@ -80,7 +80,7 @@ If your comment has more than one line, please start it from the second line.
 
 Example:
 
-.. code-block::
+.. code-block:: C
 
         /*
          * first line comment	// correct
@@ -95,7 +95,7 @@ There should be a space before and after each operator.
 
 Example:
 
-.. code-block::
+.. code-block:: C
 
         a + b;  // correct
 
@@ -110,28 +110,28 @@ body.
 Example:
 1)
 
-.. code-block::
+.. code-block:: C
 
         if ((adapter->supported_settings & MGMT_SETTING_SSP) &&
         	!(adapter->current_settings & MGMT_SETTING_SSP)) // wrong
 
 2)
 
-.. code-block::
+.. code-block:: C
 
         if ((adapter->supported_settings & MGMT_SETTING_SSP) &&
 	        			!(adapter->current_settings & MGMT_SETTING_SSP))
 
 3)
 
-.. code-block::
+.. code-block:: C
 
         void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
 	        			 btd_adapter_pin_cb_t cb) // wrong
 
 4)
 
-.. code-block::
+.. code-block:: C
 
         void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
 	        						btd_adapter_pin_cb_t cb)
@@ -147,13 +147,13 @@ There should be a space between new type and variable.
 Example:
 1)
 
-.. code-block::
+.. code-block:: C
 
         a = (int *)b;  // wrong
 
 2)
 
-.. code-block::
+.. code-block:: C
 
         a = (int *) b;  // correct
 
@@ -165,7 +165,7 @@ When declaring a variable, try not to initialize it unless necessary.
 
 Example:
 
-.. code-block::
+.. code-block:: C
 
         int i = 1;  // wrong
 
@@ -200,7 +200,7 @@ prefixed by the ``enum`` type name.
 
 Example:
 
-.. code-block::
+.. code-block:: C
 
         enum animal_type {
         	ANIMAL_TYPE_FOUR_LEGS,
@@ -211,7 +211,7 @@ Example:
 If the enum contents have values (e.g. from specification) the formatting
 should be as follows:
 
-.. code-block::
+.. code-block:: C
 
         enum animal_type {
         	ANIMAL_TYPE_FOUR_LEGS =		4,
@@ -230,7 +230,7 @@ compiler will complain the new added type hasn't been handled.
 
 Example:
 
-.. code-block::
+.. code-block:: C
 
         enum animal_type {
         	ANIMAL_TYPE_FOUR_LEGS =		4,
@@ -278,13 +278,13 @@ parenthesis, too.
 Example:
 1)
 
-.. code-block::
+.. code-block:: C
 
         memset(stuff, 0, sizeof(*stuff));
 
 2)
 
-.. code-block::
+.. code-block:: C
 
         memset(stuff, 0, sizeof *stuff); // Wrong
 
@@ -296,7 +296,7 @@ A function with no parameters must use ``void`` in the parameter list.
 Example:
 1)
 
-.. code-block::
+.. code-block:: C
 
         void foo(void)
         {
@@ -304,7 +304,7 @@ Example:
 
 2)
 
-.. code-block::
+.. code-block:: C
 
         void foo()	// Wrong
         {
@@ -321,7 +321,7 @@ Example:
 
 1)
 
-.. code-block::
+.. code-block:: C
 
         if (device) {  // worse
         	memset(&eir_data, 0, sizeof(eir_data));
@@ -335,7 +335,7 @@ Example:
 
 2)
 
-.. code-block::
+.. code-block:: C
 
         if (!device) {
         	error("Unable to get device object for %s", addr);
-- 
2.52.0

