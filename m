Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: James Cameron <james.cameron@hp.com>
To: h0016530@hkusua.hku.hk
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Questions about Role Changing during PAN setup
Message-ID: <20040708052744.GG18689@hp.com>
References: <1089262620.40ecd41c49ef3@imp.webmail.hku.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1089262620.40ecd41c49ef3@imp.webmail.hku.hk>
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
Date: Thu, 8 Jul 2004 15:27:44 +1000

On Thu, Jul 08, 2004 at 12:57:00PM +0800, h0016530@hkusua.hku.hk wrote:
> I'm using PAN daemon version 1.1rc2. 

I'm using version 2.7.

> The role of server is always "PANU" after I have tried to declare and
> change it to NAP by "pand --listen --role NAP --service --sdp
> --master" and "pand --listen --role NAP". This is what I got: 
> # pand --show
> bnep0 00:02:C7:18:25:A0 PANU

When I use "pand --listen --role NAP", and then establish a connection,
I get;

# pand --show
bnep0 00:02:72:01:E5:F5 NAP

-- 
James Cameron
Software Security Response Team
HP Services, Asia Pacific


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
