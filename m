Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <431ECFA0.50401@tcs.hut.fi>
From: Ville Nuorvala <vnuorval@tcs.hut.fi>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Subject: [Bluez-devel] [PATCH] Fix memory textfile_get() memory leaks
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
Date: Wed, 07 Sep 2005 14:31:44 +0300

Hi,

there apparently are a couple of places where the bluez-utils is leaking 
memory after calling textfile_get(). The patch below should fix this...

Index: hcid/storage.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/storage.c,v
retrieving revision 1.24
diff -u -r1.24 storage.c
--- hcid/storage.c      30 Aug 2005 00:35:39 -0000      1.24
+++ hcid/storage.c      7 Sep 2005 11:23:14 -0000
@@ -87,6 +87,8 @@
                 str[248] = '\0';
         strcpy(name, str);

+       free(str);
+
         return 0;
  }

@@ -161,6 +163,7 @@
                 memcpy(tmp, str + (i * 2), 2);
                 key[i] = (uint8_t) strtol(tmp, NULL, 16);
         }
+       free(str);

         return 0;
  }
@@ -181,5 +184,7 @@
         strncpy(pin, str, 16);
         len = strlen(pin);

+       free(str);
+
         return len;
  }
Index: common/test_textfile.c
===================================================================
RCS file: /cvsroot/bluez/utils/common/test_textfile.c,v
retrieving revision 1.2
diff -u -r1.2 test_textfile.c
--- common/test_textfile.c      6 Aug 2005 06:27:40 -0000       1.2
+++ common/test_textfile.c      7 Sep 2005 11:23:14 -0000
@@ -64,6 +64,8 @@
                 str = textfile_get(filename, key);
                 if (!str)
                         fprintf(stderr, "No value for %s\n", key);
+               else
+                       free(str);
         }

         return 0;


Regards,
Ville
-- 
Ville Nuorvala
Research Assistant,
Laboratory for Theoretical Computer Science,
Helsinki University of Technology
email: vnuorval@tcs.hut.fi, phone: +358 (0)9 451 5257


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
