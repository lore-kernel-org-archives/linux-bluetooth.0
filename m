Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Hunyue Yau <hyau@mvista.com>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 5 Nov 2007 12:29:00 -0700
References: <C3253C26-5411-4469-9623-4156F952620B@cadvium.net>
In-Reply-To: <C3253C26-5411-4469-9623-4156F952620B@cadvium.net>
MIME-Version: 1.0
Message-Id: <200711051129.00874.hyau@mvista.com>
Subject: Re: [Bluez-devel] Transmitting and Receiving SCO data
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Saturday 03 November 2007 09:03, robert wrote:
> Hello,
> 
> I am trying to write a program that just sends and receives SCO data,  
> and I am running into some problems during the transmit phase.   
> Whenever I try to stream out SCO data, the bluetooth dongle is  
> disconnected from the system, which sometimes just closes the  
> connection, but other times it crashes the whole machine.  (the  
> program doing the transmitting inevitably crashes).

Hi,

This sounds a lot like a problem I debugged recently. Is the bluetooth
dongle on USB? Also what platform (x86 or ???)? What brand and 
chipset (if known) is the dongle?

No one has replied or commented on my post but if you look in the
archives, I have a set of patches that works around/fixes it for me. It 
would be good to confirm I am not the only seeing this problem.

-- Hunyue
> 
> Is there something special that is required for sending SCO data?  I  
> have looked at all of the test programs and none of them seem to do  
> anything odd.  I am limiting the writes to the MTU size on the  
> connection, but I am writing multiple times in a row.  (another test  
> program seems to do this)
> 
> the code is a little convoluted but I can post a link to it if anyone  
> is interested.
> 
> cheers,
> robert
> 
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
