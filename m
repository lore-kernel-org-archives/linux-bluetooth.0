Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A234FA.7020303@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] audio problems with a2play
References: <41A22C0B.4050008@xmission.com>
In-Reply-To: <41A22C0B.4050008@xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 22 Nov 2004 11:50:34 -0700

hey

> * how did you decide to put 2 0xff bytes in the CSRC section of the 
> media packet header? Why isn't this CSRC a multiple of 4 bytes like the 
> spec suggests on avdtp p. 46?
> 
> * what is the CSRC? (spec says "The CSRC list identifies the 
> contributing sources for the payload contained in this packet")

csrc wasn't the right thing to look into... the csrc count (cc) is 0, so 
if I'm reading this right, the two 0xff values are actually bleeding 
into the payload header and the first byte of the payload.

brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
