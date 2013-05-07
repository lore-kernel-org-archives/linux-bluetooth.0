Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130430081629.GA777@x220.ger.corp.intel.com>
References: <1367006741-28907-1-git-send-email-deymo@chromium.org>
 <1367006741-28907-2-git-send-email-deymo@chromium.org> <20130430081629.GA777@x220.ger.corp.intel.com>
From: Alex Deymo <deymo@chromium.org>
Date: Mon, 6 May 2013 21:20:11 -0700
Message-ID: <CAGd9gwgGMyHPN9BBSS7bqbbaqsx5QVvFqf6+V5e-t4yveN_kig@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] core: Convert the pincode callback to an interable list.
To: Alex Deymo <deymo@chromium.org>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>, keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Apr 30, 2013 at 1:16 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> On Fri, Apr 26, 2013, Alex Deymo wrote:
>> +struct pincb_iter {
>
> What concerns me a bit about this is that you're now introducing the
> first symbols exported by adapter.{c.h} that are not name spaced with
> btd_adapter* or adapter*. Would it make sense to keep this name spacing
> even for the iterator?
Yes, I'll change the name of those functions to btd_adapter_pincb... .
After all, those are for iterating the adapter's pincode callback list
and not /any/ pincode callback list.

>> +     unsigned int attempt;           /* numer of times it() was called */
>
> Just use int and not unsigned int. It's what we typically use for
> iterator variables.
This "attempt" member is not exactly an iterator variable, but a
member of an iterator struct. The iterator variable will be of type
struct pincb_iter *. Also, the attempt member will only take
non-negative values, so the unsigned version looks more appropriate in
that case.

Excuse me for not iterate this patch before. I'll try to send an
update tomorrow including a fix for the bonding retry with a Bluetooth
2.1+ discoverable but not pairable device.
Best regards,
Alex.
