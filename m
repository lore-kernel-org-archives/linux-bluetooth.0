Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Mar 2014 11:14:39 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHv3 00/16] AVRCP code and test cases
Message-ID: <20140320091437.GA11610@aemeltch-MOBL1>
References: <1395134447-8957-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20140319091326.GB5215@aemeltch-MOBL1>
 <CABBYNZKveFRYL77tc46WkBzZFaKsKMNK=penzgUzrX7EPwe=HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABBYNZKveFRYL77tc46WkBzZFaKsKMNK=penzgUzrX7EPwe=HQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Mar 19, 2014 at 01:32:53PM +0200, Luiz Augusto von Dentz wrote:
> Hi Andrei,
> 
> On Wed, Mar 19, 2014 at 11:13 AM, Andrei Emeltchenko
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > On Tue, Mar 18, 2014 at 11:20:31AM +0200, Andrei Emeltchenko wrote:
> >> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >>
> >> Set of unapplied test cases and code so far.
> >
> > ping
> >
> >
> >>
> >>
> >> Changes:
> >>       * v3: Rebased against new interface
> >>
> >> Andrei Emeltchenko (16):
> >>   android/avrcp: Add avrcp_connect_browsing()
> >>   android/avrcp: Add avrcp_set_browsed_player() function
> >>   unit/avrcp: Add browsing channel support in unit testing
> >>   unit/avrcp: Add /TP/MPS/BV-03-C test
> >>   android/avrcp: Use defined constant instead of magic number
> >>   android/avrcp: Add avrcp_get_folder_items() function
> >>   unit/avrcp: Add /TP/MPS/BV-08-C test
> >>   unit/avrcp: Add /TP/MPS/BV-01-I test
> >>   unit/avrcp: Add Connection establishment and release tests
> >>   unit/avrcp: Add /TP/MCN/CB/BV-01-C test
> >>   android/avrcp: Add avrcp_change_path() function
> >>   unit/avrcp: Add /TP/MCN/CB/BV-04-C test
> >>   android/avrcp: Add avrcp_get_item_attributes() function
> >>   unit/avrcp: Add /TP/MCN/CB/BV-07-C test
> >>   android/avrcp: Add avrcp_search() function
> >>   unit/avrcp: Add /TP/MCN/SRC/BV-01-C test
> >>
> >>  .gitignore          |   2 +
> >>  android/avrcp-lib.c | 126 ++++++++++++++++++++++++++++++++-
> >>  android/avrcp-lib.h |  32 +++++++++
> >>  unit/test-avrcp.c   | 197 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> >>  4 files changed, 352 insertions(+), 5 deletions(-)
> >>
> >> --
> >> 1.8.3.2
> 
> The idea was that we start using cfm callbacks for commands, so
> instead of using avctp_rsp_cb or avctp_browsing_rsp_cb directly which
> leads to receive raw PDU as response we would internally parse then
> and only then call the respective cfm callback with the parameter in
> host order.

So will you create skeleton or example how you want interface to change?

Best regards 
Andrei Emeltchenko 

