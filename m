Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hci_acl_tx_to: hci0 ACL tx timeout, VIA USB HUBS
From: Marcel Holtmann <marcel@holtmann.org>
To: "t.[NO_SPAM]" <schorpp@gmx.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3FF9E3F2.4040506@gmx.de>
References: <3FF9E3F2.4040506@gmx.de>
Content-Type: text/plain
Message-Id: <1073393043.2508.50.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 06 Jan 2004 13:44:03 +0100

Hi Thomas,

> hi, yes i read the previous threads, this could be the well known 
> problems with the via usb chips ;), it does not occur with my older p2 
> machine. linux, pda and window$ clients kill my server after minutes:
> 
> 
> ^[[AJan  5 21:09:46 TOM1 kernel: hci_acl_tx_to: hci0 ACL tx timeout
> Jan  5 21:09:46 TOM1 kernel: hci_acl_tx_to: hci0 killing stalled ACL 
> connection DC:0F:A5:60:10:00
> Jan  5 21:22:47 TOM1 pand[5823]: Accept failed. Interrupted system call(4)
> Jan  5 21:53:36 TOM1 kernel: hci_acl_tx_to: hci0 ACL tx timeout
> Jan  5 21:53:36 TOM1 kernel: hci_acl_tx_to: hci0 killing stalled ACL 
> connection DC:0F:A5:60:10:00
> 
> same with the nokia affix stack.
> 
> cuurently i run a script detecting this error, resetting the bluetooth 
> and restarting the daemons automatically.
> 
> no nice way.
> 
> there should be a way to recover that fault better, but where to start?

why do you think that this is a BlueZ problem? What kernel do you use?
What do "hciconfig -a" say about your dongle?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
