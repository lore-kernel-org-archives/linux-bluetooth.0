Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <464194a50703150639u7d4869b7h76f5185fef01f2da@mail.gmail.com>
Date: Thu, 15 Mar 2007 15:39:16 +0200
From: "Zmej Gorianin" <mortagon.iyi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Is LMP implemented in BlueZ?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1261316540=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1261316540==
Content-Type: multipart/alternative;
	boundary="----=_Part_10661_1413930.1173965956237"

------=_Part_10661_1413930.1173965956237
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,
I am currently doing my bachelor's dissertation about creating an
alternative Bluetooth authentication and key exchange scheme, using public
key crypto, and would like to know whether I should build on top of the
Bluetooth protocol stack or I can actually add code inside the LMP.  I have
looked thorough the code in the BlueZ kernel module  and  In bluez -libs
package and I'm left with the impression that the link manager and the LMP
are part of the Bluetooth device's firmware, while the HCI asks it to
initiate specific LMP transactions. So my question is whether LMP is a
software component implemented by BlueZ on a computer or it's a firmware
component on the Bluetooth receiver connected to the computer. I'd be
thankful if somebody can clarify that for me.

Regards.

------=_Part_10661_1413930.1173965956237
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br>I am currently doing my bachelor&#39;s dissertation about creating an alternative Bluetooth authentication and key exchange scheme, using public key crypto, and would like to know whether I should build on top of the Bluetooth protocol stack or I can actually add code inside the LMP.&nbsp; I have looked thorough the code in the BlueZ kernel module&nbsp; and&nbsp; In bluez -libs package and I&#39;m left with the impression that the link manager and the LMP are part of the Bluetooth device&#39;s firmware, while the HCI asks it to initiate specific LMP transactions. So my question is whether LMP is a software component implemented by BlueZ on a computer or it&#39;s a firmware component on the Bluetooth receiver connected to the computer. I&#39;d be thankful if somebody can clarify that for me.
<br><br>Regards.<br>

------=_Part_10661_1413930.1173965956237--


--===============1261316540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1261316540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1261316540==--
