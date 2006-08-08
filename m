Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1c86461cc9a5.1cc9a51c8646@fh-wolfenbuettel.de>
References: <1c86461cc9a5.1cc9a51c8646@fh-wolfenbuettel.de>
Date: Tue, 08 Aug 2006 13:56:04 +0200
Message-Id: <1155038164.3905.121.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Multiplexing for SimAccessProfile
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

Hi Goetz,

> I am still working on the Sim Access Profile implementation and am now
> stuck on the communnication with the GSM module I use, the serial port
> multiplexing. 
> 
> The connection to the bluetooth device and all the messages and
> responses to and from the mobile phone work fine. So the bluetooth part
> is done. Now the GSM module will need to have the data from the SIM of
> the mobile phone to use it for connectiong to the GSM network. Since I
> use a device from Siemens (AC45) it already has the multiplexing (GSM
> 07.10) integrated meaning that I can send an AT-command (at+cmux=0) and
> it will switch to multiplexing mode and work as required. It will know
> how to handle data packets coming in from the serial port to divide them
> into each channel and how to pack the data with the apppropriate header
> from each multiplexing channel to be sent back over the single serial port. 
> 
> The missing part is in my software. It will need to wrap and unwrap the
> messages to and from the GSM modem in the form it is defined in the
> specification for this multiplexing. 
> 
> There is solution of a final year project of a student in Finnland
> available, but it seems to possible have a few bugs.
> (http://users.tkk.fi/~tkarvone/). Compiling is fine and the load of user
> space serial port module at runtime is ok too. To my understanding a
> controlling application is the second part of this project, which will
> open the port and enable the multiplexing of the GSM device and then
> wait for data coming into or out of the "virtual" ports, wrapping or
> unwrapping the data packets. Or am I wrong and have to replace the
> application with my blueZ-SAP-application?

everything depends on what you actually need. An overall general
solution would be a GSM 07.10 for the Linux kernel that allows us to
multiplex any TTY supporting it. We don't have this and so far nobody
actually tried to work on this. There are some efforts with the guys
hacking the Motorola Linux phones, but so far I am not aware of any real
useable code.

The question for you should be if you need this running inside the
kernel or is some userspace library or self-written code enough. To
answer this you must answer if this GSM module will be only used by your
SAP-Gateway or do you wanna also share it with other applications. If
you wanna share it then you need to focus on a kernel implementation
that does the multiplexing and then present independent TTYs for each
channel. If you are the only user of the GSM module, then you might
simply implement GSM 07.10 directly into your SAP-Gateway. This will
make you independent.

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
