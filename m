Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Apr 2015 11:33:57 +0300
From: Jouni Malinen <jouni@qca.qualcomm.com>
To: Ben Hutchings <ben@decadent.org.uk>
CC: Kyle McMartin <kyle@infradead.org>,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	<linux-firmware@kernel.org>, <linux-bluetooth@vger.kernel.org>,
	<agoel@qca.qualcomm.com>
Subject: Re: [PATCH] ath3k: update AR3012 2.2.1 firmware with v.170
Message-ID: <20150415083357.GA3907@jouni.qca.qualcomm.com>
References: <1428687294-10706-1-git-send-email-kvalo@qca.qualcomm.com>
 <20150413140205.GB27807@merlin.infradead.org>
 <20150413140617.GC27807@merlin.infradead.org>
 <1428934503.3211.7.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1428934503.3211.7.camel@decadent.org.uk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> On Mon, 2015-04-13 at 10:06 -0400, Kyle McMartin wrote:
> > actually, one question before i push it out, this license is the same as
> > LICENSE.QualcommAtheros_ath10k... can we rename and fix references?

While the license text is practically same at the moment, our preference
would be to use separate files for clarity.


On Mon, Apr 13, 2015 at 03:15:03PM +0100, Ben Hutchings wrote:
> I have some concern about the narrower patent license in this version.
> 
> The new patent license specifically excludes patents that are not owned
> by QCA (whereas the old license also included those 'controlled' by
> Atheros) and any that are obtained after the date of submission.  This
> seems to allow revoking permission to distribute at a later date, if
> there are any other patent applications in the pipeline.
> 
> If QCA wants the firmware to be redistributed freely (with the legal
> notices intact, only for use with their hardware) then I don't see what
> the point is of restricting the patent license in this way.

I don't think there is such limitation for redistribution (see the
copyright license above in the "Redistribution" section). As far as the
limited patent license language is concerned, would the following
changes address your concern?


Old:

The term "Patents" as used in this agreement means only those patents
-or- patent applications owned solely and exclusively by Licensor as of
the date of Licensor's submission of the Software and any patents
deriving priority (i.e., having a first effective filing date)
therefrom.
...
Notwithstanding anything to the contrary herein, Licensor does not grant
and Licensee does not receive, by virtue of this agreement or the
Licensor's submission of any Software, any license or other rights under
any patent or patent application owned by any affiliate of Licensor -or
any other entity- (other than Licensor), whether expressly, impliedly,
by virtue of estoppel or exhaustion, or otherwise.


New:

The term "Patents" as used in this agreement means only those patents
_and_ patent applications owned _or controlled_ solely and exclusively
by Licensor as of the date of Licensor's submission of the Software and
any patents _and patent applications_ deriving priority (i.e., having a
first effective filing date) therefrom."
...
Notwithstanding anything to the contrary herein, Licensor does not grant
and Licensee does not receive, by virtue of this agreement or the
Licensor's submission of any Software, any license or other rights under
any patent or patent application owned by any affiliate of Licensor
(other than _an entity in which more than 50% of the voting power held
by shares or other securities entitled to vote is owned or controlled,
either directly or indirectly, by_ Licensor), whether expressly,
impliedly, by virtue of estoppel or exhaustion, or otherwise.

 
-- 
Jouni Malinen                                            PGP id EFC895FA
