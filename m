Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] L2CAP retransmission, flow control
From: Imre Deak <imre.deak@Nokia.com>
To: Bluez-Devel <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1107944306.13863.15.camel@pegasus>
References: <1107934854.9489.4.camel@mammoth.research.nokia.com>
	 <1107938887.13863.4.camel@pegasus>
	 <1107940961.9489.32.camel@mammoth.research.nokia.com>
	 <1107944306.13863.15.camel@pegasus>
Content-Type: text/plain
Message-Id: <1107955473.9489.37.camel@mammoth.research.nokia.com>
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
Date: Wed, 09 Feb 2005 15:24:33 +0200

On Wed, 2005-02-09 at 11:18 +0100, ext Marcel Holtmann wrote:
> If SOCK_STREAM is requested and RFC negotiation fails, then also the
> connection must fail. For SOCK_STREAM you need flow control.
>
> For SOCK_DGRAM and SOCK_RAW we don't do anything. The SOCK_DGRAM is for
> connection-less channels and SOCK_RAW gives access to the signal channel
> itself.
> 
> If you use SOCK_SEQPACKET (current type) and mode > 0 then negotiate RFC
> and if success then use it, otherwise fail.
> 

Thanks, it got clearer now.
Shouldn't we support the flow control only mode, so without
retransmission? For SOCK_SEQPACKET and a specific mode value for
example.

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
