Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Oct 2013 10:59:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/3] Add basic commands to haltest
Message-ID: <20131022075954.GA12940@x220.p-661hnu-f1>
References: <1382364136-13665-1-git-send-email-jerzy.kasenberg@tieto.com>
 <20131021161859.GA9153@x220.p-661hnu-f1>
 <CAHCYCoyszrDFjxZA8yini=QY4A0zOP6msZPGG3WHs0C2mfjUHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHCYCoyszrDFjxZA8yini=QY4A0zOP6msZPGG3WHs0C2mfjUHg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jerzy,

On Tue, Oct 22, 2013, Jerzy Kasenberg wrote:
> On 21 October 2013 18:18, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > Hi Jerzy,
> >
> > On Mon, Oct 21, 2013, Jerzy Kasenberg wrote:
> >> - Adds handling of Ctrl-c Ctrl-d as requested
> >> - Prompted changed to includ space
> >> - Added commands: quit exit help
> >> - Added completion for help
> >> - Terminal settings restored on exit
> >>
> >> Jerzy Kasenberg (3):
> >>   android: Add space in prompt in haltest
> >>   android: Add handling of Ctrl-c to haltest
> >>   android: Add help and quit to haltest
> >>
> >>  android/client/haltest.c       |  151 ++++++++++++++++++++++++++++++++++------
> >>  android/client/if-main.h       |    6 ++
> >>  android/client/tabcompletion.c |  151 ++++++++++++++++++++++++++++------------
> >>  android/client/terminal.c      |  100 ++++++++++++++++++--------
> >>  4 files changed, 312 insertions(+), 96 deletions(-)
> >
> > Patches 1 and 3 have been applied. It seems we had a bit of a
> > misunderstanding about 2 though. I was looking for ctrl-d (i.e. EOF)
> > support. Sorry for not being more precise here. Right now when I try
> > it the following just happens:
> >
> > jh@x220:bluez{master}$ android/haltest
> >> char-0x04
> 
> Patch 2 handles Ctrl-c and Ctrl-d.
> When I tried on two terminals in bash Ctrl-d act like delete if line
> is not empty.

Seems you're right. Anyway, this was part of the same request as adding
basic "exit" or "quit" commands. When a user ends up in an unknown shell
and wants to get out from it those are usually the first things tried
(including ctrl-d).

> You or Szymon asked me to add Ctrl-c to clear current line like in
> other tools.

It wasn't me since ctrl-c was already getting me out from the tool.

> So maybe it wold be better to put Ctrl-d in patch title instead of
> Ctrl-c

Ctrl-d should be generating an EOF indicator just like feeding a file to
the program through stdin does. So in this sense "ctrl-d" isn't really
the best description as there are more ways of accomplishing the same.

> This  is what patch 2 handles by setting atexit() cleanup function
> that restore terminal settings.

Sounds like this should have been split into a separate patch then.

Johan
