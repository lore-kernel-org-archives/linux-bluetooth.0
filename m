Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] UART bluetooth chip problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <7846f1440512121306he45d777q72550620a293eab@mail.gmail.com>
References: <7846f1440512071711x6c56c8er24edb8e3a8815ab9@mail.gmail.com>
	 <1134074044.17592.13.camel@blade>
	 <7846f1440512081510w4ffff8cdoe25ae369e677144@mail.gmail.com>
	 <1134087822.17592.44.camel@blade>
	 <7846f1440512090946n58fbf3e8gfecd3ebeb270bf58@mail.gmail.com>
	 <1134154036.10644.18.camel@blade>
	 <7846f1440512091123p5abce553gff0ef4658bc5ee45@mail.gmail.com>
	 <1134158505.10644.22.camel@blade>
	 <7846f1440512121021s65b57be7g30673fa6090df057@mail.gmail.com>
	 <1134416630.429.4.camel@blade>
	 <7846f1440512121306he45d777q72550620a293eab@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1134422296.429.18.camel@blade>
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
Date: Mon, 12 Dec 2005 22:18:16 +0100

Hi Arthur,

> I tried the using the BCSP as the protocol and set the
> PSKEY_UART_CONFIG_BCSP value as 0806, however, when I tried to attach
> the chip again, using:
> 
> hciattach -s 115200 /dev/ttyS1 bcsp 115200 noflow
> 
> I get BCSP initialization error. I tried using flow too but that
> doesn't help. Finally, I used "any" for the type again and the
> hciattach worked. However when i run hciconfig hci0 up i get another
> connection timed out. :(
> 
> I have absolutely no idea what might be wrong... :( Hope you have some
> clues. 

I have no clue, because I don't know the settings of this module. The
any identifier is too stupid to detect a working UART, but the csr and
bcsp identifiers will do this. Maybe your UART is broken. Can you use
PSTool over the UART?

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
