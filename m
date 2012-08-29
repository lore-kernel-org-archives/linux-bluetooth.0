Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Which software is responsible for bringing the devices (hci0 .. hcix) up ?
Date: Wed, 29 Aug 2012 09:12:18 +0200
Message-ID: <1531E53627F1F749B4FE809BF2A4EB67036F2FAC@WETMEX10.loepfe.com>
In-Reply-To: <20120829070853.GA3937@aemeltch-MOBL1>
References: <1531E53627F1F749B4FE809BF2A4EB67036F2F97@WETMEX10.loepfe.com> <20120829070853.GA3937@aemeltch-MOBL1>
From: "Vellemans, Noel" <Noel.Vellemans@visionBMS.com>
To: "Andrei Emeltchenko" <andrei.emeltchenko.news@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

Any clue what the reason can be, that the device is not comming 'UP'
automatically ?


Regards Noel
 

-----Original Message-----
From: Andrei Emeltchenko [mailto:andrei.emeltchenko.news@gmail.com] 
Sent: 29Aug12 09:09
To: Vellemans, Noel
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Which software is responsible for bringing the devices
(hci0 .. hcix) up ?

Hi Noel,

On Wed, Aug 29, 2012 at 08:58:12AM +0200, Vellemans, Noel wrote:
> Hi,
>  
>  
> I have a simple question, I think, But I do not manage to find the 
> answer into the old mailing-list-posts.
>  
> I'm using bluez-4.99 and Linux kernel 2.6.35.3. 
>  
> When plugging in a device (CSR-device) the device is recognized but it

> is not 'UP'.
>  
> Can someone tell me what piece of software is NORMALLY setting the 
> device into the 'UP' state?
> (so that I do not have to type hciconfig hci0 up)

bluetoothd

Best regards
Andrei Emeltchenko 

