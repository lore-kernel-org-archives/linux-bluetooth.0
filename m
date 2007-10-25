Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <685df2130710250927m3f56731au9e6e508f851e9cf3@mail.gmail.com>
Date: Thu, 25 Oct 2007 12:27:06 -0400
From: "Joshua Bryant" <josh@alumni.cmu.edu>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Audio service with multiple adapters
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1512063042=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1512063042==
Content-Type: multipart/alternative;
	boundary="----=_Part_1425_33522514.1193329626135"

------=_Part_1425_33522514.1193329626135
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I am using BlueZ for a project and it is working well. I have a question
concerning multiple adapters.

I am able to connect my headset to the default adapter through the audio
service. However I cannot connect a headset to a second adapter (hci1)
through the audio service. I can bond my headset to the second adapter, but
I cannot create a sco connection.

Is it possible to start the audio service on the non-default adapter (hci1)?
Is it possible to run the audio service for both adapters? I would like to
have 2 adapters each supporting a separate headset.

Thank you for your time,
Josh

------=_Part_1425_33522514.1193329626135
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>I am using BlueZ for a project and it is working well. I have a question concerning multiple adapters.<br><br>I am able to connect my headset to the default adapter through the audio service. However I cannot connect a headset to a second adapter (hci1) through the audio service. I can bond my headset to the second adapter, but I cannot create a sco connection.
<br><br>Is it possible to start the audio service on the non-default adapter (hci1)?<br>Is it possible to run the audio service for both adapters? I would like to have 2 adapters each supporting a separate headset.<br><br>
Thank you for your time,<br>Josh<br>

------=_Part_1425_33522514.1193329626135--


--===============1512063042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1512063042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1512063042==--
