Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <404EC780.4070609@nue.et-inf.uni-siegen.de>
From: Michael Schmidt <schmidt@nue.et-inf.uni-siegen.de>
MIME-Version: 1.0
To: jessieh@MIT.EDU
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bd_addr question
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 10 Mar 2004 08:45:04 +0100

Hi Jessica,

> Sorry, I worded it poorly.  I'm a graduate student researching
> privacy issues related to Bluetooth, which I'm pretty new to.  I'm
> trying to work a way around the fact that each device address is
> unique therefore trackable.  I was wondering if I were to buy a
> Bluetooth transmitter and build my own device, can I change the
> bd_addr that is stored by the chip's manufacturer?  Which
> layer/module is in charge of reading that unique bd_addr?  I hope
> that makes more sense!

Check the source files of the AXIS OpenBT stack
(http://sourceforge.net/projects/openbt/) for vendor-specific commands 
on how to change the BD_ADDR of certain Ericsson and CSR modules (sorry, 
I forgot the precise files where these commands are located in). After 
performing the address change, you need to hard-reset (i.e. typically 
disconnect) the modules to make the change effective.

Keep in mind that you break some of the BT functionality when you use 
variable BD_ADDRs: The pairing-based security mechanisms (authentication 
and encryption) rely on a constant BD_ADDR. I guess there is more 
functionality that is affected by the change.


Hope this helps,

Michael


-- 
=================================================
Michael Schmidt
-------------------------------------------------
Institute for Data Communications Systems
University of Siegen, Germany
-------------------------------------------------
http:   www.nue.et-inf.uni-siegen.de/~schmidt/
e-mail: schmidt@nue.et-inf.uni-siegen.de
mobile: +49 179 7810214
=================================================


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
