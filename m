Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4D6CFF69.1020503@csr.com>
References: <4D6CFF69.1020503@csr.com>
From: Anderson Briglia <anderson.briglia@openbossa.org>
Date: Tue, 1 Mar 2011 11:20:21 -0400
Message-ID: <AANLkTinedBMjg6OR9yd9KhUa981K=Eb0ts6Qyw+k_p17@mail.gmail.com>
Subject: Re: HCI Le time out
To: Marco Sinigaglia <marco.sinigaglia@csr.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marco,

On Tue, Mar 1, 2011 at 10:15 AM, Marco Sinigaglia
<marco.sinigaglia@csr.com> wrote:
> Hi All,
>
> I am using CSR 8505 A06 and, using LE, I have some timeout problems raised
> on hci.c.
> The following LE functions use a 100ms for the hci_send_req cmd.
> - hci_le_set_scan_parameters
> - hci_le_set_advertise_enable
> - hci_le_set_scan_enable
>
> The 100ms is not enough becouse the chip can be in deep sleep.
> Indeed, increasing it to 1000 the problem is fixed.
>
> Would be possible to check in this modifications?

I would suggest you to follow the patch submission guidelines [1]
before send modifications to this list. And if you are just starting
in bluez development, should read this:
http://www.bluez.org/development/

Regards,

Anderson Briglia

[1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob_plain;f=Documentation/SubmittingPatches;hb=HEAD

>
> Cheers
> Marco Sinigaglia
>
>
> @@ -2646,7 +2645,7 @@
>     rq.rparam = &status;
>     rq.rlen = 1;
>
> -    if (hci_send_req(dd, &rq, 100) < 0)
> +    if (hci_send_req(dd, &rq, 1000) < 0)
>         return -1;
>
>     if (status) {
> @@ -2680,7 +2679,7 @@
>     rq.rparam = &status;
>     rq.rlen = 1;
>
> -    if (hci_send_req(dd, &rq, 100) < 0)
> +    if (hci_send_req(dd, &rq, 1000) < 0)
>         return -1;
>
>     if (status) {
> @@ -2708,7 +2707,7 @@
>     rq.rparam = &status;
>     rq.rlen = 1;
>
> -    if (hci_send_req(dd, &rq, 100) < 0)
> +    if (hci_send_req(dd, &rq, 1000) < 0)
>         return -1;
>
>
>
> Member of the CSR plc group of companies. CSR plc registered in England and
> Wales, registered number 4187346, registered office Churchill House,
> Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
INdT - Instituto Nokia de tecnologia
+55 2126 1122
http://techblog.briglia.net
