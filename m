Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Dec 2010 00:24:25 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Goubert, TonyX" <tonyx.goubert@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: problem to disconnect with bluez-test
Message-ID: <20101221222425.GA18281@jh-x301>
References: <6E42A1B4DD2F7B4D80A1F26BB498BF9F8C9BD2CAB2@irsmsx501.ger.corp.intel.com>
 <20101221092421.GA17157@jh-x301>
 <6E42A1B4DD2F7B4D80A1F26BB498BF9F8C9BD2CCC0@irsmsx501.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6E42A1B4DD2F7B4D80A1F26BB498BF9F8C9BD2CCC0@irsmsx501.ger.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

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
