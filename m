Return-Path: <szymon.janc@codecoup.pl>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] doc: Add DeviceClassic1 and DeviceSmart1 interfaces
Date: Fri, 11 Mar 2016 10:56:10 +0100
Message-ID: <1953352.ZcJQUXlYx9@ix>
In-Reply-To: <CABBYNZKK6eCVouvsQMGfQdYA-6RY02O05q7yMsjtHfPL1kBu7A@mail.gmail.com>
References: <1457106781-8566-1-git-send-email-szymon.janc@codecoup.pl> <799E44F0-0095-4281-9850-5A5A53C3D413@holtmann.org> <CABBYNZKK6eCVouvsQMGfQdYA-6RY02O05q7yMsjtHfPL1kBu7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Luiz,

On Sunday 06 March 2016 16:34:53 Luiz Augusto von Dentz wrote:
> Hi Marcel,
> 
> On Fri, Mar 4, 2016 at 7:32 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> > Hi Szymon,
> > 
> >> This interfaces will provide per tranport capabilities of remote
> >> devices. Eventually leading to deprecation of Device1 interface.
> > 
> > so I not like the naming DeviceClassic1 and DeviceSmart1 at all. Nobody
> > uses these terms widely that they are easily recognizable and can be
> > associated. I also do not want to follow Bluetooth SIG marketing and logo
> > terms. They might change and then we are stuck with it.
> IMO they are better than LE and BR/EDR, but perhaps you have something
> better in mind. Btw, this does bring the question if we should do
> something similar to the Adapter interface, although there are a
> little less conflicts because there more LE specific interfaces.

DeviceLE1 and DeviceBR{EDR}1 ?

Or maybe Device2 (that would be BREDR only) and DeviceLE1 ? 

-- 
pozdrawiam
Szymon Janc
