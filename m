Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Nokia 6230: "pairing and conn. rejected for
	security reasons"
From: Marcel Holtmann <marcel@holtmann.org>
To: Lutz Pressler <Lutz.Pressler@SerNet.DE>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <E1BPzXe-0005fC-00@intern.SerNet.DE>
References: <E1BPzXe-0005fC-00@intern.SerNet.DE>
Content-Type: text/plain
Message-Id: <1084868892.5833.45.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 18 May 2004 10:28:12 +0200

Hi Lutz,

> In contrast to Nokia 6310i, I'm not able to pair my Nokia 6230 (firmware
> 3.15) and bluez (two 2.4 systems tried, one beeing SuSE 9.0 with
> kernel 2.5.21-251 and bluez-utils-2.3-57, bluez-libs-2.4-31).

please run "hcitool info <bdaddr-6230>" for me, so I can put this phone
on my list.

> After entering the correct pin (giving the wrong one yields other error)
> in the phone's pairing dialogue, the 6230 only aborts with
> "pairing and conn. rejected for security reasons".

Run "hcidump -x" as root and show us the part of connection creation and
the request for the link key.

> hcid.conf is more or less default, works with 6310i and can be sent on
> request.

If it is not default then show it to us.

> Acer USB adapter (vend/prod 0xb7a/0x7d0).

What is the output of "hciconfig -a". What version of the Acer dongle is
this?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
