Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Kasper Markus (ETAS-PSC/ECE1)" <Markus.Kasper@escrypt.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCHv2 BlueZ 1/6] doc/gatt-api: Add options dictionary to
 ReadValue/WriteValue
Date: Wed, 18 May 2016 15:31:04 +0000
Message-ID: <c7126690df724e2284f5b1c097f26548@FE-MBX1011.de.bosch.com>
References: <1462801883-6361-1-git-send-email-luiz.dentz@gmail.com>
	<87k2j2et63.fsf@intel.com>
	<CABBYNZ+C86mPyq-86s+TX5-kkcnr6zA+nv_Xog48yX4eq0n+MA@mail.gmail.com>
	<beca2329ea604e6d8de35dca7494099b@FE-MBX1011.de.bosch.com>
	<CABBYNZKdeiBFP63fiZra0SwxXN_BDtcPHA_Ac-hpvyO+MGht_w@mail.gmail.com>
 <CABBYNZJ=uFTH=qjYyce1JjcNzge8uMSuoTbHsNhJ48dsQ39FjQ@mail.gmail.com>
In-Reply-To: <CABBYNZJ=uFTH=qjYyce1JjcNzge8uMSuoTbHsNhJ48dsQ39FjQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Wednesday, May 18, 2016 3:56 PM
> To: Kasper Markus (ETAS-PSC/ECE1) <Markus.Kasper@escrypt.com>
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCHv2 BlueZ 1/6] doc/gatt-api: Add options dictionary to
> ReadValue/WriteValue
> 
> Hi,
> 
> On Wed, May 18, 2016 at 4:55 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > Hi Markus,
> >
> > On Wed, May 18, 2016 at 10:59 AM, Kasper Markus (ETAS-PSC/ECE1)
> > <Markus.Kasper@escrypt.com> wrote:
> >> Hi,
> >>
> >>> -----Original Message-----
> >>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> >>> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> >>> Sent: Tuesday, May 17, 2016 4:22 PM
> >>> Subject: Re: [PATCHv2 BlueZ 1/6] doc/gatt-api: Add options
> >>> dictionary to ReadValue/WriteValue
> >>>
> >>> Hi,
> >>>
> >>> On Tue, May 10, 2016 at 1:57 AM, Vinicius Costa Gomes
> >>> <vinicius.gomes@intel.com> wrote:
> >>> > Hi Luiz,
> >>> >
> >>> > Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:
> >>> >
> >>> >> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >>> >>
> >>> >> This adds the possibility to pass an offset to these operations,
> >>> >> and also in the server case to give the device object.
> >>> >> ---
> >>> >> v2: Fix Vinicius comments, add necessary changes to other tools
> affected.
> >>> >>
> >>> >
> >>> > The series is looking good.
> >>>
> >>> If there are no comments to this set I will be pushing by the end of the day.
> >>
> >> Currently the write command inherently selects a write method based on the
> characteristics properties (write-without-response, reliable-write...).
> >> The option dictionary within the API allows for adding another option to
> override the default selection of the write method for characteristics supporting
> multiple write options.
> >> I thus consider this patch a more generic enabler within the given API to path
> the way for further improvements.
> >
> > Yes, I don't know where using a specific method would actually be
> > recommended since it the server should be able to indicate the proper
> > operation to use via properties but in case there is a real case where
> > the server has the properties somewhat broken then perhaps we can
> > include such feature.
> >
> > --
> > Luiz Augusto von Dentz
> 
> Btw, these patches are now upstream.
> 

I'm facing this problem for an iOS peripheral, where the properties of a characteristic are set to "write-without-response" only. The iOS stack adds a "reliable-write" descriptor to these characteristics, although write is not supported. 
While I'm quite sure the Apple stack does not behave correctly when advertising the "reliable-write" extended property for a characteristic without "write" property, having control over bluez's writes would be the easiest way to handle this. 
My current fix is a patched bluez: I modified the condition for a reliable write to check for both flags: "write" & "reliable-write" before using the reliable-write code.

Markus

> --
> Luiz Augusto von Dentz
