Return-Path: <cyrus@holtmann.org>
From: "Goubert, TonyX" <tonyx.goubert@intel.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 22 Dec 2010 11:02:30 +0000
Subject: RE: problem to disconnect with bluez-test
Message-ID: <6E42A1B4DD2F7B4D80A1F26BB498BF9F8C9BD2CE14@irsmsx501.ger.corp.intel.com>
References: <6E42A1B4DD2F7B4D80A1F26BB498BF9F8C9BD2CAB2@irsmsx501.ger.corp.intel.com>
 <20101221092421.GA17157@jh-x301>
 <6E42A1B4DD2F7B4D80A1F26BB498BF9F8C9BD2CCC0@irsmsx501.ger.corp.intel.com>
 <20101221222425.GA18281@jh-x301>
In-Reply-To: <20101221222425.GA18281@jh-x301>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,
Thank you for your answer.
This command is ok, I can disconnect.

Well, I'm a newbie in python but I'm interesting to contribute.
Is there a documentation which describes the command that we can develop?
For example, now I want to be able to connect after a disconnect.
BR. 

--
Tony Goubert
tonyx.goubert@intel.com

-----Original Message-----
From: Johan Hedberg [mailto:johan.hedberg@gmail.com] 
Sent: Tuesday, December 21, 2010 11:24 PM
To: Goubert, TonyX
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: problem to disconnect with bluez-test

Hi Tony,

On Tue, Dec 21, 2010, Goubert, TonyX wrote:
> Yes, in fact, I want to use the test scripts in bluez to disconnect a
> device.
> 
> Well, I download the latest version of bluez (Bluez-4.82) and I have
> not find the command 'disconnect' in the script 'test-device'.
> There are : list, create, remove, ... no disconnect.

Obviously that's the case since 4.82 was released before I created the
patch.

> > I just went ahead and pushed a patch for it upstream.
> 
> Can you give me your patch?

As I said, it's upstream. You can get it from there:

http://git.kernel.org/?p=bluetooth/bluez.git;a=summary
http://git.kernel.org/?p=bluetooth/bluez.git;a=commitdiff;h=dd109a698c149a805f19cd2a7ddd0cbb8434f965

Johan
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

