Return-Path: <cyrus@holtmann.org>
Message-ID: <482F8ED1.3030900@earthlink.net>
Date: Sat, 17 May 2008 21:05:05 -0500
From: "Mumia W.." <paduille.4061.mumia.w+nospam@earthlink.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <482AB4AD.50803@earthlink.net>	<1210844479.7025.35.camel@violet.holtmann.net>	<482C1DEE.8000405@earthlink.net>
	<1210858654.7025.48.camel@violet.holtmann.net>
In-Reply-To: <1210858654.7025.48.camel@violet.holtmann.net>
Content-Type: multipart/mixed; boundary="------------060604060102060601070400"
Subject: Re: [Bluez-users] Anycom USB-250 unseen by hcitool
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------060604060102060601070400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

On 05/15/2008 08:37 AM, Marcel Holtmann wrote:
> Mumia wrote:
>>
>> Hmm, "hcitool" still doesn't see my bluetooth dongle:
> 
> hciconfig hci0 up :)
> 
> Regards
> 
> Marcel
> 

Thanks Marcel, but the network connection still doesn't work.

I do this:
hcid
sdpd
dund --nodetach --listen --persist --msdun call palm

And then I tell my Palm E2's bluetooth system to search for a network 
connection, but the E2 never finds anything, and "dund" never displays 
anything other than "dund[3984]: Bluetooth DUN daemon version 3.7."

How do I get dund communicating with my PDA?

Here is a listing of my /etc/bluetooth directory:
total 12
-rw-r--r-- 1 root root 1272 2008-05-17 07:18 hcid.conf
-rw-r--r-- 1 root root    5 2008-05-17 20:44 pin
-rw-r--r-- 1 root root  396 2008-05-17 07:49 rfcomm.conf

I've attached my hcid.conf, pin, and rfcomm.conf. Please help me get my 
adapter working.

P.S.
I've been looking at this document: 
http://howto.pilot-link.org/bluesync/ga.html . I follow the procedures, 
but I never get any messages from dund like those in the document.



--------------060604060102060601070400
Content-Type: text/plain;
 name="hcid.conf.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcid.conf.txt"

#
# HCI daemon configuration file.
#

# HCId options
options {
	# Automatically initialize new devices
	autoinit yes;

	# Security Manager mode
	#   none - Security manager disabled
	#   auto - Use local PIN for incoming connections
	#   user - Always ask user for a PIN
	#
	# security user;
	security auto;

	# Pairing mode
	#   none  - Pairing disabled
	#   multi - Allow pairing with already paired devices
	#   once  - Pair once and deny successive attempts
	pairing multi;

	# Default PIN code for incoming connections
	passkey "1234";
}

# Default settings for HCI devices
device {
	# Local device name
	#   %d - device id
	#   %h - host name
	# name "%h-%d";
	name "mybluetooth";

	# Local device class
	class 0x3e0100;

	# Default packet type
	#pkt_type DH1,DM1,HV1;

	# Inquiry and Page scan
	iscan enable; pscan enable;

	# Default link mode
	#   none   - no specific policy 
	#   accept - always accept incoming connections
	#   master - become master on incoming connections,
	#            deny role switch on outgoing connections
	lm accept;

	# Default link policy
	#   none    - no specific policy
	#   rswitch - allow role switch
	#   hold    - allow hold mode
	#   sniff   - allow sniff mode
	#   park    - allow park mode
	lp rswitch,hold,sniff,park;
}

--------------060604060102060601070400
Content-Type: text/plain;
 name="pin.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pin.txt"

1234

--------------060604060102060601070400
Content-Type: text/plain;
 name="rfcomm.conf.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rfcomm.conf.txt"

#
# RFCOMM configuration file.
#

#rfcomm0 {
#	# Automatically bind the device at startup
#	bind no;
#
#	# Bluetooth address of the device
#	device 11:22:33:44:55:66;
#
#	# RFCOMM channel for the connection
#	channel	1;
#
#	# Description of the connection
#	comment "Example Bluetooth device";
#}

rfcomm0 {
	bind yes;
	device **:**:**:**:**:**;
	channel 1;
	comment "My Bluetooth device";
}


--------------060604060102060601070400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------060604060102060601070400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--------------060604060102060601070400--
