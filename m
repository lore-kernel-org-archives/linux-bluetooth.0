Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110616165140.GA5229@piper>
References: <BANLkTi=LXBzm+9g-VdonozngKhQfOZoz2w@mail.gmail.com>
	<1307957658-11330-1-git-send-email-lkslawek@gmail.com>
	<1307957658-11330-2-git-send-email-lkslawek@gmail.com>
	<BANLkTinFrYNNSj0SL3TT=kCnB3PLS7yeAw@mail.gmail.com>
	<20110615133932.GA14904@dell.ger.corp.intel.com>
	<BANLkTi=U2mgumWCTHBMvtROWn5iAA_fiJw@mail.gmail.com>
	<BANLkTikOJC7QSWkJ2HbJTQg-e2n36mc-zw@mail.gmail.com>
	<20110616165140.GA5229@piper>
Date: Fri, 17 Jun 2011 10:35:39 +0300
Message-ID: <BANLkTi=6ZFQy2d+emwS3_jUx+M7bwQ4iAA@mail.gmail.com>
Subject: Re: [PATCH 3/4] Modify obex_write_stream logic
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: Slawomir Bochenski <lkslawek@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Thu, Jun 16, 2011 at 7:51 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
>> Sorry I have to disagree here, adding another callback probably
>> simplify the code a bit since we can have something like this:
>>
>> if (!streaming && driver->get_apparams)
>>     driver->get_apparams...
>>
>> So just drivers that support get_apparams will be called and that
>> should be enough to guarantee the apparams are added in the beginning
>> packet.
>>
>> Custom headers are a different matter, right now we don't have any
>> plugin/driver who need them.
>
> But we will have soon, BIP needs them. So we better start considering
> how should we export it to the plugins.

Sure, still a different plugin, maybe when BIP is to be introduced we
should actually give the OpenOBEX object to the drivers, so that each
plugin can add their own headers in whatever order they want, or have
an abstraction of the object e.g. obexd_object which the plugins can
use to add their own headers. How about that?

-- 
Luiz Augusto von Dentz
