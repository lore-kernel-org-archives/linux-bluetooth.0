Return-Path: <bluez-devel-admin@lists.sourceforge.net>
In-Reply-To: <IJTM7X$1B27DB0B4797131F8B5DE564475869A0@libero.it>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Help with bluez pairing problem!!
MIME-Version: 1.0
Message-ID: <OFCD672CBF.223600E5-ON48257042.003FA24E-48257042.004003DB@zte.com.cn>
From: gao.yingbin@zte.com.cn
Content-Type: multipart/alternative; boundary="=_alternative 004003D548257042_="
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 18 Jul 2005 19:40:53 +0800

This is a multipart message in MIME format.
--=_alternative 004003D548257042_=
Content-Type: text/plain; charset="US-ASCII"

Hi!andrea,
 you just need modify some codes in bluez-utils-2.1x/hcid/security.c, 
about saving of linkkeys.
 
-------------------------------------------------------------------
Hi to all,

i have a problem with pairing in a scenario where a pc tries to push (via 
obex) a file to a cell phone. I set up all my environment and all works 
fine, on my cell the PC PIN is requested and after i enter it the file is 
trasmitted and all goes fine. But i ve this kind of problem:

After the first authentication i still need (for my project requirementes) 
that next pushes to the cell ask again for PIN. To do this i think i 
suppose i need to delete (on my cell phone side or on my pc side) the 
authentication info. I need to do it on my pc, but how can i 
programmatically delete a pairing entry from the link_key file ?

thansk for every kind of help !

Andrea


***********************************************
信息安全声明：本邮件包含信息归ZTE所有，
ZTE对该邮件拥有所有权利。请接收者注意
保密，未经发件人书面许可，不得向任何第
三方组织和个人透露本邮件所含信息的全部
或部分。以上声明仅适用于工作邮件。
Information Security  Notice：
The information contained in this mail is
solely property of  ZTE Corporation. 
This mail communication is confidential.
Recipients named above are obligated to
maintain secrecy and are not permitted to
disclose the contents of this communication
to others.
***********************************************

--=_alternative 004003D548257042_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2><tt>Hi!andrea,</tt></font>
<br><font size=2><tt>&nbsp;you just need modify some codes in bluez-utils-2.1x/hcid/security.c,
about saving of linkkeys.</tt></font>
<br><font size=2><tt>&nbsp; &nbsp;</tt></font>
<br><font size=2><tt>-------------------------------------------------------------------</tt></font>
<br><font size=2><tt>Hi to all,<br>
<br>
i have a problem with pairing in a scenario where a pc tries to push (via
obex) a file to a cell phone. I set up all my environment and all works
fine, on my cell the PC PIN is requested and after i enter it the file
is trasmitted and all goes fine. But i ve this kind of problem:<br>
<br>
After the first authentication i still need (for my project requirementes)
that next pushes to the cell ask again for PIN. To do this i think i suppose
i need to delete (on my cell phone side or on my pc side) the authentication
info. I need to do it on my pc, but how can i programmatically delete a
pairing entry from the link_key file ?<br>
<br>
thansk for every kind of help !<br>
<br>
Andrea</tt></font><br><br><br>
***********************************************<br>
信息安全声明：本邮件包含信息归ZTE所有，<br>
ZTE对该邮件拥有所有权利。请接收者注意<br>
保密，未经发件人书面许可，不得向任何第<br>
三方组织和个人透露本邮件所含信息的全部<br>
或部分。以上声明仅适用于工作邮件。<br>
Information&nbsp;Security&nbsp;&nbsp;Notice：<br>
The&nbsp;information&nbsp;contained&nbsp;in&nbsp;this&nbsp;mail&nbsp;is<br>
solely&nbsp;property&nbsp;of&nbsp;&nbsp;ZTE&nbsp;Corporation.&nbsp;<br>
This&nbsp;mail&nbsp;communication&nbsp;is&nbsp;confidential.<br>
Recipients&nbsp;named&nbsp;above&nbsp;are&nbsp;obligated&nbsp;to<br>
maintain&nbsp;secrecy&nbsp;and&nbsp;are&nbsp;not&nbsp;permitted&nbsp;to<br>
disclose&nbsp;the&nbsp;contents&nbsp;of&nbsp;this&nbsp;communication<br>
to&nbsp;others.<br>
***********************************************<br>

--=_alternative 004003D548257042_=--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
