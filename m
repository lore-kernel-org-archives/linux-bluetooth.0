Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
In-Reply-To: <b5fcf2320709132217x50ce9cbbsb55bd39b4239db80@mail.gmail.com>
References: <E21A90CDB9591542899EFC7FB4ED5CC90576575C@tfmail02.TFMAIL.COM>
	<AE056821-FE53-4A5B-8761-81908AC41E70@cadvium.net>
	<b5fcf2320709132217x50ce9cbbsb55bd39b4239db80@mail.gmail.com>
Message-Id: <FC45259F-96B7-4513-B655-21C1AE4867CC@cadvium.net>
From: robert <rbscott@cadvium.net>
Date: Thu, 13 Sep 2007 23:22:34 -0700
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

so here is a sample of the c part that I am writing.  (from your  
description, it seems that you and I are doing something similar).   
This is a pretty primitive code sample, and there are examples 
(probably better) in bluez-utils that do similar things.   
Furthermore, this presently only handles the speaker, not the mic.   
The second part is an easy addition.

http://www.cadvium.net/files/source/sco-manager.tar.gz

  gpl

 > make
## basically, you start it up with a file. (the bluetooth address is  
ignored but should be formatted properly).
 > sco-manager <bluetooth-address> <file-name>

This will listen for an sco connection on the first bluetooth device  
that it finds.  It will then take any data that it receives and write  
it into the file specified on the command line.  (I think it also  
generates a tonne of debugging too).

This is more useful if you specify a pipe for the file:
 > mkfifo test.sco
## Setup voice correctly
 > sudo hciconfig hci0 voice 0x0060
 > cat test.sco | aplay -f S16 &
 > sco-manager <bluetooth-address> test.sco

At this point, if you make a call, it will send the audio through out  
your speakers.  (Make sure to turn them down, if something isn't  
setup properly it makes a terrible noise).

hope this helps,
--robert








On Sep 13, 2007, at 10:17 PM, andrey larin wrote:

> ok here is what i think:
> there is no problem to create and communicate rfcomm
>
> i don't know what connection must be make to control the audio 
> ( special rfcomm to audiogateway on phone or usual  rfcomm to ssp  
> on phone)
>
> must unreserched area is how to handle the audio managment ( open,  
> support ,close, route audio from pc microphone to phone ,from phone  
> to pc speakers)
>
>
> so
>
> when i connect on my phones spp
> and make call to my cell phone
> on terminal my phone says `RING`
> i need to command the to make an audio connection (SCO)
> and route this connections
>
> how to do this ?
>
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
