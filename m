Return-Path: <cyrus@holtmann.org>
Message-Id: <CA77AEF1-2E8A-4EDB-A806-563338C34565@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <47F05CEF.8040300@aircable.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Mon, 31 Mar 2008 05:56:23 +0200
References: <47EDAEED.4000302@aircable.net>	<B8CF2082-9389-42C2-9518-CFA5F4F2E5A9@holtmann.org>	<47F059B9.5030003@aircable.net>
	<52DF986C-FC13-4F04-81F7-6A269B0EB0D1@holtmann.org>
	<47F05CEF.8040300@aircable.net>
Subject: Re: [Bluez-devel] CreateProxy usage?
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

Hi Manuel,

>> You can't really do that over D-Bus. Use the native RFCOMM sockets
>> from the Bluetooth library.
>>
> Ok if it's not there why not creating it? I can do it I think. Is  
> there
> any convention on how to do this? Any API proposal?
>
> I would say it should be something like:
> methods:
> listenRFcomm
> closeRFcomm
>
> signals:
> RFcommConnected
> RfcommDisconnected
>
> Does it make any sense at all? I would say that maybe not, but it  
> might
> be a good idea to have an rfcomm wrapper. Something that creates the
> rfcomm port, makes the connection and then just returns the rfcomm
> device. Ideas?

how do you wanna transfer the data? D-Bus is not for data transfer.

Regards

Marcel


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
