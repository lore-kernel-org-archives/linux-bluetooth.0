Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] UART bluetooth chip problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <7846f1440512191354t20d8a079u86a5be319453cc9b@mail.gmail.com>
References: <7846f1440512071711x6c56c8er24edb8e3a8815ab9@mail.gmail.com>
	 <1134087822.17592.44.camel@blade>
	 <7846f1440512090946n58fbf3e8gfecd3ebeb270bf58@mail.gmail.com>
	 <1134154036.10644.18.camel@blade>
	 <7846f1440512091123p5abce553gff0ef4658bc5ee45@mail.gmail.com>
	 <1134158505.10644.22.camel@blade>
	 <7846f1440512121021s65b57be7g30673fa6090df057@mail.gmail.com>
	 <1134416630.429.4.camel@blade>
	 <7846f1440512121306he45d777q72550620a293eab@mail.gmail.com>
	 <1134422296.429.18.camel@blade>
	 <7846f1440512191354t20d8a079u86a5be319453cc9b@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1135033114.5236.1.camel@localhost>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 19 Dec 2005 23:58:34 +0100

Hi Arthur,

> I have tried using PStool over UART. I have a seperate mini circuit
> board that connects to the chip via UART and I connect to that circuit
> board via parallel port. However, I haven't tried the UART on the
> system that I'm trying to connect to the chip to. I did some
> investigation by adding printf statements in the hciattach source code
> and recompiled it. It seems like the initialization stalls when it is
> trying to read from the UART fd. 
> 
> I used csr as the type. It hangs in the read_hci_event function within
> the csr function. It seems like UART is working as I can write to the
> file descriptor opened, but it is not getting any response back from
> the chip after the (GET_BUILD_ID) command is written to the UART. 
> 
> Would there be some different command I need to send? Or would the
> chip is not a csr chip? Or being able to write without failing still
> doesn't show that the UART is working on the system? 

I think your UART is not configured correctly. Ask your Bluetooth module
manufacturer to help you. Or make it work with Windows and PSTool over
the UART and we can work from there on.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
