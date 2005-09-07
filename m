Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <431F1F9C.4010900@tcs.hut.fi>
From: Ville Nuorvala <vnuorval@tcs.hut.fi>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] Fix memory textfile_get() memory leaks
References: <431ECFA0.50401@tcs.hut.fi> <1126094328.10631.24.camel@blade> <431F1041.3040603@tcs.hut.fi>
In-Reply-To: <431F1041.3040603@tcs.hut.fi>
Content-Type: multipart/mixed;
 boundary="------------010505010504050801040909"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 07 Sep 2005 20:13:00 +0300

This is a multi-part message in MIME format.
--------------010505010504050801040909
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Sorry, I forgot to include stdlib.h in test_textfile.c. Please use this 
updated patch file...

Regards,
Ville

-- 
Ville Nuorvala
Research Assistant,
Laboratory for Theoretical Computer Science,
Helsinki University of Technology
email: vnuorval@tcs.hut.fi, phone: +358 (0)9 451 5257

--------------010505010504050801040909
Content-Type: text/x-patch;
 name="mem_leak_fixed.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mem_leak_fixed.patch"

Index: hcid/storage.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/storage.c,v
retrieving revision 1.24
diff -u -r1.24 storage.c
--- hcid/storage.c	30 Aug 2005 00:35:39 -0000	1.24
+++ hcid/storage.c	7 Sep 2005 17:10:05 -0000
@@ -87,6 +87,8 @@
 		str[248] = '\0';
 	strcpy(name, str);
 
+	free(str);
+
 	return 0;
 }
 
@@ -161,6 +163,7 @@
 		memcpy(tmp, str + (i * 2), 2);
 		key[i] = (uint8_t) strtol(tmp, NULL, 16);
 	}
+	free(str);
 
 	return 0;
 }
@@ -181,5 +184,7 @@
 	strncpy(pin, str, 16);
 	len = strlen(pin);
 
+	free(str);
+
 	return len;
 }
Index: common/test_textfile.c
===================================================================
RCS file: /cvsroot/bluez/utils/common/test_textfile.c,v
retrieving revision 1.2
diff -u -r1.2 test_textfile.c
--- common/test_textfile.c	6 Aug 2005 06:27:40 -0000	1.2
+++ common/test_textfile.c	7 Sep 2005 17:10:05 -0000
@@ -35,7 +35,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <string.h>
-
+#include <stdlib.h>
 #include "textfile.h"
 
 int main(int argc, char *argv[])
@@ -64,6 +64,8 @@
 		str = textfile_get(filename, key);
 		if (!str)
 			fprintf(stderr, "No value for %s\n", key);
+		else
+			free(str);
 	}
 
 	return 0;

--------------010505010504050801040909--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
