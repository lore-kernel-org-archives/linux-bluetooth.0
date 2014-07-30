Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <A9D88074-2B24-4EBE-BF38-B185F0206A23@holtmann.org>
References: <1406664819-24970-1-git-send-email-armansito@chromium.org>
	<CABBYNZJdppvFb_KCBAzX9_3aVpx8r47myxPFW_ZgLUnESDJ+Hg@mail.gmail.com>
	<3E59062F-919F-46E2-99F3-39BFCDB0C706@holtmann.org>
	<CAHrH25S+Kny+h6QmGpfydvMaYEu-odB_Vd1Jkdh27PtLoe9xqQ@mail.gmail.com>
	<A9D88074-2B24-4EBE-BF38-B185F0206A23@holtmann.org>
Date: Wed, 30 Jul 2014 15:30:18 -0700
Message-ID: <CAHrH25RLzdw_wY5O+BpNaa75SHy0V7iq-aY4pLWwiba3JbO7UQ@mail.gmail.com>
Subject: Re: [PATCH] shared/att: Handle disconnects.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


> the struct io is an internal detail to bt_att. I do not follow the comment regards to upper layer. The input into bt_att_new will be a file descriptor.
>

What I meant was that, upon receiving the timeout callback, should
whoever created the bt_att be responsible for explicitly destroying
the connection by calling bt_att_unref (which will internally free the
struct io)? Just thinking out loud.


> So what I thinking is that we just do io_destroy(att->io) and then att->io = NULL.
>

In the disconnect case, is this safe to do from directly inside the
disconnect callback given to io_set_disconnect_handler?


Thanks,
Arman
