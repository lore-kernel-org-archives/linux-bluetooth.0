Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Where does the L2CAP FCS was checked?
From: Marcel Holtmann <marcel@holtmann.org>
To: Wang Haiguang <wanghg@i2r.a-star.edu.sg>
Cc: bluez devel <bluez-devel@lists.sourceforge.net>
In-Reply-To: <LMEOKMJFKNFFHEAEDGDEGELLCGAA.wanghg@i2r.a-star.edu.sg>
References: <LMEOKMJFKNFFHEAEDGDEGELLCGAA.wanghg@i2r.a-star.edu.sg>
Content-Type: text/plain
Message-Id: <1083878149.4420.88.camel@pegasus>
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
Date: Thu, 06 May 2004 23:15:49 +0200

Hi Haiguang,

please stop sending emails in blue. Keep it plain 7 bit ASCII.

> I read the bluetooth specification of L2CAP. There is a FCS at the end
> of a L2CAP frame.
>  
> Could you please tell me in which fucntion this FCS is checked. 

the FCS is for L2CAP with retransmission and flow control which is part
of Bluetooth 1.2 and currently this feature is not supported by BlueZ.
And actually not by any other Bluetooth stack that I know of. So it is
checked nowhere.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
