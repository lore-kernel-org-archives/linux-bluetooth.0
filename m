Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <1d49725d0704121242j7a278668gbea98b7bbc145b0b@mail.gmail.com>
Date: Thu, 12 Apr 2007 15:42:22 -0400
From: "Donnie Smith" <cwiid@abstrakraft.org>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Error connecting after inquiry
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0423071487=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0423071487==
Content-Type: multipart/alternative;
	boundary="----=_Part_12152_26103891.1176406942723"

------=_Part_12152_26103891.1176406942723
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

While it is a multi-threaded library, no other threads are started until
after the connection is made.

You raise a good point about checking the name for all devices.  Thanks.

We've narrowed the problem down to the hci_remote_name call - if we filter
on device class alone, and never request the name, the connection works.
Are there any connections opened by hci_remote_name that need to be
explicitly closed?  Would checking device class alone be sufficient?  From
what I've read, device class is determined by capabilities, and isn't
guaranteed to be unique to the Wiimote.

I'll take a look at the D-Bus API.


Thanks for your help,
Donnie

------=_Part_12152_26103891.1176406942723
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

While it is a multi-threaded library, no other threads are started until after the connection is made.<br><br>You raise a good point about checking the name for all devices.&nbsp; Thanks.<br><br>We&#39;ve narrowed the problem down to the hci_remote_name call - if we filter on device class alone, and never request the name, the connection works.&nbsp; Are there any connections opened by hci_remote_name that need to be explicitly closed?&nbsp; Would checking device class alone be sufficient?&nbsp; From what I&#39;ve read, device class is determined by capabilities, and isn&#39;t guaranteed to be unique to the Wiimote.
<br><br>I&#39;ll take a look at the D-Bus API.<br><br><br>Thanks for your help,<br>Donnie<br>

------=_Part_12152_26103891.1176406942723--


--===============0423071487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0423071487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0423071487==--
