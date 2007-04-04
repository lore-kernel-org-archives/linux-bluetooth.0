Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <461360B4.1030509@free2move.net>
Date: Wed, 04 Apr 2007 10:24:20 +0200
From: Markus Adolfsson <markus.adolfsson@free2move.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------050701020204030300040305"
Subject: [Bluez-devel] Troubles with mulitple SCO connections (duplex)
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
--------------050701020204030300040305
Content-Type: multipart/alternative;
	boundary="------------090500000407040008020609"


--------------090500000407040008020609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I'd like to establish two SCO connections simultaneously using BlueZ 
from my "coordinator" application that in the long run will connect / 
mix the two SCO connections to let two headsets hear each other, as well 
as letting the master controller-application I'm writing to hear both 
headsets...

The app itself is fairly straight forward and I've gotten everything to 
work properly besides one little tiny detail - One SCO connection works 
fine, but once I connect the second SCO connection, all SCO connections 
goes down (without any error from the socket / connect commands)...

Both SCO-connections are still there, the headsets only hear "noise" and 
I have the fealing that the two headsets don't send any audio, but that 
they _do receive_ on the SCO connections... Strange!

Is this a packet-type issue and if so - how can I set the packet-types 
from "within" the BlueZ lib / my app?

Regards,
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


--------------090500000407040008020609
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
I'd like to establish two SCO connections simultaneously using BlueZ
from my "coordinator" application that in the long run will connect /
mix the two SCO connections to let two headsets hear each other, as
well as letting the master controller-application I'm writing to hear
both headsets...<br>
<br>
The app itself is fairly straight forward and I've gotten everything to
work properly besides one little tiny detail - One SCO connection works
fine, but once I connect the second SCO connection, all SCO connections
goes down (without any error from the socket / connect commands)...<br>
<br>
Both SCO-connections are still there, the headsets only hear "noise"
and I have the fealing that the two headsets don't send any audio, but
that they <u>do receive</u> on the SCO connections... Strange!<br>
<br>
Is this a packet-type issue and if so - how can I set the packet-types
from "within" the BlueZ lib / my app?<br>
<br>
Regards,<br>
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

--------------090500000407040008020609--

--------------050701020204030300040305
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


--------------050701020204030300040305
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------050701020204030300040305
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------050701020204030300040305--
