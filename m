Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <0262656B-5656-422C-B12D-C6BF7239AA11@holtmann.org>
References: <1381592725-28212-1-git-send-email-scampa.giovanni@gmail.com> <0262656B-5656-422C-B12D-C6BF7239AA11@holtmann.org>
From: Giovanni Campagna <scampa.giovanni@gmail.com>
Date: Sat, 12 Oct 2013 18:18:43 +0200
Message-ID: <CABkLShFUcOTuBsy1Ej=i8p1fjKdOmgTKWthHbL+Wx6KDhhjFMg@mail.gmail.com>
Subject: Re: [PATCH] Allow using obexd without systemd in the user session
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

2013/10/12 Marcel Holtmann <marcel@holtmann.org>:
> Hi Giovanni,
>
> [...]
>
> that is something your distro specific package should be fixing if that is needed. The focus is on integration with systemd and nothing else. You can use --disable-systemd and provide your own set of D-Bus service files.

I don't think shipping with upstream packages that require distro
patches in common configurations is a good idea (it breaks jhbuild
setups, for example), but ok, I filed
https://bugzilla.redhat.com/show_bug.cgi?id=1018496

Thanks for the quick answer,

Giovanni
