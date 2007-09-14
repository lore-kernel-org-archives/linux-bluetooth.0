Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
In-Reply-To: <E21A90CDB9591542899EFC7FB4ED5CC90576575C@tfmail02.TFMAIL.COM>
References: <E21A90CDB9591542899EFC7FB4ED5CC90576575C@tfmail02.TFMAIL.COM>
Message-Id: <AE056821-FE53-4A5B-8761-81908AC41E70@cadvium.net>
From: robert <rbscott@cadvium.net>
Date: Thu, 13 Sep 2007 18:58:44 -0700
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] handsfree or headset support on pc
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

Hello Andrey Larin,

The Headset profile has two sides to it.  There is the Audio Gateway 
(AG) which is typically a cell phone, and then the Hands-Free unit (HF).

I think there has been a lot of development on the Audio Gateway(AG)  
side, because it is really useful to be able to play music on your  
computer and have it come out of your bluetooth headphones.

As far as I can tell(and someone please correct me if I am wrong),  
there are not as many projects dedicated to implementing the HF side,  
this is the side one of the projects i am working on is  
implementing.  Essentially there are two channels, the RFCOMM channel  
which essentially acts as the control channel, and then the SCO  
channel which is for sending audio data back and forth.  I wrote a  
program to handle RFCOMM channel and service discovery in java, and  
presently have a basic SCO manager (in c) for the SCO data and am  
working on a way to actually play it.

I hope to put the code online soon, but right now I am trying to  
learn how to use D-BUS in order to make the two parts communicate  
with one another.

Hope that helps,
--robert


On Sep 13, 2007, at 6:45 PM, guoyun wrote:

> Hi andrey larin
>
>> From your description,  the headset need to open visibility to be  
>> found. Hope this is not your tiny mistake. :-)
>
> Cheers
>
> -Gawain.
>
>
> ________________________________
>
> 	From: bluez-devel-bounces@lists.sourceforge.net [mailto:bluez- 
> devel-bounces@lists.sourceforge.net] On Behalf Of andrey larin
> 	Sent: Friday, September 14, 2007 4:49 AM
> 	To: BlueZ development
> 	Subject: Re: [Bluez-devel] handsfree or headset support on pc
> 	
> 	
> 	after all i see while serching
> 	i think this:
> 	
> 	currently software is able to handle this
> 	but requred some tuning
> 	
> 	but may be i wrong :)
> 	
> 	so i more interested in technical details
> 	
> 	if you could provide ... some :)
> 	
> 	or say that i wrong and there is requerd a lot of coding
> 	
> 	


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
