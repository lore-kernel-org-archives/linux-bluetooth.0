Return-Path: <cyrus@holtmann.org>
Message-ID: <1333553048.2125.31.camel@novo.hadess.net>
Subject: Re: GSoC: Obexd Ideas
From: Bastien Nocera <hadess@hadess.net>
To: dmp <dmp0x7c5@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 04 Apr 2012 16:24:08 +0100
In-Reply-To: <CAKZqhqcWhpfnhY-8aDd88LprfS9KankxCjoFoUmL=xJHOVqEmQ@mail.gmail.com>
References: <CAKZqhqfupD+b9FjKRhOjFzZ1kH_17SGPK7n+9hkb8JyiP9Qr=g@mail.gmail.com>
	 <CAKZqhqcWhpfnhY-8aDd88LprfS9KankxCjoFoUmL=xJHOVqEmQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2012-04-04 at 16:38 +0200, dmp wrote:
> Hello,
> 
> I've submitted proposal [1] for "OBEX Filesystem In Userspace". I'll
> be grateful if someone could give me some comments. There are still
> few days to improve.
> 
> [1] http://www.google-melange.com/gsoc/proposal/review/google/gsoc2012/dmp/44002

FWIW, having written the ObexFTP gvfs backend twice already, that using
a D-Bus API is a bad idea. Instead, the code should use gobex directly.
It would make the code more robust, and easier to debug.

I'm happy doing code reviews, or answer gvfs specific questions if those
crop up during the SoC project.

Cheers

