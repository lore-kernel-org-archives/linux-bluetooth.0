Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4b87e4aa.1408c00a.502e.056f@mx.google.com>
References: <4b87e4aa.1408c00a.502e.056f@mx.google.com>
Date: Fri, 5 Mar 2010 20:23:38 +0800
Message-ID: <6aeb672b1003050423y7b97ae57we98b5d18435c84a2@mail.gmail.com>
Subject: Re: [PATCH] Allow disable park state in main.conf
From: Liang Bao <tim.bao@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

We've changed to a hex value as "DefaultLinkPolicy" as following:

diff --git a/src/main.conf b/src/main.conf
index b03e169..196d703 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -50,3 +50,10 @@ ReverseServiceDiscovery = true
 # Enable name resolving after inquiry. Set it to 'false' if you don't need
 # remote devices name and want shorter discovery cycle. Defaults to 'true'.
 NameResolving = true
+
+# The link policy for connections. By default it's set to 0x000f which is
+# a bitwise OR of role switch(0x0001), hold mode(0x0002), sniff mode(0x0004)
+# and park state(0x0008) are all enabled. However, some devices have
+# connection stability issue or fail to setup SCO when the link is in park
+# state, which requires park state bit cleared.
+DefaultLinkPolicy = 0x000f

Does this look better? If yes I can re-generate a patch and send in a
separate thread.
