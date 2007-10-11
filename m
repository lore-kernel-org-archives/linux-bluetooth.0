Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 12 Oct 2007 01:16:36 +0200
From: Radek (Fotopiper) <fotopiper@o2.pl>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20071012011636.6bdbc9e5@darkstar.example.net>
In-Reply-To: <20071007230430.5910d417@darkstar.example.net>
References: <20071007230430.5910d417@darkstar.example.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] GPRS via BT,
	pppd says "Serial line is looped back."
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Sun, 7 Oct 2007 23:04:30 +0200
Radek (Fotopiper) <fotopiper@o2.pl> wrote:

> Hello to You all,
> I'm trying to connect to my GSM/GPRS/EDGE provider via a mobile with BT, on
> Linux side I'm using bluez (3.20), kernel (vanilla) 2.6.20.8 (or 20.9 makes
> little difference) and pppd 2.4.4.
> Unfortunately when I try to connect pppd announces:
> "Serial line is looped back." or "LCP terminated by peer (peer refused to
> authenticate)"
> The funny thing is that the same scripts worked well with kernel 2.6.20.2
> (about, don't remember exactly), Bluez 3.16 and pppd (an older verion) (and a
> bit different distribution - KateOS vs currently Slacware, but I suppose that's
> irrelevant).
> 
> What should I downgrade to have my notebook connected to the net on the go?
> kernel,pppd, bluez?
> Or maybe there is some better solution?

Well, there is a much better solution:
rcvd [LCP ConfReq id=0x1 <asyncmap 0xa0000> <auth pap>]
says that my ISP started to ask for username/password (they don't care what
will I provide, but they need something).
To put things short - I needed to change option noauth to user anything (plus
appropriate fields in pap/chap-secrets).

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
