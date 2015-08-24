Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLYdt=aeA4V0GosjygEU7hnNRc3rArpr5uMf0ZBLC-NjQ@mail.gmail.com>
References: <20150818220604.05b7a862@angwin.home>
	<CABBYNZLJQchUh7z1xCfmmuVq1Nexx3RYLB0AUq+DWUFpo-=gnw@mail.gmail.com>
	<CABBYNZ+qjOtB4=qba6DF+KY5wiYnhCFcMX4fPSrHRrVDx0R04w@mail.gmail.com>
	<20150819161441.GA8142@hau.nz>
	<CABBYNZK_Vy+o_XN9RSGrMVbnEMt=BHAkmpoyFmv5bK0PwCnXJw@mail.gmail.com>
	<20150819220231.58a3b14f@angwin.home>
	<CABBYNZ+w2EiecMLp-NjA59u=LVsSD4TxCqLZB-zmWXFsaDi=pw@mail.gmail.com>
	<CANq1E4TY+yzuzbkO4+h2wnEvE1dJ9u8w2V3hy_4Kk3C4YaP=Sw@mail.gmail.com>
	<CABBYNZLYdt=aeA4V0GosjygEU7hnNRc3rArpr5uMf0ZBLC-NjQ@mail.gmail.com>
Date: Mon, 24 Aug 2015 12:40:00 +0200
Message-ID: <CANq1E4QqgZsFCqC50MCrsUhAD7f_E90oHDUOSYo4172nQjbKig@mail.gmail.com>
Subject: Re: IdleTimeout behavior for Sony PS3 remote in Bluez 5
From: David Herrmann <dh.herrmann@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "Mark A. Haun" <haunma@keteu.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	David Herrmann <dh.herrmann@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On Mon, Aug 24, 2015 at 10:12 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi David,
>
> On Fri, Aug 21, 2015 at 12:03 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
>> Hey
>>
>> On Thu, Aug 20, 2015 at 10:52 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> @David: Since apparently you was the author of the patch the remove
>>> setting EUNATCH to sk_err can you tell if that was intentional or you
>>> did not know that it could affect the timeout implementation? Btw, it
>>> would nice if you could comment regarding moving the timeout policy to
>>> the HID driver.
>>
>> This sounds like an oversight. From a quick look,
>> hidp_session_terminate() should set these errors properly. I can try
>> to craft a patch on Monday.
>
> I wonder if it isn't better to just call kernel_sock_shutdown directly
> since either way we want to disconnect and the userspace is not really
> doing anything special with EUNATCH either, it just see there is an
> error and close its reference which happens to be the last one causing
> it disconnect.

I'm not very comfortable with -net internals, so not sure what
behavior you want. Calling kernel_sock_shutdown() sounds fine, but
that cannot be done from hidp_session_terminate(). Instead, you must
call it from hidp_session_thread() somewhere near hidp_del_timer(),
before hidp_session_put().

Thanks
David
