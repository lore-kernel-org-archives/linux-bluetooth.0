Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Andreas Beck <becka-bzus@bedatec.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] No audio, just noise with btsco
Message-ID: <20050921211547.GA5201@uni-duesseldorf.de>
References: <43318946.1000506@chello.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43318946.1000506@chello.at>
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
Date: Wed, 21 Sep 2005 23:15:47 +0200

Roland Lezuo <roland.lezuo@chello.at> wrote:
> I have the following BT headset:

The more interesting question might be what dongle you have.

It may sound strange, but audio transmission is not supported for all
dongles.

As root(!) run "/usr/sbin/hciconfig hci0 revision"

it must say something like "SCO mapping:  HCI". If it doesn't say
anything about SCO _mapping_, the dongle is the problem. Don't get
confused with the SCO MTU that will always be displayed.

See also: http://bluetooth-alsa.sourceforge.net/ Section Discussion

> RFCOMM channel 1 connected
> ^^

Yeah - that's only control channel. Bit me, too.


CU, Andy


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
