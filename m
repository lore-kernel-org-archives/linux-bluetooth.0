Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAE6HaM=cTHJkVKLCdUUD3oHgOFnGYGuVPwD=LSj4iL4U17vE6g@mail.gmail.com>
References: <CAGd9gwjaECWWRE+Ux4XenbUO9L-QSsjnP6wLHEvH5q3sasWWkg@mail.gmail.com>
 <CAGd9gwj=79xKJ0Mdb1eb+a5MDGtG1a3BcC8utfDad1ZLzhfd5A@mail.gmail.com> <CAE6HaM=cTHJkVKLCdUUD3oHgOFnGYGuVPwD=LSj4iL4U17vE6g@mail.gmail.com>
From: Alex Deymo <deymo@chromium.org>
Date: Mon, 6 May 2013 20:30:56 -0700
Message-ID: <CAGd9gwiyUaedR6EOMOhpw64iA=_jkM+v08QsNJUteg_d+2mvmg@mail.gmail.com>
Subject: Re: Short names on Extended Inquiry Result
To: Vinicius Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, May 3, 2013 at 6:55 PM, Vinicius Gomes
<vinicius.gomes@openbossa.org> wrote:
> Hi Alex,
>
> I don't know if this is what you already had in mind, but I would
> start on the userspace side, src/adapter.c:4052
> (update_found_devices()), and make it send the confirm name command in
> the cases that we only have the short name. It should cause the remote
> name to be requested.

Thanks for the pointer. I managed to solve the problem of updating the
already known long name with the new short name in that function, and
after some time debugging between the kernel module and the userland
daemon I also found that the problem of the "Remote Name Request" not
being sent is because confirm_name() is called with a known_name in
TRUE since we already known "a name".

I though about several options and finally choose tho consider the
short name as an unknown name and thus calling the confirm_name() with
known_name in FALSE, but also report the device with the short name,
while we ask for the long name.

This has the advantage of sending the device found signal earlier, but
may have a problem in the following scenario:
1. We have a first call to update_found_devices() with a short name
and report it to the user.
2. We request the full name.
3. The device doesn't reply to this request (for any reason)
4. We get a second call to update_found_devices() with a short name...
but since we already know "a name" we don't request the long name.

To avoid this I think the best should be to include the name_complete
field in the struct btd_device together with the name. What do you
think?

I'm sending a proposed patch with this implementation.
Thanks!
Alex.
