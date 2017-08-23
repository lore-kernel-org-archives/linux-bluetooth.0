Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 23 Aug 2017 12:37:58 +0200
From: Konrad Zapalowicz <konrad.zapalowicz@canonical.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Florian Sievert <caleb@phobeus.de>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        pwaago@cisco.com
Subject: Re: Segfault on audio pairing
Message-ID: <20170823103758.GB7309@annapurna>
References: <4239e483-1df9-8e18-fc07-d3ce755c8b16@phobeus.de>
 <CABBYNZ+xQCSDCN-GmOPNJ4BTBsvoS+KMkAGfqzrJ4AgGZJmWYg@mail.gmail.com>
 <20170823091739.GA7309@annapurna>
 <CABBYNZ+1BOM-RssKMNp23rFA4R4HQrsu-cG=rNHM_kpmJkjutw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZ+1BOM-RssKMNp23rFA4R4HQrsu-cG=rNHM_kpmJkjutw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/23, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Wed, Aug 23, 2017 at 12:17 PM, Konrad Zapalowicz
> <konrad.zapalowicz@canonical.com> wrote:
> > On 08/21, Luiz Augusto von Dentz wrote:
> >> Hi Florian,
> >>
> >> On Mon, Aug 21, 2017 at 7:29 PM, Florian Sievert <caleb@phobeus.de> wrote:
> >> > Hi all,
> >> >
> >> > I run into an issue with bluetooth when trying to connect to an audio
> >> > speaker on my Fedora 26 system. I was able to reproduce this at least on
> >> > two other Fedora systems with different hardware and thus opened up an
> >> > issue in redhat's bugzilla:
> >> >
> >> > https://bugzilla.redhat.com/show_bug.cgi?id=1469961
> >> >
> >> > While performing a discussion on the fedora user mailing list, some guy
> >> > confirmed the issue as well and pointed out that some similiar Arch
> >> > Linux does exist:
> >> >
> >> > https://bugs.archlinux.org/task/53442
> >> >
> >> > I was pointed to this mailing list to raise the issue and asking for
> >> > further advisory on debugging this segfault. The issue is 100%
> >> > reproducable here on my system and seems just to occur when connecting
> >> > an audio speaker via bluetooth to the system. All other bluetooth
> >> > devices seems to be working fine. Some logs and the segfault are
> >> > attached to the redhat issue. So how may I help to narrow down this
> >> > segfault?
> >>
> >> There have been at least one fix related to some headset that are using GATT:
> >>
> >> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=5252296b725ef159992be5372f60721bd9adca48
> >
> > Florian,
> >
> > I can add that it fixes a crash that I have been observing with Sony
> > MDR-1000X and possibly also with Sony SBH52.
> 
> It might be a good idea to compile a list of affected headsets so we
> can probably add to the changelog when releasing.

Good idea. From my side:

1) Sony MDR-1000X
2) Sony SBH52

There was also a report from Per who used a Plantronics headset however
I'm not sure what is the status with the above patch applied.

/K

> 
> -- 
> Luiz Augusto von Dentz
