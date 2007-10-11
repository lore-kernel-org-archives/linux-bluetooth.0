Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 12 Oct 2007 01:08:51 +0200
From: Radek (Fotopiper) <fotopiper@o2.pl>
To: bluez-devel@lists.sf.net
Message-ID: <20071012010851.1a1ffc7e@darkstar.example.net>
In-Reply-To: <20071011143418.65350112@darkstar.example.net>
References: <20071011143418.65350112@darkstar.example.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] RFCOMM - serial line looped back.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Thu, 11 Oct 2007 14:34:18 +0200
Radek (Fotopiper) <fotopiper@o2.pl> wrote:

> Hello,
> I'm getting a "Serial line is looped back." from pppd when I try to connect to
> the net threw my GSM phone.
> pppd 2.4.4
> kernel 2.6.22.8 (22.2 & 22.9 give the same results)
> Bluez 3.20 (libs&utils)
> Slacware 12
> 
> PPPD debug fallows "serial line looped back" and (at the end of mail) "LCP
> terminated by peer (peer refused to authenticate)".
> 
> Any suggestions what I am doing wrong?

Well I found a remedy, maybe someone else will benefit..
The serial line looped back if there was a problem connecting the ISP.. but the
main problem was the noauth option in pppd, as my ISP changed they configuration:
rcvd [LCP ConfReq id=0x1 <asyncmap 0xa0000> <auth pap>]
this line says that the peer (ISP) needs to authenticate (if anybody else
starts to look for a solution for a similar problem)..

Best regards to ALL, and sorry for the trouble

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
