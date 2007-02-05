Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Fernando Unzu <fernando@bluexare.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Mon, 5 Feb 2007 10:08:32 +0100
References: <200702011159.21531.fernando@bluexare.org>
	<e1effdeb0702010940p62d29955o5d64caf71cb68aeb@mail.gmail.com>
In-Reply-To: <e1effdeb0702010940p62d29955o5d64caf71cb68aeb@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200702051008.32983.fernando@bluexare.org>
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


> Hi Fernando,
>
> You can filter the HCI Inquiry Result Event, check the event content
> and send the inquiry cancel command when you want(after 7 different
> responses).
>
> Another approach is develop an application using the BlueZ D-Bus API.
> Using the method DiscoverDevicesWithoutNameResolving/CancelDiscovery
> and filtering for RemoteDeviceFound signals it is possible get the
> result that you want.
>
> BR,
> Claudio.

I have been studying the security code (in which it can be the function 
inquiry result, and anothers, but I have not known how I can do it.

I don't know how I can check if the device is discovered already.
Who have this information?
And, how can I avoid this repeated device to include in the information of 
devices that have responded?

Thank you for the help

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
