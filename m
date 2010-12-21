Return-Path: <cyrus@holtmann.org>
From: "Goubert, TonyX" <tonyx.goubert@intel.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 21 Dec 2010 15:57:47 +0000
Subject: RE: problem to disconnect with bluez-test
Message-ID: <6E42A1B4DD2F7B4D80A1F26BB498BF9F8C9BD2CCC0@irsmsx501.ger.corp.intel.com>
References: <6E42A1B4DD2F7B4D80A1F26BB498BF9F8C9BD2CAB2@irsmsx501.ger.corp.intel.com>
 <20101221092421.GA17157@jh-x301>
In-Reply-To: <20101221092421.GA17157@jh-x301>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,
Thank you for your answer.

Yes, in fact, I want to use the test scripts in bluez to disconnect a device.

Well, I download the latest version of bluez (Bluez-4.82) and I have not find the command 'disconnect' in the script 'test-device'.
There are : list, create, remove, ... no disconnect.

> I just went ahead and pushed a patch for it upstream.

Can you give me your patch?

BR


--
Tony Goubert
tonyx.goubert@intel.com


-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Johan Hedberg
Sent: Tuesday, December 21, 2010 10:24 AM
To: Goubert, TonyX
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: problem to disconnect with bluez-test

Hi Tony,

On Tue, Dec 21, 2010, Goubert, TonyX wrote:
> I have paired a handset with a laptop by using 'simple-agent'
> bluez-test script BUT I can't disconnect it when I use the bluez
> stack.

I suppose you mean you can't disconnect it using the test scripts that
come with BlueZ (since I'm sure you *can* disconnect it with BlueZ as
long as you use the D-Bus interface directly).

> I can remove it (./test-device remove xx:xx:xx:xx:xx:xx) but I
> want to be able to connect/disconnect/connect...

The Device.Disconnect method is indeed something that should be added to
the test-device script. I just went ahead and pushed a patch for it
upstream.

> [root@localhost test]# ./test-device disconnect xx:xx:xx:xx:xx:xx
> Unknown command

This command should work with latest git now.

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

