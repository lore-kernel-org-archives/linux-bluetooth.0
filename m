Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <5f30e2610412090915395a1747@mail.gmail.com>
From: Jeff Wilson <jazzbotley@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] newb request
In-Reply-To: <1102611436.9988.237.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <5f30e2610412090850b7f5f85@mail.gmail.com>
	 <1102611436.9988.237.camel@pegasus>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 9 Dec 2004 11:15:21 -0600

On Thu, 09 Dec 2004 17:57:16 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jeff,
> 
> I think what you really wanna do is using L2CAP or RFCOMM as transport
> layers and so better look a l2test.c and rctest.c files.
> 
> Regards
> 
> Marcel
> 

Thank you for your prompt reply!

Sorry, I was not very clear about that part.  I use RFCOMM for the
transport.  (It's been a couple of months since I wrote "Hello
World".)  You are correct; I used rctest.c as my guide for that.

My frustration is trying to understand more about HCI.  I'm sure there
is no way around a steep learning curve -- my objective is to get as
fine-tuned control as possible over the INQUIRY and INQUIRY_SCAN
modes.  I want two nodes (with zero prior knowledge of each other) to
be able to discover each other and exchange messages within a couple
of seconds.

   Thanks again for your time,
     Jeff


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
