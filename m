Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4540B313.1000302@gmail.com>
Date: Thu, 26 Oct 2006 10:07:31 -0300
From: Manuel Naranjo <naranjo.manuel@gmail.com>
MIME-Version: 1.0
To: Bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Changes to BlueZ has brooken an App
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi:
I'm trying to compile the AvetanaBT package, and can't make it compile =

with BlueZ 3.7. I have tried with BlueZ 3.4 and it compiled perfectly.
Gcc tells me:
....
ISO C++ forbids declaration of =91sdp_cstate_t=92 with no type
...
BlueZ.cpp:1961: error: =91cstate=92 was not declared in this scope
....
BlueZ.cpp:1988: error: =91sdp_cstate_t=92 was not declared in this scope
....
BlueZ.cpp:2123: error: =91sdp_cstate_t=92 was not declared in this scope
BlueZ.cpp:2123: error: =91cstate=92 was not declared in this scope

So apparently sdp_cstate and cstate has gone away, moved or changed =

name. I would like to know which was the change, and where can I find a =

changelog so I don't need to bother you with stupid questions
Manuel Naranjo

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
