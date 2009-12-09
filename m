Return-Path: <cyrus@holtmann.org>
Message-ID: <724791.92906.qm@web52608.mail.re2.yahoo.com>
References: <453936.71245.qm@web52604.mail.re2.yahoo.com> <e378cfb20912090123m51645679n3e410d6208c6f51e@mail.gmail.com> <4B1FA40F.2020003@hempeldesigngroup.com>
Date: Wed, 9 Dec 2009 07:04:03 -0800 (PST)
From: Ed Tsang <netdesign_98@yahoo.com>
Subject: Re: How to force a fix pin
To: Ralph Hempel <rhempel@hempeldesigngroup.com>,
	Nel D <newatlinux@gmail.com>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
In-Reply-To: <4B1FA40F.2020003@hempeldesigngroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ralph,Nel, 
Thanks for the hints.
Since I will need to use the same pin code for every devices and I will not know their address before hand. In the pincodes file could we use
* 0000 
I will try it out first.

Net Des


----- Original Message ----
From: Ralph Hempel <rhempel@hempeldesigngroup.com>
To: Nel D <newatlinux@gmail.com>
Cc: Ed Tsang <netdesign_98@yahoo.com>; Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Sent: Wed, December 9, 2009 8:20:15 AM
Subject: Re: How to force a fix pin

Nel D wrote:
> Hi ,
> 
> 
> On Wed, Dec 9, 2009 at 3:45 AM, Ed Tsang <netdesign_98@yahoo.com> wrote:
>> Hi, My application scan for devices, send file to it. But some device (blackberry) will request a pin. With the bluetoothd 4.51. bluetooth-applet will pop up and enter a pin. If de-install it, the bluetoothd will complain "No agent available for 0 request (pin_code_request?).". And the remote device failed to pair with a "default pin 0000".
>> Is there a way to force a default pin "0000".  look like /etc/bluetooth/pin is history.  Is there a simply work around.
>>
>> Net Des

In the directory /var/lib/xx:yy:xx:yy:xx:yy/

where xx:yy:xx:yy:xx:yy is your Bluetooth interface MAC

you will either find or have to create two files:

pincodes
trusts

Assuming that your other device is aa:bb:aa:bb:aa:bb you
modify the files as follows:

In the pincodes file, add a line like this, replace 0000
with your desired pincode

aa:bb:aa:bb:aa:bb 0000

In the trusts file, put this:

aa:bb:aa:bb:aa:bb [all]

Which says the device can access all services (I think)

If the pairing is sucessful you will get a new
entry in the linkkeys file, and that key will then be
used in the future, so no more pairing is required.

I am currently investigating why (in 4.57) the linkkeys
and trusts entry of a successfully paired device are
sometimes deleted.

Ralph

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



      __________________________________________________________________
Looking for the perfect gift? Give the gift of Flickr! 

http://www.flickr.com/gift/
