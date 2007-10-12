Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d5d240eb0710120713r27a2ddcfm84493a711187bcb3@mail.gmail.com>
Date: Fri, 12 Oct 2007 19:43:46 +0530
From: "rohit puri" <rohitpuri.rohit@gmail.com>
To: Bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] problem in browsing services through dbus interface.
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1633267864=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1633267864==
Content-Type: multipart/alternative;
	boundary="----=_Part_24164_20501938.1192198426185"

------=_Part_24164_20501938.1192198426185
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi all,

I am browsing the services using the dbus interface.but my code gives the
following error
`get_remote_service_channel':
/root/marcel/main.c:78: undefined reference to `sdp_extract_pdu'
/root/marcel/main.c:81: undefined reference to `sdp_get_access_protos'
/root/marcel/main.c:85: undefined reference to `sdp_get_proto_port'
/root/marcel/main.c:88: undefined reference to `sdp_list_free'
/root/marcel/main.c:89: undefined reference to `sdp_list_free'
/root/marcel/main.c:92: undefined reference to `sdp_record_free'
collect2: ld returned 1 exit status
Does someone know how to rectify this problem.

Thanks in advance

------=_Part_24164_20501938.1192198426185
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi all,<br><br>I am browsing the services using the dbus interface.but my code gives the following error<br>`get_remote_service_channel&#39;:<br>/root/marcel/main.c:78: undefined reference to `sdp_extract_pdu&#39;<br>/root/marcel/main.c:81: undefined reference to `sdp_get_access_protos&#39;
<br>/root/marcel/main.c:85: undefined reference to `sdp_get_proto_port&#39;<br>/root/marcel/main.c:88: undefined reference to `sdp_list_free&#39;<br>/root/marcel/main.c:89: undefined reference to `sdp_list_free&#39;<br>/root/marcel/main.c:92: undefined reference to `sdp_record_free&#39;
<br>collect2: ld returned 1 exit status<br>Does someone know how to rectify this problem.<br><br>Thanks in advance<br><br>

------=_Part_24164_20501938.1192198426185--


--===============1633267864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1633267864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1633267864==--
