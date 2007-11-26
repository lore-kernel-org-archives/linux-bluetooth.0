Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <37666aa80711191548g5a63577ge13d215410c69fd0@mail.gmail.com>
References: <37666aa80711191548g5a63577ge13d215410c69fd0@mail.gmail.com>
Date: Mon, 26 Nov 2007 07:27:11 +0100
Message-Id: <1196058431.4217.83.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] is SDPd required for RFCOMM calls ?
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

Hi Han,

> I just started to use BlueZ to write bluetooth programs in C.  And I
> am using VMware based Ubuntu Linux.
> 
> I can do hci_inquiry successfully. But  when I tried to run a RFCOMM
> server program ( listen on channel 1).  The client always reports
> error : "Operation now in progress".
> 
> The same client can connect with no problem if i closed VMware +
> ubuntu and enable bluetooth in windows XP.
> 
> since the windows XP enables bluetooth & SDP services (Serial Port on
> RFCOMM channel 1),  i was wondering if SDP is required to do RFCOMM
> communication (on server side)  ?
> 
> or, is there anything else the server side need to do to accept the
> RFCOMM connections ?

start hcid -s and you get your SDP server.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
