Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] shared/att: Handle disconnects.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25S+Kny+h6QmGpfydvMaYEu-odB_Vd1Jkdh27PtLoe9xqQ@mail.gmail.com>
Date: Wed, 30 Jul 2014 15:16:53 -0700
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <A9D88074-2B24-4EBE-BF38-B185F0206A23@holtmann.org>
References: <1406664819-24970-1-git-send-email-armansito@chromium.org> <CABBYNZJdppvFb_KCBAzX9_3aVpx8r47myxPFW_ZgLUnESDJ+Hg@mail.gmail.com> <3E59062F-919F-46E2-99F3-39BFCDB0C706@holtmann.org> <CAHrH25S+Kny+h6QmGpfydvMaYEu-odB_Vd1Jkdh27PtLoe9xqQ@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> I think the current way we have things is pretty simple and clean
> already, but I'll go ahead with your suggestion if you guys prefer
> that.
> 
> One small question: is it safe to call io_destroy inside the
> disconnect callback? If not, then we would have to post an
> asynchronous task to clean up the IO and this would complicate the
> code a little bit. We would actually still want to mark the the att
> structure as invalid somehow so that any calls made to bt_att_send,
> bt_att_register etc before the IO is freed can return false, which
> would lead us to have a "bool invalid" field somewhere.
> 
> In the timeout case, it might make sense to destroy the IO there. Then
> again, we could leave it up to the upper layer to unref the bt_att
> which would then destroy the connection.

the struct io is an internal detail to bt_att. I do not follow the comment regards to upper layer. The input into bt_att_new will be a file descriptor.

So what I thinking is that we just do io_destroy(att->io) and then att->io = NULL. 

Regards

Marcel

