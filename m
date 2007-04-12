Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 12 Apr 2007 11:13:38 +0100
From: Peter Stephenson <pws@csr.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-Id: <20070412111338.184671cf.pws@csr.com>
In-Reply-To: <46150ADA.1000503@gmx.de>
References: <46150ADA.1000503@gmx.de>
Mime-Version: 1.0
Subject: Re: [Bluez-users] raw mode
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

S. Vandersee" <seb42@gmx.de> wrote:
> Dear list,
> 
> if I simply change the product ID of my CSR dongle from
> 0a12:0001 to 0a12:0002 hciconfig will report "RAW" as device
> mode after rebooting:
>
>....
> 
> Does the Bluetooth drivers only assume it must be a raw mode
> because of the product ID? Or is there a "real" raw mode detected?
> And if there is such a raw mode how can raw frames be retrieved?

As far as the device is concerned, PID 1 is the only one that supports normal Bluetooth operation.  As it happens, PID 2 is used by Frontline Test Equipment for
their Bluetooth sniffer, which wouldn't work unless you had the right firmware, so
this is not useful.  (This is a slightly different question to what Bluez does
with a "funny" PID, but the answer to "does the device have clever handling
for PID 2" is "no".)

-- 
Peter Stephenson <pws@csr.com>                  Software Engineer
CSR PLC, Churchill House, Cambridge Business Park, Cowley Road
Cambridge, CB4 0WZ, UK                          Tel: +44 (0)1223 692070


To access the latest news from CSR copy this link into a web browser:  http://www.csr.com/email_sig.php

To get further information regarding CSR, please visit our Investor Relations page at http://ir.csr.com/csr/about/overview

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
