Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Dec 2013 10:57:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 6/7] android/tester: Add RSSI set prop fail test case
Message-ID: <20131218085758.GA18691@x220.p-661hnu-f1>
References: <1387283874-29721-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
 <1387283874-29721-6-git-send-email-grzegorz.kolodziejczyk@tieto.com>
 <20131218080034.GD12649@x220.p-661hnu-f1>
 <20131218084600.GA26311@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131218084600.GA26311@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Dec 18, 2013, Andrei Emeltchenko wrote:
> On Wed, Dec 18, 2013 at 10:00:34AM +0200, Johan Hedberg wrote:
> > Hi Grzegorz,
> > 
> > On Tue, Dec 17, 2013, Grzegorz Kolodziejczyk wrote:
> > > +static int32_t setprop_remote_rssi = 0;
> > > +
> > > +static const struct generic_data bluetooth_setprop_remote_rssi_invalid_test = {
> > > +	.expected_hal_callbacks = {ADAPTER_TEST_END},
> 
> btw: do we need to have space after "{" ?

Yes, and before } too.

Johan
