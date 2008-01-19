Return-Path: <cyrus@holtmann.org>
Message-ID: <5eee8c670801191136p604d5a84jbc1284a47bd86334@mail.gmail.com>
Date: Sat, 19 Jan 2008 19:36:06 +0000
From: "Odysseus Flappington" <deriziotis@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Bluetooth dongle not reconnecting
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1359181537=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1359181537==
Content-Type: multipart/alternative;
	boundary="----=_Part_7188_15931834.1200771366312"

------=_Part_7188_15931834.1200771366312
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I've got an Edimax EB-DGC2 USB 2.0 bluetooth dongle running on Ubuntu
7.10with kernel
2.6.22-14-generic.

I can pair my MS Intellimouse bluetooth mouse, but hidd can never re-connect
after I reboot. The same thing happens with my Apple Bluetooth keyboard (the
old one which is fully hid compatible). If I don't reboot, but let the
devices sleep, they re-establish their connections automatically. It's only
after rebooting that they can't reconnect.

I've tested both devices on my laptop and they both automatically reconnect
after rebooting without any modifications to configuration files with the
same OS and configuration.

Things I've tried:
- After rebooting, I try to re-connect manually using sudo hidd --connect
[MAC]. It gives me the following error:

Can't get device information: Operation already in progress

- When I do a dmesg after rebooting and without actually attempting to
initiate the connection using hidd --connect (however, I guess it would
already be automatically trying to reconnect), I can see a ton of the
following error messages coming up:

[  119.934706] hci_acldata_packet: hci0 ACL packet for unknown connection
handle 42

Since everthing works fine on my laptop with the same configuration, the
issue has to be with the bluetooth dongle itself. Either there's a problem
with its driver, or there's a problem with the hardware. So, three
questions:

1) Is there anything else that I need to do to further diagnose this
problem? More output needed?
2) Who do I report this problem to in order to get this issue fixed for
everyone? Kernel developer who maintains bluetooth dongle drivers?
3) Are there any immediate solutions I can try? I saw something about
flashing the dongle's firmware.. Is this a possibility? Any other
suggestions? Could always just buy a new dongle.

Thanks very much,
Alex Deriziotis

------=_Part_7188_15931834.1200771366312
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I&#39;ve got an Edimax EB-DGC2 USB 2.0 bluetooth dongle running on Ubuntu 7.10 with kernel 2.6.22-14-generic.<br><br>I can pair my MS Intellimouse bluetooth mouse, but hidd can never re-connect after I reboot. The same thing happens with my Apple Bluetooth keyboard (the old one which is fully hid compatible). If I don&#39;t reboot, but let the devices sleep, they re-establish their connections automatically. It&#39;s only after rebooting that they can&#39;t reconnect.
<br><br>I&#39;ve tested both devices on my laptop and they both automatically reconnect after rebooting without any modifications to configuration files with the same OS and configuration.<br><br>Things I&#39;ve tried:<br>

- After rebooting, I try to re-connect manually using sudo hidd --connect [MAC]. It gives me the following error:<br><br>Can&#39;t get device information: Operation already in progress<br><br>- When I do a dmesg after rebooting and without actually attempting to initiate the connection using hidd --connect (however, I guess it would already be automatically trying to reconnect), I can see a ton of the following error messages coming up:
<br><br>[&nbsp; 119.934706] hci_acldata_packet: hci0 ACL packet for unknown connection handle 42<br><br>Since everthing works fine on my laptop with the same configuration, the issue has to be with the bluetooth dongle itself. Either there&#39;s a problem with its driver, or there&#39;s a problem with the hardware. So, three questions:
<br><br>1) Is there anything else that I need to do to further diagnose this problem? More output needed?<br>2) Who do I report this problem to in order to get this issue fixed for everyone? Kernel developer who maintains bluetooth dongle drivers?
<br>3) Are there any immediate solutions I can try? I saw something about flashing the dongle&#39;s firmware.. Is this a possibility? Any other suggestions? Could always just buy a new dongle.<br><br>Thanks very much,<br>

Alex Deriziotis<br><br>

------=_Part_7188_15931834.1200771366312--


--===============1359181537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1359181537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1359181537==--
