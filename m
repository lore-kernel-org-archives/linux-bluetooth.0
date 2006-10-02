Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <3f5a9ba20610020946v10c99300pee5cc04f3f2597e6@mail.gmail.com>
Date: Tue, 3 Oct 2006 00:46:16 +0800
From: "Mingfan.Lu" <lucharse@gmail.com>
To: Bluez-devel@lists.sourceforge.net
In-Reply-To: <3f5a9ba20609291930r5b4e4c97g8b33901666fef491@mail.gmail.com>
MIME-Version: 1.0
References: <3f5a9ba20609291930r5b4e4c97g8b33901666fef491@mail.gmail.com>
Subject: [Bluez-devel] About the kernel 2.6.18
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0168699523=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0168699523==
Content-Type: multipart/alternative;
	boundary="----=_Part_49246_399080.1159807576522"

------=_Part_49246_399080.1159807576522
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

All,

   My oepnsuse 10.1 with the default kernel 2.6.16.13-4.
   When 2.6.18-mh3 released, I rebuilt and updated the kernel to 2.6.18 and
then patched it.
   When Holtman released the patch for handling multiple l2cap connections,
I patched the new kernel .
   But at last, I found that the speed of  the OBEX pushing and other Rfcomm
socket communications is slower than the original kernel.
   Then I rebuilt the 2.6.18 without the 2.6.18-mh3 and the patch for
handling multiple l2cap connections, I found it is still slower.
   So I think the patch is not the reason.
   But what makes the bluetooth communication slower? The new kernel version
2.6.18?

   Waiting for your help;

-- 
With respects,
   Mingfan.Lu

------=_Part_49246_399080.1159807576522
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><span class="gmail_quote"><br></span>
<div>All,</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp; My oepnsuse 10.1 with the&nbsp;default&nbsp;kernel 2.6.16.13-4.</div>
<div>&nbsp;&nbsp; When 2.6.18-mh3 released, I rebuilt and updated the kernel to 2.6.18 and then patched it.</div>
<div>&nbsp;&nbsp; When Holtman released the patch for handling multiple l2cap connections, I patched the new kernel .</div>
<div>&nbsp;&nbsp; But at last, I found that the speed of &nbsp;the OBEX pushing and other Rfcomm socket communications is slower than the original kernel.</div>
<div>&nbsp;&nbsp; Then I rebuilt the 2.6.18 without the 2.6.18-mh3 and the patch for handling multiple l2cap connections, I found it is still slower.</div>
<div>&nbsp;&nbsp;&nbsp;So I think the patch is not the reason.</div>
<div>&nbsp;&nbsp;&nbsp;But what makes the bluetooth communication slower? The new kernel version 2.6.18?</div>
<div>&nbsp;&nbsp; </div>
<div>&nbsp;&nbsp; Waiting for your help;</div>
<div><br>-- <br>With respects,<br>&nbsp;&nbsp; Mingfan.Lu </div><br clear="all">

------=_Part_49246_399080.1159807576522--


--===============0168699523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0168699523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0168699523==--
