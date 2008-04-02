Return-Path: <cyrus@holtmann.org>
Message-Id: <6D44E8E4-9EA0-4061-BCA4-F4CE4C8E6577@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <014501c894ca$28e9e160$6701a8c0@freqonedev>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Wed, 2 Apr 2008 18:25:17 +0300
References: <200803290830.16736.dstockwell@frequency-one.com>
	<B234BE21-AF5C-42F9-9D04-CC003C70E78B@holtmann.org>
	<014501c894ca$28e9e160$6701a8c0@freqonedev>
Subject: Re: [Bluez-devel] Proposed API for org.bluez.audio.control (AVRCP)
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

Hi David,

On Apr 2, 2008, at 17:02, David Stockwell wrote:
>
> I expressed a need (in a Connect method) to select whether the  
> application running in "this" box, connecting to "this" side of the
> DBus is CT, TG, or both.  If only one-sided, it makes no sense to  
> add both CT and TG records to SDP.  This is also constant for the
> application.

In a multi-application environment where e.g. volume-up/down messages  
can be sent to the headset (which implies CT role) with the help of D- 
Bus method calls, you can't really know if some application is going  
to use those methods or not. They might even come from a different  
application than the one that called Connect and the two applications  
might not know about each other. However, if you have some really  
embedded system with full control over what can and what cannot happen  
we can of course add the possibility to disable TG or CT service  
records and interfaces through an audio.conf option.

> As far as other requirements go from my standpoint, I need full  
> access to sending Metadata from TG to a remote CT using the
> VendorDependent message.  I did propose two methods:  
> SendVendorDependent and SendMetadata (specifically for metadata).

The idea so-far regarding metadata is that it could be communicated  
over the unix socket from the client (alsa/gstreamer/pulse/something  
else) to the audio service. As I've understood it, gstreamer even has  
some native support for this so you could get a "works out of the box"  
experience with existing gstreamer based players. However, if you have  
clear requirements where this is not enough (btw, it'd help if you  
could give some more details of your requirements and usecases), I'm  
sure we can add an interface to fulfill them.

> I also need full access to Passthrough for receiving messages from a  
> remote CT.  With respect to Passthrough, I believe receiving a
> signal is the better way to go (not just the key pressed, but also  
> the vendor dependent operation_data_field).  I know the current
> implementation converts a subset of the messages received to simple  
> "keystrokes" sent with /dev/uinput.  Maybe Johan could inform us
> of what he intended: his requirements, advantages, limitations, etc.

The use of uinput was simply a consensus reached at a BlueZ developer  
meeting some time (1 year?) ago. The idea was that as many  
applications as possible could benefit of AVRCP with very small or no  
changes to their code. I.e. the appllications don't even have to know  
that there exists something called bluetooth or AVRCP. E.g. right now  
you can hack most X based media players to work with AVRCP on Linux.  
However, at no point has it been ruled out that other interfaces for  
AVRCP TG role could be added too if necessary and if you come up with  
a nice interface and a valid set of use cases/requirements it fulfills  
I'm sure we can integrate it to BlueZ.

Johan

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
