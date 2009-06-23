Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1245768036.15367.78.camel@violet>
References: <2d5a2c100906090617m167d3815pae998d06bdbd6646@mail.gmail.com>
	 <1245595707.15367.66.camel@violet>
	 <2d5a2c100906210930q394fcf77hcd2bf39c26ae74f8@mail.gmail.com>
	 <1245603529.15367.68.camel@violet>
	 <2d5a2c100906211047n31b9d4dajac290601c184380b@mail.gmail.com>
	 <1245611096.15367.76.camel@violet>
	 <2d5a2c100906221449y6e37cb19x1bc27085bac318f4@mail.gmail.com>
	 <2d5a2c100906221608v5e3e3d8aydf66b13826ad88fa@mail.gmail.com>
	 <2d5a2c100906230651m679ccfat5bf4bfb20c130955@mail.gmail.com>
	 <1245768036.15367.78.camel@violet>
Date: Tue, 23 Jun 2009 12:01:09 -0300
Message-ID: <2d5a2c100906230801q6bd68397y34b5aa138fee5fe2@mail.gmail.com>
Subject: Re: regression introduced on v2.6.30-rc1
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jun 23, 2009 at 11:40 AM, Marcel Holtmann<marcel@holtmann.org> wrot=
e:
> what about just triggering the timer and then sending DISC for DLCI 0. I
> don't see a big benefit for this reference counting overhead.
>
> When we send the DISC, we will receive UA and thus get the required
> rfcomm_session_put() that then leads to the ACL disconnect.

Hmm, that seems to work too and is what we are doing in case of
receiving a DM, but there is a chance that the remote stack doesn't
respond the DISC in that case we can also use the session timer to
timeout. Anyway I don't think such broken stack exist, although we do
set timeout when sending DISC to a specific DLCI, so lets leave this
for latter when he actually have a real offender which doesn't respond
with UA.

Moving ahead, what about the timeout, 20 seconds seems too much
doesn't it? Are you fine with the places where I clear the timer?


--=20
Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o
