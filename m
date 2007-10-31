Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <307f591f0710302059w4b80246dnb39ba04111dcd187@mail.gmail.com>
Date: Tue, 30 Oct 2007 19:59:35 -0800
From: "Paul Huber" <paul2004x@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d89ddf300710301323h5a56b932h8304f42f5ae3fc6@mail.gmail.com>
MIME-Version: 1.0
References: <307f591f0710301305n410b8ebds4fa399dd0a518840@mail.gmail.com>
	<d89ddf300710301323h5a56b932h8304f42f5ae3fc6@mail.gmail.com>
Subject: Re: [Bluez-devel] multi-frequency scanning & possible contract work
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0902210894=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0902210894==
Content-Type: multipart/alternative;
	boundary="----=_Part_6854_17718369.1193803175511"

------=_Part_6854_17718369.1193803175511
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Brad,

I'm using the C libraries directly within my own code, so I do get the
piecemeal results, and have played with extended inquiry.  But I find that
it's still not fast enough, which was why I was hoping to try simultaneous
scanning with multiple dongles, or something like that to speed it up.

Do you know if bluez has enough low-level control over the usb device to do
something like that?  ie have two devices scanning different frequencies?
Or does the usb interface just have a high level 'start scanning' without
the low-level control that would be needed?

Paul

------=_Part_6854_17718369.1193803175511
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Brad,<br><br>I&#39;m using the C libraries directly within my own code, so I do get the piecemeal results, and have played with extended inquiry.&nbsp; But I find that it&#39;s still not fast enough, which was why I was hoping to try simultaneous scanning with multiple dongles, or something like that to speed it up.
<br><br>Do you know if bluez has enough low-level control over the usb device to do something like that?&nbsp; ie have two devices scanning different frequencies?&nbsp; Or does the usb interface just have a high level &#39;start scanning&#39; without the low-level control that would be needed?
<br><br>Paul<br><br>

------=_Part_6854_17718369.1193803175511--


--===============0902210894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0902210894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0902210894==--
