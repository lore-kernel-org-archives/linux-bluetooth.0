Return-Path: <crosser@average.org>
Subject: Re: [Bluez-devel] Re: Reproducible kernel oops on PPP session start
From: Eugene Crosser <crosser@average.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1073483871.2816.9.camel@pccross.average.org>
References: <1073475736.6998.9.camel@pccross.average.org>
	 <1073477754.2508.135.camel@pegasus>
	 <1073483871.2816.9.camel@pccross.average.org>
Content-Type: text/plain
Message-Id: <1073736024.7742.12.camel@pccross.average.org>
Mime-Version: 1.0
Date: Sat, 10 Jan 2004 15:00:24 +0300
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

With 2.6.1 out, I did some further investigation of the oops when
establishing PPP connection.  First of all, apparently oops happens on
7th attempt, after 6 successful sessions.  Next, I selected console VGA
mode with smaller font, and got the full Oops dump:

http://www.average.org/btoops/

(first picture is vanilla 2.6.1, second is 2.6.1-mh1)

As far as I can tell from analyzing the dump, and objdump of l2cap.o
object, BUG() happens when "sk_set_owner(sk, THIS_MODULE);" in
net/bluetooth/l2cap.c line 353 encounters zero refcount of the module. 
So, probably somebody incorrectly decreases the l2cap's refcount
elsewhere...

Any ideas on that?

Eugene
