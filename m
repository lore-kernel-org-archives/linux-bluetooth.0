Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: gfpadovan@gmail.com
In-Reply-To: <6b53b1990904281214y304fd3dav6ca79e7905e7c5d5@mail.gmail.com>
References: <6b53b1990904251605s75ad3478v987d3fc47e2bc318@mail.gmail.com>
	 <1240929768.3441.5866.camel@localhost.localdomain>
	 <1240933237.997.37.camel@localhost.localdomain>
	 <1240936070.3441.5901.camel@localhost.localdomain>
	 <1240937363.997.47.camel@localhost.localdomain>
	 <6b53b1990904281214y304fd3dav6ca79e7905e7c5d5@mail.gmail.com>
Date: Wed, 29 Apr 2009 05:42:47 -0300
Message-ID: <6b53b1990904290142u12165c30me531912137534e22@mail.gmail.com>
Subject: Re: GSoC 2009: L2CAP Enhanced Retransmission mode
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: ngh@isomerica.net, Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, Barry Reinhold <bbr@lampreynetworks.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nathan and Marcel,

I'm working on add the initial constant change to upstream. Until now
I have squashed your 6 first commits and have made change on it.

http://www.las.ic.unicamp.br/~gustavo/git/?p=bluetooth-testing.git;a=commit;h=a75b529b5e70ecbbe4dd56527300bf2d4b95de2f

 A little report and some question about it:

1. I Removed the L2CAP features bits that we won't use now. I'm
supposing that we are going to implement ERTM, Streaming mode and FCS
Option.

2. What did you mean with  "__u16    mtu_cnl;" ( first patch, I
think)? connectionless MTU?


3. #define L2CAP_MODE_DEFAULT    L2CAP_MODE_ENH_RETRANS
I think that we can't default this now, because de code goes to
upstream, same for L2CAP_FCS_DEFAULT.

4.
@@ -1711,12 +1715,25 @@ static int l2cap_build_conf_req(struct sock
*sk, void *data)
...
+       if (pi->mode != L2CAP_MODE_BASIC) {
+               rfc.mode = pi->mode;
+               rfc.txwin_size = L2CAP_DEFAULT_RX_WINDOW;
+               rfc.max_transmit = L2CAP_DEFAULT_MAX_RECEIVE;
+               rfc.retrans_timeout =
cpu_to_le16(L2CAP_DEFAULT_RETRANS_TIMEOUT);
+               rfc.monitor_timeout =
cpu_to_le16(L2CAP_DEFAULT_MONITOR_TIMEOUT);
+               rfc.max_pdu_size = cpu_to_le16(L2CAP_DEFAULT_MAX_RX_APDU);
+
+               l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc), &rfc);
+       }

That's wrong. pi->mode == L2CAP_MODE_ENH_RETRANS it's better.
txwin_size, max_transmit, retrans_timeout and monitor_timeout should
be 0 in L2CAP_MODE_STREAMING.




Probably my changes broke up all other commit and we will need to
apply then manually, but also we need to revert the l2cap.c split, so
the code will get broke either way.

We need still separate the code in logical and bisectable commits. I
think that we can put a first commit only with the constants
definitions, and then, other commit with all the other mode
negotiation ( just for ERTM or ERTM and streaming mode) and just  then
put the first code for sending and receive packets. What do you think?

Also I propose we implement things by parts. First ERTM, then
Streaming mode and by the end, FCS Option.



On Tue, Apr 28, 2009 at 4:14 PM, Gustavo F. Padovan
<gustavo@las.ic.unicamp.br> wrote:
> Hi Nathan,
>
> Your work will be very useful on My GSoC. We can work together on
> implementing ERTM. I was just starting to study how to do mode
> negotiaton. I'll stop it and go look through your code to understand
> it and start coding something.
>
> I think we need a TO DO list of ERTM stuff with the things that left
> to implement and the this Marcel suggested. First I think that we need
> do changes suggested by Marcel to push the to upstream. After we can
> concentrate on the issues left to implement. I'm planning to start
> this tonight.
>
> First I need to study your code, then we can discuss it more. I need
> to learn many things about l2cap and ERTM yet =).
>
> Are you around #bluez on freenode?
>
> Regards.
>



-- 
Gustavo F. Padovan
http://padovan.org
