Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP retransmission, flow control
From: Imre Deak <imre.deak@nokia.com>
To: Bluez-Devel <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1107957983.13863.37.camel@pegasus>
References: <1107934854.9489.4.camel@mammoth.research.nokia.com>
	 <1107938887.13863.4.camel@pegasus>
	 <1107940961.9489.32.camel@mammoth.research.nokia.com>
	 <1107944306.13863.15.camel@pegasus>
	 <1107955473.9489.37.camel@mammoth.research.nokia.com>
	 <1107957983.13863.37.camel@pegasus>
Content-Type: text/plain
Message-Id: <1107968685.10764.3.camel@mammoth.research.nokia.com>
Mime-Version: 1.0
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
Date: Wed, 09 Feb 2005 19:04:45 +0200

On Wed, 2005-02-09 at 15:06 +0100, ext Marcel Holtmann wrote:
> if you select SOCK_SEQPACKET and set the mode to flow control and
> retransmission then this must be negotiated and on success this can be
> used.
> 
> For SOCK_STREAM only the flow control is really needed, but also having
> retransmission whould be great.

Ok, thanks for elaborating this.

--Imre



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
