Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Sony DSC-FX77 and BIP
From: Marcel Holtmann <marcel@holtmann.org>
To: Tom Bailly-Salins <tbaillys@free.fr>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40D18682.6020306@free.fr>
References: <40D043DF.4070306@free.fr> <1087391351.4309.16.camel@pegasus>
	 <40D05E6A.402@free.fr> <1087399176.4309.24.camel@pegasus>
	 <40D068F3.3050702@free.fr> <1087427312.4309.32.camel@pegasus>
	 <40D18682.6020306@free.fr>
Content-Type: text/plain
Message-Id: <1087473798.23809.11.camel@localhost>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 17 Jun 2004 14:03:18 +0200

Hi Tom,

> After reading the BIP Specs V1.0, it seems that I need to implement the 
> following functions from the remote camera feature.
>  - GetMonitoringImage
>  - GetImage
> 
> My goal is just to be able to:
>  - connect to DSC-FX77                                    (I suppose I 
> can do it with BlueZ ?)
>  - view thumbnail sized monitoring images         (GetMonitoringImage + 
> StoreFlag = 0x00)
>  - trigger the image capture on the DSC-FX77   (GetMonitoringImage + 
> StoreFlag = 0x01)
>  - retrieve the full size image from the camera     (GetImage with the 
> correct image Handle)
>  - disconnect from the camera.                             (I also 
> suppose I can do it with BlueZ ?)

the feature bits of the SDP record shows you what function do the FX77
really support.

> The way I understand it:
>  - The 2 functions (GetMonitoringImage and GetImage) make use of OBEX 
> headers, this is where openOBEX comes in, right ?
>  - If I send those commands to the DSC-FX77 camera acting as an imaging 
> responder, will it understand them, and send back the right data ?

As I said above, check the feature bits first. But you are right, you
must use OpenOBEX and the native operations are put, get and setpath.
The rest is XML related stuff.

> Am I making any sense and am I in the right direction ?
> If so, do you know where can I find sample code that makes use of 
> openOBEX and BlueZ to start experimenting.

Check the opd and the obex repository in the BlueZ CVS.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
