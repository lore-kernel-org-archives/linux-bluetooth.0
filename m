Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Host to Host Controller flow control
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <loom.20050325T125759-162@post.gmane.org>
References: <loom.20050324T175954-608@post.gmane.org>
	 <loom.20050325T100311-440@post.gmane.org>
	 <1111751283.9195.60.camel@pegasus>
	 <loom.20050325T125759-162@post.gmane.org>
Content-Type: text/plain
Message-Id: <1111753651.9195.74.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 25 Mar 2005 13:27:31 +0100

Hi Catalin,

> > the host to host controller flow control means that we tell the chip to
> > use flow control. This is the other way around and we don't support it
> > at the moment, because it is easy for us to handle big packets. If you
> > enable host to host controller flow control you need to tell the chip
> > when you are ready to receive more packets.
> 
> Ok, but I think what we are missing then is called "host controller to host flow
> control" or as in the specification "flow control... in the direction from the
> Host Controller to the Host". Even the command that enables this is called
> Set_Host_Controller_To_Host_Flow_Control.
> 
> Correct me if I am wrong, but I think you should update the TODO list to say

I looked it up in the Bluetooth 2.0 specification and it is now called
Set_Controller_To_Host_Flow_Control and this means that the todo list
should talk about "Host Flow Control", because this is what is missing.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
