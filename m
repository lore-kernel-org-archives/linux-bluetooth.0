Return-Path: <cyrus@holtmann.org>
Date: Sun, 17 May 2015 10:41:00 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 1/8] btdev: Add LE Encrypt command support to emulator
Message-ID: <20150517074100.GB28324@t440s.P-661HNU-F1>
References: <1431697586-20611-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20150517073318.GC27593@t440s.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150517073318.GC27593@t440s.P-661HNU-F1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sun, May 17, 2015, Johan Hedberg wrote:
> Hi Andrei,
> 
> On Fri, May 15, 2015, Andrei Emeltchenko wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > Add basic crypto support to btdev using Linux crypto infrastructure.
> > ---
> >  emulator/btdev.c | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> 
> Was something different in the first three patches of this set? I
> already applied the v1 of them. Please, *always* provide a full
> changelog of what has changed when you send new revisions (either on a
> per-patch basis after the '---' line or with the help of a cover letter.

I went ahead and pushed the v2 through --force since the earlier patches
only had a chance to be a couple of minutes in the upstream tree.

Johan
