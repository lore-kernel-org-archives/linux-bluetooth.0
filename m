Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0702010940p62d29955o5d64caf71cb68aeb@mail.gmail.com>
Date: Thu, 1 Feb 2007 14:40:19 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200702011159.21531.fernando@bluexare.org>
MIME-Version: 1.0
References: <200702011159.21531.fernando@bluexare.org>
Subject: Re: [Bluez-devel] About hci_inquiry (Num_Responses)
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

On 2/1/07, Fernando Unzu <fernando@bluexare.org> wrote:
> Hello,
> I'm playing with hci_inquiry function and I have realizedthat Num_Responses,
> who is passed like an argument to the function, does not do wath I want.
>
> I thought that this value told how many devices are scanned until the scanning
> stopped.
> But this value tells how many devices "respond" the scan message (so one same
> device can "respond" several times).
>
> With the hcidump I have realized on that.
>
> I have realized this issue because I put this value to 7, for example, and 7
> seconds to the len, but, without find the 7 devices, and without spend all
> the time, the inquiry returns and saying only 3 devices found (for example).
>
> There is any way to solve this? Or is the implementation of this function to
> do so...
>
> There is any solution? Can I, in any way, say the hci_inquiry to stop the scan
> only when 7 (f.e) different devices respond, or only the unique solution is
> to scan for over 40 or more devices, and find all devices, although others
> respond several times...
>
> Can anybody tell me where is the hci_inquiry code to take a study?
>
> Thank you.
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier.
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

Hi Fernando,

You can filter the HCI Inquiry Result Event, check the event content
and send the inquiry cancel command when you want(after 7 different
responses).

Another approach is develop an application using the BlueZ D-Bus API.
Using the method DiscoverDevicesWithoutNameResolving/CancelDiscovery
and filtering for RemoteDeviceFound signals it is possible get the
result that you want.

BR,
Claudio.
-- 
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
