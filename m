Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <000a01c502eb$5e72f750$798815ac@stu.nus.edu.sg>
From: "Khoo Teck Ping" <eng10166@nus.edu.sg>
To: <bluez-devel@lists.sourceforge.net>
References: <001601c50210$feedd960$2bc212ac@stu.nus.edu.sg> <1106570617.9269.81.camel@pegasus>
Subject: Re: [Bluez-devel] Question about dev/bluetooth/rfcomm/0
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 25 Jan 2005 22:37:11 +0800

Hi Marcel

Thank you for your help. I have a few more related questions:

1. I issue the following commands with a Sony Ericsson 
T630(a1:b2:c3:d4:e5:f6) nearby
# rfcomm bind rfcomm0 a1:b2:c3:d4:e5:f6
# rfcomm connect rfcomm0 a1:b2:c3:d4:e5:f6

The T630 asked for a pin. I have previously editted the pin file in 
/etc/bluetooth/pin to be 0000. I entered 0000 into the T630 and it rejected 
it with error passkey mismatch. May I know how to resolve this?

However, when I issued the following command
# hcitool cc a1:b2:c3:d4:e5:f6
The connection proceeded successfully immediately, without the phone asking 
for a pin.

May I know the difference between the two cases?

2. I desire to use AT commands on my Fedora, via cu (call up). May I know 
how I can get cu installed? Can minicom be used for similar purpose?

Thank You.
Teck Ping




----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Sent: Monday, January 24, 2005 8:43 PM
Subject: Re: [Bluez-devel] Question about dev/bluetooth/rfcomm/0


> Hi Teck,
>
>> I do not currently have this folder on my file system.
>>
>> dev/bluetooth/rfcomm/0
>>
>> I understand that it should have been created by the kernel drivers.
>>
>> May I know how I can install this folder? This is required for
>> rfcomm.
>
> if this is a 2.6 kernel then install udev and the device node will be
> created. However this can also be /dev/rfcomm0, because the other name
> was only used by devfs.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel 



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
