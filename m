Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Project about Bluetooth Security: Request for
	assistance
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <002f01c4fd75$e647c280$19cb13ac@stu.nus.edu.sg>
References: <002f01c4fd75$e647c280$19cb13ac@stu.nus.edu.sg>
Content-Type: text/plain
Message-Id: <1106077737.8190.74.camel@pegasus>
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
Date: Tue, 18 Jan 2005 20:48:57 +0100

Hi Khoo,

> I have some questions about bluetooth security. 

I normally take money for these kind of answers ;)
 
> I am currently doing a project on bluetooth security and am required
> to develop some software (with bluetooth hardware) which can
> demonstrate bluetooth security weaknesses. 
>  
> Following are my ideas, please comment
>  
> 1. I have a silicon wave Bluetooth USB dongle and a V3 headset, and a
> Nokia 6600 smartphone. I desire to capture packets sent between the
> phone and the headset, without a bluetooth protocol analyser (eg from
> mobiwave), so that I can demostrate that a hacker can listen in to
> unencrypted voice traffic. Is this possible at all?

This is not possible. You need a protocol analyzer.
 
> hcidump is similar to a protocol analyser, but it can capture only
> high level traffic. My guess is that I can use hcitool scan to get the
> bluetooth address of the phone and the headset first, and then based
> on the addresses attempt to calculate the pseudo random frequency
> hopping sequence, so that I can stay in the same frequency as the
> phone and the headset. Problem is i don't understand the output of
> hcidump. Can hcidump capture traffic which does not belong to the host
> device? 

Even if hcidump would be able to do this, there is no normal Bluetooth
dongle available that can be a passive member of a piconet.
 
> 2. May I know the steps required to reproduce the work done by Adam
> Laurie (bluesnarfing) or the Flexilis team(bluesniper)? Will the test
> programs provided by the install of BlueZ be good as starting points?
> If so, which test program should I focus on? Please provide details if
> possible. This is purely for academic purposes. 

The bluesniper is hardware stuff. You simply change the antenna of your
Bluetooth dongle. For bluesnarfing and bluebugging, this can be done
with normal utils from the BlueZ distribution or CVS. Take a look at the
21C3 slides or my Portoroz presentation. There will be another one at
the FFG 2005 in Munich at the end of February.
 
> 3. For the program l2ping.c, what is the end result of the victim
> phone of running the program? Does it cause the phone to malfunction? 
>  
> I ran it and pinged my Sony Ericsson T630. Later my phone could not
> initiate a bluetooth connection with my headset. Otherwise everything
> else is fine. 

I haven't seen any phone vulnerable to the l2ping attack so far.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
