Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] auto pairing between client & server
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <2621d9af05042603075410e639@mail.gmail.com>
References: <2621d9af05042213064d0df1dc@mail.gmail.com>
	 <1114205889.10706.9.camel@pegasus>
	 <2621d9af05042603075410e639@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1114514920.10706.201.camel@pegasus>
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
Date: Tue, 26 Apr 2005 13:28:40 +0200

Hi,

> Thanks for replying. I'm using an old version of BlueZ stack, which
> link key file is a binary file. I know we have a new thread talking
> about changing this file to ascii. Since my product is already in
> development phase, I can't wait until the new BlueZ release coming out
> to use that feature.

actually there should be no problem to upgrade, because nobody
complained about any problems so far.

> Do you know any tool that can go and extract the content of the link
> key file from binary to readable format ascii? (That's how I should
> verify the pairing state in the link key file, right?)

With an easy answer, yes. If you have a link key, then you are paired.
However I don't know of any tool that extracted the binary link key file
format to an ASCII based version.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
