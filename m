Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] patch-2.6.7-mh
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200412020151.06979.gillan82@centrum.cz>
References: <200412011538.19225.gillan82@centrum.cz>
	 <200412011553.16649.gillan82@centrum.cz>
	 <1101913242.15615.11.camel@pegasus>
	 <200412020151.06979.gillan82@centrum.cz>
Content-Type: text/plain
Message-Id: <1101970920.15615.69.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 02 Dec 2004 08:02:00 +0100

Hi Gillan,

> I tried to do it by myself, but I'm too lame for that. Have anybody this patch 
> on locale? I'm looking for patch-2.6.7-mhX.gz .. thanks.

the latest one for 2.6.7 is -mh4. Besides the test patches these are the
ones that are missing between 2.6.7-mh4 and 2.6.9-mh4:

  o Check checksums for BNEP
  o Don't send L2CAP reject command for bad responses
  o Don't use ISOC transfers for Broadcom dongle
  o Stop TX task before notifying the driver
  o Add security manager flags and options
  o Add module parameter for disabling ISOC transfers
  o Let the CAPI free the SKB in the error case
  o Fix race when unlinking incoming connections
  o Improve connection hash handling
  o Allow vendor specific packet types
  o Fix another disconnect race
  o Ignore the BPA 100/105 devices
  o Add security callback to the core
  o Send HCI_Reset for new Microsoft dongle
  o Check for L2CAP reliability
  o Add support for L2CAP secure mode
  o Correct locking for zero SCID responses
  o Update copyright information
  o Some trivial s/int/unsigned int/
  o Make some functions static
  o Support responses with zero SCID
  o Add function for triggering a link key change
  o Use usb_kill_urb() for synchronous unlink
  o Fix connection hash bug

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
