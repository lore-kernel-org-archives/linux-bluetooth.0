Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] avdtp: Fix crash on connection lost
Date: Wed, 17 Oct 2012 12:17:26 +0200
Message-ID: <5925869.iVRXt7vIOW@uw000953>
In-Reply-To: <CABBYNZKQWy2CmM2FLZyw24UXEo202SsHymK-jzGF+k2dmg6brw@mail.gmail.com>
References: <1350391036-29997-1-git-send-email-szymon.janc@tieto.com> <15890511.ludKIz2NbJ@uw000953> <CABBYNZKQWy2CmM2FLZyw24UXEo202SsHymK-jzGF+k2dmg6brw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 17 of October 2012 11:48:36 Luiz Augusto von Dentz wrote:
> Hi Szymon,

Hi Luiz,
 
> >> We should probably get rid of the free_lock as well.
> >
> > Well, this is what this patch does, doesn't it?:)
> 
> What about the attached patch, it should fix the references for good
> by using the dc_timer when the reference drops to 0, I just need to
> check if 1 second is enough to cover all cases including the ones
> where the remote device connects but doesn't setup any stream, with
> the devices I have 1 second seems enough.

Yeap, this fix crash I've observed.

However, avdtp_get_internal() now returns newly created session with ref=0
and in avdtp_confirm_cb() there is unref called when btd_request_authorization
failed. Due to ref being signed int (why?) this could lead to not-nice-to-debug
bug if that session is reclaimed before dc timer fires (ref would go from -1 to
0).

Also I'm having trouble with tracking lifetime of session object.. I think
only avdtp_ref/unref function should really care about ref count. That would
require other function to only use ref/unref to get/free session object.
e.g. avdtp_free should be only called from disconnect_timeout() and
connection_lost() should only trigger other session users to drop their
references. Same goes to set_disconnect_timer() which should only be called
from avdtp_unref. There should be no need to call connection_lost from
disconnect_timeout as this timer should only run when there is no references
held to that session, right?

Or do I miss something?:)
-- 
BR
Szymon Janc

