Return-Path: <cyrus@holtmann.org>
Date: Thu, 29 Oct 2009 02:15:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaikumar Ganesh <jaikumar@google.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Update SDP storage records when a record is deleted.
Message-ID: <20091029001531.GA14617@jh-x301>
References: <1256253562-22532-1-git-send-email-jaikumar@google.com> <2d5a2c100910230649u1946e632qa4c50b33b6654218@mail.gmail.com> <e8892a6a0910230817l6f096f70s4de1fe534799de86@mail.gmail.com> <2d5a2c100910231044u6a6c65e0ka8258a6f65d08f41@mail.gmail.com> <e8892a6a0910260820g43b4f688g2c33d7d1ae771d07@mail.gmail.com> <20091028233425.GA13183@jh-x301> <e8892a6a0910281645r39d3b793wa9b9f2cc948da3da@mail.gmail.com> <20091028235434.GA13715@jh-x301> <e8892a6a0910281702y952d88evca1bb6a7674b9de7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <e8892a6a0910281702y952d88evca1bb6a7674b9de7@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Oct 28, 2009, Jaikumar Ganesh wrote:
> > On Wed, Oct 28, 2009, Jaikumar Ganesh wrote:
> >> The SDP cache is  removed when the device is removed. In fact, you
> >> fixed this a few days back.
> >
> > Which commit are you referring to?
> 
> Commit number:
> 
> 4bec43039626e853489e72149014868f8c8afedc
> 
> http://git.kernel.org/?p=bluetooth/bluez.git;a=commit;h=4bec43039626e853489e72149014868f8c8afedc

Ok, so we're talking about different things here. I was talking about
removing the records from /var/lib/bluetooth/...

> We can also fix this by removing the on disk SDP records when the
> device is freed.
> (I think which is what you suggested - by cache I was interpreting it
> as in memory cache)
> Will submit a new patch. Let me know if I read you wrong.

No, you're right. I was referring to the disk cache. I'm glad we have this
misunderstanding finally sorted out :)

Johan
