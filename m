Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAOFmnYASjAK0y0E-sUW21V_xxYN_BdYN8075LMUxkF-uZypT-g@mail.gmail.com>
References: <CAOFmnYASjAK0y0E-sUW21V_xxYN_BdYN8075LMUxkF-uZypT-g@mail.gmail.com>
Date: Mon, 2 Jan 2012 15:52:32 +0200
Message-ID: <CABBYNZLDn3NtoSHyztPGR=fb8q2-e16bQrKqqac8RrxM9bFy4A@mail.gmail.com>
Subject: Re: Getting sco_connect_cb(): Connection refused (111) [Bluez-Ofono-PulseAudio]
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: JEETENDRA BHATTAD <bhattad.jeetendra@gmail.com>
Cc: Michael Maddern <michael.maddern@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jan 2, 2012 at 3:38 PM, JEETENDRA BHATTAD
<bhattad.jeetendra@gmail.com> wrote:
> Hello All,
>
> When I am trying to connect my Nokia N97 or Nokia Xpress Music 5800, Samsung
> Galaxy Note on my IMX53 board.
>
> It gets connected and disconnects immediately.
>
> Getting sco_connect_cb(): Connection refused (111)  after which phone gets
> disconnected.

Please add the hcidump log if possible, I suspect you are trying to
initiate the SCO connection which iirc is not recommended when acting
as a headset/carkit, some phones may block the connection attempt
specially if there is no active call.

-- 
Luiz Augusto von Dentz
