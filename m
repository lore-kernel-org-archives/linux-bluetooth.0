Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <412D99CA.5050209@nue.et-inf.uni-siegen.de>
From: Michael Schmidt <schmidt@nue.et-inf.uni-siegen.de>
MIME-Version: 1.0
To: philip@lawatsch.at
CC: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Limit communication to serveral devices
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Thu, 26 Aug 2004 10:05:30 +0200

Hi Philip,

> Call me paranoid but I would like to know if there is any way to limit 
> all types of communication to just several devices by checking with the 
> hardware addresses.
> 
> I understand that in principle not being discoverable and the pin 
> challenge should help you with being secure but to me this is not enough.
> 
> I'm currently running 2 class 1 devices to serve my flat with rfcomm for 
> dial in and I for sure do not want anyone besides me to get access to 
> these com ports.
> 
> Is there anything I can do to tighten security and limit all 
> communication to just some devices?
> 
> I do understand that even this is no guarantee for anything, but I'd for 
> sure feel better  :) 

When assessing your level of security (and evaluating address 
filtering), keep in mind that it's not too difficult to masquerade BT 
device addresses. You only neeed to look up the Axis OpenBT stack source 
code to figure out how to adjust the device address of certain Ericsson 
and CSR-based modules.

Clearly, your main line of defense should be a strong BT PIN.


Cheers,

Michael


-- 
===========================================
Michael Schmidt
-------------------------------------------
Institute for Data Communications Systems
University of Siegen, Germany
===========================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
