Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327174090.1955.58.camel@aeonflux>
References: <1326993579-14429-1-git-send-email-octavian.purdila@intel.com>
	<1327164299.1955.53.camel@aeonflux>
	<CAE1zotJs0gJOQUX_w+A31gw6zedBGnLscyWRKya8KdNKTM4+4A@mail.gmail.com>
	<1327170562.1955.55.camel@aeonflux>
	<CAE1zotLwpoq-6kKpsCf_KWY+AbjTa9Pd4m_v_wKX6JdmJ9O8nA@mail.gmail.com>
	<1327174090.1955.58.camel@aeonflux>
Date: Sat, 21 Jan 2012 21:51:20 +0200
Message-ID: <CAE1zotJKH8jQuqf5yi8CGH_1tYdtcfkkLTZq0HvxfjSmk9eNPw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: silence lockdep warning
From: "Purdila, Octavian" <octavian.purdila@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Jan 21, 2012 at 9:28 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> so instead of keep checking sock->sk multiple times in different places,
> why not actually check the error from bt_proto[]->create() and skip the
> reclassify_lock call.
>
> And if we wanna be really paranoid, then lets add a BUG_ON for sk so we
> get some nice backtraces if we have a wrongful caller.
>

Sounds like a good idea, I've sent v3 with the check removed.

Thanks,
Tavi
