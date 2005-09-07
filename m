Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Hcidump stays in waiting state after RFCOMM "PN
	CMD" packet
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1301.193.48.73.126.1126082483.squirrel@webmail.essi.fr>
References: <200509071002.26456.cijoml@volny.cz>
	 <1301.193.48.73.126.1126082483.squirrel@webmail.essi.fr>
Content-Type: text/plain
Message-Id: <1126082971.29676.43.camel@blade>
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
Date: Wed, 07 Sep 2005 10:49:31 +0200

Hi Steve,

> I do a message again but I don't know what to do... I spent three days to
> read bluez archives and Marcel pieces of advice but I still don't know if
> my bluetooth trace is normal... After several connections, hcidump waits
> there :
> 
> > ACL data: handle 41 flags 0x02 dlen 18
>     L2CAP(d): cid 0x0041 len 14 [psm 3]
>       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
>       dlci 2 frame_type 0 credit_flow 15 pri 0 ack_timer 0
>       frame_size 319 max_retrans 0 credits 0
> < ACL data: handle 41 flags 0x02 dlen 8
>     L2CAP(d): cid 0x0041 len 4 [psm 3]
>       RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
> 
> I can't find anything relating to PN CMD on the Internet... Could you help
> me please ? Could you recommend me a document to read in order to
> understand ? I'm completely without more ideas to solve this problem :'(

what you see is an request for using RFCOMM channel 1 and the other
sides rejects it. Check if you really have a service running on that
channel.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
