Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <1089265279.40ecde7f12156@imp.webmail.hku.hk>
From: h0016530@hkusua.hku.hk
To: James Cameron <james.cameron@hp.com>
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Questions about Role Changing during PAN setup
References: <1089262620.40ecd41c49ef3@imp.webmail.hku.hk> <20040708052744.GG18689@hp.com>
In-Reply-To: <20040708052744.GG18689@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Thu,  8 Jul 2004 13:41:19 +0800

I did like this:

server(PC):
#modprobe l2cap
#modprobe bnep
#sdpd
#hcid
#hciconfig hci0 up
#pand --listen --role NAP --service --sdp --master
#pand --connect 00:02:C7:18:25:A0
#ifconfig bnep0 10.0.0.1 

client(iPAQ, familiar linux):
#pand --listen --role PANU
#ifconfig bnep0 10.0.0.2

How about you? Thank you very much.

Katie

Quoting James Cameron <james.cameron@hp.com>:

> On Thu, Jul 08, 2004 at 12:57:00PM +0800, h0016530@hkusua.hku.hk wrote:
> > I'm using PAN daemon version 1.1rc2. 
> 
> I'm using version 2.7.
> 
> > The role of server is always "PANU" after I have tried to declare and
> > change it to NAP by "pand --listen --role NAP --service --sdp
> > --master" and "pand --listen --role NAP". This is what I got: 
> > # pand --show
> > bnep0 00:02:C7:18:25:A0 PANU
> 
> When I use "pand --listen --role NAP", and then establish a connection,
> I get;
> 
> # pand --show
> bnep0 00:02:72:01:E5:F5 NAP
> 
> -- 
> James Cameron
> Software Security Response Team
> HP Services, Asia Pacific
> 






-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
