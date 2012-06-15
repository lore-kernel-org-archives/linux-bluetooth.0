Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Jun 2012 13:13:59 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Steve Langasek <steve.langasek@canonical.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] Update tests to be compatible with gi and python3
Message-ID: <20120615101359.GA6586@x220.ger.corp.intel.com>
References: <20120525054425.GA10062@virgil.dodds.net>
 <20120530075503.GI6539@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120530075503.GI6539@x220>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

> On Thu, May 24, 2012, Steve Langasek wrote:
> > From: Steve Langasek <steve.langasek@canonical.com>
> > 
> > This patch makes the python tests source-compatible with python 3, while
> > leaving the interpreter at python 2 for now.
> > 
> > The tradeoff is that this source is no longer compatible with python
> > versions < 2.6, and requires gobject-introspection for the glib-based tests.
> > 
> > Signed-off-by: Steve Langasek <steve.langasek@canonical.com>
> 
> We don't use signed-off-by for user space patches so please leave it out
> from the commit message.
> 
> > ---
> >  test/list-devices      |   30 ++++++++++---------
> >  test/monitor-bluetooth |    6 ++--
> >  test/simple-agent      |   41 +++++++++++++------------
> >  test/simple-endpoint   |   12 ++++----
> >  test/simple-service    |    8 +++--
> >  test/test-adapter      |   52 ++++++++++++++++----------------
> >  test/test-attrib       |   52 ++++++++++++++++----------------
> >  test/test-audio        |    8 +++--
> >  test/test-device       |   78 +++++++++++++++++++++++++-----------------------
> >  test/test-discovery    |   16 +++++-----
> >  test/test-health       |   62 +++++++++++++++++++-------------------
> >  test/test-health-sink  |   24 ++++++++-------
> >  test/test-input        |    8 +++--
> >  test/test-manager      |   12 ++++----
> >  test/test-nap          |    8 +++--
> >  test/test-network      |   10 ++++---
> >  test/test-oob          |   34 +++++++++++----------
> >  test/test-proximity    |   14 +++++----
> >  test/test-sap-server   |   64 ++++++++++++++++++++-------------------
> >  test/test-serial       |   10 ++++---
> >  test/test-serial-proxy |    6 ++--
> >  test/test-service      |   14 +++++----
> >  test/test-telephony    |   38 ++++++++++++-----------
> >  test/test-thermometer  |   28 +++++++++--------
> >  24 files changed, 342 insertions(+), 293 deletions(-)
> 
> In general the patch looks ok, but unfortunately it doesn't apply
> cleanly:
> 
> Applying: Update tests to be compatible with gi and python3
> /home/jh/src/bluez/.git/rebase-apply/patch:838: trailing whitespace.
>  
> /home/jh/src/bluez/.git/rebase-apply/patch:840: trailing whitespace.
>  
> fatal: 2 lines add whitespace errors.
> Patch failed at 0001 Update tests to be compatible with gi and python3
> 
> Please fix this and resend. For the future you might want to add the
> following to your gitconfig:
> 
> [apply]
>         whitespace = error

Since I haven't heard anything from you I went a head and fixed these
issues for you and applied the patch.

Johan
