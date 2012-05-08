Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 May 2012 17:34:35 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	gustavo@padovan.org
Subject: Re: [PATCH 2/3] Bluetooth: Replace unsafe batostr() calls with
 ba2str()
Message-ID: <20120508143434.GE29352@aemeltch-MOBL1>
References: <1336483706-1533-1-git-send-email-dh.herrmann@googlemail.com>
 <1336483706-1533-2-git-send-email-dh.herrmann@googlemail.com>
 <20120508134859.GC29352@aemeltch-MOBL1>
 <CANq1E4S_JihNzBipfduBz+=Bcud_OKNSjK6rKLvGJ1tJhx86vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CANq1E4S_JihNzBipfduBz+=Bcud_OKNSjK6rKLvGJ1tJhx86vA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Tue, May 08, 2012 at 04:02:39PM +0200, David Herrmann wrote:
> Hi Andrei
> 
> On Tue, May 8, 2012 at 3:49 PM, Andrei Emeltchenko
> <andrei.emeltchenko.news@gmail.com> wrote:
> > Hi David,
> >
> > On Tue, May 08, 2012 at 03:28:25PM +0200, David Herrmann wrote:
> >> batostr() is not thread-safe so we _must_ use ba2str() in all un-protected
> >> paths (which is pretty everywhere in our source).
> >>
> >> All places where BT_DBG() is used we call ba2str() as parameter so the
> >> static buffer is unused if debug is disabled during compilation and gcc
> >> should be clever enough to remove the buffers.
> >>
> >> Reported-by: Johannes Berg <johannes@sipsolutions.net>
> >> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> >> ---
> >>  net/bluetooth/bnep/core.c   |    4 +++-
> >>  net/bluetooth/cmtp/core.c   |    3 ++-
> >>  net/bluetooth/hci_conn.c    |    9 ++++++---
> >>  net/bluetooth/hci_core.c    |   32 ++++++++++++++++++++++----------
> >>  net/bluetooth/hci_event.c   |   17 +++++++++++------
> >>  net/bluetooth/hci_sysfs.c   |   14 ++++++++++----
> >>  net/bluetooth/hidp/core.c   |    4 ++--
> >>  net/bluetooth/l2cap_core.c  |   23 ++++++++++++++---------
> >>  net/bluetooth/rfcomm/core.c |   15 +++++++++------
> >>  net/bluetooth/rfcomm/sock.c |   10 ++++++----
> >>  net/bluetooth/rfcomm/tty.c  |   10 +++++++---
> >>  net/bluetooth/sco.c         |   20 ++++++++++++++------
> >>  12 files changed, 106 insertions(+), 55 deletions(-)
> >>
> >> diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
> >> index a779ec7..03a3cb3 100644
> >> --- a/net/bluetooth/bnep/core.c
> >> +++ b/net/bluetooth/bnep/core.c
> >> @@ -166,6 +166,7 @@ static int bnep_ctrl_set_netfilter(struct bnep_session *s, __be16 *data, int len
> >>  static int bnep_ctrl_set_mcfilter(struct bnep_session *s, u8 *data, int len)
> >>  {
> >>       int n;
> >> +     char babuf1[BDADDR_STRLEN], babuf2[BDADDR_STRLEN];
> >
> > NAK in this form. You are always allocating unneeded memory.
> 
> That's on the stack. I think gcc should be smart enough to _not_
> allocate this on code paths not using it. Furthermore, there is only
> one other way to do this and this is introducing a new format
> specifier for snprintf() that takes as argument a bdaddr_t but I tried
> to avoid this.
> 
> I also don't know what the problem is with using the stack for both
> buffers? That's definitely no speed problem so you must be concerned
> about stack size. But again, both are not even available when
> disabling debug and thats just 18 bytes per buffer...
> 
> Please be more specific about what's bothering you here.

Those extra variables does not look necessary. What about the method
suggested by Johannes using %pM

Best regards 
Andrei Emeltchenko 

