Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <473BF56D.8010301@szift.org>
Date: Thu, 15 Nov 2007 08:29:49 +0100
From: =?ISO-8859-2?Q?=A3ukasz_Hejnak?= <szift@szift.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] LAN over bluetooth connection hangs
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi
I've got a problem with the LAN over bluetooth functionality.
I've got two bluetooth usb dongles and two linux machines, one of which =

is connected to the internet. The idea was simply to connect the second =

machine via bluetooth to the internet.
The basic instructions that I found at =

http://fedoranews.org/contributors/muhammad_al_ismail/bluetooth/
work... but not exactly.

I mean I get the connection established, the firewall is set up, icmp =

packets are passing ok, but when I try getting anything else over the =

connection (like when I fire up my browser, or even connect via ssh and =

do some stuff that needs more bandwidth, display dmesg for example) it =

stalls. Nothing else can get trough (not even ICMP). Everything else =

seems in order:
link quality is 255, the connection according to hcitool is established, =

bnep0 devices are visible on both ends, but what I get in the logs of =

the client machine is:
hci_acldata_packet: hci0 ACL packet for unknown connection handle 266

The valid connection handle as displayed by `hcitool con` is 1
Can anybody help me?
Is this a (cheap) hardware problem or maybe just some misconfiguration?
The dongles are the ever so popular BlueSoleil.

-- =

Pozdrawiam
=A3ukasz 'Szift' Hejnak
jid: Szift@jabster.pl
email: Lukasz@Hejnak.pl

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
