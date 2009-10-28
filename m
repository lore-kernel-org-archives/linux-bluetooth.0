Return-Path: <cyrus@holtmann.org>
Date: Thu, 29 Oct 2009 01:54:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaikumar Ganesh <jaikumar@google.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Update SDP storage records when a record is deleted.
Message-ID: <20091028235434.GA13715@jh-x301>
References: <1256253562-22532-1-git-send-email-jaikumar@google.com> <2d5a2c100910230649u1946e632qa4c50b33b6654218@mail.gmail.com> <e8892a6a0910230817l6f096f70s4de1fe534799de86@mail.gmail.com> <2d5a2c100910231044u6a6c65e0ka8258a6f65d08f41@mail.gmail.com> <e8892a6a0910260820g43b4f688g2c33d7d1ae771d07@mail.gmail.com> <20091028233425.GA13183@jh-x301> <e8892a6a0910281645r39d3b793wa9b9f2cc948da3da@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e8892a6a0910281645r39d3b793wa9b9f2cc948da3da@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Oct 28, 2009, Jaikumar Ganesh wrote:
> The SDP cache is  removed when the device is removed. In fact, you
> fixed this a few days back.

Which commit are you referring to?

> This is the scenario I am referring to:
> a) Device is paired and SDP records fetched.
> b) Device is unpaired - device cache records of SDP is freed

Ok, so at this point we don't have anything stored about the device,
neither on disk nor in runtime memory.

> c) On Remote Device - some SDP records are deleted.
> d) When the device is created again and the SDP records fetched,
> profiles_removed is empty and so
> 
>         if (req->profiles_removed)
>                 device_remove_drivers(device, req->profiles_removed);
> 
> device_remove_drivers will not be called and hence SDP records will
> never get deleted.

But what is there to delete if in step b) we already deleted everything?

Johan
