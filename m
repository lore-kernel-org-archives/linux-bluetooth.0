Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Ramon A Reveron <ramon@us.ibm.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <OF0E2A126C.4B39339D-ON85256EE7.00754A22-85256EE7.0076A7D2@us.ibm.com>
References: 
	 <OF0E2A126C.4B39339D-ON85256EE7.00754A22-85256EE7.0076A7D2@us.ibm.com>
Content-Type: text/plain
Message-Id: <1091661380.16182.68.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-users] Re: Can't Connect RFCOMM Socket. Too many links.
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 05 Aug 2004 01:16:21 +0200

Hi Ramon,

> I'm having some problems while connecting to a serial profile device.
> If I connect to a device using:
> 
> rfcomm connect 0 "device address" 1
> 
> the connection works perfectly. If by some reason the device
> disconnects  (i.e. out of range), I need to wait around 50 seconds to
> reconnect to it providing that it is back in range. 
> If i try before the 50 seconds have pass, I get this error: "Can't
> Connect RFCOMM Socket. Too many links."
> 
> Is this a normal behavior?

maybe this is a link manager problem. Run "hcidump -x" to show us the
disconnect and the reconnect. What is the output of "hciconfig -a"?

> Is there a way of connecting to the device as soon as it comes back in
> range?  

Only if you start running an inquiry.

> How can you specify a "Link Timeout" with BlueZ? 

Check the Bluetooth specification for the appropriate HCI command.

> Kernel: 2.4.19
> BlueZ utils 2.3

You should update to 2.4.19-mh18 and bluez-utils-2.9 ;)

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
