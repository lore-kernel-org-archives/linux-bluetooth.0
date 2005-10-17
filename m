Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510171437w1a668500kf963ae3acb55eb2f@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1410_1869561.1129585021377"
Subject: [Bluez-devel] [DBUS-PATCH] new signals(DeviceAdded and DeviceRemoved)
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
Date: Mon, 17 Oct 2005 19:37:01 -0200

------=_Part_1410_1869561.1129585021377
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi folks,

This patch add two new signals: DeviceAdded and DeviceRemoved.
These signals are sent in the path /org/bluez/Manager/Controller

I am accepting suggestions to change the path if someone think it can be
changed.
The signal "DeviceAdded" can't related to a device specific path (eg:
/org/bluez/Manager/hci0/Controller )
and put the "DeviceRemoved" signal in a different path is not a good idea.

If you notice a conflict with the lastest Johan's patch let me know that I
can create the patch again.

The handle_inq_req reply was fixed too, the return was wrong.

Regards,
Claudio.
--
---------------------------------------------------------
Claudio Takahasi
Nokia's Institute of Technology - INdT
claudio.takahasi@indt.org.br

------=_Part_1410_1869561.1129585021377
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi folks,<br>
<br>
This patch add two new signals: DeviceAdded and DeviceRemoved.<br>
These signals are sent in the path /org/bluez/Manager/Controller<br>
<br>
I am accepting suggestions to change the path if someone think it can be ch=
anged. <br>
The signal &quot;DeviceAdded&quot; can't related to a device specific path =
(eg: /org/bluez/Manager/hci0/Controller )<br>
and put the &quot;DeviceRemoved&quot; signal in a different path is not a g=
ood idea.<br>
<br>
If you notice a conflict with the lastest Johan's patch let me know that I =
can create the patch again.<br>
<br>
The handle_inq_req reply was fixed too, the return was wrong.<br>
<br>
Regards,<br>
Claudio.<br>
-- <br>---------------------------------------------------------<br>Claudio=
 Takahasi<br>Nokia's Institute of Technology - INdT<br><a href=3D"mailto:cl=
audio.takahasi@indt.org.br">claudio.takahasi@indt.org.br</a><br>

------=_Part_1410_1869561.1129585021377--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
