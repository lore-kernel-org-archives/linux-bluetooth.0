Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Apr 2011 16:09:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Briglia <anderson.briglia@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Add basic discovery commands to the
 management interface
Message-ID: <20110420130944.GA3519@jh-x301>
References: <4dae0084.a905ec0a.709a.12f6@mx.google.com>
 <20110419215807.GA26778@jh-x301>
 <BANLkTik5UF9hPgHG1hwzWV2hG5ZLS8GXnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTik5UF9hPgHG1hwzWV2hG5ZLS8GXnQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Apr 20, 2011, Anderson Briglia wrote:
> you had already sent this few weeks ago.

Could you point me to that thread? I'm not aware of sending these
patches before. AFAIK they were only available in my kernel.org tree
(which I use for experimental stuff not yet ready for upstream).

> What do you prefer? I modify the commit message and the patch
> authoring (and send it again)?

As I said, the changes are probably too minor to justify an author
change. My main point was that don't send stuff in other peoples name
without talking to them first.

> Which coding style issues did you notice?

Minor things like adding an extra empty line at the end of both patches
(shouldn't checkpatch.pl complain about that?) and an extra space in the
format string of a BT_DBG("hci%u ", index) debug print in the first patch.

Johan
