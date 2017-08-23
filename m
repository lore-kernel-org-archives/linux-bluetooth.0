Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 23 Aug 2017 11:17:39 +0200
From: Konrad Zapalowicz <konrad.zapalowicz@canonical.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Florian Sievert <caleb@phobeus.de>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Segfault on audio pairing
Message-ID: <20170823091739.GA7309@annapurna>
References: <4239e483-1df9-8e18-fc07-d3ce755c8b16@phobeus.de>
 <CABBYNZ+xQCSDCN-GmOPNJ4BTBsvoS+KMkAGfqzrJ4AgGZJmWYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZ+xQCSDCN-GmOPNJ4BTBsvoS+KMkAGfqzrJ4AgGZJmWYg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/21, Luiz Augusto von Dentz wrote:
> Hi Florian,
> 
> On Mon, Aug 21, 2017 at 7:29 PM, Florian Sievert <caleb@phobeus.de> wrote:
> > Hi all,
> >
> > I run into an issue with bluetooth when trying to connect to an audio
> > speaker on my Fedora 26 system. I was able to reproduce this at least on
> > two other Fedora systems with different hardware and thus opened up an
> > issue in redhat's bugzilla:
> >
> > https://bugzilla.redhat.com/show_bug.cgi?id=1469961
> >
> > While performing a discussion on the fedora user mailing list, some guy
> > confirmed the issue as well and pointed out that some similiar Arch
> > Linux does exist:
> >
> > https://bugs.archlinux.org/task/53442
> >
> > I was pointed to this mailing list to raise the issue and asking for
> > further advisory on debugging this segfault. The issue is 100%
> > reproducable here on my system and seems just to occur when connecting
> > an audio speaker via bluetooth to the system. All other bluetooth
> > devices seems to be working fine. Some logs and the segfault are
> > attached to the redhat issue. So how may I help to narrow down this
> > segfault?
> 
> There have been at least one fix related to some headset that are using GATT:
> 
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=5252296b725ef159992be5372f60721bd9adca48

Florian,

I can add that it fixes a crash that I have been observing with Sony
MDR-1000X and possibly also with Sony SBH52.

/K

> 
> -- 
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
