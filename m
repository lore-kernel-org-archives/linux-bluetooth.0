Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5E13F596-B867-4C0D-9795-97D93507474C@infitsrl.com>
References: <5E13F596-B867-4C0D-9795-97D93507474C@infitsrl.com>
Date: Tue, 27 Nov 2007 09:25:53 +0100
Message-Id: <1196151954.17196.15.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] (no subject)
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

Hi Fabrizio,

if you wanna get any real attention on this mailing list, you better
fill in a subject. I tend to quickly delete messages without a subject.

> I made a simple software to send small pictures to all bluetooth  
> devices in range (it's used by a museum ).
> This software is made in C using bluez api, I've used two bluetooth  
> dongles : one to make periodic inquiry (not with HCI periodic inquiry  
> command by with a loop) and the other to make sdp query looking for  
> obex push service and sending image.
> My requirement was to use this software in some embedded linux based  
> computer so I chose to limit external library, I made all using  
> pthread so there is an infinite thread for inquiries and one thread  
> to handle every sdp query and relative connection when devices are  
> discovered. I've discarded also using python or other scripting  
> languages for the platfom limitations.
> 
> All works but I found it not so efficient, also with 6/7 devices it's  
> really slow to identify and connect to devices, some times connection  
> are unexpectedly closed and so on....

A lot of people tried to make this work and there are ways to make it
work as efficient as possible. However you need an understanding on how
the Bluetooth radio and baseband are working and what the limits are.
For example using one or two threads doesn't give anything useful. This
is the wrong approach to start with. No excuses. You are simply blocking
the baseband with your random attempts. It is also better to use
periodic inquiry or explicitly cancel an inquiry when you wanna page the
remote device for a SDP query. It also makes sense to use the class of
device to a pre-filter on remote devices that actually support object
transfer.

Run a "hcidump -X -V" during your scans and connect attempts and you see
the errors that will present themself when you try to page during an
inquiry. The kernel takes care of a lot of stuff, but it is not psychic.

> Is it my approch to the problem wrong or bluetooth protocol is not  
> suitable for this type of use?

Do you have any choice when it comes to communicate with mobile phones?

> I'm using libs version 3.7-1 (on debian 4.0)

The latest version is 3.22 :)

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
