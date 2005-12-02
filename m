Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Vendor Specific Commands
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <A35A8D03A748B34A9DA2AB0335A3F93D40838F@rfsdmail.internal.rfmd.com>
References: 
	 <A35A8D03A748B34A9DA2AB0335A3F93D40838F@rfsdmail.internal.rfmd.com>
Content-Type: text/plain
Message-Id: <1133548786.20834.89.camel@blade>
Mime-Version: 1.0
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
Date: Fri, 02 Dec 2005 19:39:46 +0100

Hi Jatin,

> Thanks for the response. I am using RFMD chipset, but I don't think it
> matters. The reason I need vendor specific commands/events support is
> for cases where there is no non volatile memory present and the host
> needs to send down configurations using vendor specific commands. An
> example of such a case would be mobile phone environment, where the
> host uses these to do simple things like write Bluetooth address or
> complicated things like configure registers.
> 
> I know that general framework for these commands/events are already
> supported, but what I am trying to find is the right place to do this
> (which is the first thing that should  happen) and for that I am
> trying to understand the BlueZ model.

this depends on. Send me the programming manual for the RFMD chip and
then I can tell you more. Are we talking about UART or USB connection to
host?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
