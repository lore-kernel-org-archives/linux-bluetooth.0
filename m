Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130430100655.GB5745@x220.ger.corp.intel.com>
References: <1365706752-4442-1-git-send-email-anderson.lizardo@openbossa.org>
	<20130430100655.GB5745@x220.ger.corp.intel.com>
Date: Tue, 30 Apr 2013 08:32:30 -0400
Message-ID: <CAJdJm_N8kZEo5ek=6VGDhcdkQhM72O-aKE=fgX=i9UTL18=5iA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] tools: Add script for updating bt_compidtostr() implementation
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> I tried this script but after downloading the page it fails with "Input
> recoding failed due to invalid input sequence." and then proceeds with
> generating a diff to remove all entries from the switch statement.

That's strange. I just tested here and it worked fine, even found 3
new companies:

--- lib/bluetooth.c.orig	2013-04-30 08:29:11.000000000 -0400
+++ lib/bluetooth.c	2013-04-30 08:29:21.000000000 -0400
@@ -655,6 +655,12 @@
 		return "adidas AG";
 	case 196:
 		return "LG Electronics";
+	case 197:
+		return "Onset Computer Corporation";
+	case 198:
+		return "Selfly BV";
+	case 199:
+		return "Quuppa Oy.";
 	case 65535:
 		return "internal use";
 	default:

Maybe "html2text" is not the same tool on all distros. I'll see if I
can make it more robust. Can you tell me the output of "html2text
-version" ?

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
