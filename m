Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120213084743.GA21179@aemeltch-MOBL1>
References: <1328797057-26331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1328797057-26331-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<CAA37ikaPnRheNYxZoNRYA6Qg+ndiW887k3ZqH51htEphCK8uBA@mail.gmail.com>
	<20120210091816.GF28197@aemeltch-MOBL1>
	<CAA37ikZKJgtRoF-aK60W0AZr93u6zJ9T6=oB+6bzNLv80R=KbQ@mail.gmail.com>
	<20120213084743.GA21179@aemeltch-MOBL1>
Date: Mon, 13 Feb 2012 22:12:22 -0300
Message-ID: <CAA37ikY=gaAyiutdO8S33GLi3DFi8cUFQt7R1PERtxV-s+ybOA@mail.gmail.com>
Subject: Re: [RFCv3 15/16] Bluetooth: Use l2cap chan lock in socket connect
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	Ulisses Furquim <ulisses@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Feb 13, 2012 at 5:47 AM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> Hi Ulisses,
>
> On Fri, Feb 10, 2012 at 04:31:26PM -0200, Ulisses Furquim wrote:
>> Hi Andrei,
>>
>> On Fri, Feb 10, 2012 at 7:18 AM, Emeltchenko Andrei
>> <Andrei.Emeltchenko.news@gmail.com> wrote:
>> > Hi Ulisses,
>> >
>> > On Thu, Feb 09, 2012 at 04:25:11PM -0200, Ulisses Furquim wrote:
>> >> >        bacpy(src, conn->src);
>> >> >
>> >> > +       l2cap_chan_unlock(chan);
>> >> >        l2cap_chan_add(conn, chan);
>> >> > +       l2cap_chan_lock(chan);
>> >>
>> >> Hum, do we really need to do this? Maybe l2cap_chan_add() can receive
>> >> chan already locked?
>> >
>> > Then we have here order of locking changed and I have lockdep warnings.
>> >
>> > And here l2cap_chan_add used locked.
>>
>> Why the locked version and not __l2cap_chan_add()?
>
> Because we need to lock addition channel to chan list and we are locked
> only with chan->lock.

Ugh, you're right.

>> >> > -       __l2cap_state_change(chan, BT_CONNECT);
>> >> > +       l2cap_state_change(chan, BT_CONNECT);
>> >>
>> >> Why? Is there a problem moving the release_sock() call to we don't
>> >> call the locked function here?
>> >>
>> >> >        __set_chan_timer(chan, sk->sk_sndtimeo);
>> >> >
>> >> >        if (hcon->state == BT_CONNECTED) {
>> >> >                if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
>> >> >                        __clear_chan_timer(chan);
>> >> >                        if (l2cap_chan_check_security(chan))
>> >> > -                               __l2cap_state_change(chan, BT_CONNECTED);
>> >> > +                               l2cap_state_change(chan, BT_CONNECTED);
>> >>
>> >> And here as well.
>> >
>> > Then we would need to release lock before l2cap_do_start.
>>
>> Sure.
>
> I will check what can be done, currently including wide locks/unlocks would
> significantly reduce readability of this part of the code.

Do you think? Having fewer lock and unlock calls actually should be
less error prone IMO. And we don't have any lock with a lot of
contention that we need to be so minimal in our critical sections.

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
