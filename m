Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <22b6c3510706280736h6367a25eiac4918c0f80497a2@mail.gmail.com>
Date: Thu, 28 Jun 2007 22:36:40 +0800
From: "Benjamin Fong" <benjamin.backup@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] hcid defunct
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2036104761=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============2036104761==
Content-Type: multipart/alternative;
	boundary="----=_Part_58978_32946717.1183041400343"

------=_Part_58978_32946717.1183041400343
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I've written a program which periodically invokes hcitool scan, and
following that propagate out content via obex to the acquired bluetooth
address. I've noticed something remarkably strange occuring throughout the
process. The program which I'd written is invoked immediately after boot.
I'd noticed when I "ps -e" my system, there are a couple of defunct hcid
processes. These defunct hcid jobs are immediately visible right after boot
and the amount of defunct hcid process will to continue grow until the
entire bluetooth service is stuffed. Once the bluetooth srvice is stuffed,
if I were to invoke either hcitool or sdptool...I would get a "connection
timeout" reply. The only way to remedy the situation is to periodically
restart the bluetooth service, once the service is restarted - all of the
defunct hcid process will be cleared.

Btw I'm running Bluez-utils and bluez-libs 3.10.1 on both Fedora 6 and 7
(issue is replicatable on both system). I've multiple dongles, but only 1
dongle dedicated to scanning. Any idea, guys?

Regards,
Ben

------=_Part_58978_32946717.1183041400343
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;</div>
<div>I&#39;ve written a program which periodically invokes hcitool scan, and following that propagate out content via obex to the acquired bluetooth address. I&#39;ve noticed something remarkably strange occuring throughout the process. The program which I&#39;d written is invoked immediately after boot. I&#39;d noticed when I &quot;ps -e&quot; my system, there are a couple of defunct hcid processes. These defunct hcid jobs are immediately visible right after boot and the&nbsp;amount of defunct hcid process&nbsp;will to continue grow until the entire bluetooth service is stuffed. Once the bluetooth srvice is stuffed, if I were to invoke either hcitool or sdptool...I would get a &quot;connection timeout&quot; reply. The only way to remedy the situation is to periodically restart the bluetooth service, once the service is restarted - all of the defunct hcid process will be cleared.
</div>
<div>&nbsp;</div>
<div>Btw I&#39;m running Bluez-utils and bluez-libs 3.10.1 on both Fedora 6 and 7 (issue is replicatable on both system). I&#39;ve multiple dongles, but only 1 dongle dedicated to scanning. Any idea, guys?</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Ben</div>

------=_Part_58978_32946717.1183041400343--


--===============2036104761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============2036104761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============2036104761==--
