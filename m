Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Tue, 8 Aug 2006 14:52:57 +0530
Message-ID: <002501c6bacc$3ccc8950$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <1c86461cc9a5.1cc9a51c8646@fh-wolfenbuettel.de>
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

Can you release the source code? I'll try at my end. I have a phone
supporting SAP.

Regards,
Mayank


> Hi all,
> 
> I am still working on the Sim Access Profile implementation and am now
> stuck on the communnication with the GSM module I use, the serial port
> multiplexing. 
> 
> The connection to the bluetooth device and all the messages and
> responses to and from the mobile phone work fine. So the 
> bluetooth part
> is done. Now the GSM module will need to have the data from the SIM of
> the mobile phone to use it for connectiong to the GSM network. Since I
> use a device from Siemens (AC45) it already has the multiplexing (GSM
> 07.10) integrated meaning that I can send an AT-command 
> (at+cmux=0) and
> it will switch to multiplexing mode and work as required. It will know
> how to handle data packets coming in from the serial port to 
> divide them
> into each channel and how to pack the data with the 
> apppropriate header
> from each multiplexing channel to be sent back over the 
> single serial port. 
> 
> The missing part is in my software. It will need to wrap and 
> unwrap the
> messages to and from the GSM modem in the form it is defined in the
> specification for this multiplexing. 
> 
> There is solution of a final year project of a student in Finnland
> available, but it seems to possible have a few bugs.
> (http://users.tkk.fi/~tkarvone/). Compiling is fine and the 
> load of user
> space serial port module at runtime is ok too. To my understanding a
> controlling application is the second part of this project, which will
> open the port and enable the multiplexing of the GSM device and then
> wait for data coming into or out of the "virtual" ports, wrapping or
> unwrapping the data packets. Or am I wrong and have to replace the
> application with my blueZ-SAP-application?
> 
> Has anyone used this multiplexing implementation successfully or does
> anyone know of a different implementation of the multiplexing as
> opensource to use with linux?
> 
> Greetings,
> Goetz
> 
> --------------------------------------------------------------
> -----------
> Using Tomcat but need to do more? Need to support web 
> services, security?
> Get stuff done quickly with pre-integrated technology to make 
> your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on 
> Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&
dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
