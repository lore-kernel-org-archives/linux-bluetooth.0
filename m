Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Nov 2010 20:29:21 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: jaikumar Ganesh <jaikumarg@gmail.com>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/4] Add DBus OOB API documentation.
Message-ID: <20101112182921.GA15584@jh-x301>
References: <1288865461-3760-1-git-send-email-szymon.janc@tieto.com>
 <1288865461-3760-4-git-send-email-szymon.janc@tieto.com>
 <AANLkTikZrbVTCDB2HRtqRJjUjYP3Z5PBieOovZZgP9id@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTikZrbVTCDB2HRtqRJjUjYP3Z5PBieOovZZgP9id@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaikumar,

On Fri, Nov 12, 2010, jaikumar Ganesh wrote:
> > +               void Deactivate()
> 
> Would it better to make this a signal ? Deactivate by itself as the
> only method doesn't seem to be right.

I guess this is analogous to the Release() method which we have for
agents, so in that sense a method call would be consistent with the rest
of the BlueZ D-Bus API (but you'd really need to rename this to Release
then).

Johan
