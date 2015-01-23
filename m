Return-Path: <cyrus@holtmann.org>
Date: Fri, 23 Jan 2015 20:00:12 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 2/2] Bluetooth: Use reject error code in pair device
 method
Message-ID: <20150123180012.GA32188@t440s.P-661HNU-F1>
References: <1422014012-6840-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1422014012-6840-2-git-send-email-lukasz.rymanowski@tieto.com>
 <20150123121426.GA14616@t440s.lan>
 <CAMudyAsxs=-A8ByHCVLj28sR9fD0z3no==mAgeaRwJBk_S_0-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMudyAsxs=-A8ByHCVLj28sR9fD0z3no==mAgeaRwJBk_S_0-Q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Fri, Jan 23, 2015, Lukasz Rymanowski wrote:
> >>               if (PTR_ERR(conn) == -EBUSY)
> >>                       status = MGMT_STATUS_BUSY;
> >> +             else if (PTR_ERR(conn) == -EOPNOTSUPP)
> >> +                     status = MGMT_STATUS_REJECTED;
> >>               else
> >>                       status = MGMT_STATUS_CONNECT_FAILED;
> >
> > Good catch, but I'd like to keep this consistent with our handling of LE
> > support elsewhere. Particularly, I'd like to follow the same semantics
> > as the mgmt_le_support() helper function, meaning if the HW doesn't
> > support LE we get NOT_SUPPORTED whereas if it does support LE but it's
> > simply not enabled we get REJECTED.
> >
> > You could e.g. use EOPNOTSUPP for non-LE HW and ECONNREFUSED for LE not
> > enabled (feel free to propose a better errno to mgmt status mapping).
> >
> Ok.
> I could not found any better error code than  ECONNREFUSED so I will go for it.
> 
> Also going with your proposal I should probably change hci_connect_acl
> in the same way.
> Meaning return EOPNOTSUPP if it is LE only chip and ECONNREFUSED if it
> is dual but
> BREDR is disabled.
> 
> Do you agree?

Yes, sounds reasonable.

Johan
