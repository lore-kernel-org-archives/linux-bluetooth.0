Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1245603529.15367.68.camel@violet>
References: <2d5a2c100906090617m167d3815pae998d06bdbd6646@mail.gmail.com>
	 <2d5a2c100906210708x1816e5d9hb9a80c82d76da6dd@mail.gmail.com>
	 <1245595707.15367.66.camel@violet>
	 <2d5a2c100906210930q394fcf77hcd2bf39c26ae74f8@mail.gmail.com>
	 <1245603529.15367.68.camel@violet>
Date: Sun, 21 Jun 2009 14:47:30 -0300
Message-ID: <2d5a2c100906211047n31b9d4dajac290601c184380b@mail.gmail.com>
Subject: Re: regression introduced on v2.6.30-rc1
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jun 21, 2009 at 1:58 PM, Marcel Holtmann<marcel@holtmann.org> wrote:
> Hi Luiz,
>
> did you actually test this change? And understand it?
>

Yep, this was actually one of my first attempts to fix the problem and
it make no difference, but the real problem is not rfcomm_dlc
reference being hold it is currently rfcomm_session reference which
are not released until the remote device respond with DISC dlci 0, but
in case where the remote never respond this reference will be held
forever which cause the ACL to never be disconnected.

There is 2 session reference being hold, one by rfcomm_dlc_link
(core.c:321) which rfcomm_dlc_unlink should takes care and another one
created on rfcomm_accept_connection (core.c:1837) which afaik won't go
away if the remote device doesn't respond with a proper DISC to dlci
0.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
