Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/7] android: Use 16-bit UUID for SDP search
Date: Wed, 12 Feb 2014 13:17:27 +0100
Message-ID: <9537432.Rvi7jDRuau@leonov>
In-Reply-To: <CAJdJm_P3caDzXXttQUvkoeo3pSaWaiuJ4G0B1gbwfw0uwfDD3A@mail.gmail.com>
References: <1392143552-11395-1-git-send-email-anderson.lizardo@openbossa.org> <1458044.bhGCHJKobi@leonov> <CAJdJm_P3caDzXXttQUvkoeo3pSaWaiuJ4G0B1gbwfw0uwfDD3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Wednesday 12 of February 2014 07:28:24 Anderson Lizardo wrote:
> Hi Szymon,
> 
> On Wed, Feb 12, 2014 at 6:59 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> >> Applied all except 6/7, I think we should probably return an error if
> >> there is an attempt to register a service out of range, then the
> >> caller can assert so we can have a proper test for it that expect an
> >> error in such case.
> > 
> > Well, currently IPC depends on hal-msg.h which defines max allowed service
> > ID and using something bigger is a code bug. We could have make IPC
> > independent of hal-msg.h and just verify registered ID in runtime but
> > that would add extra code for each caller with no profit as IDs are fixed
> > anyway.
> 
> Personally, I don't have strong opinions on using assert() versus
> raise(SIGTERM) (which is how runtime error conditions seem to be
> handled). Initially I went with raise(SIGTERM), but then I noticed the
> IDs are statically defined, and there is no way to give a invalid ID
> to ipc_register(),  unless due to programming error (for which
> assert() is ideal, due to low overhead and no introduction of dead
> code).
> 
> That said, this patch is not critical, but only a check so future
> users of ipc_register() don't reintroduce a similar crash fixed by the
> other commit.
> 
> > That test fix is invalid as we actually want to test if IPC handles
> > out-of-
> > bound service ID correctly (when receiving register command).
> > And I'm not sure why this actually was causing any problems since that
> > test is not registering handlers for out-of-bound service ID, just sends
> > ipc message with such ID.
> 
> I forgot to clarify this on the commit message: the "out of bound"
> service ID is still passed on the IPC message. What I fixed is the
> service ID field used solely for registering the handlers (i.e. passed
> to ipc_register()). If you check the changed struct, there is another
> field for the IPC headers where there is still the expected (out of
> bound) ID.
> 
> In the current format, ipc_register() must not receive an "out of
> bound" ID otherwise memory corruptions occur, which introduces subtle
> bugs (in my case the crash happened in very specific compilation
> parameters and valgrind didn't help because the corrupted structures
> were static).

Yes, I was looking at service ID in wrong line. This seems ok now.

-- 
BR
Szymon Janc
