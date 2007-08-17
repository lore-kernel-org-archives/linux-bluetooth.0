Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <79be12f70708171422h6321e538hd92ea920068ea237@mail.gmail.com>
Date: Fri, 17 Aug 2007 15:22:45 -0600
From: "John Sample" <john.m.sample@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <79be12f70708171418i44648442g45dbff593b84063@mail.gmail.com>
MIME-Version: 1.0
References: <79be12f70708171418i44648442g45dbff593b84063@mail.gmail.com>
Subject: [Bluez-users] Fwd: hcitool scan problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1866781379=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1866781379==
Content-Type: multipart/alternative;
	boundary="----=_Part_38166_2766684.1187385765034"

------=_Part_38166_2766684.1187385765034
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I am having a problem with the hcitool scan command (v3.13) using the
2.6.21kernel, as well as
2.6.23.  Here is my output:

Scanning ...
        3A:5E:11:6B:00:00       n/a
        38:C1:5E:35:3F:D9       n/a
        C5:2B:F4:F7:3C:6A       n/a
        3A:75:F9:65:1A:02       n/a.
        38:C1:60:35:1A:F6       n/a

All of the addresses are partially junk for some reason - for example
38:C1:60:35:1A:F6 should be 00:16:38:C1:60:35, and no name are returned.
This seems to effect other tools as well, for example if I do try to do a
hidd search I can't detect anything even if there are discoverable hid
devices around - I'm guessing because it doesn't have valid addresses.
Previously I had been using the 2.6.10 kernel and everything worked fine.

-- 
John Sample

------=_Part_38166_2766684.1187385765034
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hello,</div>
<div>&nbsp;</div>
<div>I am having a problem with the hcitool scan command (v3.13)&nbsp;using the 2.6.21 kernel, as well as 2.6.23.&nbsp; Here is my output:</div>
<div>&nbsp;</div>
<div>Scanning ...<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3A:5E:11:6B:00:00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n/a<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 38:C1:5E:35:3F:D9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n/a<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; C5:2B:F4:F7:3C:6A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n/a<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3A:75:F9:65:1A:02&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n/a.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 38:C1:60:35:1A:F6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n/a</div>
<div>&nbsp;</div>
<div>All of the addresses are partially junk for some reason - for example 38:C1:60:35:1A:F6 should be 00:16:38:C1:60:35, and no name are returned.&nbsp; This seems to effect other tools as well, for example if I do try to do a hidd search I can&#39;t detect anything even if there are discoverable hid devices around - I&#39;m guessing because it doesn&#39;t have valid addresses.&nbsp; Previously I had been using the 
2.6.10 kernel and everything worked fine.<br clear="all"><br>-- <br>John Sample </div>

------=_Part_38166_2766684.1187385765034--


--===============1866781379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1866781379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1866781379==--
