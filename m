Return-Path: <tbaillys@free.fr>
Message-ID: <40D18682.6020306@free.fr>
Date: Thu, 17 Jun 2004 13:54:42 +0200
From: Tom Bailly-Salins <tbaillys@free.fr>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Sony DSC-FX77 and BIP
References: <40D043DF.4070306@free.fr> <1087391351.4309.16.camel@pegasus>	 <40D05E6A.402@free.fr> <1087399176.4309.24.camel@pegasus>	 <40D068F3.3050702@free.fr> <1087427312.4309.32.camel@pegasus>
In-Reply-To: <1087427312.4309.32.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hello Marcel

After reading the BIP Specs V1.0, it seems that I need to implement the 
following functions from the remote camera feature.
 - GetMonitoringImage
 - GetImage

My goal is just to be able to:
 - connect to DSC-FX77                                    (I suppose I 
can do it with BlueZ ?)
 - view thumbnail sized monitoring images         (GetMonitoringImage + 
StoreFlag = 0x00)
 - trigger the image capture on the DSC-FX77   (GetMonitoringImage + 
StoreFlag = 0x01)
 - retrieve the full size image from the camera     (GetImage with the 
correct image Handle)
 - disconnect from the camera.                             (I also 
suppose I can do it with BlueZ ?)

The way I understand it:
 - The 2 functions (GetMonitoringImage and GetImage) make use of OBEX 
headers, this is where openOBEX comes in, right ?
 - If I send those commands to the DSC-FX77 camera acting as an imaging 
responder, will it understand them, and send back the right data ?

Am I making any sense and am I in the right direction ?
If so, do you know where can I find sample code that makes use of 
openOBEX and BlueZ to start experimenting.

Thank you

TOM

Marcel Holtmann wrote:

>Hi Tom,
>
>  
>
>>Do you have the BIP profile specifications ? If you do I would really 
>>like a copy.
>>    
>>
>
>you will find it at www.bluetooth.org
>
>Regards
>
>Marcel
>
>
>
>
>  
>
