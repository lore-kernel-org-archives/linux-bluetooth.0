Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200702211033.15862.denis.kenzior@trolltech.com>
References: <45DB19E9.5080709@access-company.com>
	<200702211033.15862.denis.kenzior@trolltech.com>
Date: Wed, 21 Feb 2007 10:20:54 +0100
Message-Id: <1172049654.10798.45.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Service API
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Denis,

> I noticed in 3.9 the service API start/stop relies on the hcid to exec 
> application that provides the service.  For external services, the start/stop 
> functionality is essentially gone.  
> 
> This makes it hard to support such daemons as pand, dund, or anything that 
> takes command line options, etc.  It also makes it difficult to support inetd 
> style daemons which handle multiple services at once (this is a fairly 
> typical use-case in the embedded world) 
> 
> Would it be useful to have such use-cases available?  For instance, KDE has 
> its own inetd style framework for services.  So if starting/stopping service 
> behavior is not uniform, it might lead to fragmentation.

the ServiceAgent abstraction that I came up with was flexible, but it
ended up to be a little bit too complex. It also had the problem that we
couldn't have service information unless the daemon was running. So the
approach was to re-work this while keeping org.bluez.Service mostly
unchanged. So org.bluez.Service is meant for the UI to show information
about the current installed/running services. It only focus is the UI
and it should not be used by the services itself.

The starting and stopping of services is actually done by executing the
service binary or killing it. This is a more Unix like approach and it
keeps the service a lot more simpler since you don't have to worry about
additional callbacks. So in general you only start a service once and
then it will be running forever. The starting normally happens if the
autostart parameter is set to true or if ActivateService() is called by
a client application. The additional Start() and Stop() methods from the
org.bluez.Service interface are only for the UI and in general not
needed at all. It has been designed this way to give hcid full control
on what is currently running on the system and have a generic way of
providing this information.

For debugging purpose we added the external service definition. Mainly
we did this so we can easily run services through gdb or valgrind. It
might also useful for other cases, but this was not the main intention.
And in case of external services the start/stop functionality doesn't
work and this is done on purpose.

When migrating all the daemons to services, the command line parameters
have to be removed. Initially we had command line parameters in the
service description file, but in the end we removed them along with the
path name of the binary. Keep in mind that these are no longer daemons,
they are services. All command line options these services might have a
purely for debugging purpose. So for all other options they have to be
read from a configuration file or even better made accessible via D-Bus.

For embedded use cases, I think the current approach gives you all
freedom you need. Services can be started automatically or on-demand
when they are needed. You can also start them manually or even make them
external and take full control of them by yourself. With the separation
of service registration and SDP records, you can even have a service
that has no strings attached with hcid.

In the long term even the Unix socket used by sdpd will be removed since
the SDP server can now made part of hcid and SDP record registration is
possible over D-Bus. This will remove another daemon and another IPC
mechanism.

The inetd style approach makes only sense for RFCOMM based services. And
actually only for Serial Port Profile based services. For stuff like
Headset Profile or File Transfer we wanna have highly integrated general
services that provide a nice D-Bus API. So for the Serial Port Profile
the current plan is to create a serial service that provides this kind
of functionality, but then is fully controlled via D-Bus.

> Another point I'd like to bring up is the setting of encryption / 
> authentication options.  This seems like it should be part of the service 
> framework API instead of being a command line option to each individual 
> daemon. 

The thing that has been left as experimental in the last release is the
authorization framework. This actually highly depends on the service
framework and so we had to stabilize that one first. The advantage of
having all servers (also externals) registered via hcid, we can have a
unique authorization callback and an AuthorizationAgent in userspace for
the UI. Both doesn't have to know any details about the service itself
and thus we can make this fully generic.

For the encryption and authentication, we might better rely on the
socket options and extend them. The kernel knows best in most cases how
to handle this within the protocol integration. I am also not willing to
commit to any API regarding this until the Bluetooth 2.1 specification
and Simple Pairing has been finally released.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
