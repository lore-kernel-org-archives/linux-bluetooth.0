Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Aug 2008 05:34:19 -0700 (PDT)
From: panca sorin <psihozefir@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <263494.3146.qm@web33613.mail.mud.yahoo.com>
Subject: [Bluez-users] How to make bluez create the bnep0 device?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0011447898=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0011447898==
Content-Type: multipart/alternative; boundary="0-1928881854-1219062859=:3146"

--0-1928881854-1219062859=:3146
Content-Type: text/plain; charset=us-ascii

I'm trying to connect my laptop to the Internet through my Sony-Ericsson K800i. The USB Internet connection is working and now I want to set my laptop up to use the bluetooth connection.
I was searching the Internet for a good howto for using bluez as PANU using the new configuration files without daemons, to no avail. Using pand I was able to get bnep0 created. A while back I found a statement saying something like "PANU is not supported, use NAP and/or GN." Is this still the case?
My phone insists on paying the NAP role.

Here is my current setup from relevant files:
sorin.p@sputnik ~ $ cut -d\# -f1 /etc/bluetooth/network.* | grep -v ^$
[General]
Disable=Server
[PANU Role]
Interface=bnep0
Script=dhcpcd
[Bluetooth Service]
Identifier=network
Name=Network service
Description=Bluetooth Personal Area Network service
Autostart=true

My laptop is running Gentoo Linux, with bluez-libs-3.36, bluez-utils-3.36 from portage on amd64.



      
--0-1928881854-1219062859=:3146
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman, new york, times, serif;font-size:12pt">
<div style="font-family: times new roman,new york,times,serif; font-size: 12pt;"><div>I'm trying to connect my laptop to the Internet through my Sony-Ericsson K800i. The USB Internet connection is working and now I want to set my laptop up to use the bluetooth connection.<br>I was searching the Internet for a good howto for using bluez as PANU using the new configuration files without daemons, to no avail. Using pand I was able to get bnep0 created. A while back I found a statement saying something like "PANU is not supported, use NAP and/or GN." Is this still the case?<br>My phone insists on paying the NAP role.<br><br>Here is my current setup from relevant files:<br>sorin.p@sputnik ~ $ cut -d\# -f1 /etc/bluetooth/network.* | grep -v ^$<br>[General]<br>Disable=Server<br>[PANU Role]<br>Interface=bnep0<br>Script=dhcpcd<br>[Bluetooth
 Service]<br>Identifier=network<br>Name=Network service<br>Description=Bluetooth Personal Area Network service<br>Autostart=true<br><br>My laptop is running Gentoo Linux, with bluez-libs-3.36, bluez-utils-3.36 from portage on amd64.<br></div></div></div><br>

      </body></html>
--0-1928881854-1219062859=:3146--


--===============0011447898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0011447898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0011447898==--
