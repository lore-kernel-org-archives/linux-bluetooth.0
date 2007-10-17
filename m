Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d5d240eb0710170654j2a3e14b4g9213136cac25628@mail.gmail.com>
Date: Wed, 17 Oct 2007 19:24:24 +0530
From: "rohit puri" <rohitpuri.rohit@gmail.com>
To: Bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Error in using DBus API'S
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1886748116=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1886748116==
Content-Type: multipart/alternative;
	boundary="----=_Part_46082_20834055.1192629264963"

------=_Part_46082_20834055.1192629264963
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all
I want to accomplish the following task.
1 To find sdp records of the discovered devices using the dbus APIs
Here I am able to find out the near by bluetooth devices using the Dbus APIs
and storing there addresses in an array.Now I want to extract  the  SDP
records of the discovered devices.

when I pass this array to function
/*function to retreive the SDP records*/

get_remote_service_channel(object,arr,uuid);

the code compiles ,find near by bluetooth devices but cannot retrive the sdp
records and the code crashesand shows the following messages.Even I Have
hardcoded address in get_remote_service_channel.Still receving
the warnings

warnings:
 Did not receive a reply. Possible causes include: the remote application
did not send a reply, the message bus security policy blocked the reply, the
reply timeout expired, or the network connection was broken.
aborting...



Host is down
aborting



Does  some one know what these warnings means

Any help would be appreciated

Thanks
Rohit

------=_Part_46082_20834055.1192629264963
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all <br>I want to accomplish the following task.<br>1 To find sdp records of the discovered devices using the dbus APIs<br>Here I am able to find out the near by bluetooth devices using the Dbus APIs and storing there addresses in an 
array.Now I want to extract&nbsp; the&nbsp; SDP records of the discovered devices.<br><br>when I pass this array to function&nbsp; <br>/*function to retreive the SDP records*/<br><br>get_remote_service_channel(object,arr,uuid);<br><br>the code compiles ,find near by bluetooth devices but cannot retrive the sdp records and the code crashesand shows the following 
messages.Even I Have hardcoded address in get_remote_service_channel.Still receving<br>the warnings<br><br>warnings:<br>&nbsp;Did not receive a reply. Possible causes include: the remote application did not send a reply, the message bus security policy blocked the reply, the reply timeout expired, or the network connection was broken.
<br>aborting...<br><br><br><br>Host is down <br>aborting<br><br><br><br>Does&nbsp; some one know what these warnings means<br><br>Any help would be appreciated<br><br>Thanks<br>Rohit<br>

------=_Part_46082_20834055.1192629264963--


--===============1886748116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1886748116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1886748116==--
