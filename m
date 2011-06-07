Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTiki2cesmaLqZh0zzAONJiqsb8Weug@mail.gmail.com>
References: <1307021003-15418-1-git-send-email-lkslawek@gmail.com>
	<1307021003-15418-5-git-send-email-lkslawek@gmail.com>
	<BANLkTiki2cesmaLqZh0zzAONJiqsb8Weug@mail.gmail.com>
Date: Tue, 7 Jun 2011 11:10:33 +0200
Message-ID: <BANLkTi=i3AJyop3KZ9ROV+xOD_eBHgAWzg@mail.gmail.com>
Subject: Re: [PATCH 4/5] Add function for starting body streaming later
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jun 3, 2011 at 9:40 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
 > What about doing this directly on obex_write_stream, so that whenever
 > we read the first time an OBEX_HRD_BODY data we do start streaming? If
 > that is possible this also means that we don't really need .get to
 > return this boolean stream since we gonna start the stream on demand
 > when the data returned is OBEX_HRD_BODY.

Yes, it is also possible. It's just a bit trickier. I'm working on
 this now, so I should be able to send new patch set soon.

 --
Slawomir Bochenski
