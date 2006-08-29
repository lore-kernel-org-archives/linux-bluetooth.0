Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <50269.157.193.214.17.1156867288.squirrel@www.ibcn.intec.ugent.be>
References: <50269.157.193.214.17.1156867288.squirrel@www.ibcn.intec.ugent.be>
Date: Tue, 29 Aug 2006 22:56:45 +0200
Message-Id: <1156885005.4026.33.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Registering service / Getting data
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

Hi Dieter,

> I'm developing an application that should capture some data sent by a
> bluetooth device.
> The device is not discoverable, only comes up when it has some data to send.
> It searches for devices with a certain PIN. When it can pair, it queries
> the sdpd for
> services meeting the Serial Port Profile (0x1101) and sends the data to
> this service.
> 
> When I use hcidump, i can see the data pass, but I can't figure out how to
> get it in a C program.
> 
> I used http://people.csail.mit.edu/albert/bluez-intro/index.html as
> reference to program in C.
> 
> When I register my service with the sdpd daemon, i don't know how to query
> the sdpd. At least i don't see my service using sdptool. When I run the C
> program, nothing happens, the app keeps listening for incoming
> connections.
> 
> In attachment my hcidump and c-file.

first of all the preferred mode is "hcidump -X -V", because I am not
going to decode any HCI traffic by hand.

Second, the RFCOMM channel in the SDP service registration (in your case
it is 11) should match the channel you listen on (which is 1).

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
