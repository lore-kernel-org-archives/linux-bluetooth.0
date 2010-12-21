Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Dec 2010 11:24:21 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Goubert, TonyX" <tonyx.goubert@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: problem to disconnect with bluez-test
Message-ID: <20101221092421.GA17157@jh-x301>
References: <6E42A1B4DD2F7B4D80A1F26BB498BF9F8C9BD2CAB2@irsmsx501.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6E42A1B4DD2F7B4D80A1F26BB498BF9F8C9BD2CAB2@irsmsx501.ger.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

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
