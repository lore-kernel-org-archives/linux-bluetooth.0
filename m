Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm receive problem and success
From: Marcel Holtmann <marcel@holtmann.org>
To: franz keuner <franz_keuner@gmx.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <18344.1080206436@www52.gmx.net>
References: <1080129568.2515.100.camel@pegasus>
	 <18344.1080206436@www52.gmx.net>
Content-Type: text/plain
Message-Id: <1080259105.2283.65.camel@pegasus>
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
Date: Fri, 26 Mar 2004 00:58:25 +0100

Hi Franz,

> that's maybe a stupid question:
> but why is there a error message if the bytes are received?

actually these is a test program and not for normal use. Maybe the code
is simply wrong. I never checked it and I don't really care. If you
fixed it, send me a patch.

> when i use the dump function i can work in my program with the data sended
> by the phone and no error.
> 
> when i try to use the receive function there's this error.
> 
> is the fault on the phone side and what can i do about it?
> does the receive function needs any additional information compared to the
> dump(read) function?

Compare the code of the recv and the dump functions and check what
happens. Look at it with hcidump to see if it is really an error.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
