Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Nov 2011 17:19:15 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Remove magic bluetooth version numbers
Message-ID: <20111123151914.GC4066@aemeltch-MOBL1>
References: <1322040215-640-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1322040215-640-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1322059738.29909.6.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322059738.29909.6.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Nov 23, 2011 at 03:48:58PM +0100, Marcel Holtmann wrote:
> > +/* Bluetooth versions */
> > +#define BLUETOOTH_VER_1_1	1
> > +#define BLUETOOTH_VER_1_2	2
> > +#define BLUETOOTH_VER_2_0_EDR	3
> > +
> 
> I am fine with the patch, but you need to use BLUETOOTH_VER_2_0 here
> since you have have 2.0 without EDR. Have a fun night reading with the
> Bluetooth SIG branding guidelines.

OK, I will remove EDR at the end. BTW: on a bluetooth web site there seems
to be different interpretation of those numbers:

Parameter Name 	Assigned Values
HCI_Version 	
        0 	Bluetooth Core Specification 1.0b
  	1 	Bluetooth Core Specification 1.1
  	2 	Bluetooth Core Specification 1.2
  	3 	Bluetooth Core Specification 2.0 + EDR
  	4 	Bluetooth Core Specification 2.1 + EDR
  	5 	Bluetooth Core Specification 3.0 + HS
  	6 	Bluetooth Core Specification 4.0
  	7 - 255 	Reserved

Source:
https://www.bluetooth.org/technical/assignednumbers/hci.htm

Best regards 
Andrei Emeltchenko 

> 
> Once you did that change, ACK.
> 
> Regards
> 
> Marcel
> 
> 
