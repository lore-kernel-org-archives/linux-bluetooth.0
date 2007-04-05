Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4614A31C.4010806@free2move.net>
Date: Thu, 05 Apr 2007 09:19:56 +0200
From: Markus Adolfsson <markus.adolfsson@free2move.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------030508090306020008000008"
Subject: [Bluez-devel] How to set packet-type and role from source-code?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030508090306020008000008
Content-Type: multipart/alternative;
	boundary="------------060000000509080202050601"


--------------060000000509080202050601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I need to set SCO packet type to HV1 as well as I'd like to specify that 
my device should be the "master" in a SCO connection. I known that I can 
do this from the command-line using the hci* utilities, but I'd like to 
set the packet-types to a known state when I initialize my application 
(from code) and I'm sorry to say that I cannot find /how/ to go about 
and to that...

It has to be possible, but I've search through the hci_lib but without 
success - yet ;)
Could someone point me in the right direction?

Much appreciated!
/Markus Adolfsson

-- 
------------------------------------------------------------------------
*Markus Adolfsson*
M.Sc.CE. Product Development
Mail: 	markus.adolfsson@free2move.net 
<mailto:markus.adolfsson@free2move.net>
Phone: 	+46 35 152268 <callto:+4635152268>
Mobile: 	+46 707 165296 <callto:+46707165296>

	
*Free2move AB* -- /WIRELESS MADE EASY/
Phone: 	+46 35 152260 <callto:+4635152260>
Fax: 	+46 35 152269 <callto:+4635152269>
Web: 	www.free2move.net <http://www.free2move.net>
Address: 	Sperlingsgatan 7
SE-30248 Halmstad
Sweden


--------------060000000509080202050601
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi all,<br>
<br>
I need to set SCO packet type to HV1 as well as I'd like to specify
that my device should be the "master" in a SCO connection. I known that
I can do this from the command-line using the hci* utilities, but I'd
like to set the packet-types to a known state when I initialize my
application (from code) and I'm sorry to say that I cannot find <i>how</i>
to go about and to that...<br>
<br>
It has to be possible, but I've search through the hci_lib but without
success - yet ;)<br>
Could someone point me in the right direction?<br>
<br>
Much appreciated!<br>
/Markus Adolfsson<br>
<br>
<div class="moz-signature">-- <br>
<hr>
<table width="100%">
  <tbody>
    <tr>
      <td align="left" valign="top" width="50%">
      <table>
        <tbody>
          <tr>
            <td colspan="2"><b>Markus Adolfsson</b></td>
          </tr>
          <tr>
            <td colspan="2">M.Sc.CE. Product Development</td>
          </tr>
          <tr>
            <td align="left" valign="top">Mail:</td>
            <td><a href="mailto:markus.adolfsson@free2move.net">markus.adolfsson@free2move.net</a></td>
          </tr>
          <tr>
            <td align="left" valign="top">Phone:</td>
            <td><a href="callto:+4635152268">+46 35 152268</a></td>
          </tr>
          <tr>
            <td align="left" valign="top">Mobile:</td>
            <td><a href="callto:+46707165296">+46 707 165296</a></td>
          </tr>
        </tbody>
      </table>
      </td>
      <td align="left" valign="top" width="50%">
      <table>
        <tbody>
          <tr>
            <td colspan="2"><b>Free2move AB</b> -- <i>WIRELESS MADE
EASY</i></td>
          </tr>
          <tr>
            <td align="left" valign="top">Phone:</td>
            <td><a href="callto:+4635152260">+46 35 152260</a></td>
          </tr>
          <tr>
            <td align="left" valign="top">Fax:</td>
            <td><a href="callto:+4635152269">+46 35 152269</a></td>
          </tr>
          <tr>
            <td align="left" valign="top">Web:</td>
            <td><a href="http://www.free2move.net">www.free2move.net</a></td>
          </tr>
          <tr>
            <td align="left" valign="top">Address:</td>
            <td>Sperlingsgatan 7<br>
SE-30248 Halmstad<br>
Sweden</td>
          </tr>
        </tbody>
      </table>
      </td>
    </tr>
  </tbody>
</table>
</div>
</body>
</html>

--------------060000000509080202050601--

--------------030508090306020008000008
Content-Type: text/x-vcard; charset=utf-8;
 name="markus.adolfsson.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="markus.adolfsson.vcf"

begin:vcard
fn:Markus Adolfsson
n:Adolfsson;Markus
org:Free2move;Product Development
adr:;;Sperlingsgatan 7;Halmstad;;302 48;Sweden
email;internet:markus.adolfsson@free2move.net
title:M.Sc.C.E.
tel;work:+46 35 152268
url:http://www.free2move.net
version:2.1
end:vcard


--------------030508090306020008000008
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------030508090306020008000008
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------030508090306020008000008--
