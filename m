Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120730110050.GA13789@x220.ger.corp.intel.com>
References: <1342790298-12193-1-git-send-email-mikel.astiz.oss@gmail.com>
	<20120730110050.GA13789@x220.ger.corp.intel.com>
Date: Wed, 8 Aug 2012 09:41:50 +0200
Message-ID: <CANT-zCULPXPSF3F5+YfJsRJ2TMGBWDcs7+JNJc2mX58_2XshjA@mail.gmail.com>
Subject: Re: [RFC v2] Bluetooth: mgmt: Add device disconnect reason
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Jul 30, 2012 at 1:00 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Mikel,
>
> On Fri, Jul 20, 2012, Mikel Astiz wrote:
>> During the BlueZ meeting in Brazil it was proposed to add two more
>> values to this enum: "Connection terminated by local host" and
>> "Connection terminated by remote host". However, after some testing,
>> it seems the result can be quite misleading. Therefore and given that
>> there are no known use-cases that need this information (local vs
>> remote disconnection), these two values have been dropped.
>
> I still think that it wouldn't hurt to include which side triggers the
> HCI_Disconnect() command. We can always document that this identifies
> accurately the ACL disconnection initiator but not necessarily the
> higher-level profile(s) disconnection initiator.

Sorry for the later reply. I will send an updated version soon.

Cheers,
Mikel
