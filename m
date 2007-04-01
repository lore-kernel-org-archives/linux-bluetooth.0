Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY124-W139C835870F41AFA3D794AF0620@phx.gbl>
References: <BAY124-W139C835870F41AFA3D794AF0620@phx.gbl>
Date: Sun, 01 Apr 2007 09:01:55 +0200
Message-Id: <1175410915.23136.64.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Multithread Service Discovery
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

Hi Robert,

> I spent some time this afternoon playing around with multithreading an
> SDP enquiry, whilst i've almost got it working, when i use the loop to
> initiate the threads they all seem to get their arguments mixed up, so
> when i loop through the join i get the wrong details returned, they
> all list the same mac address but with different channels,
> unfortunately i'm away from my code at the moment so cant post any
> samples.
>  
> Basically i'm trying to do a device discovery, and then SDP each of
> the devices to obtain the obex channel, which i can then use to push a
> file to, and i'm looking to have it do this as quickly as possible.

if you only have one Bluetooth adapter then you have to do SDP service
search for one device at a time. There is no other way. You can't do
this simultaneous. Period. And explained why.

> What would you recommend the best method for something like this? At
> the moment i'm using a C program, a large amount of the code from it
> is stripped out of an excellent article written by Albert Huang found
> here http://people.csail.mit.edu/albert/bluez-intro/c401.html.
>  
> I note that a lot of people recently have been talking about the D-Bus
> API, is this something i should perhaps be using? does it suite my
> requirements?

The D-Bus API makes this a lot easier since it takes care of all the
stuff that otherwise you have to think about. For example the different
Bluetooth versions etc. You can also sort the device list after inquiry
via the RSSI to check the devices near by you first.
 
> I've looked through the API documentation and it appears to have some
> excellent functions, however as novice C programmer, I'm a little bit
> lost as to where i might start with integrating the API into my
> application.

The bluez-utils source package contains enough examples on how to use
D-Bus within C code. However it is faster to use it from within Python.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
