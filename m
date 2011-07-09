Return-Path: <cyrus@holtmann.org>
Date: Sat, 9 Jul 2011 18:23:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: kchai1 <kai.chai@windriver.com>
Cc: "Sumangala, Suraj" <surajs@qca.qualcomm.com>,
	Koustuv Ghosh <koustuvg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: SCORouting to PCM in Desktop
Message-ID: <20110709152345.GA9576@dell.ger.corp.intel.com>
References: <BANLkTi=ku2nnVc0DgduHtxZ6xQvzW-d+zA@mail.gmail.com>
 <20110630092824.GA26690@dell.ger.corp.intel.com>
 <480687D4EEFE7447A2E09AADFF667362049C48F1@nasanexd02c.na.qualcomm.com>
 <20110630113825.GA3949@dell.ger.corp.intel.com>
 <1309510212.2306.8.camel@kchai1-Latitude-E6410>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309510212.2306.8.camel@kchai1-Latitude-E6410>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kai,

First of all, please don't top-post on this mailing list. Secondly,
sorry about the delayed response, I seem to have missed this email
initially.

On Fri, Jul 01, 2011, kchai1 wrote:
> About the Headset.Play() function you mentioned, what is the main
> purpose?

It used to be used for SCO connection creation.

> If it was marked as deprecated, what is  the replaced solution?
> 
> Could you give me some information?

You should be using the Media API (doc/media-api.txt) which is what any
audio subsystem (like PulseAudio) has to use anyway in order to access
Bluetooth audio streams. Having a separate Play method is just confusing
since it doesn't give any guarantees that someone will actually take
care of the SCO link and send/receive audio over it.

Johan
