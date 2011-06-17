Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTi=6ZFQy2d+emwS3_jUx+M7bwQ4iAA@mail.gmail.com>
References: <BANLkTi=LXBzm+9g-VdonozngKhQfOZoz2w@mail.gmail.com>
	<1307957658-11330-1-git-send-email-lkslawek@gmail.com>
	<1307957658-11330-2-git-send-email-lkslawek@gmail.com>
	<BANLkTinFrYNNSj0SL3TT=kCnB3PLS7yeAw@mail.gmail.com>
	<20110615133932.GA14904@dell.ger.corp.intel.com>
	<BANLkTi=U2mgumWCTHBMvtROWn5iAA_fiJw@mail.gmail.com>
	<BANLkTikOJC7QSWkJ2HbJTQg-e2n36mc-zw@mail.gmail.com>
	<20110616165140.GA5229@piper>
	<BANLkTi=6ZFQy2d+emwS3_jUx+M7bwQ4iAA@mail.gmail.com>
Date: Fri, 17 Jun 2011 09:59:47 +0200
Message-ID: <BANLkTin=htaxEbxopF7c-g04sE_AeAG9iA@mail.gmail.com>
Subject: Re: [PATCH 3/4] Modify obex_write_stream logic
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jun 17, 2011 at 9:35 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>> But we will have soon, BIP needs them. So we better start considering
>> how should we export it to the plugins.
>
> Sure, still a different plugin, maybe when BIP is to be introduced we
> should actually give the OpenOBEX object to the drivers, so that each
> plugin can add their own headers in whatever order they want, or have
> an abstraction of the object e.g. obexd_object which the plugins can
> use to add their own headers. How about that?

The approach of direct accessing obex_object_t from within plugin was
used before (among other bad practices) and dropped more than year
ago.

-- 
Slawomir Bochenski
