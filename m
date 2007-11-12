Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <47386088.80306@dev.rtsoft.ru>
Date: Mon, 12 Nov 2007 17:17:44 +0300
From: Rusev <arusev@dev.rtsoft.ru>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] PIN codes auto and user
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0357339692=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============0357339692==
Content-Type: multipart/alternative;
	boundary="------------050700040206030407090908"

This is a multi-part message in MIME format.
--------------050700040206030407090908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Greetings!

>>From my experiments with pairing to various devices I found that
presence of pincodes file (in /var/lib/bluetooth/<dondle-MAC>/)  in mode
"user" prevents
from pairing for some unknown reason, while absense
of pincodes file in mode "auto" just makes hcid fallback
to using of D-bus passkey agent.

Is it intented behavior? I suggested that in "user" mode pincodes would
be ignored...

Im using BlueZ libs/utils ver. 3.22

Regards,
      Alexandre


--------------050700040206030407090908
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<pre wrap="">Greetings!

>>From my experiments with pairing to various devices I found that
presence of pincodes file (in <i class="moz-txt-slash"><span
 class="moz-txt-tag">/</span>var/lib/bluetooth<span class="moz-txt-tag">/</span></i>&lt;dondle-MAC&gt;/)  in mode
"user" prevents
from pairing for some unknown reason, while absense
of pincodes file in mode "auto" just makes hcid fallback
to using of D-bus passkey agent.

Is it intented behavior? I suggested that in "user" mode pincodes would
be ignored...

Im using BlueZ libs/utils ver. 3.22

Regards,
      Alexandre</pre>
</body>
</html>

--------------050700040206030407090908--


--===============0357339692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0357339692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0357339692==--
