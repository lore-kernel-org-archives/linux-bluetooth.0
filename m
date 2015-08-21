Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+w2EiecMLp-NjA59u=LVsSD4TxCqLZB-zmWXFsaDi=pw@mail.gmail.com>
References: <20150818220604.05b7a862@angwin.home>
	<CABBYNZLJQchUh7z1xCfmmuVq1Nexx3RYLB0AUq+DWUFpo-=gnw@mail.gmail.com>
	<CABBYNZ+qjOtB4=qba6DF+KY5wiYnhCFcMX4fPSrHRrVDx0R04w@mail.gmail.com>
	<20150819161441.GA8142@hau.nz>
	<CABBYNZK_Vy+o_XN9RSGrMVbnEMt=BHAkmpoyFmv5bK0PwCnXJw@mail.gmail.com>
	<20150819220231.58a3b14f@angwin.home>
	<CABBYNZ+w2EiecMLp-NjA59u=LVsSD4TxCqLZB-zmWXFsaDi=pw@mail.gmail.com>
Date: Fri, 21 Aug 2015 11:03:51 +0200
Message-ID: <CANq1E4TY+yzuzbkO4+h2wnEvE1dJ9u8w2V3hy_4Kk3C4YaP=Sw@mail.gmail.com>
Subject: Re: IdleTimeout behavior for Sony PS3 remote in Bluez 5
From: David Herrmann <dh.herrmann@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "Mark A. Haun" <haunma@keteu.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	David Herrmann <dh.herrmann@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey

On Thu, Aug 20, 2015 at 10:52 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> @David: Since apparently you was the author of the patch the remove
> setting EUNATCH to sk_err can you tell if that was intentional or you
> did not know that it could affect the timeout implementation? Btw, it
> would nice if you could comment regarding moving the timeout policy to
> the HID driver.

This sounds like an oversight. From a quick look,
hidp_session_terminate() should set these errors properly. I can try
to craft a patch on Monday.

Thanks
David
