Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHrH25Qw2s0T_MCJndAbv63Eixc7zcJ-KTZG8Y1aKZTy+J8gMw@mail.gmail.com>
References: <CAHF=Y4pBMLaF1osqQNk1fkw1UHGk6SMYhQ=u5zYZ6qswoFKWBA@mail.gmail.com>
 <F54B539B-3C7A-48C6-B608-417FBCB5050F@holtmann.org> <CAHF=Y4oGjUc=j4DE_pyC5Ue5ymsaoaGXJRzYHdWTHa2EF1k9Gg@mail.gmail.com>
 <CAHrH25Qw2s0T_MCJndAbv63Eixc7zcJ-KTZG8Y1aKZTy+J8gMw@mail.gmail.com>
From: Alfonso Acosta <fons@spotify.com>
Date: Tue, 7 Oct 2014 01:25:42 +0200
Message-ID: <CAHF=Y4qdhn=QjQEU+Sv44NNvAzdjn3wutboXENR0=H9Lx28vbg@mail.gmail.com>
Subject: Re: Connecting to propietary remote GATT service: plugins vs D-Bus
 GATT API
To: Arman Uguray <armansito@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>, Mattias Jansson <mjansson@spotify.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,


> For client the quickest way for you might be to actually write a
> plugin (using the GAttrib code). I would just look at some of the
> profile code, like input/hog or heartrate and maybe add your
> implementation as a profile and expose a simple D-Bus API for it if
> necessary. Since you're not going to submit this upstream, this might
> be the quickest approach for the short term.

That's exactly what I had in mind before I learned about the GATT API.
We will go with this, at least until the GATT API is automatically
exposed.

Thanks,

Fons


-- 
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
