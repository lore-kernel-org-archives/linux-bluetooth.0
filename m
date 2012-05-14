Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 14 May 2012 13:25:05 +0100
Message-ID: <CAJ2qBzYiTtLaDEnwqFMGS1JS+OuUaxTGrn70YE-oL3JnLi53Jg@mail.gmail.com>
Subject: Proposal to remove the rfcomm session refcnt and use the rfcomm state
 machine to delete the session
From: Dean Jenkins <djenkins@mvista.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have been working on an ARM based project that uses kernel Bluez
from 2.6.34 plus some backports includes some upstream refcnt fixes
from Linux 3.3. Note our project still uses the tasklet rather than
the new workqueue design.

My analysis indicates that the rfcomm session refcnt is fighting
against the rfcomm state machine. In particular, failure occurs under
high processor loads causing the run-time order of rfcomm threads to
change resulting in erroneous deletion of the rfcomm session,
"scheduling whilst atomic" warnings and reuse of the freed s session
pointer by the rfcomm state machine. Actually, my analysis suggests
that in normal operations when the target initiates the connection,
the normal target disconnection procedure always accesses a freed s
pointer.

I have not fully analysed Bluez in the Linux 3.3 kernel but I can see
that the refcnt weaknesses are still in Linux 3.3. My impression is
that imbalance issues with the rfcomm session refcnt have been going
on for some time, perhaps 18 months, and there have been various
attempts at resolving it. One of the recent upstream refcnt fixes I
have doubts about as it caused connections to not disconnect in my
environment.

I have had some success in resolving one root cause of the session
refcnt failures. I am confident this issue is still in Linux 3.3.

However, my more radical working solution is to completely remove the
session refcnt. My reasoning is that the rfcomm state machine is
sufficient to know when to delete the session. Indeed, it can be seen
that the rfcomm_session_close() and rfcomm_session_del() functions
already exist. In addition, to avoid, reuse of the freed s session
pointer, modify some functions to pass back the s session pointer up
the call stack, this updates the s pointer in the higher functions
preventing reuse of a freed s pointer.

My environment is not Linux 3.3 so my patches are not currently for
the latest Bluez. If the community is interested, I will try to
forward port the patches to Linux 3.3 and provide them in a separate
E-mail but untested, at least initially. I am willing to work with the
community to get my changes into the kernel.

If the removal of the refcnt is too radical for the community then I
am happy to explain one root cause of the refcnt failures and to
provide patches for that solution.

Therefore, please can community members respond to my outline
proposals so that we can start a constructive discussion. MontaVista
is happy to contribute our changes to Bluez.

Thanks in advance.

Regards,
Dean

--
Dean Jenkins
Embedded Software Engineer
Professional Services UK/EMEA
MontaVista Software, LLC
