Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5B9B1FB0-A822-4B5E-A040-42920D336457@holtmann.org>
References: <CALkxMhEJxUXaKZgSQ4BSa-UvuEx1uFwVbr4yikH+qB81cUkvDw@mail.gmail.com>
	<5B9B1FB0-A822-4B5E-A040-42920D336457@holtmann.org>
Date: Mon, 31 Mar 2014 12:38:32 +0200
Message-ID: <CALkxMhFwk=JwSbA_uPgLxAjQUAhGiqTjPsEOQSer90BX+ojOfg@mail.gmail.com>
Subject: Re: Missing Linux Bluetooth Headers
From: Michal Labedzki <michal.labedzki@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

So what external application should do? Add own copy of headers to
sources or try use BlueZ copy of headers. I think that first option is
better, because build dependency with BlueZ does not make
implementation kernel-safe. I think about user try to use one version
of libpcap and try to change kernel to older (there can be old kernel
API).
