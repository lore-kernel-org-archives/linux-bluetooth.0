Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001901c71318$6913da00$0600a8c0@PC581820463305>
References: <001901c71318$6913da00$0600a8c0@PC581820463305>
Date: Sun, 03 Dec 2006 14:54:06 +0100
Message-Id: <1165154046.19590.38.camel@localhost>
Mime-Version: 1.0
Cc: Vicky Sweetser <vicky.sweetser@smartsensorsystems.com>,
        Jay Johannes <jay.johannes@smartsensorsystems.com>,
        Les Hammer <les.hammer@smartsensorsystems.com>
Subject: Re: [Bluez-devel] Question about BlueZ and RFCOMM
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Dave,

> I have a question about using RFCOMM on BlueZ.  Here is our system:
> 
>    
>     Linux system with    <-----over the air------->  CSR BC03-MM chip and
>     CSR-based USB dongle                             the STMicroelectronics 
>                                                      STR710 ARM
> Microprocessor
>                                                      ("micro")
> 
> 
> We want to use the BlueZ RFCOMM library.  On the microprocessor side, I'm
> using the serial
> port of the CSR Bluetooth chip so I am able to monitor the serial data
> stream between the
> CSR Bluetooth chip and the microprocessor ("micro").
> 
> Most of the RFCOMM communication works fine.  On the micro side, I observe
> that the
> parameter negotiation happens OK and the RFCOMM connection is established.
> However,
> the data I try to send from the Linux system is never received by the micro.
> What
> happens instead is that the micro receives these commands from the Bluetooth
> chip
> (these are in CSR's format):
>                                 RFC_CONTROL_IND
>                                 RFC_RELEASE_IND
>                                 RFC_CLOSE_IND
>                                 DM_ACL_CLOSED_IND
> 
> I also observe that the Linux system, while connection is being established,
> is sending
> flow control messages (3, in my case) to the micro.  These are with a credit
> field of 
> 4, 5 and 6 for the 3 flow control messages.
> 
> Now to my question: Does the micro need to respond to these flow control
> messages in some
>                     manner to maintain the RFCOMM connection?  Currently the
> micro doesn't 
>                     respond to the flow control messages.
> 
> If it is OK for the micro to not respond to the flow control messages, can
> someone help me
> understand what else might be causing the RFCOMM data to not be sent from
> the Linxu system
> and what might be causing the RFCOMM connection to be closed down?

these question should be towards CSR, because you have problems with
their embedded RFCOMM stack. I have not enough insights to answer this
properly.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
