Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <8de6c3e20708220924g3a8db7a5paa153e99b5d829ea@mail.gmail.com>
Date: Wed, 22 Aug 2007 09:24:21 -0700
From: "Jeffrey Cuenco" <jcuenco@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] hci_read_remote_name() simultaneously on multiple
	dongles question
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0667349576=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0667349576==
Content-Type: multipart/alternative;
	boundary="----=_Part_59568_4562204.1187799861836"

------=_Part_59568_4562204.1187799861836
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I apologize for yet another e-mail about this, but as the last one was too
wordy I have narrowed down the problem to a much simpler issue.

As my changes to hci.c didn't do anything towards resolving the name mixup,
I was wondering how the hci_read_remote_name() ensures that the packet that
comes in isn't a packet response to another hci_read_remote_name() request.
It seems that everytime that I do multiple hci_read_remote_name() requests
at the same time, that the name request replies indiscriminately choose
whichever dongle to enter, and at the hci.c level, there is no way to verify
the btaddr that that name request came from, which is rather frustrating.

As some background for what "fixes" that I tried to do to hci.c were, I
simply compared the bdaddr const variable with rn.bdaddr near the end of
hci_read_remote_name_with_clock_offset() to see if it didn't match, and to
reject it if so and return -1, and to allow the name to be copied to the
name pointer otherwise.

If anyone out there has experienced similar problems with multiple dongles
and hci_read_remote_name(), any help would be appreciated if any solutions
to this have been found.

Thanks!

-- 
-Jeff

------=_Part_59568_4562204.1187799861836
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I apologize for yet another e-mail about this, but as the last one was too wordy I have narrowed down the problem to a much simpler issue.<br><br>As my changes to hci.c didn&#39;t do anything towards resolving the name mixup, I was wondering how the hci_read_remote_name() ensures that the packet that comes in isn&#39;t a packet response to another hci_read_remote_name() request.&nbsp; It seems that everytime that I do multiple hci_read_remote_name() requests at the same time, that the name request replies indiscriminately choose whichever dongle to enter, and at the 
hci.c level, there is no way to verify the btaddr that that name request came from, which is rather frustrating.<br><br>As some background for what &quot;fixes&quot; that I tried to do to hci.c were, I simply compared the bdaddr const variable with 
rn.bdaddr near the end of hci_read_remote_name_with_clock_offset() to see if it didn&#39;t match, and to reject it if so and return -1, and to allow the name to be copied to the name pointer otherwise.<br><br>If anyone out there has experienced similar problems with multiple dongles and hci_read_remote_name(), any help would be appreciated if any solutions to this have been found.
<br><br>Thanks!<br clear="all"><br>-- <br>-Jeff

------=_Part_59568_4562204.1187799861836--


--===============0667349576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0667349576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0667349576==--
