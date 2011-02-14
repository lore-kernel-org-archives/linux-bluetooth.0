Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110214145649.GE2597@joana>
References: <20110211035309.GA22204@spacedout.fries.net>
	<20110214145649.GE2597@joana>
Date: Mon, 14 Feb 2011 15:40:46 -0600
Message-ID: <AANLkTi==Sh2yc2JjjY5t-NKxQexKPgPwNyWo4SMju92k@mail.gmail.com>
Subject: Re: [HACK PATCH] N900 l2cap connect crash, NULL parent
From: Andrei Warkentin <andreiw@motorola.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: David Fries <david@fries.net>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

FWIW still need it in 2.6.36.

On Mon, Feb 14, 2011 at 8:56 AM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi David,
>
> * David Fries <david@fries.net> [2011-02-10 21:53:09 -0600]:
>
>> Here's a patch to avoid a very repeatable crash in the N900.  If I
>> take a Motorola S305 bluetooth headset that was previously paried with
>> the N900, turn it on, and press the play button before the headphones
>> automatically pair with the cell phone, the N900 will crash (and
>> reboot) in pairing.  If I wait until after they have paired there
>> isn't any problem.  The patch is against the kernel-power
>> 2.6.28-maemo46 by Thomas Tanner, the stock Nokia PR1.2 oops looked
>> the same, I just haven't gone back to that kernel.
>
> This is a very old kernel. You need to check this issue against
> bluetooth-next-2.6.
>
> --
> Gustavo F. Padovan
> http://profusion.mobi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
