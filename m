Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1324583358.1965.225.camel@aeonflux>
References: <1324580173-24957-1-git-send-email-padovan@profusion.mobi>
	<1324580173-24957-2-git-send-email-padovan@profusion.mobi>
	<1324580173-24957-3-git-send-email-padovan@profusion.mobi>
	<1324580173-24957-4-git-send-email-padovan@profusion.mobi>
	<1324580173-24957-5-git-send-email-padovan@profusion.mobi>
	<1324583358.1965.225.camel@aeonflux>
Date: Thu, 22 Dec 2011 17:54:41 -0200
Message-ID: <CAA37ikYsh0wgM1qC-egH3p41nf6=P-jcCPpkCEqe3_jB6_dpzg@mail.gmail.com>
Subject: Re: [PATCH 05/12] Bluetooth: Don't use *_bh locks anymore
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Dec 22, 2011 at 5:49 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Gustavo,
>
>> Those locks are not shared between interrupt and process context anymore=
,
>> so remove the part that disable interruption. We are stiff safe because
>> preeption is disabled.
>>
>> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
>> ---
>> =A0net/bluetooth/l2cap_core.c | =A0 24 ++++++++++++------------
>> =A01 files changed, 12 insertions(+), 12 deletions(-)
>
> any reason why this can not be converted into RCU usage?

Indeed the chan_list_lock may be easily converted to RCU, IMO.

Regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
