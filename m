Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140811072409.GB21813@t440s>
References: <1407548769-5903-1-git-send-email-armansito@chromium.org>
	<1407548769-5903-2-git-send-email-armansito@chromium.org>
	<20140811072409.GB21813@t440s>
Date: Mon, 11 Aug 2014 14:21:21 -0700
Message-ID: <CAHrH25R_Uya+nHmUXGtaEMwjjxvnP3cvLtJEw+whDBhQ4dw=0g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] shared/att: Handle disconnects.
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> +     att->io_destroy_id = timeout_add(1, io_destroy_cb, att, NULL);
>
> Is this the only reason you're keeping the "bool invalid" variable? I'd
> take a different approach and fix the generic IO handling to be able to
> destroy the io from within of the disconnect callback. The simplest way
> to do this would be to increment the reference count in the generic io
> code before calling the disconnect callback and the decrement once done
> with the io pointer.

That makes sense. I sent a new patch set (v2) with your suggestion.

Thanks,
Arman
