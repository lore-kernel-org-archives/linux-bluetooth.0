Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <446A4BD6.2060102@fh-wolfenbuettel.de>
From: Goetz Issel <g.issel@fh-wolfenbuettel.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: Re: [Bluez-devel] infineon adapter init
References: <20060516152903.0BCF7ED51@sc8-sf-spam2.sourceforge.net>
In-Reply-To: <20060516152903.0BCF7ED51@sc8-sf-spam2.sourceforge.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Wed, 17 May 2006 00:01:58 +0200

bluez-devel-request@lists.sourceforge.net wrote:

Hi Brad, hi Marcel,

>Hi Bra#d,
>  
>
>>Is anyone using infineon's singlestone pba31307 with bluez?
>>
>>Gumstix just updated their stick with this chip but it comes online at
>>115k and they can't get it to switch to 921kbps... that's the best rate
>>their xscale can do but the chip is changing to some other rate out of
>>range when they try the switch to 921k.
>>    
>>
>I tried to get a development kit from Infineon and additional
>information about their chips, but I never succeeded.
>
>  
>
we do have the mentioned dev-kit at work, sorry, I can not give it to 
you. I am trying to figure out a way to get the exact same chip to work 
properly as well. So far I do have the bt-hardware running, connected 
via ttyS, using no special initialisation sequence. It is possible 
though, that the hardware already "preprogrammed" and it does now run 
with 115k, the speed I want to use anyway. I will see if I can test the 
921k with it if my time allows that in between, no promise.

I do have a list of init sequences (hci) here but it does not make much 
sense to me, the device work fine without any specific things.

I used the bluez-utils..hciattach,hcitool to get the device up, scan for 
other bt devices and even connect to them. my who system freezes whe  i 
want to get the name of a designated bt device address. (hcitool name 
xx:xx:xx:xx:xx), but using the hcitool scan work.. which also gives the 
names.

Maybe I can give you a name to contact at Infineon, Marcel, to get a kit 
for your dev. work, email me direct for that !

Regards,
Goetz


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
