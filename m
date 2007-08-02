Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <22b6c3510708020121g64bee772g72aa8762203e1a27@mail.gmail.com>
Date: Thu, 2 Aug 2007 16:21:54 +0800
From: "Benjamin Fong" <benjamin.backup@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel]  hcid does not boot up properly
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0049257818=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0049257818==
Content-Type: multipart/alternative;
	boundary="----=_Part_82266_32645465.1186042914985"

------=_Part_82266_32645465.1186042914985
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

When I was using fed 7, I'd noticed that there are a couple of defunct hcid
after boot. I'd migrated my system OS to fed 6, and that issue seem to
disappear. However, hcid always seem to have trouble initiating all of my
bluetooth dongles (I have 4). I've manually reattach each of the dongles
before hcid can properly use them.

I'm using bluez v 3.12. By the way, v3.12 doesn't seem to be picking up on
the bluetooth friendly name I'd specified in hcid.conf as well. Any idea?

Regards,
Ben

------=_Part_82266_32645465.1186042914985
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;</div>
<div>When I was using fed 7, I&#39;d noticed that there are a couple of defunct hcid after boot. I&#39;d migrated my system OS to fed 6, and that issue seem to disappear. However, hcid always seem to have trouble initiating all of my bluetooth dongles (I have 4). I&#39;ve manually reattach each of the dongles before hcid can properly use them. 
</div>
<div>&nbsp;</div>
<div>I&#39;m using bluez v 3.12. By the way, v3.12 doesn&#39;t seem to be picking up on the bluetooth friendly name I&#39;d specified in hcid.conf as well. Any idea?</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Ben</div>

------=_Part_82266_32645465.1186042914985--


--===============0049257818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0049257818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0049257818==--
