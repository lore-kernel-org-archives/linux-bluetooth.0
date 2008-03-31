Return-Path: <cyrus@holtmann.org>
Message-Id: <9ABEE439-610E-470F-AC7E-C2A611337022@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <47F0620F.8020606@aircable.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Mon, 31 Mar 2008 06:09:35 +0200
References: <47EDAEED.4000302@aircable.net>	<B8CF2082-9389-42C2-9518-CFA5F4F2E5A9@holtmann.org>	<47F059B9.5030003@aircable.net>	<52DF986C-FC13-4F04-81F7-6A269B0EB0D1@holtmann.org>	<47F05CEF.8040300@aircable.net>
	<CA77AEF1-2E8A-4EDB-A806-563338C34565@holtmann.org>
	<47F0620F.8020606@aircable.net>
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

>> how do you wanna transfer the data? D-Bus is not for data transfer
> Via a dev file the same way the rfcomm tool does, we just create
> /dev/rfcomm# or maybe new socket?
>
> I think the main idea is hiding the hole socket functionality, so  
> maybe
> creating a new socket for accessing to the established connection
> doesn't make any sense. But maybe creating a node on runtime and then
> telling the programmer over d-bus that the connection status makes  
> sense.
>
> Ideas? I don't think I'm fully out of the path.

go and write up a proper proposal for that API and make an  
implementation.

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
