Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] shared/att: Handle disconnects.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25RLzdw_wY5O+BpNaa75SHy0V7iq-aY4pLWwiba3JbO7UQ@mail.gmail.com>
Date: Wed, 30 Jul 2014 16:05:47 -0700
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <032C9596-DD08-48EE-B80B-C7A5DCC5E1F3@holtmann.org>
References: <1406664819-24970-1-git-send-email-armansito@chromium.org> <CABBYNZJdppvFb_KCBAzX9_3aVpx8r47myxPFW_ZgLUnESDJ+Hg@mail.gmail.com> <3E59062F-919F-46E2-99F3-39BFCDB0C706@holtmann.org> <CAHrH25S+Kny+h6QmGpfydvMaYEu-odB_Vd1Jkdh27PtLoe9xqQ@mail.gmail.com> <A9D88074-2B24-4EBE-BF38-B185F0206A23@holtmann.org> <CAHrH25RLzdw_wY5O+BpNaa75SHy0V7iq-aY4pLWwiba3JbO7UQ@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>> the struct io is an internal detail to bt_att. I do not follow the comment regards to upper layer. The input into bt_att_new will be a file descriptor.
>> 
> 
> What I meant was that, upon receiving the timeout callback, should
> whoever created the bt_att be responsible for explicitly destroying
> the connection by calling bt_att_unref (which will internally free the
> struct io)? Just thinking out loud.

the bt_att should stay around. It is just the internal io that should be destroyed.

Since the bt_att is reference counted and comes in from higher layers we should not touch. Meaning you will end up with a bt_att where io == NULL in case the transport disconnects or times out.

> 
>> So what I thinking is that we just do io_destroy(att->io) and then att->io = NULL.
>> 
> 
> In the disconnect case, is this safe to do from directly inside the
> disconnect callback given to io_set_disconnect_handler?

Most likely not at the moment. We might want to make it safe if it is not.

Regards

Marcel

