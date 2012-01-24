Return-Path: <cyrus@holtmann.org>
From: "Peter Krystad" <pkrystad@codeaurora.org>
To: "'Greg Hazel'" <ghazel@gmail.com>,
	"'Andrei Emeltchenko'" <andrei.emeltchenko.news@gmail.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <D0339DC2-78B0-427D-9FC3-704725A88020@gmail.com> <20120124082739.GA19238@aemeltch-MOBL1> <E07C31FC-9B74-4DBA-98F5-765E95B256B7@gmail.com> <20120124085719.GB19238@aemeltch-MOBL1> <8B1F83F9-649A-4B59-A620-774A60E64D2C@gmail.com>
In-Reply-To: <8B1F83F9-649A-4B59-A620-774A60E64D2C@gmail.com>
Subject: RE: BT_AMP_POLICY and RFCOMM
Date: Tue, 24 Jan 2012 09:45:48 -0800
Message-ID: <003501ccdac0$022a89e0$067f9da0$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Greg,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org]
> On Behalf Of Greg Hazel
> Sent: Tuesday, January 24, 2012 1:57 AM
> To: Andrei Emeltchenko
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: BT_AMP_POLICY and RFCOMM
> 
> On Jan 24, 2012, at 12:57 AM, Andrei Emeltchenko wrote:
> > On Tue, Jan 24, 2012 at 12:36:23AM -0800, Greg Hazel wrote:
> >> On Jan 24, 2012, at 12:27 AM, Andrei Emeltchenko wrote:
> >>> On Mon, Jan 23, 2012 at 08:15:16PM -0800, Greg Hazel wrote:
> >>>>
> >>>> I'm trying to set BT_AMP_POLICY on an RFCOMM socket to
> >>>> BT_AMP_POLICY_PREFER_AMP. In return I'm getting "Operation not supported
> >>>

> >>> BTW: Why would you need to set this? Functionality is not supported yet so
> >>> nothing will change.
> >>
> >> Oh, I had not made it far enough into bluez to notice it had not been implemented. My
> question still stands I suppose, but is obviously predicated on support being added
> eventually.

Since l2cap ertm is required for channels on AMP the rfcomm layer is unnecessary, it makes
more sense for obex profiles to be modified to use l2cap ertm sockets directly, which do/will
support AMP.

> Is this the right mailing list to ask about the AMP bluetooth work contained in msm and
> android-msm?

Probably not :)

E-mail me or post to https://www.codeaurora.org/forums/viewforum.php?f=4

Peter.

--Peter Krystad
  Employee of Qualcomm Innovation Center, Inc.
  Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


