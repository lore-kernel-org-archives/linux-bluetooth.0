Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328022697.1955.217.camel@aeonflux>
References: <1327999384-16094-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1327999384-16094-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<CACJA=fWD6wOnNT4jFvGQAP3hRo0AKWAoiZTHZsfmGvp+6JdxOg@mail.gmail.com>
	<20120131130242.GB7660@aemeltch-MOBL1>
	<1328022697.1955.217.camel@aeonflux>
Date: Tue, 31 Jan 2012 13:41:47 -0200
Message-ID: <CAA37ikaOnZEZNFatN4ncHkVB=H7y3DZy1E_7LWBtcmJdJTF6Zg@mail.gmail.com>
Subject: Re: [RESEND 1/3] Bluetooth: Use cancel_work instead of cancel_work_sync
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	Andre Guedes <andre.guedes@openbossa.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jan 31, 2012 at 1:11 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Andrei,
>
>> > > - =A0 =A0 =A0 cancel_delayed_work_sync(&conn->disc_work);
>> > > + =A0 =A0 =A0 cancel_delayed_work(&conn->disc_work);
>> >
>> > I'm afraid we must use _sync variant here. disc_work is not supposed t=
o
>> > be running after hci_conn is deleted.
>> >
>> > BTW, I believe we already addressed this issue in patches [PATCH 1/2]
>> > Bluetooth: Fix potential deadlock and [PATCH 2/2] Bluetooth: Remove
>> > unneeded locking. These patches are now pushed upstream. Could you
>>
>> I will check those patches from upstream and let you know.
>
> crap, I just acked these.
>
> Johan, forget about my acks and just ignore them. Lets wait until we get
> a clean new series.
>
> Regards
>
> Marcel

This change is really wrong because we're on the delete path and Andre
sent other patches which I'm almost sure will address this problem.

Best regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
