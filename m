Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Feb 2014 13:45:54 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHv2] android/avrcp: Decouple AVRCP logic from btio
Message-ID: <20140205114552.GA25435@aemeltch-MOBL1>
References: <1391092704-24806-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1391418977-24811-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20140204115622.GN2930@aemeltch-MOBL1>
 <CABBYNZKLwPzEsLCLDGr6cMgYQRobcfQ7W_EqqUpSSvBp4=hGVg@mail.gmail.com>
 <20140204130331.GO2930@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140204130331.GO2930@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Feb 04, 2014 at 03:03:33PM +0200, Andrei Emeltchenko wrote:
> Hi Luiz,
> 
> On Tue, Feb 04, 2014 at 02:50:11PM +0200, Luiz Augusto von Dentz wrote:
> > Hi Andrei,
> > 
> > On Tue, Feb 4, 2014 at 1:56 PM, Andrei Emeltchenko
> > <Andrei.Emeltchenko.news@gmail.com> wrote:
> > > On Mon, Feb 03, 2014 at 11:16:17AM +0200, Andrei Emeltchenko wrote:
> > >> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > >>
> > >> The patch makes AVRCP to be channel-agnostic so that it might be used in
> > >> unit tests. The idea is that all AVRCP logic would come to avrcp-lib and
> > >> channel stuff got to avrcp.
> > 
> > I think we discussed this offline and decided not to have a separate
> > file for now.
> 
> So is the idea is to have unit-avrcp to be compiled with btio, etc? 
> I will then just to link everything what android/avrcp needs.

It looks like together with btio it also needs android/bluetooth.c for
bt_adapter_add_record() and we have source almost all files in android
subfolder. I believe that this is not the desired behaviour and we would
be better with separating AVRCP packet processing logic from the other code.

So what is wrong with the proposed approach? Maybe rename avctp-lib?

Best regards 
Andrei Emeltchenko 
