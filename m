Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-Id: <200606140925.k5E9P2nZ026060@news01.csr.com>
To: bluez-users@lists.sourceforge.net
In-reply-to: <1150272891.7398.28.camel@johannes_01.kapune.local> 
References: <1150148335.7372.7.camel@johannes_01.kapune.local>
	<448DEA20.5000806@stfw.eu>
	<1150219383.7401.5.camel@johannes_01.kapune.local>
	<448EFA00.3030000@xmission.com>
	<1150272891.7398.28.camel@johannes_01.kapune.local>
Date: Wed, 14 Jun 2006 10:25:01 +0100
From: Peter Stephenson <pws@csr.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Can't play mp3, what I'm missing?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Johannes Kapune wrote:
> I'm not sure but I see in the "connection-display" that my headphone is
> master. Is this right or should it be slave?

It doesn't matter; the profiles above don't care.  There's actually a
power advantage to being master.  The difficulty comes if you need to
connect another device to the other end; then you end up in a scatternet
if that end is not the master, and that causes a considerable loss of
efficiency (and possibly worse).

-- 
Peter Stephenson <pws@csr.com>                  Software Engineer
CSR PLC, Churchill House, Cambridge Business Park, Cowley Road
Cambridge, CB4 0WZ, UK                          Tel: +44 (0)1223 692070


To access the latest news from CSR copy this link into a web browser:  http://www.csr.com/email_sig.php


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
