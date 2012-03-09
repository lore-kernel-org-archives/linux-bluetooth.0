Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120309130413.GC4497@localhost>
References: <1331136120-27075-1-git-send-email-jhovold@gmail.com>
	<1331136120-27075-2-git-send-email-jhovold@gmail.com>
	<1331148797.3392.191.camel@aeonflux>
	<20120308115721.GB4497@localhost>
	<1331228722.14217.7.camel@aeonflux>
	<20120309130413.GC4497@localhost>
Date: Fri, 9 Mar 2012 14:52:00 +0100
Message-ID: <CANq1E4RjnCdUfZuKawHs2te9wX30H-boC5tUPFarBCVbtn2n5Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] bluetooth: hci_ldisc: fix NULL-pointer dereference on tty_close
From: David Herrmann <dh.herrmann@googlemail.com>
To: Johan Hovold <jhovold@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan" <padovan@profusion.mobi>,
	"David S. Miller" <davem@davemloft.net>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	stable <stable@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Mar 9, 2012 at 2:04 PM, Johan Hovold <jhovold@gmail.com> wrote:
> On Thu, Mar 08, 2012 at 09:45:22AM -0800, Marcel Holtmann wrote:
>> Hi Johan,
>>
>> > > > Do not close protocol driver until device has been unregistered.
>> > > >
>> > > > This fixes a race between tty_close and hci_dev_open which can res=
ult in
>> > > > a NULL-pointer dereference.
>> > > >
>> > > > The line discipline closes the protocol driver while we may still =
have
>> > > > hci_dev_open sleeping on the req_lock mutex resulting in a NULL-po=
inter
>> > > > dereference when lock is acquired and hci_init_req called.
>> >
>> > [...]
>> >
>> > > what kernel version is this against? Our changes in bluetooth-next f=
ixed
>> > > some of the destruct handling.
>> >
>> > This is against the latest rc as it needs to be fixed in 3.3, but I
>> > missed a dependency to bluetooth-next as you point out below.
>> >
>> > > Also hci_unregister_dev should be calling the destruct handler and t=
hus
>> > > your change is now accessing hu but it got freed already.
>> >
>> > You're right, my patch depends on 010666a126fc ("Bluetooth: Make
>> > hci-destruct callback optional") and 797fe796c4 ("Bluetooth: uart-ldis=
c:
>> > Fix memory leak and remove destruct cb") from bluetooth-next.
>> >
>> > But since the latter one fixes a memory leak it should have been marke=
d
>> > for stable as well as pushed to Linus for 3.3, right?
>>
>> we need to look into this and propose patches for -stable. Is your
>> problem still present with bluetooth-next or not?
>
> Yes, both races are present in bluetooth-next of today (b8622cbd58f34)
> and only takes an additional manual step to trigger (as the core no
> longer tries to open the device twice automatically).
>
> My two patches on top of either the two patches by David Herrmann
> mentioned above or the following minimal fix of the same memory leak
> would be sufficient to fix both races in 3.3:
>
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.=
c
> index 0711448..97c5faa 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -237,7 +237,6 @@ static void hci_uart_destruct(struct hci_dev *hdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> =A0 =A0 =A0 =A0BT_DBG("%s", hdev->name);
> - =A0 =A0 =A0 kfree(hdev->driver_data);
> =A0}
>
> =A0/* ------ LDISC part ------ */
> @@ -316,6 +315,7 @@ static void hci_uart_tty_close(struct tty_struct *tty=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hci_free_d=
ev(hdev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(hu);
> =A0 =A0 =A0 =A0}
> =A0}

The "destruct"-callback was broken in many ways but working around it
without removing it seems wrong. This memory-leak occurs only if a
tty-device uses the uart-ldisc without a protocol bound to it.
Therefore, I didn't consider it important enough for stable. However,
if you want to fix this, leave the kfree() inside the destruct
callback but add another kfree() into the hci_uart_close() in an
"else"-clause like this:

if (test_and_clear_bit(...)) {
} else {
+   kfree(...);
}

This will still keep the bogus ref-counts inside hci_dev with the
destruct() callback but will also free the ldisc if no protocol is
set.
Regards
David

>
> Thanks,
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
